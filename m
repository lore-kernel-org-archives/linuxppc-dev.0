Return-Path: <SRS0=OgF1=RR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 222E0C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 23:49:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91B15217F5
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 23:49:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91B15217F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metux.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44L56L5zCzzDqRG
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 10:49:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=metux.net
 (client-ip=212.227.17.13; helo=mout.kundenserver.de;
 envelope-from=info@metux.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=metux.net
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44L3bP6BZ3zDq9C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2019 09:41:21 +1100 (AEDT)
Received: from orion.localdomain ([95.117.89.18]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MwxNF-1gofgK3Mlv-00yNe3; Thu, 14 Mar 2019 23:34:55 +0100
From: "Enrico Weigelt, metux IT consult" <info@metux.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 25/45] drivers: tty: serial: pxa: use devm_* functions
Date: Thu, 14 Mar 2019 23:33:55 +0100
Message-Id: <1552602855-26086-26-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552602855-26086-1-git-send-email-info@metux.net>
References: <1552602855-26086-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:60DXqGwgLJWFsCZvkpoZ3QggwHDJ/uIXy3f3YRehQJVpABewDLA
 ylyhjLr11n1jRWmWSPHY0KZvNvYOy7/B/iK7E5CLy7CWtnbBNqpZPPVTBN0HsMrX2JZItkf
 kroXRWFISEFKkKHcnW5EdUqpCB9J7LhdY0VKPKSUvvM6UGSs0wivkYluza0oSYAOQjx0Xef
 Bm61uIHV7LjqLzXIPW3zQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6tD+h53bsL8=:Dj1PYVDcG8hmORzptbQLze
 QMpGPWRDwiFxi28aA7R2ks7zpy9oS4HttXbNIOnKYYbpMqVks9NJd1o7GNM7D2S63hqLVqdd8
 5I10m1T0Iwo1v14Yygegp2NXoI1a75tznvw6C5cS4IYD/jPp1MU5wSMENHFtoOstH57X78Teg
 KlUkFsrPhkviIHCAUWwNBdoUFLlTxyb2DTgDNNW43N/hRB/iTAFHYjsJLSbgQRWZrfUpKqwG/
 DsMF76E11WJSmZYd9IdotSMu0Wpw+1Q3RCsONwBUR131b7osqCvKgTWhw/e6fyOlhJnlQzjqN
 KrxeUOlonj3cZo38+GM8UmO0QokeFBkWNdhSICC47+ogpKWkvExKu9EW/aK9Ktovf+zdKE4un
 aP1gTP0zWzEvVJHZBXd85zCDOji+a0F/TbYOEZJZcmjbBaDTPvCoD7SDDlcXlT0RkQAPe09E+
 YLcQ5VzV0E8Vah6snjk5LJy/VQeCbHZoRXlEmH4JKnIn3+fexD2n535wQOgJwDZiyDpWKdjf5
 +WfwBRaP6OxMDXZM50LllA8fWU7Xl618Stn5H51Mh5bv7r0EfJnh+p2V5TtKN9p1cLCfdFSdp
 LrkQpuUN6nBVoFKHD0Hp8vVAaYz8ufkAT4gEJme4amY3tRjlP7ZlqXLA902S3AqB4Xa7hZXhG
 N7LuuZVuH5/O6q1CIgHalVNvKyauiJ1SbXOXlrZxhm3nh/FSSY5CrmKYG8FVFFcfZ4YjV1zUm
 WTKmPgYPwOpVA+8FiCMEgifayh0H0a9aRtOF2g==
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
 drivers/tty/serial/pxa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/pxa.c b/drivers/tty/serial/pxa.c
index 4932b67..9512a9f 100644
--- a/drivers/tty/serial/pxa.c
+++ b/drivers/tty/serial/pxa.c
@@ -892,7 +892,7 @@ static int serial_pxa_probe(struct platform_device *dev)
 	}
 	snprintf(sport->name, PXA_NAME_LEN - 1, "UART%d", sport->port.line + 1);
 
-	sport->port.membase = ioremap(mmres->start, resource_size(mmres));
+	sport->port.membase = devm_ioremap_resource(sport->port.dev, mmres);
 	if (!sport->port.membase) {
 		ret = -ENOMEM;
 		goto err_clk;
-- 
1.9.1

