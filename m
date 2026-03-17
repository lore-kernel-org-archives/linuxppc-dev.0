Return-Path: <linuxppc-dev+bounces-18295-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D4A1FD707D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Mar 2026 11:17:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZqDD3xwtz2yj1;
	Tue, 17 Mar 2026 22:17:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773746220;
	cv=none; b=engNt7FHa7KkFCpZCxStcK0TrBnwkM3bGNCB56Ts7z/EQ8SGLzUWEDfvio29R0+1mNxfxSqxltwwJlcTpNwn1EWRF8Gnkia7Gx+v0o7i9o9b63utHbs4ZbY2ru2O7Z2BHjiWvD8VMG8dg8i6J8Aw7KcpsFtRS/EBD1IN/hi6YA1MgrcBIzp9w4GRF5e1xTlcOj7j8Whi1QUO7DOf12Nj4KiJ6ryjaKVHHSOdlR0dtqTDp+Ja3grRVwX8hLbW4EG73Judf2Q0nKjnfiJ/Dm4n6afw1RQPPRroxKqieLi0dFYhWCfrkcY6Z6lg3s5nrpuvuTUXRoxAW5SQF5lttKzsGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773746220; c=relaxed/relaxed;
	bh=OQLC7zrBdOMBaWUG9lnsW0syzGchACCgs4u5CwOarDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dufVJwvbBVAgSsFBSIbezMbeUlaWwMGWp1AwvIqCLK+XQcivarloeRM6nv0jX9Z6Mab2wCzSespIIbId1UgZvAL90Gzte4UpL1U/KNTINojd8C873Q0xP//sJRFQGZjw94blCWcsCxTOQ8Kai7w66FPBnRa8WKNcGTAGP9H4PhlSh50MxCmZ+ucafyQBR2pn5cLirgj2rIn80DecRMLq4HFliD6zIwxeRzGEa6qp6BWNuMiEGpKlXxN77pfWHwUJ01Cwzt9bpn9+RWDftthAKtZIZ15yuiy43ESbekExk6m75xMoxm2GyAPcZd529hyd2lMqWsmuGIQGi27+jiWkuA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=uaFwLzO8; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=cassel@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=uaFwLzO8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=cassel@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZqDC3rrsz2yfP
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2026 22:16:59 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 0263444458;
	Tue, 17 Mar 2026 11:16:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68824C4CEF7;
	Tue, 17 Mar 2026 11:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773746216;
	bh=QT+lbY9/xI/ADS68SjLkZ6KxcFgasXL+Xc+GdnIFe74=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uaFwLzO8bjL9By3OJ8nwOOanQikvV1XJXkwvbygj5WUi0CRTJiTdCQxfuZRogVEn/
	 ulEcpfi18dfPQ39FA+pnZqkfL2W20ZrYqBKBgCga3RqOHUvQpuJHW8kRQnONY9Twlz
	 zuu+rGnxN4SVmvq6DohbPbm5L/mxLA7TZyH1Esy1c3ZT6gnpLwgcHK4lEL5jYAVEPy
	 Z1CnBd8nUcfnUE7ekyowsB35vdsaarsVi8ZVQ5w7UbTpJ838s7CkQwTg4oDKRSJ1ma
	 y++mAlEQ6Z6Gxxnz98HcKHcIhvVQD3L3NsP3nuP7PuCCtzz8/1mTKq7gaeeC/Un7lL
	 CRkcAQxXWww1w==
Date: Tue, 17 Mar 2026 12:16:47 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: manivannan.sadhasivam@oss.qualcomm.com,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>, Will Deacon <will@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Lukas Wunner <lukas@wunner.de>, Richard Zhu <hongxing.zhu@nxp.com>,
	Brian Norris <briannorris@chromium.org>,
	Wilson Ding <dingwei@marvell.com>, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v7 0/4] PCI: Add support for resetting the Root Ports in
 a platform specific way
Message-ID: <abk3rU2EDKjkefUD@ryzen>
References: <20260310-pci-port-reset-v7-0-9dd00ccc25ab@oss.qualcomm.com>
 <abFMa6DCGGLUHddA@fedora>
 <dp2rem4gj7zhfgykvekmcrhq4ticm6m6ido6tbgflwzfcuuwkl@4wuxgle27eyx>
 <srdn3bspgwff7f7tnst7wzg4us4buifrv7o3ylo527hmuciyl3@6ioyrl6rfhaz>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="A15YEQnAzhPrJ5mF"
