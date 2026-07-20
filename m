Return-Path: <linuxppc-dev+bounces-24520-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48D4CC4452A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 15:12:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3kVh4PHRz3c4y;
	Tue, 21 Jul 2026 01:11:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=117.135.210.4
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784560268;
	cv=none; b=m6YMB/ECJixdPkL9XleFt8SQKXw/vi6gFl4lYM1aoQirp+7aZMg8eoTLaYgTsiZIR6zAz+zpMKkouECYUazWAu2/RiIr+UjZI4OFNr7g2oZHQAEqKm5+3PhDQ8ByMkcuevAL6rlQxCRdmUY5wERHf7I/VljJs2YpHZH9OB8fPHKZ2xANAwbCd7QUha2drNaoDbdMr7xbY10JqdusN4X+IBOY6Vo5jRjNGfOrYoarH2yLaRr01Z8R4MQt1Iw4zJRsXmIHGEWY7eXLu28EPqbr4F8LVdViUKqU50m1DYu731yCdS5vGli891LWnrosSMZ0ewAvFjH4ZkDIFnPfHpGN6g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784560268; c=relaxed/relaxed;
	bh=BhDWjSEv175HZK5Lkhl53A0JTo49xTss24i6v5jm7E4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c+Oxpmsm7FcgYk2gjJ7VuPITcf5T13mIKuwVjggqPe20vG9HrliAgged20qGOnLURP1MKkF9o1JQFuVYm3aFMYaM24aqhroL5FqCoeb92yEbnRrqpCa+9urYANxVOXqqs1+a3YCGG75Xilk/0IqfbguC/sRsVw8G7f2icHfCyMp9WxGnR8o275UNpoeMpplZTAjbVfilkKzNU2kSNtpa+d55NtvbaPy6SuHRnxcLMQbLlpVyO+zZMAsf4N7Ir7wPidMwLEnySBDdQ3aaH5hfnBD+XRYjk3aVP/3FOJUSRuJfYSVEHkB8qQod5JjrO6jfmZ2gTDig4WvuFs1nZ183bQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com; dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=kZgUgkgH; dkim-atps=neutral; spf=pass (client-ip=117.135.210.4; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org) smtp.mailfrom=163.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=kZgUgkgH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=163.com (client-ip=117.135.210.4; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org)
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3kVW2RL1z2ywn
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2026 01:10:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Bh
	DWjSEv175HZK5Lkhl53A0JTo49xTss24i6v5jm7E4=; b=kZgUgkgHJL7Sf1yplc
	EnVrsUr+kYw+MnNaSlluBx5Yi7X5Bp4RB+P69pUgltAro9iVZSKW7dLWF5mbf370
	LWNjY+SZWr9P+hZaEDuv9kpdl1fIU+SyfCYTwc0y5Jc3Sq+HbrVZs3IOtC3wGaC4
	yWHKyq4Tktzljvj7NEpmiisuA=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3b1rIOV5qyHOjKQ--.35310S5;
	Mon, 20 Jul 2026 23:07:58 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	jingoohan1@gmail.com
Cc: imx@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-amlogic@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v3 11/16] PCI: dwc: qcom: Use cached PCIe capability offset
Date: Mon, 20 Jul 2026 23:06:14 +0800
Message-Id: <20260720150619.24733-12-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260720150619.24733-1-18255117159@163.com>
References: <20260720150619.24733-1-18255117159@163.com>
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
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3b1rIOV5qyHOjKQ--.35310S5
X-Coremail-Antispam: 1Uf129KBjvJXoWxCF4xJFWUKFWfWw13Jr45GFg_yoWrCw4Dpa
	s0vrn0yF45Jr48WFnFyFZ3Xr1agrnxArW7Aa97Kr1SqF9xtryUGa1jyrySyFn3GFZrtFy7
	Gry8tryUX3WrtrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziHa09UUUUU=
X-Originating-IP: [240e:b8f:91b3:d000:f138:f837:e143:4264]
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7A6zV2peOc52YQAA3S

dw_pcie_host_init() caches the offset after .init, so .post_init callbacks
and later functions (.link_up, icc_opp_update) can use pci->pcie_cap
directly. For .init itself, we must call dw_pcie_get_pcie_cap() inside
qcom_pcie_host_init() to obtain the offset (hardware is already enabled).

