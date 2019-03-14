Return-Path: <SRS0=OgF1=RR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE1DCC43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 22:52:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5441121873
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 22:52:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5441121873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metux.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44L3qx4WlQzDqBN
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 09:52:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=metux.net
 (client-ip=217.72.192.75; helo=mout.kundenserver.de;
 envelope-from=info@metux.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=metux.net
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44L3SS55nBzDqNw
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2019 09:35:18 +1100 (AEDT)
Received: from orion.localdomain ([95.117.89.18]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MaIGB-1hag9r3nNt-00WEgT; Thu, 14 Mar 2019 23:34:55 +0100
From: "Enrico Weigelt, metux IT consult" <info@metux.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 24/45] drivers: tty: serial: mxs-auart: use devm_* functions
Date: Thu, 14 Mar 2019 23:33:54 +0100
Message-Id: <1552602855-26086-25-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552602855-26086-1-git-send-email-info@metux.net>
References: <1552602855-26086-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:sNp1Qce0XntNsbBnqDM4gJRqPj6uIlFIDbUZe1jLkf+/kM8/21f
 WzEnXGc8JoJbgSe8sWpjp8NDZjTPuxNG6vn/VG5EizDswJf2ENXZq7umA5royMfFypO/UvJ
 1qLY1MejYnvoIPv3kCm0mIe4jtsjdXGYK9/Nuiuxb6tUSGYv6wF6rWvWkyq3z4GzHhyXVNe
 sKkMcScanxWbW/e+TSaIg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3qFuW7PZaCo=:MwO6I7oran78L4v9NEYa07
 xx0gtecVZBNTZiVRmZxCrhS9mqJH+lz3PHEKeRCdEjSgjCpNK8PcsbySheMZgTQh9/7PZbTC9
 ybjQO7piJLBELJ8kebJYlyYRTItdVnFwhTYUupzATRrDTXUxAgJexlsv8VOQ3RH238m1vrAA3
 RmogEUHPSFx8HupqeRqVGS474bFcZw7Nho+LncfXE2lctK4Ax8L+YaU/OOgKyFv0FTfXe0k2n
 hls45xdtv5o5d5k2sAHMDIb4LPBBuU/bsR4wt/23Z1uznLnybHHsAJGHW4RzAPKXtStwkbeCo
 fHDFxoIWjxZ4KHG+jQ9c6VCx06kEw6FLqCbKPv13gOCd5QdlqwdIpvq4XywJzvRRBeOvMzC8Q
 3hN7rMOzt7vNOLL0c8Bwp16MJ5jHt4RdZJBsKLdOD7gpvYAbKcdwmom7pEZctmpa1vjUEqToc
 ltSV51cSd5peYPLt55srprhygf0zhOMG9evTKdu030drW146CM/xa2M8+8kJqLmM/rcM3ckyJ
 G0WZLYY7iJgSnYRNa3Lr2U/EjUOB56Qu2JmDl8RC2rR2YQDRPTWB3SBY0BRnyPbAyxRI0nSQP
 aqzbPLh4/2Jko7BX8uU/CRgR3iX0TQCxgiZJBQ4M2D28hraT/XxVNMbIvfWQepl9JUPbFaZcG
 /Lk64JGqAz7aCXEHDt52uFZKEfHT5NDlFl0KhVoEw8Y+11lVPS042yy/NLEmFb0Qv89N+PFY8
 RaPUBIujzSjcWJ/0z7XzuCb86jEqKxewFfQ3LQ==
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
 drivers/tty/serial/mxs-auart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index 27235a5..0a43c69 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -1685,7 +1685,7 @@ static int mxs_auart_probe(struct platform_device *pdev)
 	}
 
 	s->port.mapbase = r->start;
-	s->port.membase = ioremap(r->start, resource_size(r));
+	s->port.membase = devm_ioremap_resource(s->port.dev, r);
 	s->port.ops = &mxs_auart_ops;
 	s->port.iotype = UPIO_MEM;
 	s->port.fifosize = MXS_AUART_FIFO_SIZE;
-- 
1.9.1