Content-Disposition: inline
In-Reply-To: <srdn3bspgwff7f7tnst7wzg4us4buifrv7o3ylo527hmuciyl3@6ioyrl6rfhaz>


--A15YEQnAzhPrJ5mF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 11, 2026 at 08:44:15PM +0530, Manivannan Sadhasivam wrote:
> On Wed, Mar 11, 2026 at 08:09:53PM +0530, Manivannan Sadhasivam wrote:
> > On Wed, Mar 11, 2026 at 12:05:15PM +0100, Niklas Cassel wrote:
> > > On Tue, Mar 10, 2026 at 07:31:58PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > > > Changes in v7:
> > > > - Dropped Rockchip Root port reset patch due to reported issues. But the series
> > > >   works on other platforms as tested by others.
> > > 
> > > Are you referring to
> > > 
> > > ## On EP side:
> > > # echo 0 > /sys/kernel/config/pci_ep/controllers/a40000000.pcie-ep/start && \
> > >   sleep 0.1 && echo 1 > /sys/kernel/config/pci_ep/controllers/a40000000.pcie-ep/start
> > > 
> > > Then running pcitest only having 7 / 16 tests passed ?
> > > 
> > > If so, isn't that a problem also for qcom?
> > > 
> > 
> > No, tests are passing on my setup after link up.
> > 
> > > 
> > > There is no chance that the patch:
> > > "misc: pci_endpoint_test: Add AER error handlers"
> > > improves things in this regard?
> > > 
> > > Or will it simply avoid the "AER: device recovery failed" print?
> > > 
> > 
> > Yes, as mentioned in the commit message, it just avoids the AER recovery failure
> > message.
> > 
> 
> I also realized that Endpoint state is not saved in all the code paths. So the
> pci_endpoint_test driver has to save/restore the state also. But it is still not
> clear why that didn't help you.
> 
> Can you share the snapshot of the entire config space before and after reset
> using 'lspci -xxxx -s "0000:01:00"'?

If I don't add something like:

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 1eced7a419eb..9d7ee39164d4 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -1059,6 +1059,9 @@ static int pci_endpoint_test_set_irq(struct pci_endpoint_test *test,
                return ret;
        }
 
+       pr_info("saving PCI state (irq_type: %d)\n", req_irq_type);
+       pci_save_state(pdev);
+
        return 0;
 }
 
@@ -1453,6 +1456,7 @@ static pci_ers_result_t pci_endpoint_test_error_detected(struct pci_dev *pdev,
 
 static pci_ers_result_t pci_endpoint_test_slot_reset(struct pci_dev *pdev)
 {
+       pci_restore_state(pdev);
        return PCI_ERS_RESULT_RECOVERED;
 }

On top of your patch.

Then all the BAR tests + MSI and MSI-X tests fail.

There is a huge difference in lspci -vvv output (as I guess is expected),
including all BARs being marked as disabled.


With the patch above. There is zero difference before/after reset, and all
the BAR tests pass. However, MSI/MSI-X tests still fail with:

# pci_endpoint_test.c:143:MSI_TEST:Expected 0 (0) == ret (-110) 
# pci_endpoint_test.c:143:MSI_TEST:Test failed for MSI1

ETIMEDOUT.

This suggests that pci_endpoint_test on the host side did not receive an
interrupt.

I don't know why, but considering that lspci output is now (with the
save+restore) identical, I assume that the problem is not related to
the host. Unless somehow the host will use a new/different MSI address
after the root port has been reset, and we restore the old MSI address,
but looking at the code, dw_pcie_msi_init() is called by
dw_pcie_setup_rc(), so I would expect the MSI address to be the same.


I will be very busy for a few weeks, so I don't have time to debug this.
If anyone wants to debug this on rk3588, I'm attaching the patches for
this new feature for rk3588 that can be applied on top of this series.

Personally, I'm fine with this series getting merged even though this
new feature will only be supported by the QCOM driver.
But, I don't understand how e.g. pci endpoint test can work on QCOM
platforms, after the root port has been reset, without something like
the save/restore diff above.


