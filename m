Return-Path: <Haiying.Wang@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe005.messaging.microsoft.com [216.32.180.31])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 54E122C00B7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Nov 2013 06:30:54 +1100 (EST)
Subject: [PATCH] iommu/fsl_pamu: use physical cpu index to find the matched
 cpu nodes
From: Haiying Wang <Haiying.Wang@freescale.com>
To: <joro@8bytes.org>, <iommu@lists.linux-foundation.org>,
 <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 14 Nov 2013 14:30:40 -0500
Message-ID: <1384457440.2144.15.camel@haiying-laptop>
MIME-Version: 1.0
Cc: Varun Sethi <Varun.Sethi@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In the case we miss to bring up some cpus, we need to make sure we can
find the correct cpu nodes in the device tree based on the given logical
cpu index from the caller.

Signed-off-by: Haiying Wang <Haiying.Wang@freescale.com>
---
 drivers/iommu/fsl_pamu.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/iommu/fsl_pamu.c b/drivers/iommu/fsl_pamu.c
index cba0498..a9ab57b 100644
--- a/drivers/iommu/fsl_pamu.c
+++ b/drivers/iommu/fsl_pamu.c
@@ -539,6 +539,7 @@ u32 get_stash_id(u32 stash_dest_hint, u32 vcpu)
 	u32 cache_level;
 	int len, found = 0;
 	int i;
+	u32 cpuid = get_hard_smp_processor_id(vcpu);
 
 	/* Fastpath, exit early if L3/CPC cache is target for stashing */
 	if (stash_dest_hint == PAMU_ATTR_CACHE_L3) {
@@ -559,7 +560,7 @@ u32 get_stash_id(u32 stash_dest_hint, u32 vcpu)
 	for_each_node_by_type(node, "cpu") {
 		prop = of_get_property(node, "reg", &len);
 		for (i = 0; i < len / sizeof(u32); i++) {
-			if (be32_to_cpup(&prop[i]) == vcpu) {
+			if (be32_to_cpup(&prop[i]) == cpuid) {
 				found = 1;
 				goto found_cpu_node;
 			}
-- 
1.7.3.1.50.g1e633
