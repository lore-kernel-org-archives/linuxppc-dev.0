Return-Path: <SRS0=OgF1=RR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5539C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 23:48:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41F6B217F5
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 23:48:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41F6B217F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metux.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44L54G5m9gzDqKK
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 10:47:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=metux.net
 (client-ip=217.72.192.75; helo=mout.kundenserver.de;
 envelope-from=info@metux.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=metux.net
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44L3b464fJzDqPM
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2019 09:41:04 +1100 (AEDT)
Received: from orion.localdomain ([95.117.89.18]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N6c0W-1gyKKL0286-018294; Thu, 14 Mar 2019 23:35:15 +0100
From: "Enrico Weigelt, metux IT consult" <info@metux.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 45/45] drivers: tty: serial: mux: use devm_* functions
Date: Thu, 14 Mar 2019 23:34:15 +0100
Message-Id: <1552602855-26086-46-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552602855-26086-1-git-send-email-info@metux.net>
References: <1552602855-26086-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:z+/rx4MhVeeVcG08TBj8jDGh8jFYW4zOBRqesRKWryiDcRo/5/R
 leJZXEwA5A8UHumYCGBKoEZd/n6lwwxGYVqhYppL++hnQWZn4i/9gvdyfWaGun1q+60/N+h
 4z5cuuKGwvNPqZvAl+9UM3D2gQWTn1V1WdXgynLWTTiAImQFWYw+bzULiWFqNFoMAcBU45M
 KH5Wa0+N6J6kBEfXsWzLQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:95HGvReJ3+E=:GP0eGFDhBOT1QANJWEzSqE
 AXq7yqS1M4rX7O6MOrZZ4Fz3MRUHR9yPFQyQeKg2dkHPQ0iWnNwJuYaCFUsWAiMIzkls7Kj8e
 KrxkXcVpinffvTdvy+OC4d7KcNQxcChE516uir2nyO35IhJzzfsCllyTRt3mKqRL8Q/peJNqU
 6iy3FLVraHqO/MaQOGbWWm1YdwF1EuaguBw1EYt85+R4sTppsDTaFzrlA4/8E92tiTq5nRl0H
 jWfhIW3H1281q1YGjVF47qk5+JESKzHf86k5VDX2zZDkwmEE5y/A+NP2EmZRweYYfw1YduoYg
 ln4++mv8m2CF95TVFZcbecrnjjVAhxKGXDxSR7Ofp1Rn7G4niBjLqFeMNf5zEe8pSIsXJQYe1
 d15HwsZMt+gTP05wovtspahwNKCX00xqW8pezQm7keMwRPe8pYBWEbvzVRVQCrAi/QUMP/JYq
 OGJwxH33bYNs2I0QbLQWh4SBSSTF1LeiqhZ/JIYPxHu5fnFFtr6PSl8o8fq54N200kRxRkRVo
 MJ6RyxF+5FONRRgY0S8yWA1EXGq8brfLmy7uUP2nwgvdZKOZQCgbusXB/VqPyUUARWbl0WApb
 wup4LabYbAMH13OnlrKpsdCyM+6gtPcPQ8o9QYkkCzpcJheoloAHj5uAwaR1+jVe4koW2CqkG
 TdrRkXBmkG06oQonrk2IQA9ZFa91sbuQ24ktoQMS3xhoW8MdfvW1v5eapwDghvF0cC4ruKR1y
 1gfPLDVqTW1pS5DUSEvWViVA/bwpGKIuz728Ng==
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
 drivers/tty/serial/mux.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/mux.c b/drivers/tty/serial/mux.c
index 00ce31e..cd08f0f 100644
--- a/drivers/tty/serial/mux.c
+++ b/drivers/tty/serial/mux.c
@@ -456,8 +456,9 @@ static int __init mux_probe(struct parisc_device *dev)
 	printk(KERN_INFO "Serial mux driver (%d ports) Revision: 0.6\n", port_count);
 
 	dev_set_drvdata(&dev->dev, (void *)(long)port_count);
-	request_mem_region(dev->hpa.start + MUX_OFFSET,
-                           port_count * MUX_LINE_OFFSET, "Mux");
+	devm_request_mem_region(&dev->dev,
+				dev->hpa.start + MUX_OFFSET,
+				port_count * MUX_LINE_OFFSET, "Mux");
 
 	if(!port_cnt) {
 		mux_driver.cons = MUX_CONSOLE;
@@ -474,7 +475,9 @@ static int __init mux_probe(struct parisc_device *dev)
 		port->iobase	= 0;
 		port->mapbase	= dev->hpa.start + MUX_OFFSET +
 						(i * MUX_LINE_OFFSET);
-		port->membase	= ioremap_nocache(port->mapbase, MUX_LINE_OFFSET);
+		port->membase	= devm_ioremap_nocache(port->dev,
+						       port->mapbase,
+						       MUX_LINE_OFFSET);
 		port->iotype	= UPIO_MEM;
 		port->type	= PORT_MUX;
 		port->irq	= 0;
@@ -517,10 +520,12 @@ static int __exit mux_remove(struct parisc_device *dev)
 
 		uart_remove_one_port(&mux_driver, port);
 		if(port->membase)
-			iounmap(port->membase);
+			devm_iounmap(port->dev, port->membase);
 	}
 
-	release_mem_region(dev->hpa.start + MUX_OFFSET, port_count * MUX_LINE_OFFSET);
+	devm_release_mem_region(&dev->dev,
+				dev->hpa.start + MUX_OFFSET,
+				port_count * MUX_LINE_OFFSET);
 	return 0;
 }
 
-- 
1.9.1

