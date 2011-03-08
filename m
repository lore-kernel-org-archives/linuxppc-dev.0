Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp04.au.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C2311B6F06
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Mar 2011 17:37:39 +1100 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp04.au.ibm.com (8.14.4/8.13.1) with ESMTP id p286W7iL023935
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Mar 2011 17:32:07 +1100
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p286bdHk2183326
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Mar 2011 17:37:39 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p286bcRT005144
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Mar 2011 17:37:39 +1100
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 08/18] powerpc/pmac/smp: Fixup smp_core99_cpu_disable() and
	use it on 64-bit
Date: Tue,  8 Mar 2011 17:37:20 +1100
Message-Id: <1299566250-10516-9-git-send-email-benh@kernel.crashing.org>
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

Use the generic code, just add the MPIC priority setting,

I don't see any use in mucking around with the decrementer,
as 32-bit will have EE off all along, and 64-bit will be able
to deal with it.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/platforms/powermac/smp.c |   17 +++++------------
 1 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/platforms/powermac/smp.c b/arch/powerpc/platforms/powermac/smp.c
index e0ac7bb..eda4709 100644
--- a/arch/powerpc/platforms/powermac/smp.c
+++ b/arch/powerpc/platforms/powermac/smp.c
@@ -867,16 +867,14 @@ static void __devinit smp_core99_setup_cpu(int cpu_nr)
 
 #if defined(CONFIG_HOTPLUG_CPU) && defined(CONFIG_PPC32)
 
-int smp_core99_cpu_disable(void)
+static int smp_core99_cpu_disable(void)
 {
-	set_cpu_online(smp_processor_id(), false);
+	int rc = generic_cpu_disable();
+	if (rc)
+		return rc;
 
-	/* XXX reset cpu affinity here */
 	mpic_cpu_set_priority(0xf);
-	asm volatile("mtdec %0" : : "r" (0x7fffffff));
-	mb();
-	udelay(20);
-	asm volatile("mtdec %0" : : "r" (0x7fffffff));
+
 	return 0;
 }
 
@@ -902,12 +900,7 @@ struct smp_ops_t core99_smp_ops = {
 	.give_timebase	= smp_core99_give_timebase,
 	.take_timebase	= smp_core99_take_timebase,
 #if defined(CONFIG_HOTPLUG_CPU)
-# if defined(CONFIG_PPC32)
 	.cpu_disable	= smp_core99_cpu_disable,
-# endif
-# if defined(CONFIG_PPC64)
-	.cpu_disable	= generic_cpu_disable,
-# endif
 	.cpu_die	= generic_cpu_die,
 #endif
 };
-- 
1.7.1
