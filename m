Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 83168B7251
	for <linuxppc-dev@ozlabs.org>; Sun, 11 Sep 2011 00:20:37 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 12/21] powerpc/powernv: Add support for instanciating OPAL v2
	from Open Firmware
Date: Sat, 10 Sep 2011 11:19:59 -0300
Message-Id: <1315664408-16797-12-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1315664408-16797-1-git-send-email-benh@kernel.crashing.org>
References: <1315664408-16797-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

OPAL v2 is instantiated in a way similar to RTAS using Open Firmware
client interface calls, and the resulting address and entry point are
put in the device-tree

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/prom_init.c |  136 +++++++++++++++++++++++++++++++++------
 1 files changed, 117 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index e3f3904..4ef74ea 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -140,7 +140,9 @@ struct mem_map_entry {
 
 typedef u32 cell_t;
 
-extern void __start(unsigned long r3, unsigned long r4, unsigned long r5);
+extern void __start(unsigned long r3, unsigned long r4, unsigned long r5,
+		    unsigned long r6, unsigned long r7, unsigned long r8,
+		    unsigned long r9);
 
 #ifdef CONFIG_PPC64
 extern int enter_prom(struct prom_args *args, unsigned long entry);
@@ -1293,6 +1295,11 @@ static int __initdata prom_rtas_start_cpu;
 static u64 __initdata prom_rtas_data;
 static u64 __initdata prom_rtas_entry;
 
+#ifdef CONFIG_PPC_EARLY_DEBUG_OPAL
+static u64 __initdata prom_opal_base;
+static u64 __initdata prom_opal_entry;
+#endif
+
 /* XXX Don't change this structure without updating opal-takeover.S */
 static struct opal_secondary_data {
 	s64				ack;	/*  0 */
@@ -1468,6 +1475,76 @@ static void prom_opal_takeover(void)
 	for (;;)
 		opal_do_takeover(args);
 }
+
+/*
+ * Allocate room for and instantiate OPAL
+ */
+static void __init prom_instantiate_opal(void)
+{
+	phandle opal_node;
+	ihandle opal_inst;
+	u64 base, entry;
+	u64 size = 0, align = 0x10000;
+	u32 rets[2];
+
+	prom_debug("prom_instantiate_opal: start...\n");
+
+	opal_node = call_prom("finddevice", 1, 1, ADDR("/ibm,opal"));
+	prom_debug("opal_node: %x\n", opal_node);
+	if (!PHANDLE_VALID(opal_node))
+		return;
+
+	prom_getprop(opal_node, "opal-runtime-size", &size, sizeof(size));
+	if (size == 0)
+		return;
+	prom_getprop(opal_node, "opal-runtime-alignment", &align,
+		     sizeof(align));
+
+	base = alloc_down(size, align, 0);
+	if (base == 0) {
+		prom_printf("OPAL allocation failed !\n");
+		return;
+	}
+
+	opal_inst = call_prom("open", 1, 1, ADDR("/ibm,opal"));
+	if (!IHANDLE_VALID(opal_inst)) {
+		prom_printf("opening opal package failed (%x)\n", opal_inst);
+		return;
+	}
+
+	prom_printf("instantiating opal at 0x%x...", base);
+
+	if (call_prom_ret("call-method", 4, 3, rets,
+			  ADDR("load-opal-runtime"),
+			  opal_inst,
+			  base >> 32, base & 0xffffffff) != 0
+	    || (rets[0] == 0 && rets[1] == 0)) {
+		prom_printf(" failed\n");
+		return;
+	}
+	entry = (((u64)rets[0]) << 32) | rets[1];
+
+	prom_printf(" done\n");
+
+	reserve_mem(base, size);
+
+	prom_debug("opal base     = 0x%x\n", base);
+	prom_debug("opal align    = 0x%x\n", align);
+	prom_debug("opal entry    = 0x%x\n", entry);
+	prom_debug("opal size     = 0x%x\n", (long)size);
+
+	prom_setprop(opal_node, "/ibm,opal", "opal-base-address",
+		     &base, sizeof(base));
+	prom_setprop(opal_node, "/ibm,opal", "opal-entry-address",
+		     &entry, sizeof(entry));
+
+#ifdef CONFIG_PPC_EARLY_DEBUG_OPAL
+	RELOC(prom_opal_base) = base;
+	RELOC(prom_opal_entry) = entry;
+#endif
+	prom_debug("prom_instantiate_opal: end...\n");
+}
+
 #endif /* CONFIG_PPC_POWERNV */
 
 /*
@@ -1863,7 +1940,7 @@ static int __init prom_find_machine_type(void)
 	int x;
 #endif
 
-	/* Look for a PowerMac */
+	/* Look for a PowerMac or a Cell */
 	len = prom_getprop(_prom->root, "compatible",
 			   compat, sizeof(compat)-1);
 	if (len > 0) {
@@ -1889,7 +1966,11 @@ static int __init prom_find_machine_type(void)
 		}
 	}
 #ifdef CONFIG_PPC64
