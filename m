Return-Path: <SRS0=IbMY=PZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36325C43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 12:23:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B018720652
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 12:23:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B018720652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43gNWp5BNjzDqsL
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 23:23:02 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43gNJw2XJYzDqkL
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jan 2019 23:13:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 43gNJw0McSz9sDT; Thu, 17 Jan 2019 23:13:36 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 43gNJv5Lrnz9sDP; Thu, 17 Jan 2019 23:13:35 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/4] powerpc/64s: Move SLB init into hash_utils_64.c
Date: Thu, 17 Jan 2019 23:13:27 +1100
Message-Id: <20190117121328.13395-3-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190117121328.13395-1-mpe@ellerman.id.au>
References: <20190117121328.13395-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The SLB initialisation code is spread around a bit between prom.c and
hash_utils_64.c. Consolidate it all in hash_utils_64.c.

This slightly changes the timing of when mmu_slb_size is initialised,
but that should have no effect.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/prom.c      | 16 ----------------
 arch/powerpc/mm/hash_utils_64.c | 15 ++++++++++-----
 2 files changed, 10 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 14693f8ccb80..018ededd1948 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -229,21 +229,6 @@ static void __init check_cpu_pa_features(unsigned long node)
 		      ibm_pa_features, ARRAY_SIZE(ibm_pa_features));
 }
 
-#ifdef CONFIG_PPC_BOOK3S_64
-static void __init init_mmu_slb_size(unsigned long node)
-{
-	const __be32 *slb_size_ptr;
-
-	slb_size_ptr = of_get_flat_dt_prop(node, "slb-size", NULL) ? :
-			of_get_flat_dt_prop(node, "ibm,slb-size", NULL);
-
-	if (slb_size_ptr)
-		slb_set_size(be32_to_cpup(slb_size_ptr));
-}
-#else
-#define init_mmu_slb_size(node) do { } while(0)
-#endif
-
 static struct feature_property {
 	const char *name;
 	u32 min_value;
@@ -379,7 +364,6 @@ static int __init early_init_dt_scan_cpus(unsigned long node,
 	}
 
 	identical_pvr_fixup(node);
-	init_mmu_slb_size(node);
 
 #ifdef CONFIG_PPC64
 	if (nthreads == 1)
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 4aa0797000f7..33ce76be17de 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -344,9 +344,8 @@ static int __init parse_disable_1tb_segments(char *p)
 }
 early_param("disable_1tb_segments", parse_disable_1tb_segments);
 
-static int __init htab_dt_scan_seg_sizes(unsigned long node,
-					 const char *uname, int depth,
-					 void *data)
+static int __init htab_dt_scan_slb(unsigned long node, const char *uname,
+				   int depth, void *data)
 {
 	const char *type = of_get_flat_dt_prop(node, "device_type", NULL);
 	const __be32 *prop;
@@ -356,6 +355,12 @@ static int __init htab_dt_scan_seg_sizes(unsigned long node,
 	if (type == NULL || strcmp(type, "cpu") != 0)
 		return 0;
 
+	prop = of_get_flat_dt_prop(node, "slb-size", NULL);
+	if (!prop)
+		prop = of_get_flat_dt_prop(node, "ibm,slb-size", NULL);
+	if (prop)
+		slb_set_size(be32_to_cpup(prop));
+
 	prop = of_get_flat_dt_prop(node, "ibm,processor-segment-sizes", &size);
 	if (prop == NULL)
 		return 0;
@@ -954,8 +959,8 @@ static void __init htab_initialize(void)
 
 void __init hash__early_init_devtree(void)
 {
-	/* Initialize segment sizes */
-	of_scan_flat_dt(htab_dt_scan_seg_sizes, NULL);
+	/* Initialize SLB size and segment sizes */
+	of_scan_flat_dt(htab_dt_scan_slb, NULL);
 
 	/* Initialize page sizes */
 	htab_scan_page_sizes();
-- 
2.20.1

