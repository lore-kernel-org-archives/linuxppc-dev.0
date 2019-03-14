Return-Path: <SRS0=OgF1=RR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F996C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 23:46:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09578217F5
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 23:46:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09578217F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metux.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44L52V6rT4zDqRG
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 10:46:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=metux.net
 (client-ip=212.227.17.10; helo=mout.kundenserver.de;
 envelope-from=info@metux.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=metux.net
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44L3b42GPHzDq6Q
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2019 09:41:03 +1100 (AEDT)
Received: from orion.localdomain ([95.117.89.18]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MnZwp-1gfQnb1weL-00jcjx; Thu, 14 Mar 2019 23:34:46 +0100
From: "Enrico Weigelt, metux IT consult" <info@metux.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 15/45] drivers: tty: serial: uartlite: use dev_err()
 instead of printk()
Date: Thu, 14 Mar 2019 23:33:45 +0100
Message-Id: <1552602855-26086-16-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552602855-26086-1-git-send-email-info@metux.net>
References: <1552602855-26086-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:RSoecuiUMCZFKu5zI3Fmkey2Q65perOqK2cY4diVUxs0pMNgGPN
 PalJtmCPaFOSbfC4yBadqBKEZNlvOncF3ajHkufnu5rz1QboqDrdwUmUfiRhC+TgF+g0cbS
 JAE7DLET49TPjeUt1osFGFk20Kwdvucf6IpD2gjUvnVwceSTJfeslXtvexXj65EC854gWo3
 6okcQAIGUF2YtkvTtnAyg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vlntiE2atIk=:rKMaB4UMWpLzyLhZNiMLj6
 q7P/j079LfD8VzboKdVZUiU4cuREr3t3nE1mrnm4D2anojUGIItO3Ht+/4F0oj3fsjq6s/Yhc
 MleSl6ycNEt3Yyl/hKTvV0owAkwijg7aMA61bURW/9uNgatF2I/S3JSR6rm3/AGzlV5i+Otl8
 Cu5t/Z91cdZ5FcoNmfG7lADZnDB7C3K5LcVc6ttcDxAg+jq+01OUeT91FjPkoEkqWIXfRt2y2
 TnF+hTFN+t8I+orm0wLqfJ89H9XH6I46Z8TeqMZOH5txQYzB8d2lLltHJ6qhBOKzM/wb1ZMe2
 nWaXJ7QgQwHTsmohv73VXHe5BApL6MHwPi749/JLWj+3NGWjVVTNgOwhAyBOfovmE5ihWSyiZ
 PNloJkVy1LCNR1Z9UQwQXBcLdDiR2W0FxWq0GqYcoOAS2XWkKHlbJJisJI6k6Op2qLkWzEXS4
 bWHaIrWunszjX+KVjlefx2Kwwe74KI4vWSK9BojPHkpfMpQYmBOa7DqK4VbPE0+kvkQxAR6uq
 OSrOFwi+i0p+u3xBU7mTPOOZte0aU6uKgvw9olMCHRlfP6LjPSCuoSQj/VleAnXDuisgX3t81
 ufCB51yVI5BzQ3TkkcrytBYPEuygtpepBCsHP0xz7bK54j1mMYLWlL1Rd6kXYUGnMqQSbSZ5/
 to+ZMxxDvNZu5oQEqmQzDbv6kAF+qT2M4AbrXCkNgTM7Qt86UAgANWkFeGA8ER0Y0ui3Xng9U
 qbgcKCjtkwODkv8TrgZGBTmjo0HLDLr8IxuWOQ==
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
 drivers/tty/serial/uartlite.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index b8b912b..aa461b8 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -352,7 +352,7 @@ static int ulite_request_port(struct uart_port *port)
 	struct uartlite_data *pdata = port->private_data;
 	int ret;
 
-	pr_debug("ulite console: port=%p; port->mapbase=%llx\n",
+	dev_dbg(port->dev, "ulite console: port=%p; port->mapbase=%llx\n",
 		 port, (unsigned long long) port->mapbase);
 
 	if (!request_mem_region(port->mapbase, ULITE_REGION, "uartlite")) {
@@ -519,7 +519,7 @@ static int ulite_console_setup(struct console *co, char *options)
 
 	/* Has the device been initialized yet? */
 	if (!port->mapbase) {
-		pr_debug("console on ttyUL%i not present\n", co->index);
+		dev_dbg(port->dev, "console on ttyUL%i not present\n", co->index);
 		return -ENODEV;
 	}
 
-- 
1.9.1

