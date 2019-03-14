Return-Path: <SRS0=OgF1=RR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 329F4C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 23:39:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE6E22085A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 23:39:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE6E22085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metux.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44L4tj644KzDqKJ
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 10:39:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=metux.net
 (client-ip=212.227.17.10; helo=mout.kundenserver.de;
 envelope-from=info@metux.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=metux.net
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44L3Zz0FzXzDq9d
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2019 09:40:58 +1100 (AEDT)
Received: from orion.localdomain ([95.117.89.18]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MUXd0-1hUvWx0plo-00QRnQ; Thu, 14 Mar 2019 23:35:11 +0100
From: "Enrico Weigelt, metux IT consult" <info@metux.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 41/45] drivers: tty: serial: timuart: use devm_* functions
Date: Thu, 14 Mar 2019 23:34:11 +0100
Message-Id: <1552602855-26086-42-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552602855-26086-1-git-send-email-info@metux.net>
References: <1552602855-26086-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:VMveoKcaSSHQL6RZwKQTc3/i2g9aJhrz4ZUp5udhZJLzknlw8eb
 mO3m1FgaSydJp0i9ppsuqSSADF2wx7oy/tJetuQM2OdQdiIv1Uw9QCGJGrlDrG51wwmyQKS
 QtRqDuKYQgw1G+dZVKHDrsT7U6XfbH2WyDjSmPJht5pNnysAvx5jQQBxa9943RVv/UlP6zA
 B0m1yhUE3SDYjr3U6EIeg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fjYaaZFZv5Q=:dL5SZ5za5tVn/7FgpCjodJ
 RERWb7EkG0Pu3WRzPVql/ZBKud/cWud2YLvX9qo64FQvi8lJF2MmWO9ymG5G6R3BQ5ZONj64J
 WJFKe2pxLLvaqllNs1TLq6azuAvsigFo3oBSDpX8YK3HTwkYtvbnEh99FwHN0jTvYL1hq+H0F
 vou4Z+LSD7oWnsgJxfMimAIxDuPhln1IcNucmXk2DAf5jHPtBMU556BM+D3wUX3Bh8gY705f2
 0L5uUYwp2HXZxvDYM9rhUZQJtkkrKZ1gUVibToXQiotDIbXDQBwsKGvYCIGH7urEHl5u9lpif
 lQx/hxXb0b5eFqJBkgrrtYvw9dzyzehWbMY/PEoQLfShCcYYRKwfEw/IqMVn+EACmJyQDGBsO
 YPWGRTVYKaGkrGPFoLHpZLnjIV+IeYlKJP2Y3Lm6XkGIEhOHU8Fy1S+iF1pHU8qLj5o5E6sEy
 tlR2jCGqphsOCuc98QmmOaqGBxEXXikCGuhmsrjWvcWMiOSor+mM62sazHM3OejcBRyWekKN/
 g/krX7pjq9jW8FrO4a75ynqvcADGkEevfxpneTbTrlrjFt3ADFr/CVWMjLPatdA6Ug9PdLcwM
 QqJ+CuAQcFafOkTJo3x0gQaU1mPifg9GPtikEt1CfMC47RElBOH8vqvUcwjaxp2+99uUJy9H9
 xkTuX+p3PiaAzE2DltOZrKvbnLlVEY7QO0tvAlUrtPjOX7XWbr8i6qgNdVl/b1mAc0isNvwnO
 1HBx/dmr4UdBokxDVxriwNtnqsrRZqANmdZx+lliyd22V5Qgjuu3oQvR+92NzFvGvTsUrfhS5
 to20Pd+mK17OXPDjrGsOYDQuHvq2q3XUCj5SMafsOa/Ga9acGB1m3yV92qKeeWILGj0YiCTM6
 DM3vVXjCiVks1JCHGSFjjXl40nxOJ6tKLT/BQR585Wr58tYrvkdMayzHqH2iU+S7i4I40X0x+
 ntBwETWXG3g==
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
 drivers/tty/serial/men_z135_uart.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/men_z135_uart.c b/drivers/tty/serial/men_z135_uart.c
index ef89534..349f70e 100644
--- a/drivers/tty/serial/men_z135_uart.c
+++ b/drivers/tty/serial/men_z135_uart.c
@@ -732,7 +732,7 @@ static void men_z135_release_port(struct uart_port *port)
 {
 	struct men_z135_port *uart = to_men_z135(port);
 
-	iounmap(port->membase);
+	devm_iounmap(port->dev, port->membase);
 	port->membase = NULL;
 
 	mcb_release_mem(uart->mem);
@@ -751,7 +751,7 @@ static int men_z135_request_port(struct uart_port *port)
 	port->mapbase = mem->start;
 	uart->mem = mem;
 
-	port->membase = ioremap(mem->start, resource_size(mem));
+	port->membase = devm_ioremap_resource(port->dev, mem);
 	if (port->membase == NULL) {
 		mcb_release_mem(mem);
 		return -ENOMEM;
-- 
1.9.1

