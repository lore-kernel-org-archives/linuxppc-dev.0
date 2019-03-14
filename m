Return-Path: <SRS0=OgF1=RR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A69B0C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 23:31:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DA9D2070D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 23:31:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DA9D2070D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metux.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44L4jc5tvWzDqQr
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 10:31:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=metux.net
 (client-ip=217.72.192.74; helo=mout.kundenserver.de;
 envelope-from=info@metux.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=metux.net
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44L3Zq3rP9zDq6Q
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2019 09:40:51 +1100 (AEDT)
Received: from orion.localdomain ([95.117.89.18]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Mdv2u-1gVlt40Nfy-00b3ty; Thu, 14 Mar 2019 23:35:08 +0100
From: "Enrico Weigelt, metux IT consult" <info@metux.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 38/45] drivers: tty: serial: samsung: use devm_* functions
Date: Thu, 14 Mar 2019 23:34:08 +0100
Message-Id: <1552602855-26086-39-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552602855-26086-1-git-send-email-info@metux.net>
References: <1552602855-26086-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:6UXVHHSN/pSBbNy6AuA8qQkx6AtLHwlQl48BR55G72r4iZNdygr
 41CzcU0EUEiy9E8U/gKNs9RKX+r0+HDvVNw9phNXgBrTiysdxISUDMeZYutFSVuwHc+siq8
 KCu3fiiqgRtnherFTgfS+lKex81+mnGAWOWPNUrRrnz7bpSbnDHsTqH7IVgMQKsxi699gu7
 Tg3YiWSOGXDVfYsd8iUeQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ObE/PlRuh3I=:wFS1yVyKx0TlD+6WLLWZ81
 3Nn8hHtNUfTYXf0mTFUoJYsEb7YR5dQ+XvdJAJ/XV2autBy3Vi9XDFTvc/tRvzeShdppVzk/0
 8Datf16Iig9pA9WQCsZnPi7xF7G/v2ykPHiij83szmsL6yZW/r0gnttvTGEzmsy5Gd9LpzhwA
 hVX+OEqRfBvnS/I8/Fy+e/qipyOrJnarpnv7aryJlZdrMPRYxXi7V6pnzXfgFZEMs2OJ6AskI
 AKicdal+VljhO51nOEhC+2RyNz108jdNROlZdQbGCQfTQoV17cVWHQtbE7S0CUWmpOGm6wJau
 NRN0ww2aj7pNfa6mKxwS3OjB3OUxkzmgImiw4kHiIH5wtRPEWnuzXL/PsRINJfBbJZkGyN8ei
 tMS2RN2oBpN6HozAtlNNTbufvF6Y17KfRvlUQNqMC4DQwCl0zzPnjN22N+V31IUTD3vY5GF7r
 BCY/9jCCjrqUqEfGtvIOiYZdePZgd3DR4TwrF9RRIwhXMQ24jJ/o2Z8omiTHZg0Cfrer9J2sW
 sypTuPQTfnMP33k3nW3M3WGe4f26FfMan/XmbRhf/JPvYCvZtUSQrG5tyiKQ2SSMXQL4kkyuD
 5DJsqBGdc212FO9wIDG+jibFNUCK5SQUR8VL/QHikQuFUVd1YDHi4ijuXBDRXx4iTHjmmR+P4
 +kvzvy0ydadjDnH/4x1yHX1SFCMaAGLyj8rBKMIjCC1IUZOvQo0tTU8z1USdiq7DQI2hWiFY8
 xmqds6v+UuQTqFuWBs2FCZVA4AQ+ZN4//FeO9S7m/u2/FNzNV9wv+RtG9z7PSQKza1eeaXmS7
 n/0HYRSYpvnp5edVbZt+eEew08EGgx2PajIAx+7rCQINvlMuH/hKzx7KrfE2wdIfDCjqnAGzU
 fsA4tpib64Ld9Riml2ND2Li5dXeNK0aPp1G71VlxpjzAhrG9ITaPFMwvl2fjIJP5HbV0Yz7KF
 /rF6s9IbFmw==
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
 drivers/tty/serial/samsung.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index a49cf15..e0bab87 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -1436,13 +1436,16 @@ static const char *s3c24xx_serial_type(struct uart_port *port)
 
 static void s3c24xx_serial_release_port(struct uart_port *port)
 {
-	release_mem_region(port->mapbase, MAP_SIZE);
+	devm_release_mem_region(port->dev, port->mapbase, MAP_SIZE);
 }
 
 static int s3c24xx_serial_request_port(struct uart_port *port)
 {
 	const char *name = s3c24xx_serial_portname(port);
-	return request_mem_region(port->mapbase, MAP_SIZE, name) ? 0 : -EBUSY;
+	return devm_request_mem_region(port->dev,
+				       port->mapbase,
+				       MAP_SIZE,
+				       name) ? 0 : -EBUSY;
 }
 
 static void s3c24xx_serial_config_port(struct uart_port *port, int flags)
-- 
1.9.1

