Return-Path: <SRS0=OgF1=RR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0098CC43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 23:16:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7299D2184C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 23:16:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7299D2184C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metux.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44L4ML69RbzDqQH
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 10:15:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=metux.net
 (client-ip=217.72.192.75; helo=mout.kundenserver.de;
 envelope-from=info@metux.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=metux.net
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44L3ZT57MVzDqPN
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2019 09:40:33 +1100 (AEDT)
Received: from orion.localdomain ([95.117.89.18]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M9Evp-1h9lKv3Uud-006Q6t; Thu, 14 Mar 2019 23:34:43 +0100
From: "Enrico Weigelt, metux IT consult" <info@metux.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/45] drivers: tty: serial: zs: use dev_err() instead of
 printk()
Date: Thu, 14 Mar 2019 23:33:41 +0100
Message-Id: <1552602855-26086-12-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552602855-26086-1-git-send-email-info@metux.net>
References: <1552602855-26086-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:t3jMVA/czvP0HqlL70xGOt9Crf6Cr1wu2VJnPUa/CNRwWkENiMe
 NAdqimtATnaJ7UYdV4CPycW/xq0AfdDdp+tJQUFIoVnClKiKkap/7gkwtj4A4l77/mo7614
 q4VA9pCQoARA6IBspFcQfEgNNfwAkkuz2i9wTu/BlD/coo08FiAmqbScFdKyg5OszRZNLU7
 q6mKJfwz2h2JqiR2U2P8w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hNKFaPjWygo=:PH0HBprblAkSoE1kDsjFsY
 Q5I5xKQRYrImF9JfcBAMM0DwsK/7oOUJuVSAZqNky0gFxwbxQ9pyFsgocvh+rOA2ye+Szjd6z
 9ZUDBRKd2s7CDLq5rDewcqUbycgBbCdf2BR94XkHudoxpk5Fb4rrXFbabDmkfbkVfQo+QSMBB
 HvVIdxsa5kIu/osm2GAcO5aqnLkLpitqI4KIvhE1EGeBu1MoxkAsHlOFSAbpOdqEmX2Zl0sa5
 4EF5scSHqSGq+g7CMV8EEuUylOHepmnqjYu5Jqe/Vq17BttPH/dPdqcjR8okPw7fiXuvJvMHr
 rm6kBre3mMrlaxkbhs9phE1s08+MTkSSegD0uYZBrUq/SglPHN5rV9qzBqrvcbuxC3u5z9vSm
 jKzeLhVtA3cgvkGJsx9Q6yV+ZniptF6NUpHVs45KhhJId+Y3T+KQ8zBpdDybHuFAnOvRwht7b
 WXEbezwK7iKguSrX1KN/I14fd36IPt+XwnRVSS2rlwEK2O3XbIzHfiMiCaWKykPYNobtrs2bK
 T2kQ/XqreDKwp95va2o+/HoSgfEAV3jZ2vHB07xPKB96QG/4rYKzK0RAA8OEtnJ16vvA8qX3l
 oARiUp9TnqgaMdMNieFVcOH6jGhlXJd9TWrA9MzEDCjeVviHH6kqda9K1/8/31uC4O8PxIexj
 E1/bT4VlCkZBux9yJFjzZzh2STnlhL3s1YzoJ3vv/Y6p8ZLQDXqZYbE41jCU46LNNHmvWhgev
 yWjWo4MQ5wFZRVYs63TsBW2YSaD6ytFa24pyYQ==
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
 drivers/tty/serial/zs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/zs.c b/drivers/tty/serial/zs.c
index 0b1ec2f..c3e23d4 100644
--- a/drivers/tty/serial/zs.c
+++ b/drivers/tty/serial/zs.c
@@ -767,7 +767,7 @@ static int zs_startup(struct uart_port *uport)
 				  IRQF_SHARED, "scc", scc);
 		if (ret) {
 			atomic_add(-1, &scc->irq_guard);
-			printk(KERN_ERR "zs: can't get irq %d\n",
+			dev_err(uport->dev, "zs: can't get irq %d\n",
 			       zport->port.irq);
 			return ret;
 		}
@@ -996,7 +996,7 @@ static int zs_map_port(struct uart_port *uport)
 						      uport->mapbase,
 						      ZS_CHAN_IO_SIZE);
 	if (!uport->membase) {
-		printk(KERN_ERR "zs: Cannot map MMIO\n");
+		dev_err(port->dev, "zs: Cannot map MMIO\n");
 		return -ENOMEM;
 	}
 	return 0;
@@ -1008,7 +1008,7 @@ static int zs_request_port(struct uart_port *uport)
 
 	if (!devm_request_mem_region(uport->mapbase,
 				     ZS_CHAN_IO_SIZE, "scc")) {
-		printk(KERN_ERR "zs: Unable to reserve MMIO resource\n");
+		dev_err(uport->dev, "zs: Unable to reserve MMIO resource\n");
 		return -EBUSY;
 	}
 	ret = zs_map_port(uport);
-- 
1.9.1

