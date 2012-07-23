Return-Path: <ukl@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 3A8E62C0486
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jul 2012 19:14:30 +1000 (EST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Grant Likely <grant.likely@secretlab.ca>, Arnd Bergmann <arnd@arndb.de>,
 Rob Herring <rob.herring@calxeda.com>, Ben Dooks <ben-linux@fluff.org>,
 Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH 10/25] i2c/mpc: add a const qualifier
Date: Mon, 23 Jul 2012 11:13:15 +0200
Message-Id: <1343034810-3386-11-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 kernel@pengutronix.de, linux-i2c@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This prepares *of_device_id.data becoming const. Without this change
the following warning would occur:

	drivers/i2c/busses/i2c-mpc.c: In function 'fsl_i2c_probe':
	drivers/i2c/busses/i2c-mpc.c:650:31: warning: initialization discards 'const' qualifier from pointer target type [enabled by default]

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/i2c/busses/i2c-mpc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
index b76731e..775062c 100644
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -647,7 +647,7 @@ static int __devinit fsl_i2c_probe(struct platform_device *op)
 	}
 
 	if (match->data) {
-		struct mpc_i2c_data *data = match->data;
+		const struct mpc_i2c_data *data = match->data;
 		data->setup(op->dev.of_node, i2c, clock, data->prescaler);
 	} else {
 		/* Backwards compatibility */
-- 
1.7.10.4