Kind regards,
Niklas

--A15YEQnAzhPrJ5mF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename=0001-Revert-PCI-dw-rockchip-Simplify-regulator-setup-with.patch

From c6416291bdbe2a3964b60183492208b41208f5a0 Mon Sep 17 00:00:00 2001
From: Niklas Cassel <cassel@kernel.org>
Date: Tue, 17 Mar 2026 09:59:09 +0100
Subject: [PATCH 1/2] Revert "PCI: dw-rockchip: Simplify regulator setup with
 devm_regulator_get_enable_optional()"

This reverts commit c930b10f17c03858cfe19b9873ba5240128b4d1b.
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 23 ++++++++++++++-----
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 8db27199cfa6..bec42fe646d8 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -95,6 +95,7 @@ struct rockchip_pcie {
 	unsigned int clk_cnt;
 	struct reset_control *rst;
 	struct gpio_desc *rst_gpio;
+	struct regulator *vpcie3v3;
 	struct irq_domain *irq_domain;
 	const struct rockchip_pcie_of_data *data;
 	bool supports_clkreq;
@@ -673,15 +674,22 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 		return ret;
 
 	/* DON'T MOVE ME: must be enable before PHY init */
-	ret = devm_regulator_get_enable_optional(dev, "vpcie3v3");
-	if (ret < 0 && ret != -ENODEV)
-		return dev_err_probe(dev, ret,
-				     "failed to enable vpcie3v3 regulator\n");
+	rockchip->vpcie3v3 = devm_regulator_get_optional(dev, "vpcie3v3");
+	if (IS_ERR(rockchip->vpcie3v3)) {
+		if (PTR_ERR(rockchip->vpcie3v3) != -ENODEV)
+			return dev_err_probe(dev, PTR_ERR(rockchip->vpcie3v3),
+					"failed to get vpcie3v3 regulator\n");
+		rockchip->vpcie3v3 = NULL;
+	} else {
+		ret = regulator_enable(rockchip->vpcie3v3);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "failed to enable vpcie3v3 regulator\n");
+	}
 
 	ret = rockchip_pcie_phy_init(rockchip);
 	if (ret)
-		return dev_err_probe(dev, ret,
-				     "failed to initialize the phy\n");
+		goto disable_regulator;
 
 	ret = reset_control_deassert(rockchip->rst);
 	if (ret)
@@ -714,6 +722,9 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 	clk_bulk_disable_unprepare(rockchip->clk_cnt, rockchip->clks);
 deinit_phy:
 	rockchip_pcie_phy_deinit(rockchip);
+disable_regulator:
+	if (rockchip->vpcie3v3)
+		regulator_disable(rockchip->vpcie3v3);
 
 	return ret;
 }
-- 
2.53.0


--A15YEQnAzhPrJ5mF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename=0002-PCI-dw-rockchip-Add-support-to-reset-Root-Port-upon-.patch

From 47b29e709bb209b2877a072cd3a9c3e5f1b66399 Mon Sep 17 00:00:00 2001
From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
Date: Tue, 17 Mar 2026 09:30:57 +0100
Subject: [PATCH 2/2] PCI: dw-rockchip: Add support to reset Root Port upon
 link down event

The PCIe link may go down in cases like firmware crashes or unstable
connections. When this occurs, the PCIe Root Port must be reset to restore
the functionality. However, the current driver lacks link down handling,
forcing users to reboot the system to recover.

This patch implements the `reset_root_port` callback for link down handling
for Rockchip DWC PCIe host controller. In which, the RC is reset,
reconfigured and link training initiated to recover from the link down
event.

This also by extension fixes issues with sysfs initiated bus resets. In
that, currently, when a sysfs initiated bus reset is issued, the endpoint
device is non-functional after (may link up with downgraded link status).
With the link down handling support, a sysfs initiated bus reset works as
intended. Testing conducted on a ROCK5B board with an M.2 NVMe drive.

Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
---
 drivers/pci/controller/dwc/Kconfig            |   1 +
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 137 +++++++++++++++++-
 2 files changed, 135 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index d0aa031397fa..ecaf79da843b 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -361,6 +361,7 @@ config PCIE_ROCKCHIP_DW_HOST
 	depends on OF
 	select PCIE_DW_HOST
 	select PCIE_ROCKCHIP_DW
