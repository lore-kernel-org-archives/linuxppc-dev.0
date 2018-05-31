Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40xF424ZmQzDr30
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 May 2018 14:34:42 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 05/11] powerpc/prom_init: Remove support for OPAL v2
Date: Thu, 31 May 2018 14:33:43 +1000
Message-Id: <20180531043349.24783-6-benh@kernel.crashing.org>
In-Reply-To: <20180531043349.24783-1-benh@kernel.crashing.org>
References: <20180531043349.24783-1-benh@kernel.crashing.org>
Reply-To: [RFC.PATCH.00/11]prom_init.cleanups.and.sanitization@gate.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We removed support for running under any OPAL version
earlier than v3 in 2015 (they never saw the light of day
anyway), but we kept some leftovers of this support in
prom_init.c, so let's take it out.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/prom_init.c | 147 +++-----------------------------
 1 file changed, 10 insertions(+), 137 deletions(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index d60feccf4b27..7c3d285750ad 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -44,7 +44,6 @@
 #include <asm/btext.h>
 #include <asm/sections.h>
 #include <asm/machdep.h>
-#include <asm/opal.h>
 #include <asm/asm-prototypes.h>
 
 #include <linux/linux_logo.h>
@@ -192,7 +191,6 @@ struct platform_support {
 #define PLATFORM_LPAR		0x0001
 #define PLATFORM_POWERMAC	0x0400
 #define PLATFORM_GENERIC	0x0500
-#define PLATFORM_OPAL		0x0600
 
 static int __prombss of_platform;
 
@@ -659,7 +657,7 @@ static void __init early_cmdline_parse(void)
 		prom_debug("Radix disabled from cmdline\n");
 }
 
-#if defined(CONFIG_PPC_PSERIES) || defined(CONFIG_PPC_POWERNV)
+#ifdef CONFIG_PPC_PSERIES
 /*
  * The architecture vector has an array of PVR mask/value pairs,
  * followed by # option vectors - 1, followed by the option vectors.
@@ -1203,7 +1201,7 @@ static void __init prom_send_capabilities(void)
 	}
 #endif /* __BIG_ENDIAN__ */
 }
-#endif /* #if defined(CONFIG_PPC_PSERIES) || defined(CONFIG_PPC_POWERNV) */
+#endif /* CONFIG_PPC_PSERIES */
 
 /*
  * Memory allocation strategy... our layout is normally:
@@ -1534,88 +1532,6 @@ static void __init prom_close_stdin(void)
 	}
 }
 
-#ifdef CONFIG_PPC_POWERNV
-
-#ifdef CONFIG_PPC_EARLY_DEBUG_OPAL
-static u64 __prombss prom_opal_base;
-static u64 __prombss prom_opal_entry;
-#endif
-
-/*
- * Allocate room for and instantiate OPAL
- */
-static void __init prom_instantiate_opal(void)
-{
-	phandle opal_node;
-	ihandle opal_inst;
-	u64 base, entry;
-	u64 size = 0, align = 0x10000;
-	__be64 val64;
-	u32 rets[2];
-
-	prom_debug("prom_instantiate_opal: start...\n");
-
-	opal_node = call_prom("finddevice", 1, 1, ADDR("/ibm,opal"));
-	prom_debug("opal_node: %x\n", opal_node);
-	if (!PHANDLE_VALID(opal_node))
-		return;
-
-	val64 = 0;
-	prom_getprop(opal_node, "opal-runtime-size", &val64, sizeof(val64));
-	size = be64_to_cpu(val64);
-	if (size == 0)
-		return;
-	val64 = 0;
-	prom_getprop(opal_node, "opal-runtime-alignment", &val64,sizeof(val64));
-	align = be64_to_cpu(val64);
-
-	base = alloc_down(size, align, 0);
-	if (base == 0) {
-		prom_printf("OPAL allocation failed !\n");
-		return;
-	}
-
-	opal_inst = call_prom("open", 1, 1, ADDR("/ibm,opal"));
-	if (!IHANDLE_VALID(opal_inst)) {
-		prom_printf("opening opal package failed (%x)\n", opal_inst);
-		return;
-	}
-
-	prom_printf("instantiating opal at 0x%x...", base);
-
-	if (call_prom_ret("call-method", 4, 3, rets,
-			  ADDR("load-opal-runtime"),
-			  opal_inst,
-			  base >> 32, base & 0xffffffff) != 0
-	    || (rets[0] == 0 && rets[1] == 0)) {
-		prom_printf(" failed\n");
-		return;
-	}
-	entry = (((u64)rets[0]) << 32) | rets[1];
-
-	prom_printf(" done\n");
-
-	reserve_mem(base, size);
-
-	prom_debug("opal base     = 0x%x\n", base);
-	prom_debug("opal align    = 0x%x\n", align);
-	prom_debug("opal entry    = 0x%x\n", entry);
-	prom_debug("opal size     = 0x%x\n", (long)size);
-
-	prom_setprop(opal_node, "/ibm,opal", "opal-base-address",
-		     &base, sizeof(base));
-	prom_setprop(opal_node, "/ibm,opal", "opal-entry-address",
-		     &entry, sizeof(entry));
-
-#ifdef CONFIG_PPC_EARLY_DEBUG_OPAL
-	prom_opal_base = base;
-	prom_opal_entry = entry;
-#endif
-	prom_debug("prom_instantiate_opal: end...\n");
-}
-
-#endif /* CONFIG_PPC_POWERNV */
-
 /*
  * Allocate room for and instantiate RTAS
  */
