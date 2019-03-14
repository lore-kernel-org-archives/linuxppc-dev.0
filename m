Return-Path: <SRS0=OgF1=RR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B014EC43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 22:59:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34FBE2186A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 22:59:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34FBE2186A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metux.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44L40P6jybzDqQN
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 09:59:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=metux.net
 (client-ip=217.72.192.74; helo=mout.kundenserver.de;
 envelope-from=info@metux.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=metux.net
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44L3SV5P5dzDqNw
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2019 09:35:22 +1100 (AEDT)
Received: from orion.localdomain ([95.117.89.18]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MN4qp-1hNSje1uh3-00Iz9V; Thu, 14 Mar 2019 23:34:59 +0100
From: "Enrico Weigelt, metux IT consult" <info@metux.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 29/45] drivers: tty: serial: serial_txx9: use devm_*
 functions
Date: Thu, 14 Mar 2019 23:33:59 +0100
Message-Id: <1552602855-26086-30-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552602855-26086-1-git-send-email-info@metux.net>
References: <1552602855-26086-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:VL1BlqoS/qDU3bzWyA7BH1huZou7/8Mut+MUsbHNTMpTAAEtqPZ
 ftPZ7q/mPL1um8eNPfkU2DKtwigb7nNh5lLepfXXALah59ePSLXqGeTBEJuefyxDPAbZzWK
 xVtVCn090VOIS5TmMjMsvsuBHLVBGgsLpxCMKeXKT/iGq7Dbvrce5nKFw6BT8dZc40w26Sb
 0wTGSKBtQIWVk8DhlfK8w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8xn0xJ7FwJo=:GcBJ94TBKRgKVgf4Gk7vZr
 QJc5XF5PP+G74Iue7vaxZ6xPSaosx53WBcV6ewSe5mDfpbyKeWDs1YlfOgYVKOhcmR7iJcMdn
 4CnPv15JJQRHIdsG3kua1O+7Lo/7zmp9jB0UH9BUjFDN6AD0Z1d0udOsTBtv/er3K4/GjjlVa
 eq5fF2joFgxOyRjq4IyUWe9ryixe+Jp86Jfie9e/0ACiOjHtSDKLAR6NfvLfoI6fV6mwtDJCA
 t3giM0SrrXoNGOccbTCxu5AO1T8ukamzGfD9sBCZfwSBcmX8b4aWdKlfB/CrbrBOvp0+gsI1B
 VPJmQdFvM9vg7TmqFh3KmNyRAxC4QS1E3B/CAwPpDXLpYBx0rBgeJt6EF1XwZJHpAXS/P7gso
 dvJt1006vYfvqvzi7cDuzpVRWqd6VZx9d8K5g+mKdI46k06utzgZGLZWobGr2ARuGeDnqJOXI
 R8gLgxhJokh//jSHTbY9VrqEzyQuFG5NklKhCn4EfvhV5FUCvcmovh9CpzHZab3+FaEQCJshZ
 YGYKwAbgo7ez+MxdU3w7ic/PhyfpRGqcT/IfRTFdtfdTiETL1EBAjccuHzksQ2nlC4ab9Xe5U
 3j/f9CxXTaSqyb3QefWGy+fikLwiVoJ0xEM6/b1tfp/9fvkq1YkR8Z6Q2Gyk/tfs+U5OMfV7x
 euGgz0BuluFGLZDqWNUmU/K14RC/5BGJLjujEEvsbSal34UiswA2ygLzEOtAfYmxf6JPUb1Ax
 pHe6FQQ0IvhD0bgmhCcTuO2L6ZDhaPTSGP9vAw==
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
 drivers/tty/serial/serial_txx9.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/serial_txx9.c b/drivers/tty/serial/serial_txx9.c
index 1b4008d..aa01349 100644
--- a/drivers/tty/serial/serial_txx9.c
+++ b/drivers/tty/serial/serial_txx9.c
@@ -757,15 +757,22 @@ static int serial_txx9_request_resource(struct uart_txx9_port *up)
 		if (!up->port.mapbase)
 			break;
 
-		if (!request_mem_region(up->port.mapbase, size, "serial_txx9")) {
+		if (!devm_request_mem_region(up->port.dev,
+					     up->port.mapbase,
+					     size,
+					     "serial_txx9")) {
 			ret = -EBUSY;
 			break;
 		}
 
 		if (up->port.flags & UPF_IOREMAP) {
-			up->port.membase = ioremap(up->port.mapbase, size);
+			up->port.membase = devm_ioremap(up->port.dev,
+							up->port.mapbase,
+							size);
 			if (!up->port.membase) {
-				release_mem_region(up->port.mapbase, size);
+				devm_release_mem_region(up->port.dev,
+							up->port.mapbase,
+							size);
 				ret = -ENOMEM;
 			}
 		}
@@ -789,11 +796,11 @@ static void serial_txx9_release_resource(struct uart_txx9_port *up)
 			break;
 
 		if (up->port.flags & UPF_IOREMAP) {
-			iounmap(up->port.membase);
+			devm_iounmap(up->port.dev, up->port.membase);
 			up->port.membase = NULL;
 		}
 
-		release_mem_region(up->port.mapbase, size);
+		devm_release_mem_region(up->port.dev, up->port.mapbase, size);
 		break;
 
 	case UPIO_PORT:
-- 
1.9.1

