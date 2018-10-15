Return-Path: <SRS0=mWF2=M3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA02C070C3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 03:09:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9C3F20659
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 03:09:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9C3F20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42YNhN6hChzF36w
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 14:09:24 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42YNJJ4FnvzF38K
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 13:52:00 +1100 (AEDT)
Received: from pasglop.ozlabs.ibm.com (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w9F2o7jL008210;
 Sun, 14 Oct 2018 21:50:15 -0500
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 04/12] powerpc/prom_init: Replace __initdata with __prombss
 when applicable
Date: Mon, 15 Oct 2018 13:49:52 +1100
Message-Id: <20181015025000.4522-4-benh@kernel.crashing.org>
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

This replaces all occurrences of __initdata for uninitialized
data with a new __prombss

Currently __promdata is defined to be __initdata but we'll
eventually change that.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/prom_init.c | 55 +++++++++++++++++----------------
 1 file changed, 29 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 2e1ebf26e8e4..9942bfca12e4 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -48,6 +48,9 @@
 
 #include <linux/linux_logo.h>
 
+/* All of prom_init bss lives here */
+#define __prombss __initdata
+
 /*
  * Eventually bump that one up
  */
@@ -87,7 +90,7 @@
 #define OF_WORKAROUNDS	0
 #else
 #define OF_WORKAROUNDS	of_workarounds
-static int of_workarounds __promdata;
+static int of_workarounds __prombss;
 #endif
 
 #define OF_WA_CLAIM	1	/* do phys/virt claim separately, then map */
@@ -148,26 +151,26 @@ extern void copy_and_flush(unsigned long dest, unsigned long src,
 			   unsigned long size, unsigned long offset);
 
 /* prom structure */
-static struct prom_t __initdata prom;
+static struct prom_t __prombss prom;
 
-static unsigned long prom_entry __initdata;
+static unsigned long __prombss prom_entry;
 
 #define PROM_SCRATCH_SIZE 256
 
-static char __initdata of_stdout_device[256];
-static char __initdata prom_scratch[PROM_SCRATCH_SIZE];
+static char __prombss of_stdout_device[256];
+static char __prombss prom_scratch[PROM_SCRATCH_SIZE];
 
-static unsigned long __initdata dt_header_start;
-static unsigned long __initdata dt_struct_start, dt_struct_end;
-static unsigned long __initdata dt_string_start, dt_string_end;
+static unsigned long __prombss dt_header_start;
+static unsigned long __prombss dt_struct_start, dt_struct_end;
+static unsigned long __prombss dt_string_start, dt_string_end;
 
-static unsigned long __initdata prom_initrd_start, prom_initrd_end;
+static unsigned long __prombss prom_initrd_start, prom_initrd_end;
 
 #ifdef CONFIG_PPC64
-static int __initdata prom_iommu_force_on;
-static int __initdata prom_iommu_off;
-static unsigned long __initdata prom_tce_alloc_start;
-static unsigned long __initdata prom_tce_alloc_end;
+static int __prombss prom_iommu_force_on;
+static int __prombss prom_iommu_off;
+static unsigned long __prombss prom_tce_alloc_start;
+static unsigned long __prombss prom_tce_alloc_end;
 #endif
 
 static bool prom_radix_disable __initdata = !IS_ENABLED(CONFIG_PPC_RADIX_MMU_DEFAULT);
@@ -190,22 +193,22 @@ struct platform_support {
 #define PLATFORM_GENERIC	0x0500
 #define PLATFORM_OPAL		0x0600
 
-static int __initdata of_platform;
+static int __prombss of_platform;
 
-static char __initdata prom_cmd_line[COMMAND_LINE_SIZE];
+static char __prombss prom_cmd_line[COMMAND_LINE_SIZE];
 
-static unsigned long __initdata prom_memory_limit;
+static unsigned long __prombss prom_memory_limit;
 
-static unsigned long __initdata alloc_top;
-static unsigned long __initdata alloc_top_high;
-static unsigned long __initdata alloc_bottom;
-static unsigned long __initdata rmo_top;
-static unsigned long __initdata ram_top;
+static unsigned long __prombss alloc_top;
+static unsigned long __prombss alloc_top_high;
+static unsigned long __prombss alloc_bottom;
+static unsigned long __prombss rmo_top;
+static unsigned long __prombss ram_top;
 
-static struct mem_map_entry __initdata mem_reserve_map[MEM_RESERVE_MAP_SIZE];
-static int __initdata mem_reserve_cnt;
+static struct mem_map_entry __prombss mem_reserve_map[MEM_RESERVE_MAP_SIZE];
+static int __prombss mem_reserve_cnt;
 
-static cell_t __initdata regbuf[1024];
+static cell_t __prombss regbuf[1024];
 
 static bool rtas_has_query_cpu_stopped;
 
@@ -1565,8 +1568,8 @@ static void __init prom_close_stdin(void)
 #ifdef CONFIG_PPC_POWERNV
 
 #ifdef CONFIG_PPC_EARLY_DEBUG_OPAL
-static u64 __initdata prom_opal_base;
-static u64 __initdata prom_opal_entry;
+static u64 __prombss prom_opal_base;
+static u64 __prombss prom_opal_entry;
 #endif
 
 /*
-- 
2.17.1

