Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x209J1r5vzDr1f
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Jul 2017 20:09:40 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id s66so29212134pfs.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Jul 2017 03:09:40 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 3/3] powerpc: do not send system reset request through the
 oops path
Date: Tue,  4 Jul 2017 20:09:09 +1000
Message-Id: <20170704100909.8738-4-npiggin@gmail.com>
In-Reply-To: <20170704100909.8738-1-npiggin@gmail.com>
References: <20170704100909.8738-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

A system reset is a request to crash / debug the system rather than
necessarily caused by encountering a BUG. So there is no need to
serialize all CPUs behind the die lock, adding taints to all subsequent
traces beyond the first, breaking console locks, etc.

The system reset is NMI context which has its own printk buffers to
prevent output being interleaved. Then it's better to have all
secondaries print out their debug as quickly as possible and the primary
will flush out all printk buffers during panic().

So remove the 0x100 path from die, and move it into system_reset. Name
the crash/dump reasons "System Reset".

This gives "not tained" traces when crashing an untainted kernel. It
also gives the panic reason as "System Reset" as opposed to "Fatal
exception in interrupt" (or "die oops" for fadump).

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/traps.c | 47 ++++++++++++++++++++++++++++++---------------
 1 file changed, 31 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index bfcfd9ef09f2..574e949f8db9 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -162,21 +162,9 @@ static void oops_end(unsigned long flags, struct pt_regs *regs,
 
 	crash_fadump(regs, "die oops");
 
-	/*
-	 * A system reset (0x100) is a request to dump, so we always send
-	 * it through the crashdump code.
-	 */
-	if (kexec_should_crash(current) || (TRAP(regs) == 0x100)) {
+	if (kexec_should_crash(current))
 		crash_kexec(regs);
 
-		/*
-		 * We aren't the primary crash CPU. We need to send it
-		 * to a holding pattern to avoid it ending up in the panic
-		 * code.
-		 */
-		crash_kexec_secondary(regs);
-	}
-
 	if (!signr)
 		return;
 
@@ -294,17 +282,44 @@ void system_reset_exception(struct pt_regs *regs)
 			goto out;
 	}
 
-	die("System Reset", regs, SIGABRT);
+	if (debugger(regs))
+		goto out;
+
+	/*
+	 * A system reset is a request to dump, so we always send
+	 * it through the crashdump code (if fadump or kdump are
+	 * registered).
+	 */
+	crash_fadump(regs, "System Reset");
+
+	crash_kexec(regs);
+
+	/*
+	 * We aren't the primary crash CPU. We need to send it
+	 * to a holding pattern to avoid it ending up in the panic
+	 * code.
+	 */
+	crash_kexec_secondary(regs);
+
+	/*
+	 * No debugger or crash dump registered, print logs then
+	 * panic.
+	 */
+	__die("System Reset", regs, SIGABRT);
+
+	mdelay(2*MSEC_PER_SEC); /* Wait a little while for others to print */
+	add_taint(TAINT_DIE, LOCKDEP_NOW_UNRELIABLE);
+	nmi_panic(regs, "System Reset");
 
 out:
 #ifdef CONFIG_PPC_BOOK3S_64
 	BUG_ON(get_paca()->in_nmi == 0);
 	if (get_paca()->in_nmi > 1)
-		panic("Unrecoverable nested System Reset");
+		nmi_panic(regs, "Unrecoverable nested System Reset");
 #endif
 	/* Must die if the interrupt is not recoverable */
 	if (!(regs->msr & MSR_RI))
-		panic("Unrecoverable System Reset");
+		nmi_panic(regs, "Unrecoverable System Reset");
 
 	if (!nested)
 		nmi_exit();
-- 
2.11.0
