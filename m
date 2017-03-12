Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vh6mJ0Z2VzDqYB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Mar 2017 04:04:16 +1100 (AEDT)
Received: by mail-pg0-x243.google.com with SMTP id g2so11195925pge.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Mar 2017 10:04:15 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: kvm-ppc@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH] KVM: PPC: Book3S HV: Use msgsync for hypervisor doorbells on
 POWER9
Date: Mon, 13 Mar 2017 03:03:49 +1000
Message-Id: <20170312170349.20323-2-npiggin@gmail.com>
In-Reply-To: <20170312170349.20323-1-npiggin@gmail.com>
References: <20170312170349.20323-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When msgsnd is used for IPIs to other cores, msgsync must be executed by
the target to order stores performed on the source before its msgsnd
(provided the source executes the appropriate sync).

Fixes: 1704a81ccebc ("KVM: PPC: Book3S HV: Use msgsnd for IPIs to other cores on POWER9")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

---
Hi,

I found this by inspection only and don't have a way to test it
(I have no POWER9 KVM set up yet). I don't know the KVM interrupt
code very well, so it might not be the right way to fix it. Flames
welcome.

Thanks,
Nick


 arch/powerpc/include/asm/ppc-opcode.h   | 2 ++
 arch/powerpc/kvm/book3s_hv_rmhandlers.S | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index e7d6d86563ee..142d78d645f4 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -161,6 +161,7 @@
 #define PPC_INST_MFTMR			0x7c0002dc
 #define PPC_INST_MSGSND			0x7c00019c
 #define PPC_INST_MSGCLR			0x7c0001dc
+#define PPC_INST_MSGSYNC		0x7c0006ec
 #define PPC_INST_MSGSNDP		0x7c00011c
 #define PPC_INST_MTTMR			0x7c0003dc
 #define PPC_INST_NOP			0x60000000
@@ -345,6 +346,7 @@
 					___PPC_RB(b) | __PPC_EH(eh))
 #define PPC_MSGSND(b)		stringify_in_c(.long PPC_INST_MSGSND | \
 					___PPC_RB(b))
+#define PPC_MSGSYNC		stringify_in_c(.long PPC_INST_MSGSYNC)
 #define PPC_MSGCLR(b)		stringify_in_c(.long PPC_INST_MSGCLR | \
 					___PPC_RB(b))
 #define PPC_MSGSNDP(b)		stringify_in_c(.long PPC_INST_MSGSNDP | \
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index 7c6477d1840a..caba3afe787d 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -1239,6 +1239,9 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 	/* Hypervisor doorbell - exit only if host IPI flag set */
 	cmpwi	r12, BOOK3S_INTERRUPT_H_DOORBELL
 	bne	3f
+BEGIN_FTR_SECTION
+	PPC_MSGSYNC
+END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
 	lbz	r0, HSTATE_HOST_IPI(r13)
 	cmpwi	r0, 0
 	beq	4f
-- 
2.11.0
