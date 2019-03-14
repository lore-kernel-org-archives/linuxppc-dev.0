Return-Path: <SRS0=OgF1=RR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0528EC43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 22:49:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75FA820854
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 22:49:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75FA820854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metux.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44L3mS4nw2zDqPB
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 09:49:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=metux.net
 (client-ip=217.72.192.74; helo=mout.kundenserver.de;
 envelope-from=info@metux.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=metux.net
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44L3SQ453fzDqNx
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2019 09:35:18 +1100 (AEDT)
Received: from orion.localdomain ([95.117.89.18]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N3bCH-1gvJWc0uCR-010bd1; Thu, 14 Mar 2019 23:34:49 +0100
From: "Enrico Weigelt, metux IT consult" <info@metux.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 18/45] drivers: tty: serial: sirfsoc_uart: use devm_*
 functions
Date: Thu, 14 Mar 2019 23:33:48 +0100
Message-Id: <1552602855-26086-19-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552602855-26086-1-git-send-email-info@metux.net>
References: <1552602855-26086-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:pEqS+yFNBBWf5G6twcSYrBP6943zklyRLJUn9hzyF1TXbZEv7FE
 /fqk0BpEo7as7Vqdp/IF6N1tjm35oXPnXS7XEErlbF7pkMBQ8tMJpSUmJHeCSV2Fx58xejU
 5uavxtG1YBdvT89kw4g+iSLUNct9YGK3sJbxqFo2x1WWaGvRxd4z+6Ady+fpSqrhTB1ASNm
 LhIzW/2K+E5D5Tk//jQxg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:F17me8Z2WW8=:yYzCbvsrd19OMz7N2+iQAU
 bwJEXN8ODvASpvy80DH8h4z9NGaLXUwthKd4XvTPQvpC9GN50YAIv2tqCH+4UhrE4jR065gDX
 uWmDWpFWbWcH/QHBtUxc6VhtEA2vMQALjISbicSokVFE0W14pn9j8G7+SMHnh8glTI4fmdbrt
 F6GaD1gTzOo5FCx4NjAmnv1elQmgHysko+NBGvtYlIWF55FeRl4aqxYsylZA81hdNJkjrr+gR
 f16W7fL0Byk6VwpBd02S9G5MLCvzQxjMDeki02l5Z6YOhyUpUI7cT5C0unQTkgd5P1JUwFdND
 7Sw6nzFO/rpijCCZYmofi/mBFklZhwkBHqln8iukzDSkX6zsebPO6MsWjcd2JbXsPU2PjRtyt
 U58aBvlqbE+2MiW+rrtVRTqxJwhzLuzZfsQOQ5xh4AB8CQ/ME58U4dBV0y4lhyUJEPgvgwnmF
 lBG9apU5NK31KwH/j1uVRNapDSMGVdzVyirgeYVJ3szajR0J6E2X5nE01JCXUB/szcACwAN1L
 KEDNB4P3zCzbC9dTJ2Ylc4Wgp+CZvdLWD7vQ+QO7Bqw86NuYddVGS7Nwk2FryAvTnTCaBShR7
 3hJAjx8wkUHCacIlj8g26Q85HUBJlUjfD+JNc3LQHkft0cv/Pr7zNVDZUh3+V/v0JTVRh67ey
 qy4J7NZIKrCdfbmFOrsnvmauf11/0ty+ZFknDlV+Qmx/h1wk63zUjFLu2Acruq8yps+E5hmLa
 UJy3liUSH2iwCCet5MlGDntCcQuKiuUIrVLaQw==
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
 drivers/tty/serial/sirfsoc_uart.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sirfsoc_uart.c b/drivers/tty/serial/sirfsoc_uart.c
index db2e08d..64ea1e7 100644
--- a/drivers/tty/serial/sirfsoc_uart.c
+++ b/drivers/tty/serial/sirfsoc_uart.c
@@ -1042,14 +1042,14 @@ static int sirfsoc_uart_request_port(struct uart_port *port)
 	struct sirfsoc_uart_port *sirfport = to_sirfport(port);
 	struct sirfsoc_uart_param *uart_param = &sirfport->uart_reg->uart_param;
 	void *ret;
-	ret = request_mem_region(port->mapbase,
+	ret = devm_request_mem_region(port->dev, port->mapbase,
 		SIRFUART_MAP_SIZE, uart_param->port_name);
 	return ret ? 0 : -EBUSY;
 }
 
 static void sirfsoc_uart_release_port(struct uart_port *port)
 {
-	release_mem_region(port->mapbase, SIRFUART_MAP_SIZE);
+	devm_release_mem_region(port->dev, port->mapbase, SIRFUART_MAP_SIZE);
 }
 
 static void sirfsoc_uart_config_port(struct uart_port *port, int flags)
-- 
1.9.1

