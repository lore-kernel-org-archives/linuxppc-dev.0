Return-Path: <SRS0=OgF1=RR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0DAFC43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 22:55:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24A1D21873
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 22:55:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24A1D21873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metux.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44L3vR0TV3zDq6Q
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 09:55:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=metux.net
 (client-ip=217.72.192.73; helo=mout.kundenserver.de;
 envelope-from=info@metux.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=metux.net
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44L3SS55m9zDqNm
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2019 09:35:18 +1100 (AEDT)
Received: from orion.localdomain ([95.117.89.18]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MsZeX-1gkHxf0is7-00txnj; Thu, 14 Mar 2019 23:34:52 +0100
From: "Enrico Weigelt, metux IT consult" <info@metux.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 21/45] drivers: tty: serial: altera_jtaguart: use devm_*
 functions
Date: Thu, 14 Mar 2019 23:33:51 +0100
Message-Id: <1552602855-26086-22-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552602855-26086-1-git-send-email-info@metux.net>
References: <1552602855-26086-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:/7N3Y15yubt1Hp/mjw3zs7TBCGDbpCWoamybrySXM7TWT1iiZ5r
 2R8qGWtT++LJJEcxQpELQ8gkj3HbqZ0eXBmEHjMtZDtMbIQlKSH4mB2MapOJmflPOvkQlJH
 NKjJApxMquO+xfL6lXyipXMxU89N9c6JrlVMWKHy2OyBKhNKp3c99Rkevx9rKdNWXzDu9gW
 fZGjlLuF87u52WfoatMxA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZOxp4iW/df8=:suctqOpq3a/nVrfdf/e1hw
 MNoCU4SRZ7HWSprUjLQV7I3v2UgGm+YHZbGfV/V7DGZPk4exNA7H4Ei+tLgG6ZposG0O2RWam
 cYOsNjUoZI3yuwm8shOQjmuBJAZmNqA4/Yeor7sMVJvA1OnfZqurxmfHlcc814DxLrqN6XCi9
 x0pO3bw30vLUDh0jCjvRFCMr3IOf2/x8wpcn7P4kwPAMTMa2XJj7/azpzikkrVPMqYZlquyBu
 +deD1Lii4JlDPATXMSHb+TP0GWBbKHF3IvnOrIyqXG2M/59fPgJcoaraM8OqEz4ZB93WC1v4d
 zmO+g103p+K848F4RiqTbKYbKJfd3YHoyYd7YC9KI6wjAh4U64kPjDSIz77cL/RpqXH7G3UGo
 leuLZFF4Z7PaAhQu2VipOsGfxdPVQi4z90j1cUPzHiahjRZ15Wwtq359R2uNyzLWZo/sPQYgN
 SaPjsot9Z1lK6NZF5nLV39mmBOeDmPsuyRmFd0IpH0bgWDfoRQy6Z1BDpOa1qLJ3USOuRqH41
 1QlXnWFrMfaCa1pjU6MX9Ov+DuE1Ez4o530TumHkNxa/0IAwj2tKf6HrS+D9XsDDsFwRlrnSa
 Yni/M4O+NGtSg4gQ/2aj+mVJWUI6z3Vfdk/lRrk+/gRVAHjw77VQMjjJxpTefXqB4KVqBvyx+
 ajrOBFamJ9xRSN0qEICe4myxxQs1wbP6O0XgjPHHpiRE5urnj2GS6wj+1pAJVioPA5MO1kS1Q
 LKfM83cdawIT1kmG8V4p3VA4GYckcO8YKaTCUA==
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
 drivers/tty/serial/altera_jtaguart.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/altera_jtaguart.c b/drivers/tty/serial/altera_jtaguart.c
index c90e503..13cab5d 100644
--- a/drivers/tty/serial/altera_jtaguart.c
+++ b/drivers/tty/serial/altera_jtaguart.c
@@ -448,7 +448,9 @@ static int altera_jtaguart_probe(struct platform_device *pdev)
 	else
 		return -ENODEV;
 
-	port->membase = ioremap(port->mapbase, ALTERA_JTAGUART_SIZE);
+	port->membase = devm_ioremap(port->dev,
+				     port->mapbase,
+				     ALTERA_JTAGUART_SIZE);
 	if (!port->membase)
 		return -ENOMEM;
 
@@ -474,7 +476,7 @@ static int altera_jtaguart_remove(struct platform_device *pdev)
 
 	port = &altera_jtaguart_ports[i].port;
 	uart_remove_one_port(&altera_jtaguart_driver, port);
-	iounmap(port->membase);
+	devm_iounmap(port->dev, port->membase);
 
 	return 0;
 }
-- 
1.9.1

