Return-Path: <SRS0=OgF1=RR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5382CC43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 22:50:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC0B620854
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 22:50:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC0B620854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metux.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44L3pG0qT5zDq75
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 09:50:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=metux.net
 (client-ip=217.72.192.74; helo=mout.kundenserver.de;
 envelope-from=info@metux.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=metux.net
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44L3SQ3RLQzDqNw
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2019 09:35:18 +1100 (AEDT)
Received: from orion.localdomain ([95.117.89.18]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N5n3t-1gxVOA2LVr-017DKh; Thu, 14 Mar 2019 23:34:45 +0100
From: "Enrico Weigelt, metux IT consult" <info@metux.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 14/45] drivers: tty: serial: vr41xx_siu: use devm_*
 functions
Date: Thu, 14 Mar 2019 23:33:44 +0100
Message-Id: <1552602855-26086-15-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552602855-26086-1-git-send-email-info@metux.net>
References: <1552602855-26086-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:dNA35lHBD6TS3o/t+wft9eaQSmB463i8UvNUaBDiNuLH2i66kgs
 4gCaYE7EyTA9YiatBNZkQ6kWIa1+RYBD83/FCTzoO4b8PSi3JcCyqdRw67M9BUNaDNItZiu
 wh3vVqwvC3ROZwQud1FgjkMm9saadhojIjDQHhzqLLXQu1hTmQtvoDnjJvb1aQRPIHuWZRc
 RDhlsC/yf4El07DyDmqRA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:b3Z4UF+GiOs=:jnsNoKlxQ5rKQx9c5HGwK+
 ZE10wODdx7vmZdz9/W/CtQh0Hn/RdFdKdTU0VVy+Wj5V0+JERASj41YD0YevaiLUrdui8pLJk
 L2NNbQOkRB1PQ/Wpvr2oYwl5RZYrb5JPav152ml1cR0T7fIwcGAE33bqDuH02Sp/y0dya798x
 KqaR4VhXyd+tKMyRgNxG8s1oC6JVwxiNTYkd+QA+VErcoPdVcWAbDixeAk69Z6jAccTe+I7aU
 rwJlPAjaBYWKWWR9R7ppFbNmQRZCUk8+ZtIBtkPB5Jjdcw34JTz8Q3ykCMd9VYotY6jTtcStG
 QSuVtk15CZcFK3EtQ+CuS0taog3Zguoe4YzwQKGhHc3ZAa+EK696pFF89jk4M9kaWcytStJMl
 f9KEEFk1/eXss4o79s5BVRchQsFsIlK8Fzjkxyf/YpJ2XKsw3ziMwnsHLgbhbG/VeSrCM3LBB
 x4qtpaQz1CxFTIQLapD6ZapiJIylkfFo4VeT+o4w8v4ayrPmquWSCyNF4fL6CNlbajNSxMtvy
 IaYva2RlkwjUOOadPkLtj5RKK1ng9PPeA18kz32U9OkF1J9WfN/02I9+u2aKmgSnTdCqHUloI
 gtcV3pVY5sBy/5yG+ZvAhNsH+8qUa0t2F5dNhaKFVAybZfJ5NEpJMUBjrx8/u8tbmH7D5lVZQ
 DCUYqRatVclda/LSjmPIzLMvxrN9rsOga05TOXEfWptyOchs2ZHPnEpzVbOahjiITZ4XqRKXz
 d0pudl4tUySrp6FowgcFeGmY/p0HAV0Z0DOlfQ==
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
 drivers/tty/serial/vr41xx_siu.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/vr41xx_siu.c b/drivers/tty/serial/vr41xx_siu.c
index 6d106e3..3f69603 100644
--- a/drivers/tty/serial/vr41xx_siu.c
+++ b/drivers/tty/serial/vr41xx_siu.c
@@ -617,12 +617,12 @@ static void siu_release_port(struct uart_port *port)
 	unsigned long size;
 
 	if (port->flags	& UPF_IOREMAP) {
-		iounmap(port->membase);
+		devm_iounmap(port->dev, port->membase);
 		port->membase = NULL;
 	}
 
 	size = siu_port_size(port);
-	release_mem_region(port->mapbase, size);
+	devm_release_mem_region(port->dev, port->mapbase, size);
 }
 
 static int siu_request_port(struct uart_port *port)
@@ -631,12 +631,15 @@ static int siu_request_port(struct uart_port *port)
 	struct resource *res;
 
 	size = siu_port_size(port);
-	res = request_mem_region(port->mapbase, size, siu_type_name(port));
+	res = devm_request_mem_region(port->dev,
+				      port->mapbase,
+				      size,
+				      siu_type_name(port));
 	if (res == NULL)
 		return -EBUSY;
 
 	if (port->flags & UPF_IOREMAP) {
-		port->membase = ioremap(port->mapbase, size);
+		port->membase = devm_ioremap(port->dev, port->mapbase, size);
 		if (port->membase == NULL) {
 			release_resource(res);
 			return -ENOMEM;
-- 
1.9.1

