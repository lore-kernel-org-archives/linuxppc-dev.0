Return-Path: <SRS0=OgF1=RR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 417EFC43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 22:41:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B01C02184C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 22:41:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B01C02184C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metux.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44L3c06ZQnzDqPV
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 09:41:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=metux.net
 (client-ip=217.72.192.73; helo=mout.kundenserver.de;
 envelope-from=info@metux.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=metux.net
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44L3SF3S2dzDqNP
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2019 09:35:08 +1100 (AEDT)
Received: from orion.localdomain ([95.117.89.18]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N3sRi-1gvalv2zSq-00zmY0; Thu, 14 Mar 2019 23:34:43 +0100
From: "Enrico Weigelt, metux IT consult" <info@metux.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 12/45] drivers: tty: serial: xilinx_uartps: use devm_*
 functions
Date: Thu, 14 Mar 2019 23:33:42 +0100
Message-Id: <1552602855-26086-13-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552602855-26086-1-git-send-email-info@metux.net>
References: <1552602855-26086-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:D6vqc6/SMpMwV3Mjm1p7xwRTR72HMVZBBVh1/FCbNDWkp8P3g2W
 TrOQ87bVPA7kZwpyl4ktqhFPS0EHPzrsjJIhjUlp5PE8BrbbZWJkU1r+OdPzwIb+4IuKGu8
 qTaAipHSCwQ95WbNCyDsmAXV+n3scqPBNNtGSqPBn9yAKY29csLqZoxzRV+w7cCK1CTqMJt
 srxJ7oLeNS4PEbiQgosVQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dQYoeogF+gM=:+v5tmVFISov78Xbvh9iZWd
 +upmxph7jKFEYXmvk+036QcWGCaBMGC4wGaE3YoW8226iiUEqZCy0tCZE4//CTfsZlYfXBIGD
 jEGMIOXU4rvKB2NR0rJzpIpCH2Jlz9U4Ri8KL6Ae3Nd6n3D6E6l/rjfIZ+HdZVEGDWFvMLNNW
 hSD/aOk99A1r/xJb+clK1/e70LznqkzsFj3mfkp9Q0hbPnJ0ytnaiONyW0ZSPe3QhFOzSA+F1
 /vP4Wi9Ghxc5+teU3KNPolONOKVbwpzIYVk4CzZ18tbnxil8nosXH0PoMlbsRKA0p65myyigy
 qUQcN9E8jchRS08fDImRAWZEBlj1bcEuLq/wvzzE2w6stKJeo9LWDylJXF4/UA/Xv43rVauY7
 Jy/t1QiO2zSmF39CpPkDN+x761trSt3rU+zCZxc+vjH6DIURsynyMWONBkGumyLEW9MmyvkTw
 F9WRIcYiT3BUP3RmzycQb56UcT8yz3b2w6uUiKQKiW7Fj7kW607xGWGMxKeIwMfp1qPjUjSn1
 Y2MrNOOPKqIZ25Lj90rVDUboOBWh07kvUTnpK9zRTHgdrzSOL8C7IpTxCzGXIXubVb0NQYmPN
 9abhyKD7BY2nDDo5Va52UH2qhTmNv13ENTShkP60bQnP6Fi8FXWhPQPUvJd4/2oVLai2FFhbC
 hnOtc6GA2K0p+e90KmRseGL5sTZtwPyHnXAGmJWM2JutSjpd8hG0NGbwfHaAGEzqMkRA8O9l7
 9ccXjW99SDXU0FLLE9VvHYFZ/hdZ1wZXaHrbdw==
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
 drivers/tty/serial/xilinx_uartps.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 74089f5..6684ed7 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -953,15 +953,21 @@ static int cdns_uart_verify_port(struct uart_port *port,
  */
 static int cdns_uart_request_port(struct uart_port *port)
 {
-	if (!request_mem_region(port->mapbase, CDNS_UART_REGISTER_SPACE,
-					 CDNS_UART_NAME)) {
+	if (!devm_request_mem_region(port->dev,
+				     port->mapbase,
+				     CDNS_UART_REGISTER_SPACE,
+				     CDNS_UART_NAME)) {
 		return -ENOMEM;
 	}
 
-	port->membase = ioremap(port->mapbase, CDNS_UART_REGISTER_SPACE);
+	port->membase = devm_ioremap(port->dev,
+				     port->mapbase,
+				     CDNS_UART_REGISTER_SPACE);
 	if (!port->membase) {
 		dev_err(port->dev, "Unable to map registers\n");
-		release_mem_region(port->mapbase, CDNS_UART_REGISTER_SPACE);
+		devm_release_mem_region(port->dev,
+					port->mapbase,
+					CDNS_UART_REGISTER_SPACE);
 		return -ENOMEM;
 	}
 	return 0;
@@ -976,8 +982,10 @@ static int cdns_uart_request_port(struct uart_port *port)
  */
 static void cdns_uart_release_port(struct uart_port *port)
 {
-	release_mem_region(port->mapbase, CDNS_UART_REGISTER_SPACE);
-	iounmap(port->membase);
+	devm_release_mem_region(port->dev,
+				port->mapbase,
+				CDNS_UART_REGISTER_SPACE);
+	devm_iounmap(port->dev, port->membase);
 	port->membase = NULL;
 }
 
-- 
1.9.1

