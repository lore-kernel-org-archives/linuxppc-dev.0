Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09445606A321
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Nov 2026 04:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=Ql+iCI9s
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jPVl42n3Pz2xWR;
	Wed, 11 Nov 2026 15:23:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=210.79.60.23
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794371024;
	cv=none; b=mJPYHiciHm8bScTXTVNE6wL9Jv0Ah3LOXdtWqpgdlMULyRVuVY0TdvtYVHxrJ1zhe4dG8HFezUmgeHyLj19ADN0s2shMUyzhFPFMs3L75FmdPGqSfJgZht074cj0miDYZt+PJLZkj8GVGyIqXsNNRE/pNPIQYOMdJbvfoxL321NWpyOvxH6k0s1kSwQ4kjY8UbgBLwZ0UDp9EbUdWBXxGGUBIGyE34yRJdIE9ch39c/pkv4n27wsTISsPRHz0qp6rhsOH4sKnQy6ubK5pnMMZLuAIivNAkAcr6qOYRP/cAXoP9kbzI6INE0UAfe9Aw3c57M250EaLGZp4hYNR3EYpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794371024; c=relaxed/relaxed;
	bh=9V2SAasYyMu6F4znYH6XJbSf3b8w7ZlDKHwO1aQZKs8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GjckDBlPkN3Jjg1RLDvZOkO534sGnOuT5eojWcnQMHB9WleTTRM557ljsQFm4yCHAeC/pQhMVDSAfUFGnnsJpsXurM91TNWm419ramf3spTE4tHDwnWgtrimLc0+PFapEhGxmvSpLaYUtBIv3tKl9NOQS/0V99n6/CaigzCgr4eXNy7vfxN2a20frCfDL4NPWyUqtFF51/VxWVgmLUM2/MLHNT1TwtDwQI8NO6IZpp5c3NnoFspTCqCvoe+jXFCRpT8l3d/9iMi25a0kA8Hch8xkEA/TOmYFOjk41Yj6WdIN9BhPg1tRTe9trADHujILnwppO1k+ckj+cKf7rVhqxw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=Ql+iCI9s; dkim-atps=neutral; spf=pass (client-ip=210.79.60.23; helo=mail-m6023.netease.com; envelope-from=shawn.lin@rock-chips.com; receiver=lists.ozlabs.org) smtp.mailfrom=rock-chips.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=Ql+iCI9s;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=rock-chips.com (client-ip=210.79.60.23; helo=mail-m6023.netease.com; envelope-from=shawn.lin@rock-chips.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 304 seconds by postgrey-1.37 at boromir; Wed, 11 Nov 2026 15:23:41 AEDT
Received: from mail-m6023.netease.com (mail-m6023.netease.com [210.79.60.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jPVl10wdBz2xGg
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Nov 2026 15:23:40 +1100 (AEDT)
Received: from localhost.localdomain (unknown [61.154.14.87])
	by smtp.qiye.163.com (Hmail) with ESMTP id 5440544dd;
	Wed, 11 Nov 2026 12:18:30 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org,
	imx@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH] PCI: dwc: Check the pme_turn_off callback return value
Date: Wed, 11 Nov 2026 12:18:21 +0800
Message-Id: <20261111041821.2259326-1-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.25.1
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa1c8d429d603a4kunm94b39dc87e521
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDHkwfVh4ZSUkYGE1KHh9KTlYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ0xZV1kWGg8SFR0UWUFZT0tIVUpLSU
	9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=Ql+iCI9shA9B280n8sAEN/nCTVjb/oMol5IJ0XkKDFICwIvhsHc9+tf+6EaWajWh7TjzBMZnGavUTa06Qss0H++qu88KJRnypylmXkXdO+5vP5Fo0HvrDbrqqOMZY2LDn5zO3yu6nJdFnu6StNORnMqdI9gwA8F58Tuug2TBDWo=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=9V2SAasYyMu6F4znYH6XJbSf3b8w7ZlDKHwO1aQZKs8=;
	h=date:mime-version:subject:message-id:from;
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

dw_pcie_suspend_noirq() invokes the optional host ->pme_turn_off()
callback but ignores its result, so a platform that fails to send
PME_Turn_Off still has the link brought down as if the handshake had
completed.

Turn the callback into an int returning function and propagate its
error from dw_pcie_suspend_noirq(), matching how the generic
dw_pcie_pme_turn_off() path is already handled.

All existing implementations return 0 except:
  - the Layerscape PF LUT variant, which now returns -ETIMEDOUT when
    the PME_Turn_Off handshake does not complete instead of only
    logging it;
  - the Rockchip host, which now returns an error only when
    PME_Turn_Off could not be sent at all.  Its PME_TO_Ack and
    L23-ready wait timeouts remain non-fatal and just log, consistent
    with the generic path, which does not abort the suspend when an
    endpoint fails to respond: such timeouts are an endpoint behaviour
    and must not make the whole system suspend fail.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/pci/controller/dwc/pci-imx6.c         |  4 +++-
 drivers/pci/controller/dwc/pci-layerscape.c   | 22 +++++++++++++------
 .../pci/controller/dwc/pcie-designware-host.c |  4 +++-
 drivers/pci/controller/dwc/pcie-designware.h  |  2 +-
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 16 ++++++++------
 drivers/pci/controller/dwc/pcie-eswin.c       |  4 +++-
 drivers/pci/controller/dwc/pcie-qcom.c        |  4 +++-
 drivers/pci/controller/dwc/pcie-ultrarisc.c   |  3 ++-
 8 files changed, 39 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 38a59795f98f..643b591c789f 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1575,7 +1575,7 @@ static void imx_pcie_host_post_init(struct dw_pcie_rp *pp)
  * register is reserved, so the generic DWC implementation of sending the
  * PME_Turn_Off message using a dummy MMIO write cannot be used.
  */
-static void imx_pcie_pme_turn_off(struct dw_pcie_rp *pp)
+static int imx_pcie_pme_turn_off(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct imx_pcie *imx_pcie = to_imx_pcie(pci);
@@ -1584,6 +1584,8 @@ static void imx_pcie_pme_turn_off(struct dw_pcie_rp *pp)
 	regmap_clear_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12, IMX6SX_GPR12_PCIE_PM_TURN_OFF);
 
 	usleep_range(PCIE_PME_TO_L2_TIMEOUT_US/10, PCIE_PME_TO_L2_TIMEOUT_US);
+
+	return 0;
 }
 
 static const struct dw_pcie_host_ops imx_pcie_host_ops = {
diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
index 475aea3ef58a..8bd879226971 100644
--- a/drivers/pci/controller/dwc/pci-layerscape.c
+++ b/drivers/pci/controller/dwc/pci-layerscape.c
@@ -117,7 +117,7 @@ static void ls_pcie_pf_lut_writel(struct ls_pcie *pcie, u32 off, u32 val)
 		iowrite32(val, pcie->pf_lut_base + off);
 }
 
-static void ls_pcie_send_turnoff_msg(struct dw_pcie_rp *pp)
+static int ls_pcie_send_turnoff_msg(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct ls_pcie *pcie = to_ls_pcie(pci);
@@ -132,8 +132,12 @@ static void ls_pcie_send_turnoff_msg(struct dw_pcie_rp *pp)
 				 val, !(val & PF_MCR_PTOMR),
 				 PCIE_PME_TO_L2_TIMEOUT_US/10,
 				 PCIE_PME_TO_L2_TIMEOUT_US);
-	if (ret)
+	if (ret) {
 		dev_err(pcie->pci->dev, "PME_Turn_off timeout\n");
+		return ret;
+	}
+
+	return 0;
 }
 
 static int ls_pcie_exit_from_l2(struct dw_pcie_rp *pp)
