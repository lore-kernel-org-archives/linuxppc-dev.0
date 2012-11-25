Return-Path: <sachin.surendran@gmail.com>
Received: from mail-da0-f51.google.com (mail-da0-f51.google.com
 [209.85.210.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8C0A22C008A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Nov 2012 09:19:58 +1100 (EST)
Received: by mail-da0-f51.google.com with SMTP id i30so2714119dad.38
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Nov 2012 14:19:55 -0800 (PST)
From: sachin.surendran@gmail.com
To: galak@kernel.crashing.org,
	jochen@scram.de
Subject: [PATCH 1/1] i2c-cpm: Fix to takeback i2c bus master-ship after a
 collision
Date: Mon, 26 Nov 2012 11:20:01 +1300
Message-Id: <1353882001-30744-1-git-send-email-sachin.surendran@gmail.com>
In-Reply-To: <sachin.surendran@gmail.com>
References: <sachin.surendran@gmail.com>
Cc: Sachin Surendran <sachin.surendran@alliedtelesis.co.nz>,
 sachin.surendran@gmail.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Sachin Surendran <sachin.surendran@alliedtelesis.co.nz>

In case of collision on i2c bus the controller which lost bus mastership
stays as a slave for all subsequent transfers. This results in the i2c
controller never writing to the bus for future transactions, resulting
in i2c transfer timeouts.
  This fix checks for a collision on last I2C transaction and sets the
I2COM_MASTER bit for the new transaction.

Signed-off-by: Sachin Surendran <sachin.surendran@alliedtelesis.co.nz>
---
 drivers/i2c/busses/i2c-cpm.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/i2c/busses/i2c-cpm.c b/drivers/i2c/busses/i2c-cpm.c
index c1e1096..bb94c6d 100644
--- a/drivers/i2c/busses/i2c-cpm.c
+++ b/drivers/i2c/busses/i2c-cpm.c
@@ -338,6 +338,14 @@ static int cpm_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 	tptr = 0;
 	rptr = 0;
 
+	/*
+	 * If there was a collision in the last i2c transaction,
+	 * Set I2COM_MASTER as it was cleared during collision.
+	 */
+	if (in_be16(&tbdf->cbd_sc) & BD_SC_CL) {
+		out_8(&cpm->i2c_reg->i2com, I2COM_MASTER);
+	}
+
 	while (tptr < num) {
 		pmsg = &msgs[tptr];
 		dev_dbg(&adap->dev, "R: %d T: %d\n", rptr, tptr);
-- 
1.7.9.5
