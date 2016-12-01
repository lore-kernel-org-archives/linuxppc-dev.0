Return-Path: <srinivas.kandagatla@linaro.org>
Received: from mail-wm0-x234.google.com (mail-wm0-x234.google.com
 [IPv6:2a00:1450:400c:c09::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tTwcs1ZQTzDvnx
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Dec 2016 22:52:12 +1100 (AEDT)
Received: by mail-wm0-x234.google.com with SMTP id t79so245126359wmt.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Dec 2016 03:52:12 -0800 (PST)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Jingoo Han <jingoohan1@gmail.com>,
 Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Javier Martinez Canillas <javier@osg.samsung.com>,
 Richard Zhu <Richard.Zhu@freescale.com>,
 Lucas Stach <l.stach@pengutronix.de>,
 Murali Karicheri <m-karicheri2@ti.com>,
 Minghuan Lian <minghuan.Lian@freescale.com>,
 Mingkai Hu <mingkai.hu@freescale.com>,
 Roy Zang <tie-fei.zang@freescale.com>,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Jose Abreu <Jose.Abreu@synopsys.com>,
 Pratyush Anand <pratyush.anand@gmail.com>,
 Stanimir Varbanov <svarbanov@mm-sol.com>, linux-omap@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-msm@vger.kernel.org,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RFC PATCH] PCI: designware: add host_init() error handling
Date: Thu,  1 Dec 2016 11:51:17 +0000
Message-Id: <1480593077-15402-1-git-send-email-srinivas.kandagatla@linaro.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch add support to return value from host_init() callback from
drivers,so that the designware library can handle or pass it to proper
place. Issue with void return type is that errors or error handling
within host_init() callback are never know to designware code, which
could go ahead and access registers even in error cases.

Typical case in qcom controller driver is to turn off clks in case of
errors, if designware code continues to read/write register when clocks
are turned off the board would reboot/lockup.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---

Currently designware code does not have a way return errors generated
as part of host_init() callback in controller drivers. This is an issue
with controller drivers like qcom which turns off the clocks in error
handling path. As the dw core is un aware of this would continue to
access registers which faults resulting in board reboots/hangs. 

There are two ways to solve this issue,
one is remove error handling in the qcom controller host_init() function
other is to handle error and pass back to dw core code which would then
pass back to controller driver as part of dw_pcie_host_init() return value.

Second option seems more sensible and correct way to fix the issue,
this patch does the same.

As part of this change to host_init() return type I had to patch other
host controller drivers which use dw core. Most of these changes are
harmless as I have not added any extra code other then returning 0
from host_init().

 drivers/pci/host/pci-dra7xx.c           |  4 +++-
 drivers/pci/host/pci-exynos.c           |  4 +++-
 drivers/pci/host/pci-imx6.c             |  4 +++-
 drivers/pci/host/pci-keystone.c         |  4 +++-
 drivers/pci/host/pci-layerscape.c       | 12 ++++++++----
 drivers/pci/host/pcie-armada8k.c        |  4 +++-
 drivers/pci/host/pcie-designware-plat.c |  4 +++-
 drivers/pci/host/pcie-designware.c      |  4 +++-
 drivers/pci/host/pcie-designware.h      |  2 +-
 drivers/pci/host/pcie-qcom.c            |  6 ++++--
 drivers/pci/host/pcie-spear13xx.c       |  4 +++-
 11 files changed, 37 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/host/pci-dra7xx.c b/drivers/pci/host/pci-dra7xx.c
index 9595fad..f63491c 100644
--- a/drivers/pci/host/pci-dra7xx.c
+++ b/drivers/pci/host/pci-dra7xx.c
@@ -127,7 +127,7 @@ static void dra7xx_pcie_enable_interrupts(struct dra7xx_pcie *dra7xx)
 				   LEG_EP_INTERRUPTS);
 }
 
-static void dra7xx_pcie_host_init(struct pcie_port *pp)
+static int dra7xx_pcie_host_init(struct pcie_port *pp)
 {
 	struct dra7xx_pcie *dra7xx = to_dra7xx_pcie(pp);
 
@@ -142,6 +142,8 @@ static void dra7xx_pcie_host_init(struct pcie_port *pp)
 	if (IS_ENABLED(CONFIG_PCI_MSI))
 		dw_pcie_msi_init(pp);
 	dra7xx_pcie_enable_interrupts(dra7xx);
+
+	return 0;
 }
 
 static struct pcie_host_ops dra7xx_pcie_host_ops = {
diff --git a/drivers/pci/host/pci-exynos.c b/drivers/pci/host/pci-exynos.c
index f1c544b..b5a8f11 100644
--- a/drivers/pci/host/pci-exynos.c
+++ b/drivers/pci/host/pci-exynos.c
@@ -458,12 +458,14 @@ static int exynos_pcie_link_up(struct pcie_port *pp)
 	return 0;
 }
 