@@ -179,7 +183,7 @@ static int ls_pcie_host_init(struct dw_pcie_rp *pp)
 	return 0;
 }
 
-static void scfg_pcie_send_turnoff_msg(struct regmap *scfg, u32 reg, u32 mask)
+static int scfg_pcie_send_turnoff_msg(struct regmap *scfg, u32 reg, u32 mask)
 {
 	/* Send PME_Turn_Off message */
 	regmap_write_bits(scfg, reg, mask, mask);
@@ -195,14 +199,17 @@ static void scfg_pcie_send_turnoff_msg(struct regmap *scfg, u32 reg, u32 mask)
 	 * to complete the PME_Turn_Off handshake.
 	 */
 	regmap_write_bits(scfg, reg, mask, 0);
+
+	return 0;
 }
 
-static void ls1021a_pcie_send_turnoff_msg(struct dw_pcie_rp *pp)
+static int ls1021a_pcie_send_turnoff_msg(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct ls_pcie *pcie = to_ls_pcie(pci);
 
-	scfg_pcie_send_turnoff_msg(pcie->scfg, SCFG_PEXPMWRCR(pcie->index), PMXMTTURNOFF);
+	return scfg_pcie_send_turnoff_msg(pcie->scfg, SCFG_PEXPMWRCR(pcie->index),
+					  PMXMTTURNOFF);
 }
 
 static int scfg_pcie_exit_from_l2(struct regmap *scfg, u32 reg, u32 mask)
