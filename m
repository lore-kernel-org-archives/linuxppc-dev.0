Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp06.au.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A273AB6EEB
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Mar 2011 17:37:40 +1100 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp06.au.ibm.com (8.14.4/8.13.1) with ESMTP id p286bbdI000654
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Mar 2011 17:37:37 +1100
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p286beV82416862
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Mar 2011 17:37:40 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p286bdqj005190
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Mar 2011 17:37:39 +1100
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 13/18] powerpc/smp: Add a smp_ops->bringup_up() done callback
Date: Tue,  8 Mar 2011 17:37:25 +1100
Message-Id: <1299566250-10516-14-git-send-email-benh@kernel.crashing.org>
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

This allows us to stop abusing smp_ops->setup_cpu() for cleanup
tasks that have to take place after the initial boot time CPU
bringup.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/machdep.h |    1 +
 arch/powerpc/kernel/smp.c          |    4 ++++
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index 578d330..e4f0191 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -35,6 +35,7 @@ struct smp_ops_t {
 	int   (*probe)(void);
 	void  (*kick_cpu)(int nr);
 	void  (*setup_cpu)(int nr);
+	void  (*bringup_done)(void);
 	void  (*take_timebase)(void);
 	void  (*give_timebase)(void);
 	int   (*cpu_disable)(void);
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index f6cc5c1..df37397 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -553,7 +553,11 @@ void __init smp_cpus_done(unsigned int max_cpus)
 
 	free_cpumask_var(old_mask);
 
+	if (smp_ops && smp_ops->bringup_done)
+		smp_ops->bringup_done();
+
 	dump_numa_cpu_topology();
+
 }
 
 int arch_sd_sibling_asym_packing(void)
-- 
1.7.1
