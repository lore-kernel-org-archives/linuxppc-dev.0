Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40gyGS0flwzF1QZ
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 May 2018 23:42:40 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/3] powerpc/prom: Save the boot CPU hardware id in a local
Date: Wed,  9 May 2018 23:42:28 +1000
Message-Id: <20180509134229.26278-2-mpe@ellerman.id.au>
In-Reply-To: <20180509134229.26278-1-mpe@ellerman.id.au>
References: <20180509134229.26278-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In early_init_dt_scan_cpus() we find the boot CPU, and get it's
hardware CPU number. Currently we do that by using the thread number
and doing be32_to_cpu(instserv[i]) three times.

The endian flips are not very efficient, but the main concern is just
that it's ugly to do the same flip in three places. Instead just put
the endian flipped value in a local and use it.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/prom.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 05e7fb47a7a4..9edb0d0af986 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -313,8 +313,7 @@ static int __init early_init_dt_scan_cpus(unsigned long node,
 	const __be32 *intserv;
 	int i, nthreads;
 	int len;
-	int found = -1;
-	int found_thread = 0;
+	int found = -1, found_hwid = -1;
 
 	/* We are scanning "cpu" nodes only */
 	if (type == NULL || strcmp(type, "cpu") != 0)
@@ -332,11 +331,9 @@ static int __init early_init_dt_scan_cpus(unsigned long node,
 	 * NOTE: This must match the parsing done in smp_setup_cpu_maps.
 	 */
 	for (i = 0; i < nthreads; i++) {
-		if (be32_to_cpu(intserv[i]) ==
-			fdt_boot_cpuid_phys(initial_boot_params)) {
+		found_hwid = be32_to_cpu(intserv[i]);
+		if (found_hwid == fdt_boot_cpuid_phys(initial_boot_params))
 			found = boot_cpu_count;
-			found_thread = i;
-		}
 #ifdef CONFIG_SMP
 		/* logical cpu id is always 0 on UP kernels */
 		boot_cpu_count++;
@@ -347,8 +344,7 @@ static int __init early_init_dt_scan_cpus(unsigned long node,
 	if (found < 0)
 		return 0;
 
-	DBG("boot cpu: logical %d physical %d\n", found,
-	    be32_to_cpu(intserv[found_thread]));
+	DBG("boot cpu: logical %d physical %d\n", found, found_hwid);
 	boot_cpuid = found;
 
 	/*
@@ -389,7 +385,7 @@ static int __init early_init_dt_scan_cpus(unsigned long node,
 		cur_cpu_spec->cpu_features |= CPU_FTR_SMT;
 	allocate_paca(boot_cpuid);
 #endif
-	set_hard_smp_processor_id(found, be32_to_cpu(intserv[found_thread]));
+	set_hard_smp_processor_id(found, found_hwid);
 
 	return 0;
 }
-- 
2.14.1
