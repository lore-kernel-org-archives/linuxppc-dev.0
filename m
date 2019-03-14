Return-Path: <SRS0=OgF1=RR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D4A4C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 23:10:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F5A221874
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 23:10:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F5A221874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metux.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44L4FC42kPzDqDN
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 10:10:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=metux.net
 (client-ip=217.72.192.74; helo=mout.kundenserver.de;
 envelope-from=info@metux.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=metux.net
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44L3Ss03K7zDqNV
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2019 09:35:40 +1100 (AEDT)
Received: from orion.localdomain ([95.117.89.18]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Mnqfc-1gfhVr0JQY-00pPMk; Thu, 14 Mar 2019 23:35:13 +0100
From: "Enrico Weigelt, metux IT consult" <info@metux.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 43/45] drivers: tty: serial: pmac_zilog: use devm_*
 functions
Date: Thu, 14 Mar 2019 23:34:13 +0100
Message-Id: <1552602855-26086-44-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552602855-26086-1-git-send-email-info@metux.net>
References: <1552602855-26086-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:h8L3vUD1hqRCDdoedxoMxbXPzNL0BOzZpGwAj5Iv5os2xWwwPjK
 74QvRmvyzA2dsoMmyBD0FXBwhfu1u8FSUXEl2W9nkKRWYLSWIy613rAJu0XWPBRmOKjaTmb
 MYPIhJiSAGeQiwf12i9DlucbIkHdq7FdZaTxWuXQVDCyTYrHkG5FS4nebi1ruYLxt9f/UlP
 nstSxBvZF8mdO1cHjUqTQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NQakjFCqD30=:3wb9HWwyA+mTGE5oMNepZt
 TmLZftY9Sv5WN/7JjevuM0O/h8v17ZqI4ahFkFs+wYGFaGAzN/vmwZAfWChZ5b7msW0qwSGR/
 omNEB6xvaC+8il39/XzdwXCXzqaV/nC9M32id9wAH8miAxtS3qlKBPWJTdb6Uq1yqO/Aa5TNu
 U2+J6+ibwrxaf8p+w6vwdVQ6+aA59gfhv1PfoUEepXW5zO/5C8fyr981b838+UYyyHFOH4InN
 DUmJx256+iIDjz3b3b8B+PebbGUcg/VA+kl606FCB/dp2WOuxJOoigvV5EYxSvAGAwk9TRpTT
 KdKB17dgYSU9NMr0x/nCfAlEBTVCXashfnBqcDmZYb5rp0HrhAglxnaVA+C5NhCe7KPcYq7wB
 PPVZNruY+uI6axA8X6RLG9wb9OgP+A3CtlnpB8GwAN2YwzjESuXGR3Mm3IEJfKHYmCcXQHmM1
 nenzEKACzlVRhm7lTJ49eE+tSuuXCFv8Sxnk0DaZNJs3pzEZmAElkaRj5+pjuBxF/5rM/5qfP
 XPd4tUlhVueeSHucedcwh6z9g8uOU51t7NsK/C62RyQFQ/5cO+KV+GIJWaPblSWQWR+I3T9eD
 E/hNLprZ6xMLUuj1UIScrnkcWwALgyJGlx07Vr+sWLbEW970qmX74mJ07AAJwl/9xsZuDaFKI
 s0dptY1p1Z8Ukh32S8imvoPDzoJmuEEWGWI2fBmHD5qI1epXW/uYkmhRNY43FUQ7/NsYZeNMf
 kW/jorUQGumZZsgvUkXeQLFCPV6rk+ogBMhkYw==
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
Cc: linux-arm-msm@vger.kernel.org, yamada.masahiro@socionext.com,
 macro@linux-mips.org, jacmet@sunsite.dk, festevam@gmail.com,
 stefan.wahren@i2se.com, f.fainelli@gmail.com,
 bcm-kernel-feedback-list@broadcom.com, linux-imx@nxp.com,
 linux-serial@vger.kernel.org, u.kleine-koenig@pengutronix.de,
 andy.gross@linaro.org, tklauser@distanz.ch, david.brown@linaro.org,
 rjui@broadcom.com, s.hauer@pengutronix.de, slemieux.tyco@gmail.com,
 linuxppc-dev@lists.ozlabs.org, vz@mleia.com, matthias.bgg@gmail.com,
 andriy.shevchenko@linux.intel.com, baohua@kernel.org, sbranden@broadcom.com,
 eric@anholt.net, richard.genoud@gmail.com, gregkh@linuxfoundation.org,
 kernel@pengutronix.de, shawnguo@kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Use the safer devm versions of memory mapping functions.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/tty/serial/pmac_zilog.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/pmac_zilog.c b/drivers/tty/serial/pmac_zilog.c
index bcb5bf7..bce19b0 100644
--- a/drivers/tty/serial/pmac_zilog.c
+++ b/drivers/tty/serial/pmac_zilog.c
@@ -1411,7 +1411,7 @@ static int __init pmz_init_port(struct uart_pmac_port *uap)
 	if (of_address_to_resource(np, 0, &r_ports))
 		return -ENODEV;
 	uap->port.mapbase = r_ports.start;
-	uap->port.membase = ioremap(uap->port.mapbase, 0x1000);
+	uap->port.membase = devm_ioremap(uap->port->dev, uap->port.mapbase, 0x1000);
 
 	uap->control_reg = uap->port.membase;
 	uap->data_reg = uap->control_reg + 0x10;
@@ -1428,14 +1428,16 @@ static int __init pmz_init_port(struct uart_pmac_port *uap)
 	memset(&r_rxdma, 0, sizeof(struct resource));
 #endif	
 	if (ZS_HAS_DMA(uap)) {
-		uap->tx_dma_regs = ioremap(r_txdma.start, 0x100);
+		uap->tx_dma_regs = devm_ioremap(uap->port.dev,
+					        r_txdma.start, 0x100);
 		if (uap->tx_dma_regs == NULL) {	
 			uap->flags &= ~PMACZILOG_FLAG_HAS_DMA;
 			goto no_dma;
 		}
-		uap->rx_dma_regs = ioremap(r_rxdma.start, 0x100);
+		uap->rx_dma_regs = devm_ioremap(uap->port.dev,
+					        r_rxdma.start, 0x100);
 		if (uap->rx_dma_regs == NULL) {	
-			iounmap(uap->tx_dma_regs);
+			devm_iounmap(uap->port.dev, uap->tx_dma_regs);
 			uap->tx_dma_regs = NULL;
 			uap->flags &= ~PMACZILOG_FLAG_HAS_DMA;
 			goto no_dma;
@@ -1530,9 +1532,9 @@ static void pmz_dispose_port(struct uart_pmac_port *uap)
 	struct device_node *np;
 
 	np = uap->node;
-	iounmap(uap->rx_dma_regs);
-	iounmap(uap->tx_dma_regs);
-	iounmap(uap->control_reg);
+	devm_iounmap(uap->port.dev, uap->rx_dma_regs);
+	devm_iounmap(uap->port.dev, uap->tx_dma_regs);
+	devm_iounmap(uap->port.dev, uap->control_reg);
 	uap->node = NULL;
 	of_node_put(np);
 	memset(uap, 0, sizeof(struct uart_pmac_port));
-- 
1.9.1

