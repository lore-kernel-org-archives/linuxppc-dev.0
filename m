Return-Path: <SRS0=o5MI=RC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A4F0C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 05:01:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 972A3218E2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 05:01:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 972A3218E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 448NnP3ww8zDqMq
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 16:01:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=zte.com.cn
 (client-ip=202.103.147.172; helo=mxct.zte.com.cn;
 envelope-from=wen.yang99@zte.com.cn; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=zte.com.cn
Received: from mxct.zte.com.cn (out1.zte.com.cn [202.103.147.172])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 448NhR6V1NzDqCq
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Feb 2019 15:57:11 +1100 (AEDT)
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
 by Forcepoint Email with ESMTPS id 7D76CE85EDBE605184E3;
 Wed, 27 Feb 2019 12:40:42 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
 by mse01.zte.com.cn with ESMTP id x1R4eaTr003644;
 Wed, 27 Feb 2019 12:40:36 +0800 (GMT-8)
 (envelope-from wen.yang99@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
 by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
 with ESMTP id 2019022712405722-2029107 ;
 Wed, 27 Feb 2019 12:40:57 +0800 
From: Wen Yang <wen.yang99@zte.com.cn>
To: benh@kernel.crashing.org
Subject: [PATCH 2/8] PCI: uniphier: fix a leaked reference by adding missing
 of_node_put
Date: Wed, 27 Feb 2019 12:40:37 +0800
Message-Id: <1551242443-27300-2-git-send-email-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1551242443-27300-1-git-send-email-wen.yang99@zte.com.cn>
References: <1551242443-27300-1-git-send-email-wen.yang99@zte.com.cn>
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release
 8.5.3FP6|November 21, 2013) at 2019-02-27 12:40:57,
 Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-02-27 12:40:29, Serialize complete at 2019-02-27 12:40:29
X-MAIL: mse01.zte.com.cn x1R4eaTr003644
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
Cc: heiko@sntech.de, hayashi.kunihiko@socionext.com, linux-pci@vger.kernel.org,
 shawn.lin@rock-chips.com, minghuan.Lian@nxp.com, paulus@samba.org,
 thomas.petazzoni@bootlin.com, Wen Yang <wen.yang99@zte.com.cn>,
 ryder.lee@mediatek.com, kishon@ti.com, linux-rockchip@lists.infradead.org,
 bcm-kernel-feedback-list@broadcom.com, linux-arm-kernel@lists.infradead.org,
 wang.yi59@zte.com.cn, rjui@broadcom.com, lorenzo.pieralisi@arm.com,
 linux-mediatek@lists.infradead.org, tyreld@linux.vnet.ibm.com,
 matthias.bgg@gmail.com, linux-omap@vger.kernel.org, mingkai.hu@nxp.com,
 roy.zang@nxp.com, sbranden@broadcom.com, yamada.masahiro@socionext.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 bhelgaas@google.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The call to of_get_child_by_name returns a node pointer with refcount
incremented thus it must be explicitly decremented after the last
usage.
irq_domain_add_linear also calls of_node_get to increase refcount,
so irq_domain will not be affected when it is released.

Detected by coccinelle with the following warnings:
./drivers/pci/controller/dwc/pcie-uniphier.c:283:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 274, but without a corresponding object release within this function.
./drivers/pci/controller/dwc/pcie-uniphier.c:290:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 274, but without a corresponding object release within this function.
./drivers/pci/controller/dwc/pcie-uniphier.c:296:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 274, but without a corresponding object release within this function.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-pci@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/pci/controller/dwc/pcie-uniphier.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-uniphier.c b/drivers/pci/controller/dwc/pcie-uniphier.c
index d5dc402..3f30ee4 100644
--- a/drivers/pci/controller/dwc/pcie-uniphier.c
+++ b/drivers/pci/controller/dwc/pcie-uniphier.c
@@ -270,6 +270,7 @@ static int uniphier_pcie_config_legacy_irq(struct pcie_port *pp)
 	struct uniphier_pcie_priv *priv = to_uniphier_pcie(pci);
 	struct device_node *np = pci->dev->of_node;
 	struct device_node *np_intc;
+	int ret = 0;
 
 	np_intc = of_get_child_by_name(np, "legacy-interrupt-controller");
 	if (!np_intc) {
@@ -280,20 +281,24 @@ static int uniphier_pcie_config_legacy_irq(struct pcie_port *pp)
 	pp->irq = irq_of_parse_and_map(np_intc, 0);
 	if (!pp->irq) {
 		dev_err(pci->dev, "Failed to get an IRQ entry in legacy-interrupt-controller\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out_put_node;
 	}
 
 	priv->legacy_irq_domain = irq_domain_add_linear(np_intc, PCI_NUM_INTX,
 						&uniphier_intx_domain_ops, pp);
 	if (!priv->legacy_irq_domain) {
 		dev_err(pci->dev, "Failed to get INTx domain\n");
-		return -ENODEV;
+		ret = -ENODEV;
+		goto out_put_node;
 	}
 
 	irq_set_chained_handler_and_data(pp->irq, uniphier_pcie_irq_handler,
 					 pp);
 
-	return 0;
+out_put_node:
+	of_node_put(np_intc);
+	return ret;
 }
 
 static int uniphier_pcie_host_init(struct pcie_port *pp)
-- 
2.9.5

