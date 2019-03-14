Return-Path: <SRS0=OgF1=RR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3EA5C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 23:24:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27BD22184C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 23:24:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27BD22184C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metux.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44L4Xd4qlLzDq9B
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 10:24:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=metux.net
 (client-ip=217.72.192.74; helo=mout.kundenserver.de;
 envelope-from=info@metux.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=metux.net
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44L3Zj0mLCzDqBW
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2019 09:40:44 +1100 (AEDT)
Received: from orion.localdomain ([95.117.89.18]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MCsDe-1hDOdm1UB6-008uwe; Thu, 14 Mar 2019 23:34:50 +0100
From: "Enrico Weigelt, metux IT consult" <info@metux.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 19/45] drivers: tty: serial: sh-sci: use devm_* functions
Date: Thu, 14 Mar 2019 23:33:49 +0100
Message-Id: <1552602855-26086-20-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552602855-26086-1-git-send-email-info@metux.net>
References: <1552602855-26086-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:HBGeKvv+qEQbXti20pnx8D1tVmbz/ITGLOz+ix4DhYOtbK33vmW
 CqRzKVbI/QB4yWVcPfKCrF3m9cdKXwAZy+T/T/iH6WLxOYsrHpUCge07Ig3YQ4jBQwQfR5A
 BayTuIA0srciiGBNxM0Z9PHtR+w9JC/KSEY+REGx/xEWlNr7AHzMPRlkNx5UbMmMywR9HVK
 6Qei2aTMX/gvKEjJj66KA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5c0z1I256Xs=:mDW/F4m3xzU5ZXv2QE3ega
 QbjEnsn2vJ7baNu+hV6PkvgkafopAFSHDj+uv+kW7DHl7KZgR3Lwbo3EUl2OYWDKs/UI3TfsQ
 T2+E2wnzjcc2bdO6hnRYGjBNGXdYAKNzwp8SgPYQ51k/ZSRhkvEZ5W5HFjiOlTnEj1ZnArSZ2
 W6XjKzL0tuPZOmV8cRDaiSIXgXHhoh43f6qKG9g5yw64nuOZ92y4SaP8pjYc3MxzOclsuv1CB
 rUHTk9xaSLqvcIK7TCQWNeiNfCH3wAstpkpjYHDTQ46pCI9IzaLGe5E/+sTGFNT7J0AkLc9Ny
 o+IUbCDt1Kb4vFww2w791dpoJXgrN95QLxKHBpr8NXdhmzibLjM7nTdiu3SYrXonjGwOQCGpa
 kPgKLOhm+it19uin5bGoBPIiDiJwHcSyy8ur/K3/rzM2c9hDIHUyCNterkEunP7SxmAsjmsyV
 CbLVoQk4Z+IiSuCBNeHIp+Gqvx7HscshN5gqs2/e77QWx7P4guZwc5H+TetWJB83FXhnU8VfQ
 Wj1KCapRB3r5zwurmkdYSDrk8yFkeAqY0A5hL5dipr/jacJimcWbcXoxEf3e4+2wZrGk14esA
 8yZdMKP4/CX7yzNheVCrVw8ht17w8eYnr3QEjmlnHBMiW3ucmq7LsqQEZO8im8ndlrBJiNnmk
 ++LJ/weTcxVLBTP6Bz3tk4tTk8WD9oEWIxmAqq1VKtfmXQmpbWKzgFvqDq5KNT18pDP+gaqc0
 j6d/lU6akrGvjNOP0ERs1wFyhwo3H6MTJgjQPw==
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
 drivers/tty/serial/sh-sci.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 060fcd4..e40b0d0 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2667,7 +2667,9 @@ static int sci_remap_port(struct uart_port *port)
 		return 0;
 
 	if (port->dev->of_node || (port->flags & UPF_IOREMAP)) {
-		port->membase = ioremap_nocache(port->mapbase, sport->reg_size);
+		port->membase = devm_ioremap_nocache(port->dev,
+						     port->mapbase,
+						     sport->reg_size);
 		if (unlikely(!port->membase)) {
 			dev_err(port->dev, "can't remap port#%d\n", port->line);
 			return -ENXIO;
@@ -2689,11 +2691,11 @@ static void sci_release_port(struct uart_port *port)
 	struct sci_port *sport = to_sci_port(port);
 
 	if (port->dev->of_node || (port->flags & UPF_IOREMAP)) {
-		iounmap(port->membase);
+		devm_iounmap(port->dev, port->membase);
 		port->membase = NULL;
 	}
 
-	release_mem_region(port->mapbase, sport->reg_size);
+	devm_release_mem_region(port->dev, port->mapbase, sport->reg_size);
 }
 
 static int sci_request_port(struct uart_port *port)
@@ -2702,8 +2704,10 @@ static int sci_request_port(struct uart_port *port)
 	struct sci_port *sport = to_sci_port(port);
 	int ret;
 
-	res = request_mem_region(port->mapbase, sport->reg_size,
-				 dev_name(port->dev));
+	res = devm_request_mem_region(port->dev,
+				      port->mapbase,
+				      sport->reg_size,
+				      dev_name(port->dev));
 	if (unlikely(res == NULL)) {
 		dev_err(port->dev, "request_mem_region failed.");
 		return -EBUSY;
-- 
1.9.1