+	select PCI_HOST_COMMON
 	help
 	  Enables support for the DesignWare PCIe controller in the
 	  Rockchip SoC (except RK3399) to work in host mode.
diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index bec42fe646d8..75928057acee 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -24,6 +24,7 @@
 #include <linux/reset.h>
 
 #include "../../pci.h"
+#include "../pci-host-common.h"
 #include "pcie-designware.h"
 
 /*
@@ -106,6 +107,9 @@ struct rockchip_pcie_of_data {
 	const struct pci_epc_features *epc_features;
 };
 
+static int rockchip_pcie_rc_reset_root_port(struct pci_host_bridge *bridge,
+				       struct pci_dev *pdev);
+
 static int rockchip_pcie_readl_apb(struct rockchip_pcie *rockchip, u32 reg)
 {
 	return readl_relaxed(rockchip->apb_base + reg);
@@ -326,6 +330,7 @@ static int rockchip_pcie_host_init(struct dw_pcie_rp *pp)
 
 	rockchip_pcie_configure_l1ss(pci);
 	rockchip_pcie_enable_l0s(pci);
+	pp->bridge->reset_root_port = rockchip_pcie_rc_reset_root_port;
 
 	/* Disable Root Ports BAR0 and BAR1 as they report bogus size */
 	dw_pcie_writel_dbi2(pci, PCI_BASE_ADDRESS_0, 0x0);
@@ -524,6 +529,32 @@ static const struct dw_pcie_ops dw_pcie_ops = {
 	.get_ltssm = rockchip_pcie_get_ltssm,
 };
 
