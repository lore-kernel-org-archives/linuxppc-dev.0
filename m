Return-Path: <SRS0=OgF1=RR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98515C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 23:36:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1225C2070D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 23:36:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1225C2070D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metux.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44L4q85bzNzDqK6
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 10:36:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=metux.net
 (client-ip=212.227.17.24; helo=mout.kundenserver.de;
 envelope-from=info@metux.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=metux.net
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44L3Zv2vgHzDqP7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2019 09:40:54 +1100 (AEDT)
Received: from orion.localdomain ([95.117.89.18]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MauFB-1gSl5B1D5f-00cQwx; Thu, 14 Mar 2019 23:35:02 +0100
From: "Enrico Weigelt, metux IT consult" <info@metux.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 32/45] drivers: tty: serial: atmel_serial: use devm_*
 functions
Date: Thu, 14 Mar 2019 23:34:02 +0100
Message-Id: <1552602855-26086-33-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552602855-26086-1-git-send-email-info@metux.net>
References: <1552602855-26086-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:mbSZOFPTtDMVcBC7couioKu8NlV3HZl6EoZ0F7G18McCNoJhxGX
 pqzW5OiO90J9dTDV5nrvniiLum8BCoZKvDJUHTol/JUxZwmIv7lhZw3IGZmWEDtlkJ8VW/U
 cL7GQbqC0wJHsMQugo3uMmRYVBohKsRqBgEHQYtbqQfSm6cwF+hd2hXDon9oH7A1QAjy4w2
 5fBf7VG25bC8rl9662a8w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:smiOzac+cp4=:/RgXVMb27jxTnwsWZkKBCE
 /5ZYyyfqhf8gJp9Gx0JqIzA1B7KtrBJleJOHJTCf6QuaxFQyGWnTq4PehauEDJola7JEoQCyl
 d8Jp/09r/CTnhnUUp2aEiikFvxdHGRVcZGxL1IgBLUHFcWpipQivYes0E7nmJJbrwPApML/PP
 EiQhXu0RluAMLG/gqEuKsc3A+iccS5yipuJ1OEyEBocYlXlIxz1M+kjY3EdQoXVWUs0wPzj+4
 glUdrqfoCqGUlJ5e5sMmOJOyyMlWBeWirSrIuSFKjMdloyLIuW4bdNtd5Yu6Jlpl6nTkL8eMk
 /HdkmET2mgXMg5g3pwbfa7JEXLkC3Kf8lCrgSA3JuipElHPPF3l4Mzv6C3Sudz2mNHXVdw0ae
 V5jqSC6PAC9ER3ZV+f2659JkQ4DkCxn74fa9rzAa5KhNzyL3VWFmKoe6SeqeqLVEYau4wUWZE
 AemqyV+8bHSjBLupZFI8raVm6E//9CH8oawjIUDbfq74h8zzm3GZHBf6KDpNFngH90wpCcrbk
 ICi45YM+NCVuUU2Nwsy1QCpYWj0yiULRMR1KZkDXsTmeiRXPtibTYzoLRK8cE/7PnRh9bEC9n
 Jk+tMqIaf9sbGwE+huMKX41BAxqptIukwHEjSV+zBbEWkJjnzTPSLggRGJirZnBaZd/1Hbbq5
 x5w7FqpLjPVHf/C4qb+jQB6VoOAzEejNu5U8rU2YIY0pE5gtN7zpQkZGQnXmAZEzmu+uT+4l3
 gp3491jaYRpyeehOmi1m456jNRUl36QDiCyKkQ==
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
 drivers/tty/serial/atmel_serial.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 05147fe..084f106 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -2389,10 +2389,10 @@ static void atmel_release_port(struct uart_port *port)
 	struct platform_device *mpdev = to_platform_device(port->dev->parent);
 	int size = resource_size(mpdev->resource);
 
-	release_mem_region(port->mapbase, size);
+	devm_release_mem_region(port->dev, port->mapbase, size);
 
 	if (port->flags & UPF_IOREMAP) {
-		iounmap(port->membase);
+		devm_iounmap(port->dev, port->membase);
 		port->membase = NULL;
 	}
 }
@@ -2405,13 +2405,16 @@ static int atmel_request_port(struct uart_port *port)
 	struct platform_device *mpdev = to_platform_device(port->dev->parent);
 	int size = resource_size(mpdev->resource);
 
-	if (!request_mem_region(port->mapbase, size, "atmel_serial"))
+	if (!devm_request_mem_region(port->dev,
+				     port->mapbase,
+				     size,
+				     "atmel_serial"))
 		return -EBUSY;
 
 	if (port->flags & UPF_IOREMAP) {
-		port->membase = ioremap(port->mapbase, size);
+		port->membase = devm_ioremap(port->dev, port->mapbase, size);
 		if (port->membase == NULL) {
-			release_mem_region(port->mapbase, size);
+			devm_release_mem_region(port->dev, port->mapbase, size);
 			return -ENOMEM;
 		}
 	}
-- 
1.9.1

