Return-Path: <SRS0=OgF1=RR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2631DC43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 22:53:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5042121873
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 22:53:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5042121873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metux.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44L3sl3nyQzDqP7
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 09:53:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=metux.net
 (client-ip=217.72.192.75; helo=mout.kundenserver.de;
 envelope-from=info@metux.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=metux.net
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44L3SS55kzzDqNg
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2019 09:35:18 +1100 (AEDT)
Received: from orion.localdomain ([95.117.89.18]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MK3mS-1hKRez1baA-00LRrW; Thu, 14 Mar 2019 23:34:47 +0100
From: "Enrico Weigelt, metux IT consult" <info@metux.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 16/45] drivers: tty: serial: uartlite: use devm_* functions
Date: Thu, 14 Mar 2019 23:33:46 +0100
Message-Id: <1552602855-26086-17-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552602855-26086-1-git-send-email-info@metux.net>
References: <1552602855-26086-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:SlzeGhHlOuxFduqp5QuUml5rOBQzKNh69j7CDj7Ua0DFA/PwUiw
 1lhjZUG18/PBNkuKf+0Ltm8rhlvh77rYT5Hwow7OUXX/JTdcUgQZh/oKi5/EsA2RFNKzX47
 UrPJmeeH1jZk48JBFb1CyoHx7Cu4A3gTsWPn/T7TGVztCN2KHvV4sDeNv+Iiyeh4eQltg7e
 p9J66Ais57XCJGu26Su2g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:S3GpsMXKkd8=:18iZLGQUyS/zWRDlmeJy1l
 t+CUbbf7JicHBp9EJh5e/ge6UxEsJBFnHeFriW9pXaNeQk9y7UMIvZlK/WxDYPLxs7Z8T+vlp
 UJmdkA8z2wEl7aOWq+zC52paCNg9uiRwydirnMv4QxQusIR48nyZfe2UKcWpXn99jtVQzhnrL
 L1K5XO4WxYMCOqaOKL1EfQd69BCunSgT3DsGqP08X0lClf2fhdB1hGT5V49TBvrEAoQ+DhiA+
 zfBDR3I3PDq0b0W4oi11+SZDLA8mgnD9Q4jR3XV+Im04Qd7Px7N5jjW8FcrAxEtRlcsCkOSvw
 5Yjsl0RJVzmdLdA/y6beeeN8xoyff16M6UNDEp290o4TJ3bnAVT1FEO1HL2B994SNxfrQMPy1
 k7+6S0B78z+VQPRThV0hABwx0X0k+L/nuzYoHdhhgeKiSSC7FHfEeYM/bKd73mhuRoihT2tY/
 AWwRGa/UejhwRpXUqHqYN3paVYS2uwbHam7aqscs2rwfd+bygDQTQQQSGTjTCp0RaLcicv+TT
 rAxojJeLPEk8x4NoPz9BdjumexSv27cwtiqNWmDl/YkisO7gavxnakRMt45QBmlrNrUOsn2LF
 nfFQ9k+mabqGs9eC9OVGzFsu5mC7PLm+GpPCUvHAfcC2rNEcmZiKOaXP7aZPbnqkAo5t5zJmM
 ZcUXg0utXbXRUpOHU9d3axMc2LXLTx1zFWdmMkEsbSBQCeKSjKvIyttaet8ejhl1Hour8g5EC
 vKnDtaCzqmclKRrrQNiTCIpzP6RM2skLaFdHqQ==
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
 drivers/tty/serial/uartlite.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index aa461b8..f068d00 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -342,8 +342,8 @@ static const char *ulite_type(struct uart_port *port)
 
 static void ulite_release_port(struct uart_port *port)
 {
-	release_mem_region(port->mapbase, ULITE_REGION);
-	iounmap(port->membase);
+	devm_release_mem_region(port->dev, port->mapbase, ULITE_REGION);
+	devm_iounmap(port->dev, port->membase);
 	port->membase = NULL;
 }
 
@@ -355,15 +355,20 @@ static int ulite_request_port(struct uart_port *port)
 	dev_dbg(port->dev, "ulite console: port=%p; port->mapbase=%llx\n",
 		 port, (unsigned long long) port->mapbase);
 
-	if (!request_mem_region(port->mapbase, ULITE_REGION, "uartlite")) {
+	if (!devm_request_mem_region(port->dev,
+				     port->mapbase,
+				     ULITE_REGION,
+				     "uartlite")) {
 		dev_err(port->dev, "Memory region busy\n");
 		return -EBUSY;
 	}
 
-	port->membase = ioremap(port->mapbase, ULITE_REGION);
+	port->membase = devm_ioremap(port->dev, port->mapbase, ULITE_REGION);
 	if (!port->membase) {
 		dev_err(port->dev, "Unable to map registers\n");
-		release_mem_region(port->mapbase, ULITE_REGION);
+		devm_release_mem_region(port->dev,
+					port->mapbase,
+					ULITE_REGION);
 		return -EBUSY;
 	}
 
-- 
1.9.1

