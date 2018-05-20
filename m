Return-Path: <wsa@the-dreams.de>
Received: from pokefinder.org (sauhun.de [88.99.104.3])
 by lists.ozlabs.org (Postfix) with ESMTP id 40pXc35p01zDrWV
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 May 2018 16:50:41 +1000 (AEST)
From: Wolfram Sang <wsa@the-dreams.de>
To: linux-i2c@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] i2c: opal: don't check number of messages in the driver
Date: Sun, 20 May 2018 08:50:34 +0200
Message-Id: <20180520065035.7920-3-wsa@the-dreams.de>
In-Reply-To: <20180520065035.7920-1-wsa@the-dreams.de>
References: <20180520065035.7920-1-wsa@the-dreams.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since commit 1eace8344c02 ("i2c: add param sanity check to
i2c_transfer()") and b7f625840267 ("i2c: add quirk checks to core"), the
I2C core does this check now. We can remove it here.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---

Only build tested.

 drivers/i2c/busses/i2c-opal.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-opal.c b/drivers/i2c/busses/i2c-opal.c
index 0aabb7eca0c5..dc2a23f4fb52 100644
--- a/drivers/i2c/busses/i2c-opal.c
+++ b/drivers/i2c/busses/i2c-opal.c
@@ -94,8 +94,6 @@ static int i2c_opal_master_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 	 */
 	memset(&req, 0, sizeof(req));
 	switch(num) {
-	case 0:
-		return 0;
 	case 1:
 		req.type = (msgs[0].flags & I2C_M_RD) ?
 			OPAL_I2C_RAW_READ : OPAL_I2C_RAW_WRITE;
@@ -114,8 +112,6 @@ static int i2c_opal_master_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 		req.size = cpu_to_be32(msgs[1].len);
 		req.buffer_ra = cpu_to_be64(__pa(msgs[1].buf));
 		break;
-	default:
-		return -EOPNOTSUPP;
 	}
 
 	rc = i2c_opal_send_request(opal_id, &req);
-- 
2.11.0
