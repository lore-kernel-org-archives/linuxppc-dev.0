Return-Path: <chenhui.zhao@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0141.outbound.protection.outlook.com [65.55.169.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C5FF01A1D07
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2015 23:08:33 +1000 (AEST)
From: Chenhui Zhao <chenhui.zhao@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <scottwood@freescale.com>
CC: <linux-kernel@vger.kernel.org>, <Jason.Jin@freescale.com>
Subject: [PATCH 2/4] powerpc: get the physical base address of DCSR
Date: Fri, 31 Jul 2015 20:53:04 +0800
Message-ID: <1438347186-8462-2-git-send-email-chenhui.zhao@freescale.com>
In-Reply-To: <1438347186-8462-1-git-send-email-chenhui.zhao@freescale.com>
References: <1438347186-8462-1-git-send-email-chenhui.zhao@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add get_dcsrbase() to get the physical base address of DCSR.

Signed-off-by: Chenhui Zhao <chenhui.zhao@freescale.com>
---
 arch/powerpc/sysdev/fsl_soc.c | 31 +++++++++++++++++++++++++++++++
 arch/powerpc/sysdev/fsl_soc.h |  1 +
 2 files changed, 32 insertions(+)

diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index 99269c0..ffb7c1c 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -45,6 +45,37 @@ extern void init_fcc_ioports(struct fs_platform_info*);
 extern void init_fec_ioports(struct fs_platform_info*);
 extern void init_smc_ioports(struct fs_uart_platform_info*);
 static phys_addr_t immrbase = -1;
+static phys_addr_t dcsrbase = -1;
+
+phys_addr_t get_dcsrbase(void)
+{
+	struct device_node *np;
+	const __be32 *prop;
+	int size;
+	u32 naddr;
+
+	if (dcsrbase != -1)
+		return dcsrbase;
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,dcsr");
+	if (!np)
+		return -1;
+
+	prop = of_get_property(np, "#address-cells", &size);
+	if (prop && size == 4)
+		naddr = be32_to_cpup(prop);
+	else
+		naddr = 2;
+
+	prop = of_get_property(np, "ranges", NULL);
+	if (prop)
+		dcsrbase = of_translate_address(np, prop + naddr);
+
+	of_node_put(np);
+
+	return dcsrbase;
+}
+EXPORT_SYMBOL(get_dcsrbase);
 
 phys_addr_t get_immrbase(void)
 {
diff --git a/arch/powerpc/sysdev/fsl_soc.h b/arch/powerpc/sysdev/fsl_soc.h
index 4c5a19e..5fdd3a5 100644
--- a/arch/powerpc/sysdev/fsl_soc.h
+++ b/arch/powerpc/sysdev/fsl_soc.h
@@ -6,6 +6,7 @@
 
 struct spi_device;
 
+extern phys_addr_t get_dcsrbase(void);
 extern phys_addr_t get_immrbase(void);
 #if defined(CONFIG_CPM2) || defined(CONFIG_QUICC_ENGINE) || defined(CONFIG_8xx)
 extern u32 get_brgfreq(void);
-- 
1.9.1