-	/* If not a mac, try to figure out if it's an IBM pSeries or any other
+	/* Try to detect OPAL */
+	if (PHANDLE_VALID(call_prom("finddevice", 1, 1, ADDR("/ibm,opal"))))
+		return PLATFORM_OPAL;
+
+	/* Try to figure out if it's an IBM pSeries or any other
 	 * PAPR compliant platform. We assume it is if :
 	 *  - /device_type is "chrp" (please, do NOT use that for future
 	 *    non-IBM designs !
@@ -2116,7 +2197,7 @@ static void __init scan_dt_build_struct(phandle node, unsigned long *mem_start,
 	unsigned long soff;
 	unsigned char *valp;
 	static char pname[MAX_PROPERTY_NAME];
-	int l, room;
+	int l, room, has_phandle;
 
 	dt_push_token(OF_DT_BEGIN_NODE, mem_start, mem_end);
 
@@ -2200,19 +2281,26 @@ static void __init scan_dt_build_struct(phandle node, unsigned long *mem_start,
 		valp = make_room(mem_start, mem_end, l, 4);
 		call_prom("getprop", 4, 1, node, RELOC(pname), valp, l);
 		*mem_start = _ALIGN(*mem_start, 4);
+
+		if (!strcmp(RELOC(pname), RELOC("phandle")))
+			has_phandle = 1;
 	}
 
-	/* Add a "linux,phandle" property. */
-	soff = dt_find_string(RELOC("linux,phandle"));
-	if (soff == 0)
-		prom_printf("WARNING: Can't find string index for"
-			    " <linux-phandle> node %s\n", path);
-	else {
-		dt_push_token(OF_DT_PROP, mem_start, mem_end);
-		dt_push_token(4, mem_start, mem_end);
-		dt_push_token(soff, mem_start, mem_end);
-		valp = make_room(mem_start, mem_end, 4, 4);
-		*(u32 *)valp = node;
+	/* Add a "linux,phandle" property if no "phandle" property already
+	 * existed (can happen with OPAL)
+	 */
+	if (!has_phandle) {
+		soff = dt_find_string(RELOC("linux,phandle"));
+		if (soff == 0)
+			prom_printf("WARNING: Can't find string index for"
+				    " <linux-phandle> node %s\n", path);
+		else {
+			dt_push_token(OF_DT_PROP, mem_start, mem_end);
+			dt_push_token(4, mem_start, mem_end);
+			dt_push_token(soff, mem_start, mem_end);
+			valp = make_room(mem_start, mem_end, 4, 4);
+			*(u32 *)valp = node;
+		}
 	}
 
 	/* do all our children */
@@ -2746,6 +2834,7 @@ unsigned long __init prom_init(unsigned long r3, unsigned long r4,
 	 * between pSeries SMP and pSeries LPAR
 	 */
 	RELOC(of_platform) = prom_find_machine_type();
+	prom_printf("Detected machine type: %x\n", RELOC(of_platform));
 
 #ifndef CONFIG_RELOCATABLE
 	/* Bail if this is a kdump kernel. */
@@ -2807,7 +2896,8 @@ unsigned long __init prom_init(unsigned long r3, unsigned long r4,
 	 * On non-powermacs, try to instantiate RTAS. PowerMacs don't
 	 * have a usable RTAS implementation.
 	 */
-	if (RELOC(of_platform) != PLATFORM_POWERMAC)
+	if (RELOC(of_platform) != PLATFORM_POWERMAC &&
+	    RELOC(of_platform) != PLATFORM_OPAL)
 		prom_instantiate_rtas();
 
 #ifdef CONFIG_PPC_POWERNV
@@ -2818,7 +2908,8 @@ unsigned long __init prom_init(unsigned long r3, unsigned long r4,
 			prom_opal_hold_cpus();
 			prom_opal_takeover();
 		}
-	}
+	} else if (RELOC(of_platform) == PLATFORM_OPAL)
+		prom_instantiate_opal();
 #endif
 
 	/*
@@ -2826,7 +2917,8 @@ unsigned long __init prom_init(unsigned long r3, unsigned long r4,
 	 *
 	 * PowerMacs use a different mechanism to spin CPUs
 	 */
-	if (RELOC(of_platform) != PLATFORM_POWERMAC)
+	if (RELOC(of_platform) != PLATFORM_POWERMAC &&
+	    RELOC(of_platform) != PLATFORM_OPAL)
 		prom_hold_cpus();
 
 	/*
@@ -2894,7 +2986,13 @@ unsigned long __init prom_init(unsigned long r3, unsigned long r4,
 	reloc_got2(-offset);
 #endif
 
-	__start(hdr, kbase, 0);
+#ifdef CONFIG_PPC_EARLY_DEBUG_OPAL
+	/* OPAL early debug gets the OPAL base & entry in r8 and r9 */
+	__start(hdr, kbase, 0, 0, 0,
+		RELOC(prom_opal_base), RELOC(prom_opal_entry));
+#else
+	__start(hdr, kbase, 0, 0, 0, 0, 0);
+#endif
 
 	return 0;
 }
-- 
1.7.4.1
