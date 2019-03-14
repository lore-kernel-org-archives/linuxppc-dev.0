Return-Path: <SRS0=OgF1=RR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E4FC43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 23:38:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22E302070D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 23:38:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22E302070D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metux.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44L4s61P5DzDqRB
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 10:38:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=metux.net
 (client-ip=217.72.192.73; helo=mout.kundenserver.de;
 envelope-from=info@metux.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=metux.net
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44L3Zy4VTczDq6t
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2019 09:40:58 +1100 (AEDT)
Received: from orion.localdomain ([95.117.89.18]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M8hEd-1h9De70Imf-004mDV; Thu, 14 Mar 2019 23:35:14 +0100
From: "Enrico Weigelt, metux IT consult" <info@metux.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 44/45] drivers: tty: serial: pnx8xxx_uart: use devm_*
 functions
Date: Thu, 14 Mar 2019 23:34:14 +0100
Message-Id: <1552602855-26086-45-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552602855-26086-1-git-send-email-info@metux.net>
References: <1552602855-26086-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:F6spCLrnPk4yuFxqhl6fX+h+SLnr1wF1ZAV5scoTF7cyAy3wHqN
 Qq1DudA02ljbXR6u9JxOIqYan1EFOoCSjey9XlbB05Si21KBlSp40f1pSu6AOGLKF0i5IqQ
 lPay4c8yMzJTyi56IeCv1wZ+PZ22BgyXbsTDWvNPQVyOYET89/anwsX8AXt+2tVmdMd8zgb
 5ias72tJZkdphbbm/dAQA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:n0RdofhsXps=:bi7cWhXjM//jCClZieXnJD
 AuZI4/7Bt2bPnaskGBTsGcu2LzkYRWp4pd/GKShbFmLIU+h1+XZaAA/YuVqlPWxd45EGZtGQC
 W3TiwZlAdA9nJFeXAHfU4WJ7kdEjUdiJ7vikl57t8CxuiaoYeQ67qc9gt+XWnkHlbvt7MyJkE
 qNURfn8+yih2MSpAUoAKYTZo7V0taVsEfORrTUxKVxk7hapJ/Z5okeJWTB4Zmo3sFAsipW1uj
 wxPEMRZv0DGIId+C3R9i8mXblXM3dRkUZ+Wm0jGvcQasAzk0UTeaJT6K2UqIXlj5IUE9nCd8v
 FBgghnW82+IU+LKuFc4+CcmN1rn40rVWcP+nCAnVPKTxBcx+Oa5tOXGbHHwRlgiMC6hzz0GG+
 aEPEVCYttwmcyMLCNZrCcI23ltOyZF6Aj4mExhTaD0LRNZX8PiH2OK6rjT2Ul1dYxWnttm92q
 wC9OARH1O0u+5CnMfSYmQnIq9UTdQ7ef09Vj0im8GuszvbbHbF2DPgJACTyP7y8IYUTZ/4c8F
 dfzbhtvFNVaamwGLmGQlwuWCuuPzxLUM602hQNlnGFKUEWfJ0ZnKc6kuCebg+bg/bq3OivkCC
 sJBMS0uwmZT9GWyOS25fXeW7EeVEL43y7Kgp8ktWpT9a57HFjbFySInCr8Oz8G6u2qcS//E1c
 N+0hhvoFJ0+bzOBDV+DJQpg0gLs1vmiGs9A4/as9HGmWKMeiZJvsfG0tAGx6FTYfK/zmruNoF
 pXud1K7NWLhC8vuj6J+WbZw2/taQNTBKnR6T4A==
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
 drivers/tty/serial/pnx8xxx_uart.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/pnx8xxx_uart.c b/drivers/tty/serial/pnx8xxx_uart.c
index 223a949..3951226 100644
--- a/drivers/tty/serial/pnx8xxx_uart.c
+++ b/drivers/tty/serial/pnx8xxx_uart.c
@@ -568,10 +568,7 @@ static const char *pnx8xxx_type(struct uart_port *port)
  */
 static void pnx8xxx_release_port(struct uart_port *port)
 {
-	struct pnx8xxx_port *sport =
-		container_of(port, struct pnx8xxx_port, port);
-
-	release_mem_region(sport->port.mapbase, UART_PORT_SIZE);
+	devm_release_mem_region(port->dev, port->mapbase, UART_PORT_SIZE);
 }
 
 /*
@@ -579,9 +576,7 @@ static void pnx8xxx_release_port(struct uart_port *port)
  */
 static int pnx8xxx_request_port(struct uart_port *port)
 {
-	struct pnx8xxx_port *sport =
-		container_of(port, struct pnx8xxx_port, port);
-	return request_mem_region(sport->port.mapbase, UART_PORT_SIZE,
+	return devm_request_mem_region(port->dev, port->mapbase, UART_PORT_SIZE,
 			"pnx8xxx-uart") != NULL ? 0 : -EBUSY;
 }
 
-- 
1.9.1

