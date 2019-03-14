Return-Path: <SRS0=OgF1=RR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51640C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 23:17:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1DDC2184C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 23:17:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1DDC2184C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metux.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44L4P23MN3zDqG1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 10:17:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=metux.net
 (client-ip=217.72.192.75; helo=mout.kundenserver.de;
 envelope-from=info@metux.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=metux.net
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44L3ZY6bWjzDq74
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2019 09:40:37 +1100 (AEDT)
Received: from orion.localdomain ([95.117.89.18]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MvrRB-1gnZmO0vzT-00srrv; Thu, 14 Mar 2019 23:34:35 +0100
From: "Enrico Weigelt, metux IT consult" <info@metux.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/45] drivers: tty: serial: 8250_ingenic: use
 devm_ioremap_resource()
Date: Thu, 14 Mar 2019 23:33:33 +0100
Message-Id: <1552602855-26086-4-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552602855-26086-1-git-send-email-info@metux.net>
References: <1552602855-26086-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:5GzyXryUCmPhaqsbZOtkTmtvvnO+gg6pzLTYxW3RxRcEjAoNXdO
 +lAE/VWhVRPlbPQJCB+g3Ld9/FEIODdn6m7Cs25TEXWnoYX6TFnNW91Jd7l1w3c72fyw/ai
 ExQlqgaL0xZNA62P2gp27c5eWykMCBCgqyoIR3Sx2+7eCabx/b/kivarJvErvg4qBMjp+G8
 B4Jvc4PvLWY88dnQ8uAdQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JUNPtTS76RI=:Qs2fauVH6S5di0QClIHlEi
 PgUHgT8DxWU0RVD4We4u6p+Q5Heyg4Y6wXlb+y0O9eZm0efCHJsJOBmC3+iY6Vh6aSUeTYt5y
 YCGs3mlQmMXOjfJvyRC8JLjnUX+eZjw/Yu0JbHE8c1HJaC1viaVdOvmXfwQ9kgEjEGO4f2ET4
 77NGTLnT6V8ZHBN/TXY6JEEZjzHOZ1CYAeifKTXKkOkX6JRDqNcqUmRys1Ep+CC4yGhdu88GK
 HNkQUJPFZLzBUQ0J7pRZ9hGlLX08iMHd4V9eg+uGxqiWyqxHZNiTR3RZahZQB5Y6O/BUt2pLu
 45be/MvbZes65GWTjngpFT3bKvWZVojErh4F/O9PQfRZgqkFQQpzPsuICztJcp9yNVoo7TXGb
 AHp7CtdG5Q3xODPhRhKRMHXRsbAZrxTTdyVjEc8fwxZrSvNVaA3uVv9dhn3d1PBbWV+hMO/5N
 RCTikNrzkOrh6CUm4QzmAALxyxKvo5sFUUwcWD39ZYA0pnW2DccutkOXt+ChnhMaJsA//vDCq
 TA2eEFb5ArKaMT8exfNEqLuyrpMjSFQEvug4AvSflU9iwGnFB0kn+YqXFvLZYQlQRzQO+qQ1x
 64onpEjCtVpda7V0wkywSunStFhYMvie7DW9eDlYVPUtkp2mR5nXPK2Eat1ybufNY8EEoGj73
 iMh1Hk/DTzBZicHrNoThVdGBNlY5ondruVt7Ln6cAJI6NXliRIv1MANmv++YwDZo+P2e0m9uh
 f5W/LAvmMP1PX/eihJh8oygAknXb8F8MEUVE6w==
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

Instead of fetching out data from a struct resource for passing
it to devm_ioremap(), directly use devm_ioremap_resource()

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/tty/serial/8250/8250_ingenic.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_ingenic.c b/drivers/tty/serial/8250/8250_ingenic.c
index 424c07c..90ae3e2 100644
--- a/drivers/tty/serial/8250/8250_ingenic.c
+++ b/drivers/tty/serial/8250/8250_ingenic.c
@@ -249,8 +249,7 @@ static int ingenic_uart_probe(struct platform_device *pdev)
 	if (line >= 0)
 		uart.port.line = line;
 
-	uart.port.membase = devm_ioremap(&pdev->dev, regs->start,
-					 resource_size(regs));
+	uart.port.membase = devm_ioremap_resource(&pdev->dev, regs);
 	if (!uart.port.membase)
 		return -ENOMEM;
 
-- 
1.9.1

