Return-Path: <SRS0=HEEy=BV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73ECCC433DF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Aug 2020 10:21:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3C092054F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Aug 2020 10:21:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3C092054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BQplJ2Q4RzDqVW
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Aug 2020 20:21:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=nxp.com
 (client-ip=92.121.34.13; helo=inva020.nxp.com;
 envelope-from=zhiqiang.hou@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BQpKR3MrNzDqRh
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2020 20:02:19 +1000 (AEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 27E4B1A1972;
 Tue, 11 Aug 2020 12:02:14 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com
 [165.114.16.14])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id AB44B1A1985;
 Tue, 11 Aug 2020 12:02:06 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
 by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id C20E4402F3;
 Tue, 11 Aug 2020 12:01:57 +0200 (CEST)
From: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, robh+dt@kernel.org, bhelgaas@google.com,
 lorenzo.pieralisi@arm.com, shawnguo@kernel.org, leoyang.li@nxp.com,
 kishon@ti.com, gustavo.pimentel@synopsys.com, roy.zang@nxp.com,
 jingoohan1@gmail.com, andrew.murray@arm.com
Subject: [PATCHv7 08/12] PCI: layerscape: Modify the MSIX to the doorbell mode
Date: Tue, 11 Aug 2020 17:54:37 +0800
Message-Id: <20200811095441.7636-9-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200811095441.7636-1-Zhiqiang.Hou@nxp.com>
References: <20200811095441.7636-1-Zhiqiang.Hou@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: minghuan.Lian@nxp.com, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Xiaowei Bao <xiaowei.bao@nxp.com>, mingkai.hu@nxp.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Xiaowei Bao <xiaowei.bao@nxp.com>

dw_pcie_ep_raise_msix_irq was never called in the exisitng driver
before, because the ls1046a platform don't support the MSIX feature
and msix_capable was always set to false.
Now that add the ls1088a platform with MSIX support, use the doorbell
method to support the MSIX feature.

Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
Reviewed-by: Andrew Murray <andrew.murray@arm.com>
Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
V7:
 - Rebase the patch without functionality change.

 drivers/pci/controller/dwc/pci-layerscape-ep.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-layerscape-ep.c b/drivers/pci/controller/dwc/pci-layerscape-ep.c
index 9601f9c09cb1..bfab1c694f00 100644
--- a/drivers/pci/controller/dwc/pci-layerscape-ep.c
+++ b/drivers/pci/controller/dwc/pci-layerscape-ep.c
@@ -79,7 +79,8 @@ static int ls_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
 	case PCI_EPC_IRQ_MSI:
 		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
 	case PCI_EPC_IRQ_MSIX:
-		return dw_pcie_ep_raise_msix_irq(ep, func_no, interrupt_num);
+		return dw_pcie_ep_raise_msix_irq_doorbell(ep, func_no,
+							  interrupt_num);
 	default:
 		dev_err(pci->dev, "UNKNOWN IRQ type\n");
 		return -EINVAL;
-- 
2.17.1

