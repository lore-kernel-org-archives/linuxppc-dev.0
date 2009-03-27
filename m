Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 27 Mar 2009 16:29:06 +1100
Subject: [PATCH] powerpc: Fix bugs introduced by sysfs changes (v2)
Message-Id: <20090327052936.4EB43DDD04@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Rusty's patch to change our sysfs access to various registers
to use smp_call_function_single() introduced a whole bunch of
warnings. This fixes them. This version also fixes an actual
bug in here where it did mtspr instead of mfspr when reading
the files

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/kernel/sysfs.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- linux-work.orig/arch/powerpc/kernel/sysfs.c	2009-03-27 14:12:04.000000000 +1100
+++ linux-work/arch/powerpc/kernel/sysfs.c	2009-03-27 14:16:06.000000000 +1100
@@ -134,17 +134,15 @@ void ppc_enable_pmcs(void)
 }
 EXPORT_SYMBOL(ppc_enable_pmcs);
 
-
 #define SYSFS_PMCSETUP(NAME, ADDRESS) \
 static void read_##NAME(void *val) \
 { \
-	mtspr(ADDRESS, *(unsigned long *)val);	\
+	*(unsigned long *)val = mfspr(ADDRESS);	\
 } \
-static unsigned long write_##NAME(unsigned long val) \
+static void write_##NAME(void *val) \
 { \
 	ppc_enable_pmcs(); \
 	mtspr(ADDRESS, *(unsigned long *)val);	\
-	return 0; \
 } \
 static ssize_t show_##NAME(struct sys_device *dev, \
 			struct sysdev_attribute *attr, \
