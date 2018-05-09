Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40gyGQ4NMJzF1QZ
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 May 2018 23:42:38 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/3] powerpc/prom: Drop support for old FDT versions
Date: Wed,  9 May 2018 23:42:27 +1000
Message-Id: <20180509134229.26278-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In commit e6a6928c3ea1 ("of/fdt: Convert FDT functions to use
libfdt") (Apr 2014), the generic flat device tree code dropped support
for flat device tree's older than version 0x10 (16).

We still have code in our CPU scanning to cope with flat device tree
versions earlier than 2, which can now never trigger, so drop it.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/prom.c | 23 ++++-------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 9dbed488aba1..05e7fb47a7a4 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -332,25 +332,10 @@ static int __init early_init_dt_scan_cpus(unsigned long node,
 	 * NOTE: This must match the parsing done in smp_setup_cpu_maps.
 	 */
 	for (i = 0; i < nthreads; i++) {
-		/*
-		 * version 2 of the kexec param format adds the phys cpuid of
-		 * booted proc.
-		 */
-		if (fdt_version(initial_boot_params) >= 2) {
-			if (be32_to_cpu(intserv[i]) ==
-			    fdt_boot_cpuid_phys(initial_boot_params)) {
-				found = boot_cpu_count;
-				found_thread = i;
-			}
-		} else {
-			/*
-			 * Check if it's the boot-cpu, set it's hw index now,
-			 * unfortunately this format did not support booting
-			 * off secondary threads.
-			 */
-			if (of_get_flat_dt_prop(node,
-					"linux,boot-cpu", NULL) != NULL)
-				found = boot_cpu_count;
+		if (be32_to_cpu(intserv[i]) ==
+			fdt_boot_cpuid_phys(initial_boot_params)) {
+			found = boot_cpu_count;
+			found_thread = i;
 		}
 #ifdef CONFIG_SMP
 		/* logical cpu id is always 0 on UP kernels */
-- 
2.14.1
