Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x2S1v6KRKzDr1k
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Jul 2017 14:04:51 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id j186so29586966pge.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Jul 2017 21:04:51 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Subject: [PATCH 4/4] powerpc: machine check interrupt is a non-maskable
 interrupt
Date: Wed,  5 Jul 2017 14:04:22 +1000
Message-Id: <20170705040422.20933-5-npiggin@gmail.com>
In-Reply-To: <20170705040422.20933-1-npiggin@gmail.com>
References: <20170705040422.20933-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use nmi_enter similarly to system reset interrupts. This uses NMI
printk NMI buffers and turns off various debugging facilities that
helps avoid tripping on ourselves or other CPUs.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/traps.c           | 9 ++++++---
 arch/powerpc/platforms/powernv/opal.c | 2 +-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 574e949f8db9..1933b74372a1 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -767,8 +767,10 @@ int machine_check_generic(struct pt_regs *regs)
 
 void machine_check_exception(struct pt_regs *regs)
 {
-	enum ctx_state prev_state = exception_enter();
 	int recover = 0;
+	bool nested = in_nmi();
+	if (!nested)
+		nmi_enter();
 
 	__this_cpu_inc(irq_stat.mce_exceptions);
 
@@ -798,10 +800,11 @@ void machine_check_exception(struct pt_regs *regs)
 
 	/* Must die if the interrupt is not recoverable */
 	if (!(regs->msr & MSR_RI))
-		panic("Unrecoverable Machine check");
+		nmi_panic("Unrecoverable Machine check");
 
 bail:
-	exception_exit(prev_state);
+	if (!nested)
+		nmi_exit();
 }
 
 void SMIException(struct pt_regs *regs)
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 92f00113227f..29967de9823d 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -449,7 +449,7 @@ int opal_machine_check(struct pt_regs *regs)
 
 	pnv_platform_error = "Unrecoverable Machine Check exception";
 
-	panic("Unrecoverable Machine Check exception");
+	nmi_panic("Unrecoverable Machine Check exception");
 }
 
 /* Early hmi handler called in real mode. */
-- 
2.11.0
