Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E9E05B7D0F
	for <linuxppc-dev@ozlabs.org>; Sun, 21 Mar 2010 01:14:46 +1100 (EST)
From: Wolfram Sang <w.sang@pengutronix.de>
To: kernel-janitors@vger.kernel.org
Date: Sat, 20 Mar 2010 15:12:50 +0100
Message-Id: <1269094385-16114-10-git-send-email-w.sang@pengutronix.de>
In-Reply-To: <1269094385-16114-1-git-send-email-w.sang@pengutronix.de>
References: <1269094385-16114-1-git-send-email-w.sang@pengutronix.de>
Subject: [PATCH 09/24] macintosh: fix dangling pointers
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	linux-i2c@vger.kernel.org, Colin Leroy <colin@colino.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fix I2C-drivers which missed setting clientdata to NULL before freeing the
structure it points to. Also fix drivers which do this _after_ the structure
was freed already.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: Colin Leroy <colin@colino.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Found using coccinelle, then reviewed. Full patchset is available via
kernel-janitors, linux-i2c, and LKML.
---
 drivers/macintosh/therm_adt746x.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/macintosh/therm_adt746x.c b/drivers/macintosh/therm_adt746x.c
index c42eeb4..16d82f1 100644
--- a/drivers/macintosh/therm_adt746x.c
+++ b/drivers/macintosh/therm_adt746x.c
@@ -182,6 +182,7 @@ remove_thermostat(struct i2c_client *client)
 
 	thermostat = NULL;
 
+	i2c_set_clientdata(client, NULL);
 	kfree(th);
 
 	return 0;
@@ -399,6 +400,7 @@ static int probe_thermostat(struct i2c_client *client,
 	rc = read_reg(th, CONFIG_REG);
 	if (rc < 0) {
 		dev_err(&client->dev, "Thermostat failed to read config!\n");
+		i2c_set_clientdata(client, NULL);
 		kfree(th);
 		return -ENODEV;
 	}
-- 
1.7.0