@@ -2124,10 +2040,6 @@ static int __init prom_find_machine_type(void)
 		}
 	}
 #ifdef CONFIG_PPC64
-	/* Try to detect OPAL */
-	if (PHANDLE_VALID(call_prom("finddevice", 1, 1, ADDR("/ibm,opal"))))
-		return PLATFORM_OPAL;
-
 	/* Try to figure out if it's an IBM pSeries or any other
 	 * PAPR compliant platform. We assume it is if :
 	 *  - /device_type is "chrp" (please, do NOT use that for future
@@ -2373,7 +2285,7 @@ static void __init scan_dt_build_struct(phandle node, unsigned long *mem_start,
 	unsigned long soff;
 	unsigned char *valp;
 	static char pname[MAX_PROPERTY_NAME];
-	int l, room, has_phandle = 0;
+	int l, room;
 
 	dt_push_token(OF_DT_BEGIN_NODE, mem_start, mem_end);
 
@@ -2450,26 +2362,6 @@ static void __init scan_dt_build_struct(phandle node, unsigned long *mem_start,
 		valp = make_room(mem_start, mem_end, l, 4);
 		call_prom("getprop", 4, 1, node, pname, valp, l);
 		*mem_start = _ALIGN(*mem_start, 4);
-
-		if (!strcmp(pname, "phandle"))
-			has_phandle = 1;
-	}
-
-	/* Add a "linux,phandle" property if no "phandle" property already
-	 * existed (can happen with OPAL)
-	 */
-	if (!has_phandle) {
-		soff = dt_find_string("linux,phandle");
-		if (soff == 0)
-			prom_printf("WARNING: Can't find string index for"
-				    " <linux-phandle> node %s\n", path);
-		else {
-			dt_push_token(OF_DT_PROP, mem_start, mem_end);
-			dt_push_token(4, mem_start, mem_end);
-			dt_push_token(soff, mem_start, mem_end);
-			valp = make_room(mem_start, mem_end, 4, 4);
-			*(__be32 *)valp = cpu_to_be32(node);
-		}
 	}
 
 	/* do all our children */
@@ -3146,7 +3038,7 @@ unsigned long __init prom_init(unsigned long r3, unsigned long r4,
 	 */
 	early_cmdline_parse();
 
-#if defined(CONFIG_PPC_PSERIES) || defined(CONFIG_PPC_POWERNV)
+#ifdef CONFIG_PPC_PSERIES
 	/*
 	 * On pSeries, inform the firmware about our capabilities
 	 */
@@ -3190,15 +3082,9 @@ unsigned long __init prom_init(unsigned long r3, unsigned long r4,
 	 * On non-powermacs, try to instantiate RTAS. PowerMacs don't
 	 * have a usable RTAS implementation.
 	 */
-	if (of_platform != PLATFORM_POWERMAC &&
-	    of_platform != PLATFORM_OPAL)
+	if (of_platform != PLATFORM_POWERMAC)
 		prom_instantiate_rtas();
 
-#ifdef CONFIG_PPC_POWERNV
-	if (of_platform == PLATFORM_OPAL)
-		prom_instantiate_opal();
-#endif /* CONFIG_PPC_POWERNV */
-
 #ifdef CONFIG_PPC64
 	/* instantiate sml */
 	prom_instantiate_sml();
@@ -3211,8 +3097,7 @@ unsigned long __init prom_init(unsigned long r3, unsigned long r4,
 	 *
 	 * (This must be done after instanciating RTAS)
 	 */
-	if (of_platform != PLATFORM_POWERMAC &&
-	    of_platform != PLATFORM_OPAL)
+	if (of_platform != PLATFORM_POWERMAC)
 		prom_hold_cpus();
 
 	/*
@@ -3256,11 +3141,9 @@ unsigned long __init prom_init(unsigned long r3, unsigned long r4,
 	/*
 	 * in case stdin is USB and still active on IBM machines...
 	 * Unfortunately quiesce crashes on some powermacs if we have
-	 * closed stdin already (in particular the powerbook 101). It
-	 * appears that the OPAL version of OFW doesn't like it either.
+	 * closed stdin already (in particular the powerbook 101).
 	 */
-	if (of_platform != PLATFORM_POWERMAC &&
-	    of_platform != PLATFORM_OPAL)
+	if (of_platform != PLATFORM_POWERMAC)
 		prom_close_stdin();
 
 	/*
@@ -3277,25 +3160,15 @@ unsigned long __init prom_init(unsigned long r3, unsigned long r4,
 	 */
 	hdr = dt_header_start;
 
-	/* Don't print anything after quiesce under OPAL, it crashes OFW */
-	if (of_platform != PLATFORM_OPAL) {
-		prom_printf("Booting Linux via __start() @ 0x%lx ...\n", kbase);
-		prom_debug("->dt_header_start=0x%x\n", hdr);
-	}
+	prom_printf("Booting Linux via __start() @ 0x%lx ...\n", kbase);
+	prom_debug("->dt_header_start=0x%x\n", hdr);
 
 #ifdef CONFIG_PPC32
 	reloc_got2(-offset);
 #else
 	unreloc_toc();
 #endif
-
-#ifdef CONFIG_PPC_EARLY_DEBUG_OPAL
-	/* OPAL early debug gets the OPAL base & entry in r8 and r9 */
-	__start(hdr, kbase, 0, 0, 0,
-		prom_opal_base, prom_opal_entry);
-#else
 	__start(hdr, kbase, 0, 0, 0, 0, 0);
-#endif
 
 	return 0;
 }
-- 
2.17.0