@@ -222,12 +229,13 @@ static int ls1021a_pcie_exit_from_l2(struct dw_pcie_rp *pp)
 	return scfg_pcie_exit_from_l2(pcie->scfg, SCFG_PEXSFTRSTCR, PEXSR(pcie->index));
 }
 
-static void ls1043a_pcie_send_turnoff_msg(struct dw_pcie_rp *pp)
+static int ls1043a_pcie_send_turnoff_msg(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct ls_pcie *pcie = to_ls_pcie(pci);
 
-	scfg_pcie_send_turnoff_msg(pcie->scfg, SCFG_PEXPMECR, PEXPME(pcie->index));
+	return scfg_pcie_send_turnoff_msg(pcie->scfg, SCFG_PEXPMECR,
+					  PEXPME(pcie->index));
 }
 
 static int ls1043a_pcie_exit_from_l2(struct dw_pcie_rp *pp)
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index f531c5b51b3c..eb11556aca72 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -1249,7 +1249,9 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
 		return 0;
 
 	if (pci->pp.ops->pme_turn_off) {
-		pci->pp.ops->pme_turn_off(&pci->pp);
+		ret = pci->pp.ops->pme_turn_off(&pci->pp);
+		if (ret)
+			return ret;
 	} else {
 		ret = dw_pcie_pme_turn_off(pci);
 		if (ret)
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 0ece9c433229..9836ea9127bd 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -440,7 +440,7 @@ struct dw_pcie_host_ops {
 	void (*deinit)(struct dw_pcie_rp *pp);
 	void (*post_init)(struct dw_pcie_rp *pp);
 	int (*msi_init)(struct dw_pcie_rp *pp);
-	void (*pme_turn_off)(struct dw_pcie_rp *pp);
+	int (*pme_turn_off)(struct dw_pcie_rp *pp);
 };
 
 struct dw_pcie_rp {
diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 525a26ee1d07..ea7ef0be1214 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -464,7 +464,7 @@ static void rockchip_pcie_host_post_init(struct dw_pcie_rp *pp)
 	pp->bridge->broken_l1ss_resume = true;
 }
 
-static void rockchip_pcie_pme_turn_off(struct dw_pcie_rp *pp)
+static int rockchip_pcie_pme_turn_off(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
@@ -478,18 +478,16 @@ static void rockchip_pcie_pme_turn_off(struct dw_pcie_rp *pp)
 				 status, !(status & BIT(4)), PCIE_PME_TO_L2_TIMEOUT_US / 10,
 				 PCIE_PME_TO_L2_TIMEOUT_US);
 	if (ret) {
-		dev_warn(dev, "Failed to send PME_Turn_Off\n");
-		return;
+		dev_err(dev, "Failed to send PME_Turn_Off\n");
+		return ret;
 	}
 
 	/* 2. Wait for PME_TO_Ack, bit 9 will be set once received */
 	ret = readl_poll_timeout(rockchip->apb_base + PCIE_CLIENT_INTR_STATUS_MSG_RX,
 				 status, status & BIT(9), PCIE_PME_TO_L2_TIMEOUT_US / 10,
 				 PCIE_PME_TO_L2_TIMEOUT_US);
-	if (ret) {
+	if (ret)
 		dev_warn(dev, "Failed to receive PME_TO_Ack\n");
-		return;
-	}
 
 	/* 3. Clear PME_TO_Ack and Wait for ready to enter L23 message */
 	rockchip_pcie_writel_apb(rockchip, PME_TO_ACK, PCIE_CLIENT_INTR_STATUS_MSG_RX);
@@ -497,8 +495,12 @@ static void rockchip_pcie_pme_turn_off(struct dw_pcie_rp *pp)
 				 status, status & PME_READY_ENTER_L23,
 				 PCIE_PME_TO_L2_TIMEOUT_US / 10,
 				 PCIE_PME_TO_L2_TIMEOUT_US);
