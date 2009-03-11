Return-Path: <rusty@rustcorp.com.au>
Received: from vivaldi.localnet (unknown [150.101.102.135])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPSA id CF4BCDDF7F
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2009 09:20:11 +1100 (EST)
From: Rusty Russell <rusty@rustcorp.com.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: make sysfs code use smp_call_function_single
Date: Thu, 12 Mar 2009 08:50:05 +1030
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200903120850.05522.rusty@rustcorp.com.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Impact: performance improvement

This fixes 'powerpc: avoid cpumask games in arch/powerpc/kernel/sysfs.c'
which talked about using smp_call_function_single, but actually used
work_on_cpu (an older version of the patch).

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 arch/powerpc/kernel/sysfs.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
--- a/arch/powerpc/kernel/sysfs.c
+++ b/arch/powerpc/kernel/sysfs.c
@@ -135,14 +135,14 @@ EXPORT_SYMBOL(ppc_enable_pmcs);
 EXPORT_SYMBOL(ppc_enable_pmcs);
 
 #define SYSFS_PMCSETUP(NAME, ADDRESS) \
-static long read_##NAME(void *junk) \
+static void read_##NAME(void *val) \
 { \
-	return mfspr(ADDRESS); \
+	*(unsigned long *)val = mfspr(ADDRESS);	\
 } \
 static long write_##NAME(void *val) \
 { \
 	ppc_enable_pmcs(); \
-	mtspr(ADDRESS, (unsigned long)val);	\
+	mtspr(ADDRESS, *(unsigned long *)val);	\
 	return 0; \
 } \
 static ssize_t show_##NAME(struct sys_device *dev, \
@@ -150,7 +150,8 @@ static ssize_t show_##NAME(struct sys_de
 			char *buf) \
 { \
 	struct cpu *cpu = container_of(dev, struct cpu, sysdev); \
-	unsigned long val = work_on_cpu(cpu->sysdev.id, read_##NAME, NULL); \
+	unsigned long val; \
+	smp_call_function_single(cpu->sysdev.id, read_##NAME, &val, 1);	\
 	return sprintf(buf, "%lx\n", val); \
 } \
 static ssize_t __used \
@@ -162,7 +163,7 @@ static ssize_t __used \
 	int ret = sscanf(buf, "%lx", &val); \
 	if (ret != 1) \
 		return -EINVAL; \
-	work_on_cpu(cpu->sysdev.id, write_##NAME, (void *)val);	\
+	smp_call_function_single(cpu->sysdev.id, write_##NAME, &val, 1); \
 	return count; \
 }
 
