Return-Path: <SRS0=OgF1=RR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1618EC43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 23:28:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 861EA21873
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 23:28:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 861EA21873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metux.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44L4f34W5pzDqK3
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 10:28:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=metux.net
 (client-ip=212.227.17.10; helo=mout.kundenserver.de;
 envelope-from=info@metux.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=metux.net
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44L3Zl2MVlzDqD2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2019 09:40:46 +1100 (AEDT)
Received: from orion.localdomain ([95.117.89.18]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M8hEd-1h9DdJ2voX-004mDV; Thu, 14 Mar 2019 23:34:56 +0100
From: "Enrico Weigelt, metux IT consult" <info@metux.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 26/45] drivers: tty: serial: dz: use dev_err() instead of
 printk()
Date: Thu, 14 Mar 2019 23:33:56 +0100
Message-Id: <1552602855-26086-27-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552602855-26086-1-git-send-email-info@metux.net>
References: <1552602855-26086-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:t0vfwJPx9NfL4tq35ATbtyhLGWVbWI4RcxTsENYe1aYWbwSsoQZ
 1Z5+0lsUwBrQI7AvTa0DeKSahSaDtX9EbAWLqXqLNZMfq07W52PHspP/T3ruOaZhqKhbg36
 SyPtbHYVTyLU4wK5aeHInuw34Vnn/lEwuANVrVxVGZ8fog4g2BnfXSESTzTIdRpQTGieYG4
 7gKVMzlBXkmqTuf2x4gDw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zsv3d5hXaoQ=:4WTAOT0nLxFUAsZDcalQQx
 2P7kBJS6IoPhUgGuQcPaZeTbzvNCK+spQhtpDtfqmOL5ph3W06/QNhH7lHmJU+rPWPOT8RB+h
 wRUnirGBU3hMtI9YfCjj/oflA+A8p4JgdC8yYV+ROrXNOPXKYQQC3Zclokc4j28Hi0GE8KDFa
 4/OTdGw1NthO4l/nGEQRdzqNH6uowitJkzkC6+/o7e0S7y2ZYj3jZEsK8FSgrcGYKEmDu/dxX
 utEzQJ3LNO5I2wtla4ONpmTyLQBDTX2SDBn6a2RcQHgjMTdgK0vPy2HnENk374NVXEZSZpSi3
 cVWsiou46wjcZVo4pRzg3XX64k39vDVp1pC+UT8DvlELiwSJEidVv1nIbLiuKgPsZJckxg3+x
 BEpiJKFCt5AipAqB876lPPlyMpCN9jqY/NosgUxJuJ9Oav3GHPccU53S7C2pWG1JA1OuH99ZQ
 KAn1hULLfSHabpc7swmy8y87g0LhfNFHAeStHXzl78opDUvbTZ2qNJAQFz8E1cyM8+RiUdLwJ
 k8wBErRydPGc3hfIvvd3L3ebRupOIdd2Pw/efp8eVMaLvX01UhmItzTs5n9q047AME0fyKY6X
 PssdlYylqBdCDlfxhfQzeMWZ18pgmMB/nj+Q3tNZIbMuFbd4C6SOvrAVd44/djUL849wpjKoM
 gOUVxZd2JlykgTlxyAqUl3VQ0hDytb2KPXeaJX54XMP6s5yPlL+qcyr3O6HUP+aDgWlZr96Ce
 giTNlHBtVCgECtBTTTgMA2gzcq3JhKe21PdAhA==
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

Using dev_err() instead of printk() for more consistent output.
(prints device name, etc).

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/tty/serial/dz.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/dz.c b/drivers/tty/serial/dz.c
index 7b57e84..96e35af 100644
--- a/drivers/tty/serial/dz.c
+++ b/drivers/tty/serial/dz.c
@@ -416,7 +416,7 @@ static int dz_startup(struct uart_port *uport)
 			  IRQF_SHARED, "dz", mux);
 	if (ret) {
 		atomic_add(-1, &mux->irq_guard);
-		printk(KERN_ERR "dz: Cannot get IRQ %d!\n", dport->port.irq);
+		dev_err(uport->dev, "Cannot get IRQ %d!\n", dport->port.irq);
 		return ret;
 	}
 
@@ -680,7 +680,7 @@ static int dz_map_port(struct uart_port *uport)
 		uport->membase = ioremap_nocache(uport->mapbase,
 						 dec_kn_slot_size);
 	if (!uport->membase) {
-		printk(KERN_ERR "dz: Cannot map MMIO\n");
+		dev_err(uport->dev, "Cannot map MMIO\n");
 		return -ENOMEM;
 	}
 	return 0;
@@ -697,8 +697,8 @@ static int dz_request_port(struct uart_port *uport)
 		if (!request_mem_region(uport->mapbase, dec_kn_slot_size,
 					"dz")) {
 			atomic_add(-1, &mux->map_guard);
-			printk(KERN_ERR
-			       "dz: Unable to reserve MMIO resource\n");
+			dev_err(uport->dev,
+				"Unable to reserve MMIO resource\n");
 			return -EBUSY;
 		}
 	}
-- 
1.9.1

