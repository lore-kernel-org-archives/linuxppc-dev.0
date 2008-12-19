Return-Path: <gerickson@nuovations.com>
Received: from relay03.pair.com (relay03.pair.com [209.68.5.17])
	by ozlabs.org (Postfix) with SMTP id 27550DDD0B
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Dec 2008 05:18:00 +1100 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Const-qualify Device Node Argument to DCR Resource Extent API
Date: Fri, 19 Dec 2008 10:17:54 -0800
Message-Id: <1229710674-30301-1-git-send-email-gerickson@nuovations.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add const qualifier to device_node argument for
dcr_resource_{start,len} as of_get_property also const-qualifies this
argument.

Signed-off-by: Grant Erickson <gerickson@nuovations.com>
---
 arch/powerpc/include/asm/dcr.h |    4 ++--
 arch/powerpc/sysdev/dcr.c      |    5 +++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/dcr.h b/arch/powerpc/include/asm/dcr.h
index d13fb68..9d6851c 100644
--- a/arch/powerpc/include/asm/dcr.h
+++ b/arch/powerpc/include/asm/dcr.h
@@ -68,9 +68,9 @@ typedef dcr_host_mmio_t dcr_host_t;
  * additional helpers to read the DCR * base from the device-tree
  */
 struct device_node;
-extern unsigned int dcr_resource_start(struct device_node *np,
+extern unsigned int dcr_resource_start(const struct device_node *np,
 				       unsigned int index);
-extern unsigned int dcr_resource_len(struct device_node *np,
+extern unsigned int dcr_resource_len(const struct device_node *np,
 				     unsigned int index);
 #endif /* CONFIG_PPC_DCR */
 #endif /* __ASSEMBLY__ */
diff --git a/arch/powerpc/sysdev/dcr.c b/arch/powerpc/sysdev/dcr.c
index a8ba998..bb44aa9 100644
--- a/arch/powerpc/sysdev/dcr.c
+++ b/arch/powerpc/sysdev/dcr.c
@@ -124,7 +124,8 @@ EXPORT_SYMBOL_GPL(dcr_write_generic);
 
 #endif /* defined(CONFIG_PPC_DCR_NATIVE) && defined(CONFIG_PPC_DCR_MMIO) */
 
-unsigned int dcr_resource_start(struct device_node *np, unsigned int index)
+unsigned int dcr_resource_start(const struct device_node *np,
+				unsigned int index)
 {
 	unsigned int ds;
 	const u32 *dr = of_get_property(np, "dcr-reg", &ds);
@@ -136,7 +137,7 @@ unsigned int dcr_resource_start(struct device_node *np, unsigned int index)
 }
 EXPORT_SYMBOL_GPL(dcr_resource_start);
 
-unsigned int dcr_resource_len(struct device_node *np, unsigned int index)
+unsigned int dcr_resource_len(const struct device_node *np, unsigned int index)
 {
 	unsigned int ds;
 	const u32 *dr = of_get_property(np, "dcr-reg", &ds);
-- 
1.6.0.5
