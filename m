Return-Path: <SRS0=OgF1=RR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22AF5C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 23:12:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A5E421874
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 23:12:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A5E421874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metux.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44L4Gv5wz2zDqQM
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 10:12:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=metux.net
 (client-ip=217.72.192.75; helo=mout.kundenserver.de;
 envelope-from=info@metux.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=metux.net
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44L3Ss02wtzDqNS
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2019 09:35:39 +1100 (AEDT)
Received: from orion.localdomain ([95.117.89.18]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MybX9-1gqJq61u05-00yvbl; Thu, 14 Mar 2019 23:35:03 +0100
From: "Enrico Weigelt, metux IT consult" <info@metux.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 33/45] drivers: tty: serial: sb1250-duart: use dev_err()
 instead of printk()
Date: Thu, 14 Mar 2019 23:34:03 +0100
Message-Id: <1552602855-26086-34-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552602855-26086-1-git-send-email-info@metux.net>
References: <1552602855-26086-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:mXqIaXu/DsCMYAftQQOsTksW196HtfI2cGBEAdlsI7IaVaRzetQ
 hQ9E6yXhs8QO0celBJI9MkXkb9xa9UZ5NVEfVYG0q6Ylu4o5S+dTfLuWhdWJYvG45z/YN+H
 BLHC6mysacRdZZo/HKhZBzq3N18KWoD4v7i8KJ9ddSJO+0V1mnx9vGoMmA/fio59soYXwlj
 2iPg9YGI7E8HJelxcgQfw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vH37rNIdhrg=:9t0UMKNOshW3jKdl00zRP1
 K01TXJoRjyLHcC6zzSlIohpRDmwb6YDpRc1olNvhl8AJcgxmQiNV47g8mvaA9drp98mJZJLTB
 dg+E4LXdTJ+ytkEIznH5f/SF0VdvhejTDv94i0715GcNwOTapywNxF8U7LTi3nW2Pu6keg4iM
 rjO8tGsp576ZwhFUaJI3NfSeFTzBKMDyFVXzlNsJ8htOTS9SNIyzgNeIqPXmxc/FB2isr1Kfb
 LR82JGnsmEqanmMaguxzT0hap+jIOyvKoGTMk0MvsQVuyYAZoy7Vfcst7Ca1WVmLa/44OTIXa
 tIbi+NuBQomBxJ0/kldrdybOIMnQcIshH+Rd0jiuJB3ureSugPA5Co2jbmZgvoyeaqKcwPujX
 Slh1ROMJx1bzExGlLx7S+aqLAcd9uPGBeMtQjxTV4E6UxMH45w/MbEvUqzVu4oX1P5rCY8dmY
 oSkKijHl77DkwF//IsujcFRnbzh2usBh9fFs7fMddNsJ+Sq9ByAaHqsvzJrQB1KsQhoLvvmw7
 tVgt5NxBdKEgFmmR2eO4R8Ly5/pn+Hv0zcrH05Dk1VNufXfeBfCRiyW4uU8xWNdNbXGBTT4Vg
 DIL5xSEPdU+1BBZaGMHasRFDM877DnvttgO6yHXIcYTu4RlDJQZI4SJ3rcVqALNrZl0e4nMTV
 wFMT4odT3YgVgLidU+zlysssHst81QN0qABsTJDgt5g7EaSvrpyOhGNeghYLao2O77oDqYDKN
 Br09yrGLW5Ns9ljIsJzZjwIMGk/o1qdTcTi63Q==
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
 drivers/tty/serial/sb1250-duart.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/sb1250-duart.c b/drivers/tty/serial/sb1250-duart.c
index 329aced..655961c 100644
--- a/drivers/tty/serial/sb1250-duart.c
+++ b/drivers/tty/serial/sb1250-duart.c
@@ -663,7 +663,6 @@ static void sbd_release_port(struct uart_port *uport)
 
 static int sbd_map_port(struct uart_port *uport)
 {
-	const char *err = KERN_ERR "sbd: Cannot map MMIO\n";
 	struct sbd_port *sport = to_sport(uport);
 	struct sbd_duart *duart = sport->duart;
 
@@ -671,7 +670,7 @@ static int sbd_map_port(struct uart_port *uport)
 		uport->membase = ioremap_nocache(uport->mapbase,
 						 DUART_CHANREG_SPACING);
 	if (!uport->membase) {
-		printk(err);
+		dev_err(uport->dev, "Cannot map MMIO (base)\n");
 		return -ENOMEM;
 	}
 
@@ -679,7 +678,7 @@ static int sbd_map_port(struct uart_port *uport)
 		sport->memctrl = ioremap_nocache(duart->mapctrl,
 						 DUART_CHANREG_SPACING);
 	if (!sport->memctrl) {
-		printk(err);
+		dev_err(uport->dev, "Cannot map MMIO (ctrl)\n");
 		iounmap(uport->membase);
 		uport->membase = NULL;
 		return -ENOMEM;
-- 
1.9.1

