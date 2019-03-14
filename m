Return-Path: <SRS0=OgF1=RR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9380CC43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 23:27:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 193A121873
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 23:27:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 193A121873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metux.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44L4cS22LJzDq9B
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 10:27:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=metux.net
 (client-ip=212.227.17.24; helo=mout.kundenserver.de;
 envelope-from=info@metux.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=metux.net
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44L3Zl0gFGzDq74
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2019 09:40:46 +1100 (AEDT)
Received: from orion.localdomain ([95.117.89.18]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M4aEC-1h56dS1INq-001j9O; Thu, 14 Mar 2019 23:34:48 +0100
From: "Enrico Weigelt, metux IT consult" <info@metux.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 17/45] drivers: tty: serial: timuart: use devm_* functions
Date: Thu, 14 Mar 2019 23:33:47 +0100
Message-Id: <1552602855-26086-18-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552602855-26086-1-git-send-email-info@metux.net>
References: <1552602855-26086-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:5r+Ptv5G3/1qWxI3DWCkkbtFxPTEnvSfhR5ukwO5ADoTqXU448U
 dtQMPth5bJpZ6f7Bscl0OBv3BL5nInhWPlG6uW76I9pJm3YfyWCWgkRwTyR5fQemqZGQEcW
 81RCi+VaElgdX2WTkloTzCI6WzzEdF+ZLkdYdHoDsuLPWXtSOleXnFSGakAbdc6hwe1rkHo
 fgRNgH1EdpTrK0eSklwNQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Y6FBjMqMod8=:RFj98U1jMlB8AvUIfWIFXI
 Jrr/9udDmTiAvf+86SrQD67xdQa/1ORf49scBIL7ZhI22pvHcF6w8gwIvad4XutwiFszRGxti
 83K3mcygBt5tnEaLxSct1MICCjEo22O0jZchhCdHEhwkAV/cOkKHbPm2PXNaK6Gddq2jSxLJC
 V7GsRG2+7wcscFpkpGJpUqtV1cJ0EDbnIvTKf3at7M31l7p3tTkOY0Mucpw0eYS2YXkO7LD8r
 9xOXhGqCclChlD76BTTsksv1xgnx28VZLnjXY9LzBImLtGmIdO8bzL95EILew0Gjo+PVZ67cx
 2pek+a2UldFfxBGATpb5OcLaahAzdMxKB9ChLYP6S0Z27yTz3bBfSGIhFDXYT2Zw2Yj4Z1YV9
 sk3rqjVpIuJeF0rngpWQI9AHjrCUKzOTdbxhR8aTjfYgjtH7IX1RzSUTPedtKkUDEdQC/RkfC
 OqT6B87zOz0/PXTiFK4NFXixtco8R2aLLPIF6NUxERwhWOQE/ChZhH85lcZaT0Plo/9n1zZVh
 5U2X+KAaaKiRb/TbcyjaSqE1/gj9qthM3ud+hIvEHBVbDFz68+5kTglDVnQlyh2lh8t/ipWLR
 pZ5wpdcyXt+D97YepIZwX5yBPKLj4oQ2hBWbzLGXkUNRRceb4kfcFIkuKfKBhQjkiDc61uFWB
 NaoWYS3vB0jSI4dWQI3H350rG9UooJrUs9umqd4v31EwRoH5+vRktS/CnFKxztpJ8t4HJusLU
 rF+X7AxqwdC1f1aTQSHdKjPZ6x9y+J6E+u+XIg==
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
 drivers/tty/serial/timbuart.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/timbuart.c b/drivers/tty/serial/timbuart.c
index 19d38b5..292354b 100644
--- a/drivers/tty/serial/timbuart.c
+++ b/drivers/tty/serial/timbuart.c
@@ -319,11 +319,11 @@ static void timbuart_release_port(struct uart_port *port)
 		resource_size(platform_get_resource(pdev, IORESOURCE_MEM, 0));
 
 	if (port->flags & UPF_IOREMAP) {
-		iounmap(port->membase);
+		devm_iounmap(port->dev, port->membase);
 		port->membase = NULL;
 	}
 
-	release_mem_region(port->mapbase, size);
+	devm_release_mem_region(port->dev, port->mapbase, size);
 }
 
 static int timbuart_request_port(struct uart_port *port)
@@ -332,13 +332,18 @@ static int timbuart_request_port(struct uart_port *port)
 	int size =
 		resource_size(platform_get_resource(pdev, IORESOURCE_MEM, 0));
 
-	if (!request_mem_region(port->mapbase, size, "timb-uart"))
+	if (!devm_request_mem_region(port->dev,
+				     port->mapbase,
+				     size,
+				     "timb-uart"))
 		return -EBUSY;
 
 	if (port->flags & UPF_IOREMAP) {
 		port->membase = ioremap(port->mapbase, size);
 		if (port->membase == NULL) {
-			release_mem_region(port->mapbase, size);
+			devm-release_mem_region(port->dev,
+						port->mapbase,
+						size);
 			return -ENOMEM;
 		}
 	}
-- 
1.9.1