+static irqreturn_t rockchip_pcie_rc_sys_irq_thread(int irq, void *arg)
+{
+	struct rockchip_pcie *rockchip = arg;
+	struct dw_pcie *pci = &rockchip->pci;
+	struct dw_pcie_rp *pp = &pci->pp;
+	struct device *dev = pci->dev;
+	struct pci_dev *port;
+	u32 reg;
+
+	reg = rockchip_pcie_readl_apb(rockchip, PCIE_CLIENT_INTR_STATUS_MISC);
+	rockchip_pcie_writel_apb(rockchip, reg, PCIE_CLIENT_INTR_STATUS_MISC);
+
+	dev_dbg(dev, "PCIE_CLIENT_INTR_STATUS_MISC: %#x\n", reg);
+	dev_dbg(dev, "LTSSM_STATUS: %#x\n", rockchip_pcie_get_ltssm_reg(rockchip));
+
+	if (reg & PCIE_LINK_REQ_RST_NOT_INT) {
+		dev_dbg(dev, "hot reset or link-down reset\n");
+		for_each_pci_bridge(port, pp->bridge->bus) {
+			if (pci_pcie_type(port) == PCI_EXP_TYPE_ROOT_PORT)
+				pci_host_handle_link_down(port);
+		}
+	}
+
+	return IRQ_HANDLED;
+}
+
 static irqreturn_t rockchip_pcie_ep_sys_irq_thread(int irq, void *arg)
 {
 	struct rockchip_pcie *rockchip = arg;
@@ -556,14 +587,29 @@ static irqreturn_t rockchip_pcie_ep_sys_irq_thread(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
-static int rockchip_pcie_configure_rc(struct rockchip_pcie *rockchip)
+static int rockchip_pcie_configure_rc(struct platform_device *pdev,
+				      struct rockchip_pcie *rockchip)
 {
+	struct device *dev = &pdev->dev;
 	struct dw_pcie_rp *pp;
+	int irq, ret;
 	u32 val;
 
 	if (!IS_ENABLED(CONFIG_PCIE_ROCKCHIP_DW_HOST))
 		return -ENODEV;
 
+	irq = platform_get_irq_byname(pdev, "sys");
+	if (irq < 0)
+		return irq;
+
+	ret = devm_request_threaded_irq(dev, irq, NULL,
+					rockchip_pcie_rc_sys_irq_thread,
+					IRQF_ONESHOT, "pcie-sys-rc", rockchip);
+	if (ret) {
+		dev_err(dev, "failed to request PCIe sys IRQ\n");
+		return ret;
+	}
+
 	/* LTSSM enable control mode */
 	val = FIELD_PREP_WM16(PCIE_LTSSM_ENABLE_ENHANCE, 1);
 	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_HOT_RESET_CTRL);
@@ -575,7 +621,17 @@ static int rockchip_pcie_configure_rc(struct rockchip_pcie *rockchip)
 	pp = &rockchip->pci.pp;
 	pp->ops = &rockchip_pcie_host_ops;
 
-	return dw_pcie_host_init(pp);
+	ret = dw_pcie_host_init(pp);
+	if (ret) {
+		dev_err(dev, "failed to initialize host\n");
+		return ret;
+	}
+
+	/* unmask hot reset/link-down reset */
+	val = FIELD_PREP_WM16(PCIE_LINK_REQ_RST_NOT_INT, 0);
+	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_INTR_MASK_MISC);
+
+	return ret;
 }
 
 static int rockchip_pcie_configure_ep(struct platform_device *pdev,
@@ -701,7 +757,7 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 
 	switch (data->mode) {
 	case DW_PCIE_RC_TYPE:
-		ret = rockchip_pcie_configure_rc(rockchip);
+		ret = rockchip_pcie_configure_rc(pdev, rockchip);
 		if (ret)
 			goto deinit_clk;
 		break;
@@ -729,6 +785,81 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static int rockchip_pcie_rc_reset_root_port(struct pci_host_bridge *bridge,
+					    struct pci_dev *pdev)
+{
+	struct pci_bus *bus = bridge->bus;
+	struct dw_pcie_rp *pp = bus->sysdata;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
+	struct device *dev = rockchip->pci.dev;
+	u32 val;
+	int ret;
+
+	dw_pcie_stop_link(pci);
+	clk_bulk_disable_unprepare(rockchip->clk_cnt, rockchip->clks);
+	rockchip_pcie_phy_deinit(rockchip);
+
+	ret = reset_control_assert(rockchip->rst);
+	if (ret)
+		return ret;
+
+	ret = rockchip_pcie_phy_init(rockchip);
+	if (ret)
+		goto disable_regulator;
+
+	ret = reset_control_deassert(rockchip->rst);
+	if (ret)
+		goto deinit_phy;
+
+	ret = rockchip_pcie_clk_init(rockchip);
+	if (ret)
+		goto deinit_phy;
+
+	ret = pp->ops->init(pp);
+	if (ret) {
+		dev_err(dev, "Host init failed: %d\n", ret);
+		goto deinit_clk;
+	}
+
+	/* LTSSM enable control mode */
+	val = FIELD_PREP_WM16(PCIE_LTSSM_ENABLE_ENHANCE, 1);
+	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_HOT_RESET_CTRL);
+
+	rockchip_pcie_writel_apb(rockchip,
+				 PCIE_CLIENT_SET_MODE(PCIE_CLIENT_MODE_RC),
+				 PCIE_CLIENT_GENERAL_CON);
+
+	ret = dw_pcie_setup_rc(pp);
+	if (ret) {
+		dev_err(dev, "Failed to setup RC: %d\n", ret);
+		goto deinit_clk;
+	}
+
+	/* unmask hot reset/link-down reset */
+	val = FIELD_PREP_WM16(PCIE_LINK_REQ_RST_NOT_INT, 0);
+	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_INTR_MASK_MISC);
+
+	ret = dw_pcie_start_link(pci);
+	if (ret)
+		goto deinit_clk;
+
+	/* Ignore errors, the link may come up later */
+	dw_pcie_wait_for_link(pci);
+	dev_dbg(dev, "Root Port reset completed\n");
+	return ret;
+
+deinit_clk:
+	clk_bulk_disable_unprepare(rockchip->clk_cnt, rockchip->clks);
+deinit_phy:
+	rockchip_pcie_phy_deinit(rockchip);
+disable_regulator:
+	if (rockchip->vpcie3v3)
+		regulator_disable(rockchip->vpcie3v3);
+
+	return ret;
+}
+
 static const struct rockchip_pcie_of_data rockchip_pcie_rc_of_data_rk3568 = {
 	.mode = DW_PCIE_RC_TYPE,
 };
-- 
2.53.0


--A15YEQnAzhPrJ5mF--

