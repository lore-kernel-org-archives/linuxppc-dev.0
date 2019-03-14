Return-Path: <SRS0=OgF1=RR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D608AC43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 22:58:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54E4D2186A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 22:58:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54E4D2186A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metux.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44L3yn2w7WzDqQK
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 09:58:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=metux.net
 (client-ip=217.72.192.75; helo=mout.kundenserver.de;
 envelope-from=info@metux.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=metux.net
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44L3ST4JJ5zDqNb
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2019 09:35:19 +1100 (AEDT)
Received: from orion.localdomain ([95.117.89.18]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MnZwp-1gfQqZ046X-00jcjx; Thu, 14 Mar 2019 23:34:38 +0100
From: "Enrico Weigelt, metux IT consult" <info@metux.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/45] drivers: tty: serial: samsung: use
 devm_ioremap_resource()
Date: Thu, 14 Mar 2019 23:33:36 +0100
Message-Id: <1552602855-26086-7-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552602855-26086-1-git-send-email-info@metux.net>
References: <1552602855-26086-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:biPYKTkboYb/1OcCYoABqLwj1O505ksU/PyTR3LJ7Da35VWUqJk
 KaLZ2YHPrK+MwI0vSMJbRK2E3/v/XiYFWvv74iQVL1ADferdn+dvJmjrKVVTOtQGW9LHINY
 pYkp6FZIW2ft1INaMVS460EQaeKy7jQqTy12j0ZJ0Qb+sLxC5h+erEeWrmtopbd4om5ulZ5
 /5eWv8ekIAvi+Ut3e1bvQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QkSB6AzkaFA=:/04NccFh0LgsEP9J2BJ72q
 B1eFmVEwPpMjYm749dnhjlR1rmq+dnbhS6j1MXeV82rBiAi26ThL9pAAc7klQcrBlTg+hkxu8
 h1rJLzQ/4yonbiJVN6eV4GUs3aA1WldGeFNX3MyrNaGjcDvKrgDaf92xZ3GjkVlxMznHPwgBu
 gorsROrsJc3QPP05pvlrxMcoB8Odwxr/OOInZYZ1C8+7iJGYltXL+homHLriVX2jA4ZRjrwbO
 iz5G+tXjg0v4D3B/kBij3/OsX4pNtdNL2e0s9P+at5Tm1wAQFNb+/c0POxcgyoplqD2JoeoMs
 pUu27HM70pR+0N6EtOCi0mQOFd2p3OkgwemsL69XOYPm/La/tKOs1xZKj1G4dpxC0IQHXuFR9
 bEV6dEwTq5AgGjNTs4l+xEl3Wsp4guxJObrvwleGgxuo9fBmOykncZQxvcZwazG7u9EVYIZAN
 ZmSt4oaQYJaHNFvKNAjUfcz0OwDd9BSt7BAEmhy006a9MCW7ol88W+fQ9eqj0Bspk8Ap/2zHt
 oWG0svr6rviYWfub8FWEsOoQfavzOW8eEzn8Kg71fNi8NLLmJDHbocxubhmKWsODbTO3Ns9PU
 twaMKF7mHGFdqfjwXzeDqMUPwvvjX/tAWETSvK9Uyly9LwBTcWZDnARxTOHT6WdMHl55Dr8lK
 2X3WCBPEkivrB4HiM9zjH19trWcXVULV7kI3OG/2ZThodsdZk/jgKz8GwO1He91bKQOtyQJwo
 D01Eu3eXeIA/cG/JFR2C/6WCsl7Bv0pmQa7DCA==
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

Instead of fetching out data from a struct resource for passing
it to devm_ioremap(), directly use devm_ioremap_resource()

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/tty/serial/samsung.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index 83fd516..a49cf15 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -1775,7 +1775,7 @@ static int s3c24xx_serial_init_port(struct s3c24xx_uart_port *ourport,
 
 	dbg("resource %pR)\n", res);
 
-	port->membase = devm_ioremap(port->dev, res->start, resource_size(res));
+	port->membase = devm_ioremap_resource(port->dev, res);
 	if (!port->membase) {
 		dev_err(port->dev, "failed to remap controller address\n");
 		return -EBUSY;
-- 
1.9.1

