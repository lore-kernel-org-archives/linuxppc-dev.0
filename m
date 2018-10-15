Return-Path: <SRS0=mWF2=M3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77DFC070C3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 03:02:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BC5F2086A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 03:02:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BC5F2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42YNX21WQpzDqlD
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 14:02:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: lists.ozlabs.org; spf=permerror (mailfrom)
 smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57;
 helo=gate.crashing.org; envelope-from=benh@kernel.crashing.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42YNJ84YVlzF0hg
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 13:51:52 +1100 (AEDT)
Received: from pasglop.ozlabs.ibm.com (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w9F2o7jM008210;
 Sun, 14 Oct 2018 21:50:16 -0500
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 05/12] powerpc/prom_init: Remove support for OPAL v2
Date: Mon, 15 Oct 2018 13:49:53 +1100
Message-Id: <20181015025000.4522-5-benh@kernel.crashing.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181015025000.4522-1-benh@kernel.crashing.org>
References: <20181015025000.4522-1-benh@kernel.crashing.org>
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

We removed support for running under any OPAL version
earlier than v3 in 2015 (they never saw the light of day
anyway), but we kept some leftovers of this support in
prom_init.c, so let's take it out.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/prom_init.c | 125 +++-----------------------------
 1 file changed, 10 insertions(+), 115 deletions(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 9942bfca12e4..9852cdb8bb9e 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -43,7 +43,6 @@
 #include <asm/btext.h>
 #include <asm/sections.h>
 #include <asm/machdep.h>
-#include <asm/opal.h>
 #include <asm/asm-prototypes.h>
 
 #include <linux/linux_logo.h>
@@ -191,7 +190,6 @@ struct platform_support {
 #define PLATFORM_LPAR		0x0001
 #define PLATFORM_POWERMAC	0x0400
 #define PLATFORM_GENERIC	0x0500
-#define PLATFORM_OPAL		0x0600
 
 static int __prombss of_platform;
 
@@ -684,7 +682,7 @@ static void __init early_cmdline_parse(void)
 		prom_debug("Radix disabled from cmdline\n");
 }
 
-#if defined(CONFIG_PPC_PSERIES) || defined(CONFIG_PPC_POWERNV)
+#ifdef CONFIG_PPC_PSERIES
 /*
  * The architecture vector has an array of PVR mask/value pairs,
  * followed by # option vectors - 1, followed by the option vectors.
@@ -1228,7 +1226,7 @@ static void __init prom_send_capabilities(void)
 	}
 #endif /* __BIG_ENDIAN__ */
 }
-#endif /* #if defined(CONFIG_PPC_PSERIES) || defined(CONFIG_PPC_POWERNV) */
+#endif /* CONFIG_PPC_PSERIES */
 
 /*
  * Memory allocation strategy... our layout is normally:
@@ -1565,88 +1563,6 @@ static void __init prom_close_stdin(void)
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
-	prom_printf("instantiating opal at 0x%llx...", base);
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
-	prom_debug("opal base     = 0x%llx\n", base);
-	prom_debug("opal align    = 0x%llx\n", align);
-	prom_debug("opal entry    = 0x%llx\n", entry);
-	prom_debug("opal size     = 0x%llx\n", size);
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
@@ -2153,10 +2069,6 @@ static int __init prom_find_machine_type(void)
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
@@ -2485,7 +2397,7 @@ static void __init scan_dt_build_struct(phandle node, unsigned long *mem_start,
 	}
 
 	/* Add a "linux,phandle" property if no "phandle" property already
-	 * existed (can happen with OPAL)
+	 * existed.
 	 */
 	if (!has_phandle) {
 		soff = dt_find_string("linux,phandle");
@@ -3175,7 +3087,7 @@ unsigned long __init prom_init(unsigned long r3, unsigned long r4,
 	 */
 	early_cmdline_parse();
 
-#if defined(CONFIG_PPC_PSERIES) || defined(CONFIG_PPC_POWERNV)
+#ifdef CONFIG_PPC_PSERIES
 	/*
 	 * On pSeries, inform the firmware about our capabilities
 	 */
@@ -3219,15 +3131,9 @@ unsigned long __init prom_init(unsigned long r3, unsigned long r4,
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
@@ -3240,8 +3146,7 @@ unsigned long __init prom_init(unsigned long r3, unsigned long r4,
 	 *
 	 * (This must be done after instanciating RTAS)
 	 */
-	if (of_platform != PLATFORM_POWERMAC &&
-	    of_platform != PLATFORM_OPAL)
+	if (of_platform != PLATFORM_POWERMAC)
 		prom_hold_cpus();
 
 	/*
@@ -3285,11 +3190,9 @@ unsigned long __init prom_init(unsigned long r3, unsigned long r4,
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
@@ -3307,10 +3210,8 @@ unsigned long __init prom_init(unsigned long r3, unsigned long r4,
 	hdr = dt_header_start;
 
 	/* Don't print anything after quiesce under OPAL, it crashes OFW */
-	if (of_platform != PLATFORM_OPAL) {
-		prom_printf("Booting Linux via __start() @ 0x%lx ...\n", kbase);
-		prom_debug("->dt_header_start=0x%lx\n", hdr);
-	}
+	prom_printf("Booting Linux via __start() @ 0x%lx ...\n", kbase);
+	prom_debug("->dt_header_start=0x%lx\n", hdr);
 
 #ifdef CONFIG_PPC32
 	reloc_got2(-offset);
@@ -3318,13 +3219,7 @@ unsigned long __init prom_init(unsigned long r3, unsigned long r4,
 	unreloc_toc();
 #endif
 
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
2.17.1

