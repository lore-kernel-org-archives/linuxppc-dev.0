Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vnL6b4msHzDqSS
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 15:53:11 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id o126so20295574pfb.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Mar 2017 21:53:11 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>
Subject: [PATCH 2/2] powerpc/64s: msgclr when handling doorbell exceptions
Date: Tue, 21 Mar 2017 14:52:54 +1000
Message-Id: <20170321045254.21384-3-npiggin@gmail.com>
In-Reply-To: <20170321045254.21384-1-npiggin@gmail.com>
References: <20170321045254.21384-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

msgsnd doorbell exceptions are cleared when the doorbell interrupt is
taken. However if a doorbell exception causes a system reset interrupt
wake from power saving state, the message is not cleared. Processing
the doorbell from the system reset interrupt requires msgclr to avoid
taking the exception twice.

Testing this plus the previous wakup direct patch gives:

                                original         wakeup direct     msgclr
Different threads, same core:   315k/s           264k/s            345k/s
Different cores:                235k/s           242k/s            242k/s

Net speedup is +10% for same core, and +3% for different core.
---
 arch/powerpc/include/asm/dbell.h      | 13 +++++++++++++
 arch/powerpc/include/asm/ppc-opcode.h |  3 +++
 arch/powerpc/kernel/dbell.c           |  9 +++++++++
 3 files changed, 25 insertions(+)

diff --git a/arch/powerpc/include/asm/dbell.h b/arch/powerpc/include/asm/dbell.h
index 378167377065..b242badb2af7 100644
--- a/arch/powerpc/include/asm/dbell.h
+++ b/arch/powerpc/include/asm/dbell.h
@@ -46,6 +46,19 @@ static inline void _ppc_msgsnd(u32 msg)
 		__asm__ __volatile__ (PPC_MSGSNDP(%0) : : "r" (msg));
 }
 
+static inline void _ppc_msgclr(u32 msg)
+{
+	__asm__ __volatile__ (ASM_FTR_IFSET(PPC_MSGCLR(%1), PPC_MSGCLRP(%1), %0)
+				: : "i" (CPU_FTR_HVMODE), "r" (msg));
+}
+
+static inline void ppc_msgclr(enum ppc_dbell type)
+{
+	u32 msg = PPC_DBELL_TYPE(type);
+
+	_ppc_msgclr(msg);
+}
+
 #else /* CONFIG_PPC_BOOK3S */
 
 #define PPC_DBELL_MSGTYPE		PPC_DBELL
diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index e7d6d86563ee..eb8c7d5fcfbe 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -162,6 +162,7 @@
 #define PPC_INST_MSGSND			0x7c00019c
 #define PPC_INST_MSGCLR			0x7c0001dc
 #define PPC_INST_MSGSNDP		0x7c00011c
+#define PPC_INST_MSGCLRP		0x7c00015c
 #define PPC_INST_MTTMR			0x7c0003dc
 #define PPC_INST_NOP			0x60000000
 #define PPC_INST_PASTE			0x7c00070c
@@ -349,6 +350,8 @@
 					___PPC_RB(b))
 #define PPC_MSGSNDP(b)		stringify_in_c(.long PPC_INST_MSGSNDP | \
 					___PPC_RB(b))
+#define PPC_MSGCLRP(b)		stringify_in_c(.long PPC_INST_MSGCLRP | \
+					___PPC_RB(b))
 #define PPC_POPCNTB(a, s)	stringify_in_c(.long PPC_INST_POPCNTB | \
 					__PPC_RA(a) | __PPC_RS(s))
 #define PPC_POPCNTD(a, s)	stringify_in_c(.long PPC_INST_POPCNTD | \
diff --git a/arch/powerpc/kernel/dbell.c b/arch/powerpc/kernel/dbell.c
index 2128f3a96c32..2919f11b6afe 100644
--- a/arch/powerpc/kernel/dbell.c
+++ b/arch/powerpc/kernel/dbell.c
@@ -40,6 +40,15 @@ void doorbell_exception(struct pt_regs *regs)
 
 	irq_enter();
 
+	/*
+	 * May have come from doorbell triggered sreset wakeup, which does
+	 * not clear the message (tested on POWER8). Clear it here so we
+	 * don't get a doorbell interrupt when enabling hard irqs. This
+	 * msgclear could be moved into the sreset wakeup replay specific
+	 * code if it is expensive.
+	 */
+	ppc_msgclr(PPC_DBELL_MSGTYPE);
+
 	may_hard_irq_enable();
 
 	kvmppc_set_host_ipi(smp_processor_id(), 0);
-- 
2.11.0