-static void exynos_pcie_host_init(struct pcie_port *pp)
+static int exynos_pcie_host_init(struct pcie_port *pp)
 {
 	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pp);
 
 	exynos_pcie_establish_link(exynos_pcie);
 	exynos_pcie_enable_interrupts(exynos_pcie);
+
+	return 0;
 }
 
 static struct pcie_host_ops exynos_pcie_host_ops = {
diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index c8cefb0..4844367 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -550,7 +550,7 @@ static int imx6_pcie_establish_link(struct imx6_pcie *imx6_pcie)
 	return ret;
 }
 
-static void imx6_pcie_host_init(struct pcie_port *pp)
+static int imx6_pcie_host_init(struct pcie_port *pp)
 {
 	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pp);
 
@@ -562,6 +562,8 @@ static void imx6_pcie_host_init(struct pcie_port *pp)
 
 	if (IS_ENABLED(CONFIG_PCI_MSI))
 		dw_pcie_msi_init(pp);
+
+	return 0;
 }
 
 static int imx6_pcie_link_up(struct pcie_port *pp)
diff --git a/drivers/pci/host/pci-keystone.c b/drivers/pci/host/pci-keystone.c
index 043c19a..fded7f9 100644
--- a/drivers/pci/host/pci-keystone.c
+++ b/drivers/pci/host/pci-keystone.c
@@ -260,7 +260,7 @@ static int keystone_pcie_fault(unsigned long addr, unsigned int fsr,
 	return 0;
 }
 
-static void __init ks_pcie_host_init(struct pcie_port *pp)
+static int __init ks_pcie_host_init(struct pcie_port *pp)
 {
 	struct keystone_pcie *ks_pcie = to_keystone_pcie(pp);
 	u32 val;
@@ -287,6 +287,8 @@ static void __init ks_pcie_host_init(struct pcie_port *pp)
 	 */
 	hook_fault_code(17, keystone_pcie_fault, SIGBUS, 0,
 			"Asynchronous external abort");
+
+	return 0;
 }
 
 static struct pcie_host_ops keystone_pcie_host_ops = {
diff --git a/drivers/pci/host/pci-layerscape.c b/drivers/pci/host/pci-layerscape.c
index 6537079..d3a7266 100644
--- a/drivers/pci/host/pci-layerscape.c
+++ b/drivers/pci/host/pci-layerscape.c
@@ -103,7 +103,7 @@ static int ls1021_pcie_link_up(struct pcie_port *pp)
 	return 1;
 }
 
-static void ls1021_pcie_host_init(struct pcie_port *pp)
+static int ls1021_pcie_host_init(struct pcie_port *pp)
 {
 	struct device *dev = pp->dev;
 	struct ls_pcie *pcie = to_ls_pcie(pp);
@@ -114,19 +114,21 @@ static void ls1021_pcie_host_init(struct pcie_port *pp)
 	if (IS_ERR(pcie->scfg)) {
 		dev_err(dev, "No syscfg phandle specified\n");
 		pcie->scfg = NULL;
-		return;
+		return 0;
 	}
 
 	if (of_property_read_u32_array(dev->of_node,
 				       "fsl,pcie-scfg", index, 2)) {
 		pcie->scfg = NULL;
-		return;
+		return 0;
 	}
 	pcie->index = index[1];
 
 	dw_pcie_setup_rc(pp);
 
 	ls_pcie_drop_msg_tlp(pcie);
+
+	return 0;
 }
 
 static int ls_pcie_link_up(struct pcie_port *pp)
@@ -144,7 +146,7 @@ static int ls_pcie_link_up(struct pcie_port *pp)
 	return 1;
 }
 
-static void ls_pcie_host_init(struct pcie_port *pp)
+static int ls_pcie_host_init(struct pcie_port *pp)
 {
 	struct ls_pcie *pcie = to_ls_pcie(pp);
 
@@ -153,6 +155,8 @@ static void ls_pcie_host_init(struct pcie_port *pp)
 	ls_pcie_clear_multifunction(pcie);
 	ls_pcie_drop_msg_tlp(pcie);
 	iowrite32(0, pcie->pp.dbi_base + PCIE_DBI_RO_WR_EN);
+
+	return 0;
 }
 
 static int ls_pcie_msi_host_init(struct pcie_port *pp,
diff --git a/drivers/pci/host/pcie-armada8k.c b/drivers/pci/host/pcie-armada8k.c
index 0ac0f18..29bdd8b 100644
--- a/drivers/pci/host/pcie-armada8k.c
+++ b/drivers/pci/host/pcie-armada8k.c
@@ -134,12 +134,14 @@ static void armada8k_pcie_establish_link(struct armada8k_pcie *pcie)
 		dev_err(pp->dev, "Link not up after reconfiguration\n");
 }
 
