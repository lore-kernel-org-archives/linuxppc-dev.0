Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 1AD27DE038
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jan 2009 10:54:31 +1100 (EST)
Date: Wed, 7 Jan 2009 10:54:25 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc: remove unnecessary casts
Message-Id: <20090107105425.395d7bde.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

of_get_flat_dt_prop() returns a "void *", so we don't need to cast when
assigning its result to a pointer variable.
---
 arch/powerpc/kernel/prom.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

This will help when we to the l64 to ll64 switch as well.

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 6f73c73..c09cffa 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -824,11 +824,11 @@ static int __init early_init_dt_scan_chosen(unsigned long node,
 #endif
 
 #ifdef CONFIG_KEXEC
-	lprop = (u64*)of_get_flat_dt_prop(node, "linux,crashkernel-base", NULL);
+	lprop = of_get_flat_dt_prop(node, "linux,crashkernel-base", NULL);
 	if (lprop)
 		crashk_res.start = *lprop;
 
-	lprop = (u64*)of_get_flat_dt_prop(node, "linux,crashkernel-size", NULL);
+	lprop = of_get_flat_dt_prop(node, "linux,crashkernel-size", NULL);
 	if (lprop)
 		crashk_res.end = crashk_res.start + *lprop - 1;
 #endif
@@ -893,12 +893,12 @@ static int __init early_init_dt_scan_drconf_memory(unsigned long node)
 	u64 base, size, lmb_size;
 	unsigned int is_kexec_kdump = 0, rngs;
 
-	ls = (cell_t *)of_get_flat_dt_prop(node, "ibm,lmb-size", &l);
+	ls = of_get_flat_dt_prop(node, "ibm,lmb-size", &l);
 	if (ls == NULL || l < dt_root_size_cells * sizeof(cell_t))
 		return 0;
 	lmb_size = dt_mem_next_cell(dt_root_size_cells, &ls);
 
-	dm = (cell_t *)of_get_flat_dt_prop(node, "ibm,dynamic-memory", &l);
+	dm = of_get_flat_dt_prop(node, "ibm,dynamic-memory", &l);
 	if (dm == NULL || l < sizeof(cell_t))
 		return 0;
 
@@ -907,7 +907,7 @@ static int __init early_init_dt_scan_drconf_memory(unsigned long node)
 		return 0;
 
 	/* check if this is a kexec/kdump kernel. */
-	usm = (cell_t *)of_get_flat_dt_prop(node, "linux,drconf-usable-memory",
+	usm = of_get_flat_dt_prop(node, "linux,drconf-usable-memory",
 						 &l);
 	if (usm != NULL)
 		is_kexec_kdump = 1;
@@ -981,9 +981,9 @@ static int __init early_init_dt_scan_memory(unsigned long node,
 	} else if (strcmp(type, "memory") != 0)
 		return 0;
 
-	reg = (cell_t *)of_get_flat_dt_prop(node, "linux,usable-memory", &l);
+	reg = of_get_flat_dt_prop(node, "linux,usable-memory", &l);
 	if (reg == NULL)
-		reg = (cell_t *)of_get_flat_dt_prop(node, "reg", &l);
+		reg = of_get_flat_dt_prop(node, "reg", &l);
 	if (reg == NULL)
 		return 0;
 
-- 
1.6.0.5

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