-	if (ret)
+	if (ret) {
 		dev_err(dev, "Failed to get ready to enter L23 message\n");
+		ret = 0;
+	}
+
+	return ret;
 }
 
 static const struct dw_pcie_host_ops rockchip_pcie_host_ops = {
diff --git a/drivers/pci/controller/dwc/pcie-eswin.c b/drivers/pci/controller/dwc/pcie-eswin.c
index 5639666d5148..ed498601312f 100644
--- a/drivers/pci/controller/dwc/pcie-eswin.c
+++ b/drivers/pci/controller/dwc/pcie-eswin.c
@@ -269,7 +269,7 @@ static void eswin_pcie_host_deinit(struct dw_pcie_rp *pp)
 	clk_bulk_disable_unprepare(pcie->num_clks, pcie->clks);
 }
 
-static void eswin_pcie_pme_turn_off(struct dw_pcie_rp *pp)
+static int eswin_pcie_pme_turn_off(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct eswin_pcie *pcie = to_eswin_pcie(pci);
@@ -281,6 +281,8 @@ static void eswin_pcie_pme_turn_off(struct dw_pcie_rp *pp)
 	 * the skip_l23_ready has been set.
 	 */
 	pp->skip_l23_ready = pcie->data->skip_l23;
+
+	return 0;
 }
 
 static const struct dw_pcie_host_ops eswin_pcie_host_ops = {
diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index eba1b2cb30f0..9548c6568c82 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1594,11 +1594,13 @@ static void qcom_pcie_host_post_init(struct dw_pcie_rp *pp)
 		pcie->cfg->ops->host_post_init(pcie);
 }
 
-static void qcom_pcie_host_pme_turn_off(struct dw_pcie_rp *pp)
+static int qcom_pcie_host_pme_turn_off(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 
 	writel(ELBI_SYS_CTRL_PME_TURNOFF_MSG, pci->elbi_base + ELBI_SYS_CTRL);
+
+	return 0;
 }
 
 static const struct dw_pcie_host_ops qcom_pcie_dw_ops = {
diff --git a/drivers/pci/controller/dwc/pcie-ultrarisc.c b/drivers/pci/controller/dwc/pcie-ultrarisc.c
index ee844ff7ed55..493b6c68b42f 100644
--- a/drivers/pci/controller/dwc/pcie-ultrarisc.c
+++ b/drivers/pci/controller/dwc/pcie-ultrarisc.c
@@ -77,12 +77,13 @@ static int ultrarisc_pcie_host_init(struct dw_pcie_rp *pp)
 	return 0;
 }
 
-static void ultrarisc_pcie_pme_turn_off(struct dw_pcie_rp *pp)
+static int ultrarisc_pcie_pme_turn_off(struct dw_pcie_rp *pp)
 {
 	/*
 	 * DP1000 does not support sending PME_Turn_Off from the RC.
 	 * Keep this callback empty to skip the generic MSG TLP path.
 	 */
+	return 0;
 }
 
 static const struct dw_pcie_host_ops ultrarisc_pcie_host_ops = {
-- 
2.25.1


