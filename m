Return-Path: <SRS0=OgF1=RR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3917C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 23:09:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E17AD21874
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 23:09:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E17AD21874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metux.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44L4CM5FflzDqDM
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 10:09:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=metux.net
 (client-ip=217.72.192.73; helo=mout.kundenserver.de;
 envelope-from=info@metux.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=metux.net
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44L3Ss0363zDqNT
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2019 09:35:40 +1100 (AEDT)
Received: from orion.localdomain ([95.117.89.18]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N2VGj-1guDas0JF1-013tPv; Thu, 14 Mar 2019 23:34:53 +0100
From: "Enrico Weigelt, metux IT consult" <info@metux.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 22/45] drivers: tty: serial: altera_uart: use devm_*
 functions
Date: Thu, 14 Mar 2019 23:33:52 +0100
Message-Id: <1552602855-26086-23-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552602855-26086-1-git-send-email-info@metux.net>
References: <1552602855-26086-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:HRcMubCl3N0QCtdhqoBNq0bPoJCbZHNiTmEpSNwwLRZVYnt2ZMx
 jUx1m4mQpcGoYURsig0O/V4XNZY3cW0ETmLEJO181v9/Phz7JS13acIuMZJXS2kVgeCDC0e
 rCQDk9V0Sr8dqk4fgIWphZNEiZMC9v9PkGsJwYowXf2tukaPvdV5AsU5QoTedKYHXyR9w25
 T3HqZcufo578vTzTzuIsA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lpRqgLeb8zc=:sNipjjzqP8wdzFQL6Kw4vZ
 MSDB6yhuOSOfxVhWGKozjrCOY1WswqY7E+cMjEZ9JI+EZA2q6s6ZNUzB5Z0CQZnUMG1MimHmE
 wF8us2SJRAsBrBCw3i8j0cFtULXuwTzhWQJqeibknIFxtUsnfYXKM6ARtSgnj1OaM16cuqtZM
 klcjsNMSExmysWWLiGmqGmEt8CraYu25yutjQbLArR4cV3sIittiav51rKJ8XFkQRCwT9s5EI
 wU2VP79xIRiqTc7NpPIer1L/k8hLq5wV5AgzsMpbOsGCmJ4dJgtAivXp/97tQcAo0BBR3qwq/
 ln1m6hl3JYIpjMvE7s30grv/9HV3vcNE0OK8RTK+6ydQiHWS2vpscS+My9IItuhbzhvTpRmPb
 GL9nwGUGXTbYRdZaKvjSM/qJR3grbl9f0lvO7aqPg0Fmh+I7Mq6ZliNNY2/1eC0XeCLApGdPL
 HAIA7XNK5euFkmrnd7rdiGs1YCC8JPlv5CgghK6PI7xhW/ORoncvdxVjDQz2QW3QrMOF1gFiE
 +sDWYBtjGemcUtTfaCSLaKSGqKd1rS40qqiqZobymHCQV32ywtXcDLSSW7TI56c3iSgUUTXEy
 FLYD9mQYh6w3kHL/oG8SdVg93Xv95W4PJbj6Onub32os097Rd6fXeOA0odkkugrNZvZ5rdK7b
 NTLbTTiuYYijV2/ZlLH/qq6gJnxoImCjA/+GU3qu6+vNuIj4RvV5ZSqNFBgk32e+rojN8xTQV
 rBRXLv1d9wm7LwRS8b0kkH1tXHF8kb7tuoLQeg==
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
The iounmap() call isn't necessary anymore, as devm will clean up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/tty/serial/altera_uart.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/altera_uart.c b/drivers/tty/serial/altera_uart.c
index 0e487ce..d4f7150 100644
--- a/drivers/tty/serial/altera_uart.c
+++ b/drivers/tty/serial/altera_uart.c
@@ -595,7 +595,9 @@ static int altera_uart_probe(struct platform_device *pdev)
 			return ret;
 	}
 
-	port->membase = ioremap(port->mapbase, ALTERA_UART_SIZE);
+	port->membase = devm_ioremap(port->dev,
+				     port->mapbase,
+				     ALTERA_UART_SIZE);
 	if (!port->membase)
 		return -ENOMEM;
 
@@ -625,7 +627,6 @@ static int altera_uart_remove(struct platform_device *pdev)
 	if (port) {
 		uart_remove_one_port(&altera_uart_driver, port);
 		port->mapbase = 0;
-		iounmap(port->membase);
 	}
 
 	return 0;
-- 
1.9.1