-static void armada8k_pcie_host_init(struct pcie_port *pp)
+static int armada8k_pcie_host_init(struct pcie_port *pp)
 {
 	struct armada8k_pcie *pcie = to_armada8k_pcie(pp);
 
 	dw_pcie_setup_rc(pp);
 	armada8k_pcie_establish_link(pcie);
+
+	return 0;
 }
 
 static irqreturn_t armada8k_pcie_irq_handler(int irq, void *arg)
diff --git a/drivers/pci/host/pcie-designware-plat.c b/drivers/pci/host/pcie-designware-plat.c
index 8df6312..a4f146a 100644
--- a/drivers/pci/host/pcie-designware-plat.c
+++ b/drivers/pci/host/pcie-designware-plat.c
@@ -35,13 +35,15 @@ static irqreturn_t dw_plat_pcie_msi_irq_handler(int irq, void *arg)
 	return dw_handle_msi_irq(pp);
 }
 
-static void dw_plat_pcie_host_init(struct pcie_port *pp)
+static int dw_plat_pcie_host_init(struct pcie_port *pp)
 {
 	dw_pcie_setup_rc(pp);
 	dw_pcie_wait_for_link(pp);
 
 	if (IS_ENABLED(CONFIG_PCI_MSI))
 		dw_pcie_msi_init(pp);
+
+	return 0;
 }
 
 static struct pcie_host_ops dw_plat_pcie_host_ops = {
diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index bed1999..4a81b72 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -638,7 +638,9 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	}
 
 	if (pp->ops->host_init)
-		pp->ops->host_init(pp);
+		ret = pp->ops->host_init(pp);
+			if (ret < 0)
+				goto error;
 
 	pp->root_bus_nr = pp->busn->start;
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
diff --git a/drivers/pci/host/pcie-designware.h b/drivers/pci/host/pcie-designware.h
index a567ea2..eacf18f 100644
--- a/drivers/pci/host/pcie-designware.h
+++ b/drivers/pci/host/pcie-designware.h
@@ -63,7 +63,7 @@ struct pcie_host_ops {
 	int (*wr_other_conf)(struct pcie_port *pp, struct pci_bus *bus,
 			unsigned int devfn, int where, int size, u32 val);
 	int (*link_up)(struct pcie_port *pp);
-	void (*host_init)(struct pcie_port *pp);
+	int (*host_init)(struct pcie_port *pp);
 	void (*msi_set_irq)(struct pcie_port *pp, int irq);
 	void (*msi_clear_irq)(struct pcie_port *pp, int irq);
 	phys_addr_t (*get_msi_addr)(struct pcie_port *pp);
diff --git a/drivers/pci/host/pcie-qcom.c b/drivers/pci/host/pcie-qcom.c
index f37c690..14f730a 100644
--- a/drivers/pci/host/pcie-qcom.c
+++ b/drivers/pci/host/pcie-qcom.c
@@ -582,7 +582,7 @@ static void qcom_pcie_deinit_v2(struct qcom_pcie *pcie)
 	clk_disable_unprepare(res->pipe_clk);
 }
 
-static void qcom_pcie_host_init(struct pcie_port *pp)
+static int qcom_pcie_host_init(struct pcie_port *pp)
 {
 	struct qcom_pcie *pcie = to_qcom_pcie(pp);
 	int ret;
@@ -611,12 +611,14 @@ static void qcom_pcie_host_init(struct pcie_port *pp)
 	if (ret)
 		goto err;
 
-	return;
+	return ret;
 err:
 	qcom_ep_reset_assert(pcie);
 	phy_power_off(pcie->phy);
 err_deinit:
 	pcie->ops->deinit(pcie);
+
+	return ret;
 }
 
 static int qcom_pcie_rd_own_conf(struct pcie_port *pp, int where, int size,
diff --git a/drivers/pci/host/pcie-spear13xx.c b/drivers/pci/host/pcie-spear13xx.c
index 3cf197b..5f7ae90 100644
--- a/drivers/pci/host/pcie-spear13xx.c
+++ b/drivers/pci/host/pcie-spear13xx.c
@@ -174,12 +174,14 @@ static int spear13xx_pcie_link_up(struct pcie_port *pp)
 	return 0;
 }
 
-static void spear13xx_pcie_host_init(struct pcie_port *pp)
+static int spear13xx_pcie_host_init(struct pcie_port *pp)
 {
 	struct spear13xx_pcie *spear13xx_pcie = to_spear13xx_pcie(pp);
 
 	spear13xx_pcie_establish_link(spear13xx_pcie);
 	spear13xx_pcie_enable_interrupts(spear13xx_pcie);
+
+	return 0;
 }
 
 static struct pcie_host_ops spear13xx_pcie_host_ops = {
-- 
2.10.1
