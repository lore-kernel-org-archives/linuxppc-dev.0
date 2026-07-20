Return-Path: <linuxppc-dev+bounces-24519-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDD90C44515
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 15:12:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3kVh1z3lz3c44;
	Tue, 21 Jul 2026 01:11:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784560267;
	cv=none; b=iYPWoS/txcRhM5kZ2WiSPSZqLmt5QVkraDwxrFHL94P5iRwZT2JkuD9mAgaX00S8kl9nxzpVhqc+OZtqG19g+rJygv3W3Bc2QQ+b4jp7E11rfJw4Im4fHdT723u7ttnGXCXCkHpKCGCapuTeB+gqfQyMuSlrx7kPkpGKeupIkOWb2q/QemuNXOYpSpppZ792KTLi+rgobRBUOPNEtzk/AV592ElEvPrY78jnkHeaG6KdOigaBu2+qNU5MyP53gM4my1+1WCZe9M9bBv8lk1gMvcvxHEH1DyqF0eR+sUpnCnB2bLnsFX0kk3yxf9jtmUFGEcUpli047MVvSfa9PiODg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784560267; c=relaxed/relaxed;
	bh=VUTpNwnx9GB412jRFvqDOQChNSZ1zG4+eKVBbgWXW+o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H14IveVxO/gojm8UPBt7PEkh9Kf8Sg+5eGvxrlHxxCZPl2ER28bgaV3hk+v5ZHarldInXFCP9QZyNTKyseyJ7B0K4EiLx1AOKjM88JdGR+OF3wWvGDxkovwV44Z7Mh2xXEPImDZ3fy0SKr1poaGyfdMN4PRywppGVyCHTN+v4z5V5GHIqseSkLFwwJeSd3H3Sm3HjVBkIzDLBhekrY71TROMp8VkYbU9T46YjEpALqkcXy35OK0hhAglBAfRHE8ZMlkI1/nOL5XJjhq8HpSUX3z+s328R34BRx71KeMiqYq98JJyOGvp5/AWbjJiH8e4XlXndDKJvmDtnFbkpMYO4w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com; dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=mjcdWVKA; dkim-atps=neutral; spf=pass (client-ip=117.135.210.2; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org) smtp.mailfrom=163.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=mjcdWVKA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=163.com (client-ip=117.135.210.2; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org)
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3kVW4qZ4z303X
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2026 01:10:58 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=VU
	TpNwnx9GB412jRFvqDOQChNSZ1zG4+eKVBbgWXW+o=; b=mjcdWVKAVye0opVEIp
	B7cvAgIgtvrGvWmFeBHOAgQT2pfdzVZgQej9yN+2nEzaPS9/hfGcCmjy81iVQECm
	DhY9+X7ka1kcVkXXeWa+7upsUKJbcV64VG37ZB8MCW4Lb7Ptx2of6aUryfNniK21
	dwjxOH5X7HLBV+J+Z3gz4wujA=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wDX+mO9OV5q8LEOKg--.8910S5;
	Mon, 20 Jul 2026 23:07:46 +0800 (CST)
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
Subject: [PATCH v3 03/16] PCI: dwc: imx6: Use cached PCIe capability offset
Date: Mon, 20 Jul 2026 23:06:06 +0800
Message-Id: <20260720150619.24733-4-18255117159@163.com>
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
X-CM-TRANSID:_____wDX+mO9OV5q8LEOKg--.8910S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7CF18ZFW7uF45Zr4ktry7ZFb_yoW8uF43pa
	y3u3yFyr4rJF42qFsFy3Z8Zr13tas0kw47Jw47Kw1Sqry7JryDWFy0yryfta1akr4kKFy7
	AF1xtFyfJ34FyF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zipBTrUUUUU=
X-Originating-IP: [240e:b8f:91b3:d000:f138:f837:e143:4264]
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCxAKwVGpeOcIFMgAA3a

Thus, the cached offset is available when these functions are called, and
DBI access occurs only after hardware is enabled.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
In pci-imx6, dw_pcie_find_capability() is called in the following
call chain:

  static const struct dw_pcie_ops dw_pcie_ops = {
    .start_link = imx_pcie_start_link,
  };
  imx_pcie_start_link()
    -> dw_pcie_find_capability()
    -> imx_pcie_ltssm_enable()
      -> dw_pcie_find_capability()

Replace these calls with the cached pci->pcie_cap. The call chain after
modification becomes:

  dw_pcie_host_init()
    -> pp->ops->init() [imx6_pcie_host_init]
    -> dw_pcie_get_pcie_cap()  (caches offset)
    -> pci->ops->start_link = imx_pcie_start_link
      -> uses pci->pcie_cap
      -> imx_pcie_ltssm_enable()
        -> uses pci->pcie_cap
---
 drivers/pci/controller/dwc/pci-imx6.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 98e1db751132..74b28b4df484 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -966,10 +966,10 @@ static void imx_pcie_ltssm_enable(struct device *dev)
 {
 	struct imx_pcie *imx_pcie = dev_get_drvdata(dev);
 	const struct imx_pcie_drvdata *drvdata = imx_pcie->drvdata;
-	u8 offset = dw_pcie_find_capability(imx_pcie->pci, PCI_CAP_ID_EXP);
+	struct dw_pcie *pci = imx_pcie->pci;
 	u32 tmp;
 
-	tmp = dw_pcie_readl_dbi(imx_pcie->pci, offset + PCI_EXP_LNKCAP);
+	tmp = dw_pcie_readl_dbi(pci, pci->pcie_cap + PCI_EXP_LNKCAP);
 	phy_set_speed(imx_pcie->phy, FIELD_GET(PCI_EXP_LNKCAP_SLS, tmp));
 	if (drvdata->ltssm_mask)
 		regmap_update_bits(imx_pcie->iomuxc_gpr, drvdata->ltssm_off, drvdata->ltssm_mask,
@@ -995,7 +995,7 @@ static int imx_pcie_start_link(struct dw_pcie *pci)
 {
 	struct imx_pcie *imx_pcie = to_imx_pcie(pci);
 	struct device *dev = pci->dev;
-	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	u8 offset = pci->pcie_cap;
 	u32 tmp;
 	int ret;
 
-- 
2.34.1


