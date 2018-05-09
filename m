Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40gyGS6qhFzF1QZ
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 May 2018 23:42:40 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/3] powerpc/prom: Clean up local variables in
 early_init_dt_scan_cpus()
Date: Wed,  9 May 2018 23:42:29 +1000
Message-Id: <20180509134229.26278-3-mpe@ellerman.id.au>
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

This is cosmetic, but the current arrangement is hell ugly, so clean
it up.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/prom.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 9edb0d0af986..0e47fb85f47d 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -308,12 +308,11 @@ static int __init early_init_dt_scan_cpus(unsigned long node,
 					  const char *uname, int depth,
 					  void *data)
 {
-	const char *type = of_get_flat_dt_prop(node, "device_type", NULL);
-	const __be32 *prop;
-	const __be32 *intserv;
-	int i, nthreads;
-	int len;
-	int found = -1, found_hwid = -1;
+	int i, len, nthreads, found_hwid, found;
+	const __be32 *prop, *intserv;
+	const char *type;
+
+	type = of_get_flat_dt_prop(node, "device_type", NULL);
 
 	/* We are scanning "cpu" nodes only */
 	if (type == NULL || strcmp(type, "cpu") != 0)
@@ -330,6 +329,7 @@ static int __init early_init_dt_scan_cpus(unsigned long node,
 	 * Now see if any of these threads match our boot cpu.
 	 * NOTE: This must match the parsing done in smp_setup_cpu_maps.
 	 */
+	found = found_hwid = -1;
 	for (i = 0; i < nthreads; i++) {
 		found_hwid = be32_to_cpu(intserv[i]);
 		if (found_hwid == fdt_boot_cpuid_phys(initial_boot_params))
-- 
2.14.1
