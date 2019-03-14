Return-Path: <SRS0=OgF1=RR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E676AC43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 23:04:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DEFF21874
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 23:04:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DEFF21874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metux.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44L46L3zY8zDqQP
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 10:04:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=metux.net
 (client-ip=217.72.192.74; helo=mout.kundenserver.de;
 envelope-from=info@metux.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=metux.net
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44L3Sh5DphzDqNr
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2019 09:35:31 +1100 (AEDT)
Received: from orion.localdomain ([95.117.89.18]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MMWcT-1hMuVR0qhD-00JX7L; Thu, 14 Mar 2019 23:35:06 +0100
From: "Enrico Weigelt, metux IT consult" <info@metux.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 36/45] drivers: tty: serial: pic32_uart: use devm_*
 functions
Date: Thu, 14 Mar 2019 23:34:06 +0100
Message-Id: <1552602855-26086-37-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552602855-26086-1-git-send-email-info@metux.net>
References: <1552602855-26086-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:470VhaLpNC6lKxsvkwsuYrMW/TNf5OEECXD1f0Sbftri6x8ZrSB
 /Kps+C6NL9+/F2nl9xWr+/6JWiQsAGwxrb3GEj2aqNfH/38CZFmS4flrktATiwUi4M/rjev
 qSVUDYZCFAQj9Bvzey7VKBOwFhkD/hTiCCJcXorivOizFH8JN0RIHFGQSFhrKlNgvkQv5ii
 Q+GrPPjQjta3ydAQ+blNQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:D9c0qOR8ong=:juCLVtgDScU3i+htrRvVfW
 QeEgKi/DbwtBxOExSsZAXM+NjfGByaBXZIifSyOoiXRDncdTlGuiBnrYLloy2PBfJfK8xh/hy
 +p8Kx0KmLNfnS+cXkiaJrnDvMxPour0HREFaz1Dd/HrmXJG9wej1NPO1TfM1vRhdZf11pQJy1
 CGDCI1QbmzMK8F9ZJQmWSd1I9xu/W+SClRNYLbzVl//6ZMrxmE72ZXHVlITUXuVQQpalQDtBH
 VrHs+aDhYOgBo4W/8hzl3+7HNGH2WOzvEQgk9XezGNM4X/jbCfOH1toswng+9sOFLDHNZayng
 1a7A7uJtvTELw/hYFrbAuRD1Uzrwok2TfkSI4K0d3ICsA+2x8x935rkilJ/fABlUEganBd8xL
 09isMTlCwm8OQqc3ejl5D3RfpgorTbYvGlW6smSGNCu2qew3xCV+H//M62A9yWh0oxZE4vHRB
 fOEYwm2xVQvGJ9PDJLck3rvWKmGEYGi/gG8aS+fSGjZXJ4LMtXKY6OYtCMcq/w1KMi3fejy8v
 6swY+x1CrSGZeLvsww2Ffc6Lx904IuYMgjDTtQcH2UNT2I/MhTau1hbZHkwFo3m408dTbD0Aa
 QUs6f04ot3yaPfGpEvmfyKUXYGSX2GqkAHcwvTR3P2z4OPWv843M8g5TWPk38sVC+cblcdrWC
 vvqcfBgEFAKmd/+cblnsE353y/FiFV9XBCJmijoaJt3sUzkkjJIbnyWg/9DI8wphMzAGbifFO
 8F+2d1KTJPIRaJrCDAjLGHs6g+CpGFjqEMLU+g==
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
 drivers/tty/serial/pic32_uart.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/pic32_uart.c b/drivers/tty/serial/pic32_uart.c
index 0bdf168..b4f0b29 100644
--- a/drivers/tty/serial/pic32_uart.c
+++ b/drivers/tty/serial/pic32_uart.c
@@ -614,15 +614,19 @@ static int pic32_uart_request_port(struct uart_port *port)
 	if (unlikely(!res_mem))
 		return -EINVAL;
 
-	if (!request_mem_region(port->mapbase, resource_size(res_mem),
-				"pic32_uart_mem"))
+	if (!devm_request_mem_region(port->dev,
+				     port->mapbase,
+				     resource_size(res_mem),
+				     "pic32_uart_mem"))
 		return -EBUSY;
 
 	port->membase = devm_ioremap_nocache(port->dev, port->mapbase,
 						resource_size(res_mem));
 	if (!port->membase) {
 		dev_err(port->dev, "Unable to map registers\n");
-		release_mem_region(port->mapbase, resource_size(res_mem));
+		devm_release_mem_region(port->dev,
+					port->mapbase,
+					resource_size(res_mem));
 		return -ENOMEM;
 	}
 
@@ -641,7 +645,7 @@ static void pic32_uart_release_port(struct uart_port *port)
 		return;
 	res_size = resource_size(res_mem);
 
-	release_mem_region(port->mapbase, res_size);
+	devm_release_mem_region(port->dev, port->mapbase, res_size);
 }
 
 /* serial core request to do any port required auto-configuration */
-- 
1.9.1

