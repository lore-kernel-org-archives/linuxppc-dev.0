Return-Path: <SRS0=OgF1=RR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9FBBC43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 23:30:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57E392070D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 23:30:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57E392070D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metux.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44L4gj4rvzzDqQr
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 10:30:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=metux.net
 (client-ip=212.227.17.10; helo=mout.kundenserver.de;
 envelope-from=info@metux.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=metux.net
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44L3Zq21SszDqPV
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2019 09:40:50 +1100 (AEDT)
Received: from orion.localdomain ([95.117.89.18]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M2fM1-1h3Bl93DKR-004C7v; Thu, 14 Mar 2019 23:34:40 +0100
From: "Enrico Weigelt, metux IT consult" <info@metux.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/45] drivers: tty: serial: 8250_mtk: use
 devm_ioremap_resource()
Date: Thu, 14 Mar 2019 23:33:39 +0100
Message-Id: <1552602855-26086-10-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552602855-26086-1-git-send-email-info@metux.net>
References: <1552602855-26086-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:tq46V5HkrKkArgmZSws3car69JUj8undTbtBhIc70QwufTd1mZL
 sWiBwGH86COST0US8abTbeTb+YuOxrd+ByPEkwf/3SUkGlon3TFUmogQpGmbYbN/Dfqd/m7
 scOAUvc5wsVofgiem9lmqwyaaNquTW8jzLZVbee2wrjJYMuaEh5tI2/4lwJL8McPMlhNDpW
 Wl1Zwfy3og3RCloZTQzWA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BW1eKWC833I=:Mx+/m5bgyBIbmKn/ObGw0G
 GSkbKqQUYdWw8EshopTRko/BbxnwqsizfLK11iMU0pf4Xf71yWnEZMI8qIo9S4AuJ0IwKHMaD
 7yj90Fc2VI0zm3aLfgTO4HkCJFYsGr9ZDxajC3jrr6hptD1W+zKvYNyFlfnXosGIpWWafral/
 7+qJNSTIMadjggVHqg8UxHLR+HqrGi3DdVPgUm7sFqz1qQDvGFIQKCFf90B9jkJZ29456tKMM
 zL4Pd6Kp3n15G0xN8sGzp5mshGD198vX5xfSrBCKjMGHTyP7YseUECmkJ2HaSDCPfjm0Nj9j/
 UxSN3uQa8nVoirOnhiK98wCYwMElgbmtXxP/73aCkY9zaexwehmsJiZtHEtXOi9EegC/O0kLD
 0Aez/wnbCXCz31HUa5CFY6fRTFhimhjSv3d/o86h4rKO0nJklpvLMTr/AIJ5HIg4TYL9ILdzd
 8ICC/gCERziOIkQlZtzK+igIHgWm+iTlXFKduUfiQEYz24MxpqCiiuoLysyGFdDWKpy8bpBqf
 b9hTuwz5SmIhfGsUDqMlEmjU9Tq8Xn4U78tY3P1AYo6LPnioKhRTgMwy94XDBr710q69bDMlb
 ENJZYCeQ4d726UwujBAfJBHnkVMgTkTDbvjRO4alWeE6NpnB+Im/To1wQf8+mmC2mK/Uutd0z
 Hr6/iCmFKqYabEn7WQoemyk+Z9NezGFN2WXIx2AEZI2z9wpv2qSNgQyjCzZxcrLHgCeY5H3oR
 mRXO8QJ/rJKtOHrjeB/WSxuOHW/a9JXZnsxCoZyFpcVNIwm9eTuzvQMQILL8t2i17KbpRyz33
 iKbYAyW5tVM7cUaDaXERpJYpz5e1j2DmdXKSUPR7g3AlPfaplOWATjZ1EvJo7Yj7NWQ0uSfFl
 Rjh5iq/H6o3ZF7UApT8X01zg8KU6368tKqAy5pamuGd/xfPGhMTKR1fEgm70XsPyzufnL7pjW
 Svc+tYNKuXQ==
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
 drivers/tty/serial/8250/8250_mtk.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
index c1fdbc0..bf6eb8d 100644
--- a/drivers/tty/serial/8250/8250_mtk.c
+++ b/drivers/tty/serial/8250/8250_mtk.c
@@ -383,8 +383,7 @@ static int mtk8250_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	uart.port.membase = devm_ioremap(&pdev->dev, regs->start,
-					 resource_size(regs));
+	uart.port.membase = devm_ioremap_resource(&pdev->dev, regs);
 	if (!uart.port.membase)
 		return -ENOMEM;
 
-- 
1.9.1

