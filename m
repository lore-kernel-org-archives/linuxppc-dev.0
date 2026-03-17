Return-Path: <linuxppc-dev+bounces-18315-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8DD4FD8763
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Mar 2026 13:11:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZsmd3dwSz2yjN;
	Wed, 18 Mar 2026 00:11:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773753105;
	cv=none; b=bmIUuqAIkVrYCXbFcKJJXsrBqXuDHhMHsHqHUZOq5cd75XM3iE0ImhKoJgP5ZrMOeeT/lzzNUZa/SjYHbISpeQ9hmOyOxRISmKFrR97M/dLybB/5Hzlb+7//1oyXWsHpY5qyvYWyg/xpraKYM+rcQbvWUksSHxF/2/mz0OHUfRX6hiy6VOJrnydAYX/pr4v3/8rOOrLF/6paz3gma2sGRHnVHPY2pf21ml1a3wVmgY+Juqp1C0xsFbji93c5gIO8mlaxL1JWZnwoQvZZi5W5qYS0g9tVodxTVE7CIyOkWJwkXy3IwhmnZK8k6PrWEWXZDQ65ohr3MLqgxVgMaTAqOw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773753105; c=relaxed/relaxed;
	bh=mFGp+yGqG92BkKIyWdkXQp2E8yLuA9rb9ca+RU4aluY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bda3kQmdVmkI0a44NhjAp3PZ714pVbi5lfAC+tKoZ4K2os75u2jtvMRpZAONxZAtvaFCfsUzamwjoKlyY+u3dVUcavndWTZ4eSPM3cAh5eoTix/kL8ebcgTNI7XF1VF2r+38E2K7aZWZn3QWD5q4apEGiK+OarMn5BAZl1jcHIbMvyfPjN5yrXW0HVB4D2aMA/xAXNPYOgGuT0FBIGoBl+4i31eyCTzZy+Ht80UwjciX0LsEE2pl2cDFEaBoNx9vvtlhiezc0p+skzJ0P5ldIKNhrOEZESmTgX4K6dS389Tc69/MeBk5JDwB6zf/4mI3qCr+7Pz+omu+EgjcdikCPg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=AvMP0wT7; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=cassel@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=AvMP0wT7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=cassel@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZsmc39NSz2yh4
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Mar 2026 00:11:44 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id E238E60008;
	Tue, 17 Mar 2026 13:11:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E2B2C4CEF7;
	Tue, 17 Mar 2026 13:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773753100;
	bh=XphC/sm5cVJb9L02EfuN4T0tZepA1WWawu3Zl3lpiC4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AvMP0wT7KtZir5xHl20/Ga9rJ4mzmxrlieZIYeTWGRcCPRKOEnktbzUaW7s3G2Jkl
	 T+ihlFedtv792G796rzrfudULsaMr4u1dKPXqJJ6GMg2RHP3D+cujnoh8JnydWoFDy
	 PNE3vR3gUYUsUSWy4ClSwcx7ZezKow0HhZ3EsLC5f2n++y/Kq/ppgX+IzstVVevlE/
	 sFLl+JM3ewu9ZL0Y7aJwykpAoW1w3+ObEuBnbGpFkuCn20sqjoAkpowDspO35yW+3c
	 IIbJCDnL4e26e9D4RMsbz8IcEKjZsd+gsrsPEeIqdoa1g/g83mkoeaQfZJ1njypTKX
	 6s+WS6C8IX5vA==
Date: Tue, 17 Mar 2026 14:11:29 +0100
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
	Wilson Ding <dingwei@marvell.com>, Frank Li <Frank.Li@nxp.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v7 0/4] PCI: Add support for resetting the Root Ports in
 a platform specific way
Message-ID: <ablS8r0LzfJ_jVpD@ryzen>
References: <20260310-pci-port-reset-v7-0-9dd00ccc25ab@oss.qualcomm.com>
 <abFMa6DCGGLUHddA@fedora>
 <dp2rem4gj7zhfgykvekmcrhq4ticm6m6ido6tbgflwzfcuuwkl@4wuxgle27eyx>
 <srdn3bspgwff7f7tnst7wzg4us4buifrv7o3ylo527hmuciyl3@6ioyrl6rfhaz>
 <abk3rU2EDKjkefUD@ryzen>
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
Content-Type: multipart/mixed; boundary="Iae7tS6iThanSYoD"
Content-Disposition: inline
In-Reply-To: <abk3rU2EDKjkefUD@ryzen>


--Iae7tS6iThanSYoD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 17, 2026 at 12:17:19PM +0100, Niklas Cassel wrote:
> 
> I will be very busy for a few weeks, so I don't have time to debug this.
> If anyone wants to debug this on rk3588, I'm attaching the patches for
> this new feature for rk3588 that can be applied on top of this series.

For what it is worth, attaching an improved patch for rk3588 that does not
require any revert.


Kind regards,
Niklas

--Iae7tS6iThanSYoD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename=0001-PCI-dw-rockchip-Add-support-to-reset-Root-Port-upon-.patch

From a69679430750d7371e65e1b209059803cea2f5de Mon Sep 17 00:00:00 2001
From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
Date: Tue, 17 Mar 2026 09:30:57 +0100
Subject: [PATCH] PCI: dw-rockchip: Add support to reset Root Port upon link
 down event

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
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 134 +++++++++++++++++-
 2 files changed, 132 insertions(+), 3 deletions(-)

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
index 8db27199cfa6..988d98effcd7 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -24,6 +24,7 @@
 #include <linux/reset.h>
 
 #include "../../pci.h"
+#include "../pci-host-common.h"
 #include "pcie-designware.h"
 
 /*
@@ -105,6 +106,9 @@ struct rockchip_pcie_of_data {
 	const struct pci_epc_features *epc_features;
 };
 
+static int rockchip_pcie_rc_reset_root_port(struct pci_host_bridge *bridge,
+				       struct pci_dev *pdev);
+
 static int rockchip_pcie_readl_apb(struct rockchip_pcie *rockchip, u32 reg)
 {
 	return readl_relaxed(rockchip->apb_base + reg);
@@ -325,6 +329,7 @@ static int rockchip_pcie_host_init(struct dw_pcie_rp *pp)
 
 	rockchip_pcie_configure_l1ss(pci);
 	rockchip_pcie_enable_l0s(pci);
+	pp->bridge->reset_root_port = rockchip_pcie_rc_reset_root_port;
 
 	/* Disable Root Ports BAR0 and BAR1 as they report bogus size */
 	dw_pcie_writel_dbi2(pci, PCI_BASE_ADDRESS_0, 0x0);
@@ -523,6 +528,32 @@ static const struct dw_pcie_ops dw_pcie_ops = {
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
@@ -555,14 +586,29 @@ static irqreturn_t rockchip_pcie_ep_sys_irq_thread(int irq, void *arg)
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
@@ -574,7 +620,17 @@ static int rockchip_pcie_configure_rc(struct rockchip_pcie *rockchip)
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
@@ -693,7 +749,7 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 
 	switch (data->mode) {
 	case DW_PCIE_RC_TYPE:
-		ret = rockchip_pcie_configure_rc(rockchip);
+		ret = rockchip_pcie_configure_rc(pdev, rockchip);
 		if (ret)
 			goto deinit_clk;
 		break;
@@ -718,6 +774,78 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
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
+		return ret;
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
+
+	return ret;
+}
+
 static const struct rockchip_pcie_of_data rockchip_pcie_rc_of_data_rk3568 = {
 	.mode = DW_PCIE_RC_TYPE,
 };
-- 
2.53.0


--Iae7tS6iThanSYoD--

