Return-Path: <SRS0=OgF1=RR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85756C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 23:19:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 095062184C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 23:19:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 095062184C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metux.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44L4R76HlszDq6W
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 10:19:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=metux.net
 (client-ip=212.227.17.10; helo=mout.kundenserver.de;
 envelope-from=info@metux.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=metux.net
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44L3Zc22CXzDqPK
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2019 09:40:39 +1100 (AEDT)
Received: from orion.localdomain ([95.117.89.18]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MxmJs-1gpUW13UAI-00zCSQ; Thu, 14 Mar 2019 23:34:40 +0100
From: "Enrico Weigelt, metux IT consult" <info@metux.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/45] drivers: tty: serial: 8250_lpc18xx: use
 devm_ioremap_resource()
Date: Thu, 14 Mar 2019 23:33:38 +0100
Message-Id: <1552602855-26086-9-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552602855-26086-1-git-send-email-info@metux.net>
References: <1552602855-26086-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:VNFqRitCVhR/QvfRU71bdEi19RCYMosXsVa+dbZIUtqM0/So7w6
 WsUpKH3AYerVvwkhIbGqqwssVBUZ1NZ3s5t68seo/luOTCBgG0i1KwSbptAvCwU09DcApt9
 UU0yty9FBEPWwB0RsesG7Y8gtvj28G5/H2Yrmz3j2803BHISpfIOUVucZuoHsTtTy8PyrGS
 GrPWUf/H3vNdjdzCusdHQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WyVZTSFnFjM=:2EoogJORx9+g7SeAmjZDYy
 Res3DU3tmi/GjPs3sDvCA+XrRIabU2vocRCnq2wUZYflylNMow2ll0gXC168rgdVECGjguGbI
 qumuOekVVyN2I8hnpNnrblMt1uQcNp5dGrqUfj5JN2oWYvmUJI+MpVSwfMKC3FjxbMXwy5YT+
 WPZTwRityGCO4lWiBBx1+vyz49Sm9IKGc2maHwjiv8oAOqYY4uQnlIrXWDCGaINZ/rdgBMJls
 GvLX2jpViRDhLquRIxFYhR3bz3nz/bykPpImsXvxLepIa94iOAeDlxTi6a5aqXrnd4/n51ihe
 ZSw144xE/19gihPqwjqq00/pYe6vdlX1vNXV4E8A7YmlpMAkiWoFaDo4lMe3JoHkeEGfPDElY
 bs2JpW5tP+1TpVR+RA9QOgg0tBhJxkqKrtgTyPLhhuC1ifmR8oedp18uiEUIHzpPyhd2yXA5z
 /DvAiE/RP4rtNARbBbh7pkLicvT7Iel0doyliVAfadnLUGcZW8KFMrpOCT/9Kbt3kV8BQ/v2k
 u0Axve5kPqtOr2ZR6qmJPaIZY+EtPiaeyKioBD/s9DTioHWX2oWNlKdv2LKdlNhIi4PkV192d
 rkeNQsxt7x2N0UyMeV5+zCI4Py13FnWxbJh4ies3B4B/FS+uA5qRxFXoqFVEzRaJOh+9oRwOv
 5YD1nb8EiL//8qDyGVfKSBHvBn/EuHHJhXbelKnqtuN84brJ6pVniTjej5ANlVwmbdC4OLNQ3
 HPGE0+kivScrzBmqTCufUQsIj1B/9aQp4ruFgfwkwQJZi8cjeY+FNXMMjBaEdIrCzERnyJq9c
 VUuXGQ7qn71XSwG+KsB6MBZmZ1hC93Sf55FnSOf0OyZ5BN0zWyaNYBDCs9KVC7xw6Dxp2eFTe
 G3RadeKtUn+pVvhTlDqvt+uti/gF+i6MHobzZ+7Z23k+aGHftWth7nu9g0F6Z1Hn6VtND+75P
 cfMWaEG6dEw==
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
 drivers/tty/serial/8250/8250_lpc18xx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_lpc18xx.c b/drivers/tty/serial/8250/8250_lpc18xx.c
index eddf119..f36902b 100644
--- a/drivers/tty/serial/8250/8250_lpc18xx.c
+++ b/drivers/tty/serial/8250/8250_lpc18xx.c
@@ -119,8 +119,7 @@ static int lpc18xx_serial_probe(struct platform_device *pdev)
 
 	memset(&uart, 0, sizeof(uart));
 
-	uart.port.membase = devm_ioremap(&pdev->dev, res->start,
-					 resource_size(res));
+	uart.port.membase = devm_ioremap_resource(&pdev->dev, res);
 	if (!uart.port.membase)
 		return -ENOMEM;
 
-- 
1.9.1

