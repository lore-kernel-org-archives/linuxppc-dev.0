Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5B019DE42D
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Sep 2008 04:31:45 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id m8JIVdrP019643
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Sep 2008 13:31:40 -0500
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Fix build warnings introduced by PMC support on
	32-bit
Date: Fri, 19 Sep 2008 13:31:39 -0500
Message-Id: <1221849099-27015-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

arch/powerpc/kernel/sysfs.c:197:7: warning: "CONFIG_6xx" is not defined
arch/powerpc/kernel/sysfs.c:141: warning: 'run_on_cpu' defined but not used

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/kernel/sysfs.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
index ef2ad92..86a2ffc 100644
--- a/arch/powerpc/kernel/sysfs.c
+++ b/arch/powerpc/kernel/sysfs.c
@@ -134,6 +134,7 @@ void ppc_enable_pmcs(void)
 }
 EXPORT_SYMBOL(ppc_enable_pmcs);
 
+#if defined(CONFIG_6xx) || defined(CONFIG_PPC64)
 /* XXX convert to rusty's on_one_cpu */
 static unsigned long run_on_cpu(unsigned long cpu,
 			        unsigned long (*func)(unsigned long),
@@ -152,6 +153,7 @@ static unsigned long run_on_cpu(unsigned long cpu,
 
 	return ret;
 }
+#endif
 
 #define SYSFS_PMCSETUP(NAME, ADDRESS) \
 static unsigned long read_##NAME(unsigned long junk) \
@@ -190,11 +192,11 @@ static ssize_t __used \
  * that are implemented on the current processor
  */
 
-#ifdef CONFIG_PPC64
+#if defined(CONFIG_PPC64)
 #define HAS_PPC_PMC_CLASSIC	1
 #define HAS_PPC_PMC_IBM		1
 #define HAS_PPC_PMC_PA6T	1
-#elif CONFIG_6xx
+#elif defined(CONFIG_6xx)
 #define HAS_PPC_PMC_CLASSIC	1
 #define HAS_PPC_PMC_IBM		1
 #define HAS_PPC_PMC_G4		1
-- 
1.5.5.1
