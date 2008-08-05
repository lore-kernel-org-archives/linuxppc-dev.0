Return-Path: <jrigby@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 56E10DE198
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Aug 2008 06:13:46 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m75KDfvE008444
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Aug 2008 13:13:41 -0700 (MST)
Received: from localhost.localdomain (mvp-10-214-72-194.am.freescale.net
	[10.214.72.194])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m75KDeN9025312
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Aug 2008 15:13:40 -0500 (CDT)
From: John Rigby <jrigby@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH add immr alias 1/4] powerpc: Teach get_immrbase to use immr
	alias if it exists.
Date: Tue,  5 Aug 2008 14:13:37 -0600
Message-Id: <1217967220-30557-1-git-send-email-jrigby@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This will allow the eventual removal of device_type = "soc"
properties in soc nodes.

Signed-off-by: John Rigby <jrigby@freescale.com>
---
 arch/powerpc/sysdev/fsl_soc.c |   25 +++++++++++++++++++++++--
 1 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index 214388e..2643395 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -45,14 +45,35 @@ extern void init_fec_ioports(struct fs_platform_info*);
 extern void init_smc_ioports(struct fs_uart_platform_info*);
 static phys_addr_t immrbase = -1;
 
+/* 
+ * Some chips call this immr some ccsr, we
+ * use the term immr for both.
+ */
 phys_addr_t get_immrbase(void)
 {
-	struct device_node *soc;
+	struct device_node *soc = NULL;
+	struct device_node *np;
+	const char *path;
+
 
 	if (immrbase != -1)
 		return immrbase;
 
-	soc = of_find_node_by_type(NULL, "soc");
+	/*
+	 * First look for an immr alias
+	 */
+	np = of_find_node_by_name(NULL, "/aliases");
+	if (np) {
+		path = of_get_property(np, "immr", NULL);
+		if (path)
+			soc = of_find_node_by_name(NULL, path);
+	}
+	/*
+	 * If no immr alias then fall back to finding
+	 * it by device_type
+	 */
+	if (!soc)
+		soc = of_find_node_by_type(NULL, "soc");
 	if (soc) {
 		int size;
 		u32 naddr;
-- 
