Return-Path: <paul.gortmaker@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 85670B6F2B
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  1 Apr 2011 06:00:06 +1100 (EST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/kexec: Fix mismatched ifdefs for PPC64/SMP.
Date: Thu, 31 Mar 2011 13:27:20 -0400
Message-Id: <1301592440-30012-1-git-send-email-paul.gortmaker@windriver.com>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit b3df895aebe091b1657 "powerpc/kexec: Add support for FSL-BookE"
introduced the original PPC_STD_MMU_64 checks around the function
crash_kexec_wait_realmode().   Then commit c2be05481f61252
"powerpc: Fix default_machine_crash_shutdown #ifdef botch" changed
the ifdef around the calling site to add a check on SMP, but the
ifdef around the function itself was left unchanged, leaving an
unused function for PPC_STD_MMU_64=y and SMP=n

Rather than have two ifdefs that can get out of sync like this,
simply put the corrected conditional around the function and use
a stub to get rid of one set of ifdefs completely.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/powerpc/kernel/crash.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/crash.c b/arch/powerpc/kernel/crash.c
index 3d569e2..3d3d416 100644
--- a/arch/powerpc/kernel/crash.c
+++ b/arch/powerpc/kernel/crash.c
@@ -163,7 +163,7 @@ static void crash_kexec_prepare_cpus(int cpu)
 }
 
 /* wait for all the CPUs to hit real mode but timeout if they don't come in */
-#ifdef CONFIG_PPC_STD_MMU_64
+#if defined(CONFIG_PPC_STD_MMU_64) && defined(CONFIG_SMP)
 static void crash_kexec_wait_realmode(int cpu)
 {
 	unsigned int msecs;
@@ -188,6 +188,8 @@ static void crash_kexec_wait_realmode(int cpu)
 	}
 	mb();
 }
+#else
+static inline void crash_kexec_wait_realmode(int cpu) {}
 #endif
 
 /*
@@ -344,9 +346,7 @@ void default_machine_crash_shutdown(struct pt_regs *regs)
 	crash_save_cpu(regs, crashing_cpu);
 	crash_kexec_prepare_cpus(crashing_cpu);
 	cpu_set(crashing_cpu, cpus_in_crash);
-#if defined(CONFIG_PPC_STD_MMU_64) && defined(CONFIG_SMP)
 	crash_kexec_wait_realmode(crashing_cpu);
-#endif
 
 	machine_kexec_mask_interrupts();
 
-- 
1.7.3.3
