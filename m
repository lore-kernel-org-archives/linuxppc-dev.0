Return-Path: <SRS0=OgF1=RR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F20C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 23:20:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECD952184C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 23:20:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECD952184C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metux.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44L4T46JgpzDq5x
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 10:20:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=metux.net
 (client-ip=212.227.17.10; helo=mout.kundenserver.de;
 envelope-from=info@metux.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=metux.net
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44L3Zh3VtVzDqBZ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2019 09:40:43 +1100 (AEDT)
Received: from orion.localdomain ([95.117.89.18]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MEmpp-1hFJFm48Lb-00GLjL; Thu, 14 Mar 2019 23:34:54 +0100
From: "Enrico Weigelt, metux IT consult" <info@metux.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 23/45] drivers: tty: serial: amba-pl010: use devm_*
 functions
Date: Thu, 14 Mar 2019 23:33:53 +0100
Message-Id: <1552602855-26086-24-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552602855-26086-1-git-send-email-info@metux.net>
References: <1552602855-26086-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:VmkbMXgZ5mJ68rFO9MD0xatMizo8sSKA6igdCG69Xczwsw11M5a
 jXG0nirTWbaUHmc0O7c5Bl5TtJOO4xYilcC1dkS/NoFePkR93NDXWPzVFcVdrpDxkvtuAhX
 AGU1PZvaWHmV3IyD7FT0tKLtIP+Anruqf81mZmBILABKNjMNkpsuWg/JAnpsRN20tYNglDC
 /tJSCgslw+xDWm7r9tTCg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RKvN/W2/ZwI=:bq6jDtWooMiunuFrYdL/1m
 GFQ8STpYnsUu84fw5rjd0h+m/HKJBFrYfdmCjoqMax+8mc0gjlQeMFgriALZadgIsCN1zwMaI
 hqR2lrOm0C34/h2jxXdvPOlW1Pd3cy8Mb0ylj2dxl05B37sJ9Kaqsm6d9slW3gJKXEhoK4XIH
 I6wU9J7gwww9RTaYe4jsSODlJjvqNFgVaHBWRglTmn56riIbHYVQSe7TbzcwVRiOsuAALBgRi
 ZJExdg1jmt4UYf4o+dabIUdaMHr+N0BzP8fUYEmWAYS37ldh9v3Oh8rJmaV4+P4VAnFENetkW
 gAjTcRd+mQOFWyaPk0TvkcNR9bGcSJQJOKT+W0YlRmihTSuEqMriddmxknsoNRMXP8LH4CtZr
 i0uQVG7RlPy5AGzk20itaJ6/3baFuL1Pa0uC5w54Z+Ax0ZqiXOf+Iqm9vN8EciTNdqbh1kmC/
 1/ls7TMD4KnJOP+WaUwlMs6OCTMMDDkpsV9YR0a9pUT7g0FMGVd5aVmCvBTdCWekXGlyKDgQK
 rrbH/kW4XtKuYgNYCzKPlT9oR6xOyLaUFOtFeZaqj5fIv1ao0jUEvlq9ho9oBTNpk1bdmFBDx
 tHFEmqoQg5YvQg4qiRtcmAgtjLNCu9pL/4CxAFhDNLgJWYg9omNDDmmoQLufZVWxDF00Wj9+l
 /zZRa7ERzNg8XRpPJ5+LHryvXJ+WfGJY27kxncEH7Q+FjJtPcUUUQyoEmqYBsPQIrX31Huna9
 2TR1KsH6GuMKYXYISIJ72fIEOF8vbo46imBDvfQc7qs0ruQahJO1vSbjkcvGR8WI6y+iUM9xX
 RUZmOpFftrbwXzbTM0XRCK+1hy/EfxUUAMjh/PVZGl/7+LWuENPxbnnd/uAL5CX6eOMZ+48bg
 rXutvLBhrRMP5eDhM4NhMP2KNWLeM2pwefFoIYlg4xGEaAl02+pvkHEpJd88GGThTRmhCu5B9
 5ljjvI7d4Iw==
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
 drivers/tty/serial/amba-pl010.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/amba-pl010.c b/drivers/tty/serial/amba-pl010.c
index 109b8df..7abd1f8 100644
--- a/drivers/tty/serial/amba-pl010.c
+++ b/drivers/tty/serial/amba-pl010.c
@@ -503,7 +503,7 @@ static const char *pl010_type(struct uart_port *port)
  */
 static void pl010_release_port(struct uart_port *port)
 {
-	release_mem_region(port->mapbase, UART_PORT_SIZE);
+	devm_release_mem_region(port->dev, port->mapbase, UART_PORT_SIZE);
 }
 
 /*
@@ -511,7 +511,10 @@ static void pl010_release_port(struct uart_port *port)
  */
 static int pl010_request_port(struct uart_port *port)
 {
-	return request_mem_region(port->mapbase, UART_PORT_SIZE, "uart-pl010")
+	return devm_request_mem_region(port->dev,
+				       port->mapbase,
+				       UART_PORT_SIZE,
+				       "uart-pl010")
 			!= NULL ? 0 : -EBUSY;
 }
 
-- 
1.9.1

