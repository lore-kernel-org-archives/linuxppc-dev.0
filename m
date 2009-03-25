Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 25 Mar 2009 12:51:02 +1100
Subject: [PATCH] powerpc: Fix warnings introduced by sysfs changes
Message-Id: <20090325015128.C109DDDEFE@ozlabs.org>
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
warnings. This fixes them

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

I've also now fixed my build test tool to report warnings properly
so hopefully I won't miss that next time around :-)

 arch/powerpc/kernel/sysfs.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- linux-work.orig/arch/powerpc/kernel/sysfs.c	2009-03-25 11:17:28.000000000 +1100
+++ linux-work/arch/powerpc/kernel/sysfs.c	2009-03-25 11:18:15.000000000 +1100
@@ -140,11 +140,10 @@ static void read_##NAME(void *val) \
 { \
 	mtspr(ADDRESS, *(unsigned long *)val);	\
 } \
-static unsigned long write_##NAME(unsigned long val) \
+static void write_##NAME(void *val) \
 { \
 	ppc_enable_pmcs(); \
-	mtspr(ADDRESS, *(unsigned long *)val);	\
-	return 0; \
+	mtspr(ADDRESS, *(unsigned long *)val); \
 } \
 static ssize_t show_##NAME(struct sys_device *dev, \
 			struct sysdev_attribute *attr, \
