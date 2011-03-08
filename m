Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp03.au.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C1F9BB6EF7
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Mar 2011 17:37:39 +1100 (EST)
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp03.au.ibm.com (8.14.4/8.13.1) with ESMTP id p286X250021854
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Mar 2011 17:33:02 +1100
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p286bcWh2191434
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Mar 2011 17:37:38 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p286bcj4005128
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Mar 2011 17:37:38 +1100
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 05/18] powerpc/smp: Remove unused smp_ops->cpu_enable()
Date: Tue,  8 Mar 2011 17:37:17 +1100
Message-Id: <1299566250-10516-6-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1299566250-10516-1-git-send-email-benh@kernel.crashing.org>
References: <1299566250-10516-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Remove the last remnants of cpu_enable(), everybody uses the normal
__cpu_up() path now

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/machdep.h    |    1 -
 arch/powerpc/kernel/smp.c             |   10 ----------
 arch/powerpc/platforms/powermac/smp.c |    2 --
 3 files changed, 0 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index fe56a23..bcfc0da 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -37,7 +37,6 @@ struct smp_ops_t {
 	void  (*setup_cpu)(int nr);
 	void  (*take_timebase)(void);
 	void  (*give_timebase)(void);
-	int   (*cpu_enable)(unsigned int nr);
 	int   (*cpu_disable)(void);
 	void  (*cpu_die)(unsigned int nr);
 	int   (*cpu_bootable)(unsigned int nr);
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 19d0c25..be7d728 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -350,21 +350,11 @@ void generic_mach_cpu_die(void)
 }
 #endif
 
-static int __devinit cpu_enable(unsigned int cpu)
-{
-	if (smp_ops && smp_ops->cpu_enable)
-		return smp_ops->cpu_enable(cpu);
-
-	return -ENOSYS;
-}
-
 int __cpuinit __cpu_up(unsigned int cpu)
 {
 	int c;
 
 	secondary_ti = current_set[cpu];
-	if (!cpu_enable(cpu))
-		return 0;
 
 	if (smp_ops == NULL ||
 	    (smp_ops->cpu_bootable && !smp_ops->cpu_bootable(cpu)))
diff --git a/arch/powerpc/platforms/powermac/smp.c b/arch/powerpc/platforms/powermac/smp.c
index c95215f..ebd2b7e 100644
--- a/arch/powerpc/platforms/powermac/smp.c
+++ b/arch/powerpc/platforms/powermac/smp.c
@@ -923,8 +923,6 @@ struct smp_ops_t core99_smp_ops = {
 # if defined(CONFIG_PPC64)
 	.cpu_disable	= generic_cpu_disable,
 	.cpu_die	= generic_cpu_die,
-	/* intentionally do *NOT* assign cpu_enable,
-	 * the generic code will use kick_cpu then! */
 # endif
 #endif
 };
-- 
1.7.1