Signed-off-by: Hans Zhang <18255117159@163.com>
---
In pcie-qcom, dw_pcie_find_capability() appears in multiple call chains:

  static const struct dw_pcie_host_ops qcom_pcie_dw_ops = {
    .init = qcom_pcie_host_init,
  };
  qcom_pcie_host_init()
    -> qcom_pcie_clear_aspm_l0s()
      -> dw_pcie_find_capability()

  static const struct qcom_pcie_ops ops_* = {
    .post_init = qcom_pcie_post_init_*,
  };
  qcom_pcie_post_init_*()
    -> qcom_pcie_set_slot_nccs()  (for many versions)
      -> dw_pcie_find_capability()
    -> For 2_3_3 and 2_9_0: also calls dw_pcie_find_capability() directly

  static const struct dw_pcie_ops dw_pcie_ops = {
    .link_up = qcom_pcie_link_up,
  };
  qcom_pcie_link_up()
    -> dw_pcie_find_capability()

  qcom_pcie_probe()
    -> dw_pcie_host_init()
    -> qcom_pcie_icc_opp_update()
      -> dw_pcie_find_capability()
---
 drivers/pci/controller/dwc/pcie-qcom.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index d8eb52857f69..bd383d7cb02b 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -341,13 +341,13 @@ static int qcom_pcie_start_link(struct dw_pcie *pci)
 static void qcom_pcie_clear_aspm_l0s(struct dw_pcie *pci)
 {
 	struct qcom_pcie *pcie = to_qcom_pcie(pci);
-	u16 offset;
+	u8 offset;
 	u32 val;
 
 	if (!pcie->cfg->no_l0s)
 		return;
 
-	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	offset = dw_pcie_get_pcie_cap(pci);
 
 	dw_pcie_dbi_ro_wr_en(pci);
 
@@ -360,7 +360,6 @@ static void qcom_pcie_clear_aspm_l0s(struct dw_pcie *pci)
 
 static void qcom_pcie_set_slot_nccs(struct dw_pcie *pci)
 {
-	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
 	u32 val;
 
 	dw_pcie_dbi_ro_wr_en(pci);
@@ -370,9 +369,9 @@ static void qcom_pcie_set_slot_nccs(struct dw_pcie *pci)
 	 * notifications for the Hot-Plug commands. So set the NCCS field to
 	 * avoid waiting for the completions.
 	 */
-	val = readl(pci->dbi_base + offset + PCI_EXP_SLTCAP);
+	val = readl(pci->dbi_base + pci->pcie_cap + PCI_EXP_SLTCAP);
 	val |= PCI_EXP_SLTCAP_NCCS;
-	writel(val, pci->dbi_base + offset + PCI_EXP_SLTCAP);
+	writel(val, pci->dbi_base + pci->pcie_cap + PCI_EXP_SLTCAP);
 
 	dw_pcie_dbi_ro_wr_dis(pci);
 }
@@ -935,7 +934,7 @@ static int qcom_pcie_init_2_3_3(struct qcom_pcie *pcie)
 static int qcom_pcie_post_init_2_3_3(struct qcom_pcie *pcie)
 {
 	struct dw_pcie *pci = pcie->pci;
-	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	u8 offset = pci->pcie_cap;
 	u32 val;
 
 	/* Force PHY out of lowest power state */
@@ -1257,7 +1256,7 @@ static int qcom_pcie_init_2_9_0(struct qcom_pcie *pcie)
 static int qcom_pcie_post_init_2_9_0(struct qcom_pcie *pcie)
 {
 	struct dw_pcie *pci = pcie->pci;
-	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	u8 offset = pci->pcie_cap;
 	u32 val;
 	int i;
 
@@ -1303,8 +1302,7 @@ static int qcom_pcie_post_init_2_9_0(struct qcom_pcie *pcie)
 
 static bool qcom_pcie_link_up(struct dw_pcie *pci)
 {
-	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
-	u16 val = readw(pci->dbi_base + offset + PCI_EXP_LNKSTA);
+	u16 val = readw(pci->dbi_base + pci->pcie_cap + PCI_EXP_LNKSTA);
 
 	return val & PCI_EXP_LNKSTA_DLLLA;
 }
@@ -1664,15 +1662,14 @@ static int qcom_pcie_icc_init(struct qcom_pcie *pcie)
 
 static void qcom_pcie_icc_opp_update(struct qcom_pcie *pcie)
 {
-	u32 offset, status, width, speed;
+	u32 status, width, speed;
 	struct dw_pcie *pci = pcie->pci;
 	struct dev_pm_opp_key key = {};
 	unsigned long freq_kbps;
 	struct dev_pm_opp *opp;
 	int ret, freq_mbps;
 
-	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
-	status = readw(pci->dbi_base + offset + PCI_EXP_LNKSTA);
+	status = readw(pci->dbi_base + pci->pcie_cap + PCI_EXP_LNKSTA);
 
 	/* Only update constraints if link is up. */
 	if (!(status & PCI_EXP_LNKSTA_DLLLA))
-- 
2.34.1


