Return-Path: <SRS0=OgF1=RR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA57C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 23:01:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE4F321874
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 23:01:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE4F321874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metux.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44L42J0hvjzDq6X
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 10:01:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=metux.net
 (client-ip=217.72.192.73; helo=mout.kundenserver.de;
 envelope-from=info@metux.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=metux.net
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44L3SW3WqmzDqNP
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2019 09:35:22 +1100 (AEDT)
Received: from orion.localdomain ([95.117.89.18]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MDPuq-1hDwLE2JGA-00AYq2; Thu, 14 Mar 2019 23:34:58 +0100
From: "Enrico Weigelt, metux IT consult" <info@metux.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 28/45] drivers: tty: serial: netx-serial: use devm_*
 functions
Date: Thu, 14 Mar 2019 23:33:58 +0100
Message-Id: <1552602855-26086-29-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552602855-26086-1-git-send-email-info@metux.net>
References: <1552602855-26086-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:S82o8HU0azrcFmsU0hMEHnzXNmoSRV38Q8v139dSDyjMCjNHRgG
 gpg1q0wC1fyBgLaNGyH3hpzthti4AQA35ByJC1bg2yUKfS5hxGWLbcYB/Q5/j7O7Tol+G4z
 iVnAFah9ndfwmZRK2Bn+pHwWFwkjbjukHr+DvquWYfqqxOVuQp2hQ3DcIHPNbiaD75nj1BO
 P9FAatFokQrA/3sPbgTag==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oJJnwzqad2E=:CoCCoGy8+8bRDWcEU5PXRj
 8RpKSJQ0nBsQqFPVecwJfdyIVGmUDKP9+XHriOKFqT4rta7/qmTIejzASlNtr1yuTCuDcF8VN
 nHQ7TqvpVffLKWnqbzrvtOuYSgwv8TweDQUtFP63/l6Qj/D3bSBLpzAeQJMYus8vF7O5wxfZF
 UeNISWB1JjgBkBp7OhD7nt3Qve69/ZV1spQC2wd+1p6s3NLHBI+ERNoOrdhKrv5IWK9AFjNsl
 h21CKn/NPdmQCB1uCggpwNaiwJKbVSC9cD/H2BvXGaCIEhQsC4BY80BppjXh6VUvGJi+uggdC
 M5V2rhZvZIZHE0Tcd52pNMTL5xMFBfpaU+ZPb5srDkecv3G/5M1+Qc9Hhrd3POanFtv7yY8R8
 3zm7BRuW2Sy0v1KE8TvQFfzvfr9XovYQugKIu6m+gmNr0ox1YE7SO2Ghbeuno11binj4ZN7YH
 gI5Zn4mIy44wH5l4OLuLARmUJ+yggPFA9SuHQJIgC0NFepCRAVhFCn+vm9fQPBKvH2FFGWqcE
 0NAjL20p56IMCxFG6bqnH4UFZWED4Fn1VeRTKjJGAolie0JErzDLMs+a6y5GFjTX9gHKAkcsE
 nba3BWZYwOcUQv8cQNKESliPsHQx8zdjEBMSO5i770u6FbGp1Z2Q9ZK2W4HK/XtSCsMQtqtp7
 gxUa/rJNgjs5tzyjvmHz8o6jqljaWDCxQb3l3MK20rxgWm+RLGplMhnjxBRw3WLKkn75iSF7N
 up7op/z6RgKIElnHRs8lgMO6siowH80C3MwW0A==
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
 drivers/tty/serial/netx-serial.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/netx-serial.c b/drivers/tty/serial/netx-serial.c
index b355686..a696d96 100644
--- a/drivers/tty/serial/netx-serial.c
+++ b/drivers/tty/serial/netx-serial.c
@@ -424,12 +424,13 @@ static const char *netx_type(struct uart_port *port)
 
 static void netx_release_port(struct uart_port *port)
 {
-	release_mem_region(port->mapbase, UART_PORT_SIZE);
+	devm_release_mem_region(port->dev, port->mapbase, UART_PORT_SIZE);
 }
 
 static int netx_request_port(struct uart_port *port)
 {
-	return request_mem_region(port->mapbase, UART_PORT_SIZE,
+	return devm_request_mem_region(port->dev,
+				       port->mapbase, UART_PORT_SIZE,
 			DRIVER_NAME) != NULL ? 0 : -EBUSY;
 }
 
-- 
1.9.1

