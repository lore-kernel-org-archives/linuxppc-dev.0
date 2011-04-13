Return-Path: <paul.gortmaker@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 7B39AB6FCE
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 14 Apr 2011 02:30:30 +1000 (EST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: benh@kernel.crashing.org
Subject: [PATCH] powerpc/kexec: fix regression causing compile failure on UP
Date: Wed, 13 Apr 2011 12:30:08 -0400
Message-Id: <1302712208-28794-1-git-send-email-paul.gortmaker@windriver.com>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, mike@it-loops.com,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Recent commit b987812b3fcaf70fdf0037589e5d2f5f2453e6ce caused
a compile failure on UP because a considerably large block
of the file was included within CONFIG_SMP, hence making a stub
function not exposed on UP builds when it needed to be.

Relocate the stub to the #else /* ! CONFIG_SMP */ section
and also annotate the relevant else/endif so that nobody
else falls into the same trap I did.

Reported-by: Michael Guntsche <mike@it-loops.com>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---

      ** compile tested on both UP & SMP this time! **

 arch/powerpc/kernel/crash.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/crash.c b/arch/powerpc/kernel/crash.c
index 3d3d416..5b5e1f0 100644
--- a/arch/powerpc/kernel/crash.c
+++ b/arch/powerpc/kernel/crash.c
@@ -163,7 +163,7 @@ static void crash_kexec_prepare_cpus(int cpu)
 }
 
 /* wait for all the CPUs to hit real mode but timeout if they don't come in */
-#if defined(CONFIG_PPC_STD_MMU_64) && defined(CONFIG_SMP)
+#ifdef CONFIG_PPC_STD_MMU_64
 static void crash_kexec_wait_realmode(int cpu)
 {
 	unsigned int msecs;
@@ -188,9 +188,7 @@ static void crash_kexec_wait_realmode(int cpu)
 	}
 	mb();
 }
-#else
-static inline void crash_kexec_wait_realmode(int cpu) {}
-#endif
+#endif	/* CONFIG_PPC_STD_MMU_64 */
 
 /*
  * This function will be called by secondary cpus or by kexec cpu
@@ -235,7 +233,9 @@ void crash_kexec_secondary(struct pt_regs *regs)
 	crash_ipi_callback(regs);
 }
 
-#else
+#else	/* ! CONFIG_SMP */
+static inline void crash_kexec_wait_realmode(int cpu) {}
+
 static void crash_kexec_prepare_cpus(int cpu)
 {
 	/*
@@ -255,7 +255,7 @@ void crash_kexec_secondary(struct pt_regs *regs)
 {
 	cpus_in_sr = CPU_MASK_NONE;
 }
-#endif
+#endif	/* CONFIG_SMP */
 
 /*
  * Register a function to be called on shutdown.  Only use this if you
-- 
1.7.3.3
