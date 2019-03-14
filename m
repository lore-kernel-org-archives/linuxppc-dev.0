Return-Path: <SRS0=OgF1=RR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5265BC43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 23:03:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC25621874
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 23:03:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC25621874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metux.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44L44b4f9pzDqHk
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 10:03:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=metux.net
 (client-ip=217.72.192.74; helo=mout.kundenserver.de;
 envelope-from=info@metux.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=metux.net
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44L3Sh3vsFzDqNj
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2019 09:35:31 +1100 (AEDT)
Received: from orion.localdomain ([95.117.89.18]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N5W4y-1gxEOp193a-016wDW; Thu, 14 Mar 2019 23:35:05 +0100
From: "Enrico Weigelt, metux IT consult" <info@metux.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 35/45] drivers: tty: serial: lpc32xx_hs: use devm_*
 functions
Date: Thu, 14 Mar 2019 23:34:05 +0100
Message-Id: <1552602855-26086-36-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552602855-26086-1-git-send-email-info@metux.net>
References: <1552602855-26086-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:te4TBOLd0AsObsYwaKbuq3GQUSFWyyoYsWbEecdVNIqZj5kp8kI
 QFrPLrflaxNteCN3YD3usBroa57u0rrRiGZp0ReH5gzoRB8gM15rA3a0NDzkIIP+k5/yDlh
 LvR36Mr04OkvDGUp31Kzuz5czxwmL6ukyf9lXFg76Y2owmPk2zC4xjAcl4EJPSkMPPRVY8d
 n4jk04eYTqRikCqVJesuQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AX6cckKTnAg=:ICZlOILXa9RJlGaLMOdLrX
 COPAoGd0JasjPiu1Y71B/lNhZb7Be8bqw8kMB99yWM6jfXqQ7pnioaIpRKK6hj4uLdCR7QOwX
 Df7FOi1yUBKW1wRFtuJD94z8EhRL/tCsdQlFZE3CdL1dCg9Cq/AlXBuHYm8I6vs+X8g9BTurv
 e2vhSH1Op2irGi7MsVsWUXBEZ8QZdX3OVB8FJWcgzmk6a3WPF9NWvYX4usLaoUlAlzzIvFNkc
 9+h7XcC7vLtxsQU1D8xLfeF7yd1Wz6+sFnSaUbDLpvJ6TV0ziHhY8BGusjSk1ViNmhXqg0IkW
 ueHfNLuwzGc0ZiiAdW5YBZt58dxVubV9VR3ibEiJqyJYwauMGdUGlXqqtTLZ77sCZFnuS03Vq
 EbfYP1HsmI048YVxalqLTntJZSXZXmZCYqhAIopsSGu9FiUeGeQdiwBa3t35dFFXNpEpOO8lH
 DdXE0NP1vsCHDm+0/IRug+aVM97iTaa/krVAB8Whk+XZT541V47uuF4DqSgFPO7wvh1GLujqC
 NxSvS4ixdNEoFk79SmlU/agoAKeUWYNp+fstqhOH9yaBZvbMCx/v+q6WHifd21cOiWVGm0KqU
 gPUefBZtFuJGl9yppjVqykWPmQKJCsBcnjmtvrmHK0meZ4dPs2+gNwhwWFayLLZxzTEFI1Q8S
 9FE8c1olRhlmn4mbE+P/M8gCxph4b5nR1R/WIQ/ShFcoB2uubZl5um/y0XHo9I6GXKT3u3luX
 GbS3nwowSy/89EsnNQ07BoAKR+e/y+pvb7+EsQ==
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
 drivers/tty/serial/lpc32xx_hs.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/lpc32xx_hs.c b/drivers/tty/serial/lpc32xx_hs.c
index f4e27d0..0bb86d7 100644
--- a/drivers/tty/serial/lpc32xx_hs.c
+++ b/drivers/tty/serial/lpc32xx_hs.c
@@ -575,11 +575,11 @@ static void serial_lpc32xx_release_port(struct uart_port *port)
 {
 	if ((port->iotype == UPIO_MEM32) && (port->mapbase)) {
 		if (port->flags & UPF_IOREMAP) {
-			iounmap(port->membase);
+			devm_iounmap(port->dev, port->membase);
 			port->membase = NULL;
 		}
 
-		release_mem_region(port->mapbase, SZ_4K);
+		devm_release_mem_region(port->dev, port->mapbase, SZ_4K);
 	}
 }
 
@@ -590,12 +590,19 @@ static int serial_lpc32xx_request_port(struct uart_port *port)
 	if ((port->iotype == UPIO_MEM32) && (port->mapbase)) {
 		ret = 0;
 
-		if (!request_mem_region(port->mapbase, SZ_4K, MODNAME))
+		if (!devm_request_mem_region(port->dev,
+					     port->mapbase,
+					     SZ_4K,
+					     MODNAME))
 			ret = -EBUSY;
 		else if (port->flags & UPF_IOREMAP) {
-			port->membase = ioremap(port->mapbase, SZ_4K);
+			port->membase = devm_ioremap(port->dev,
+						     port->mapbase,
+						     SZ_4K);
 			if (!port->membase) {
-				release_mem_region(port->mapbase, SZ_4K);
+				devm_release_mem_region(port->dev,
+							port->mapbase,
+							SZ_4K);
 				ret = -ENOMEM;
 			}
 		}
-- 
1.9.1

