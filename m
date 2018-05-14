Return-Path: <peda@axentia.se>
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr20133.outbound.protection.outlook.com [40.107.2.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40l3db2tfhzF2r9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 May 2018 00:54:59 +1000 (AEST)
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, linuxppc-dev@lists.ozlabs.org,
 linux-i2c@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 16/21] i2c: pasemi: make use of i2c_8bit_addr_from_msg
Date: Mon, 14 May 2018 16:53:25 +0200
Message-Id: <20180514145330.4857-17-peda@axentia.se>
In-Reply-To: <20180514145330.4857-1-peda@axentia.se>
References: <20180514145330.4857-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Because it looks neater.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/busses/i2c-pasemi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-pasemi.c b/drivers/i2c/busses/i2c-pasemi.c
index df1dbc92a024..55fd5c6f3cca 100644
--- a/drivers/i2c/busses/i2c-pasemi.c
+++ b/drivers/i2c/busses/i2c-pasemi.c
@@ -121,7 +121,7 @@ static int pasemi_i2c_xfer_msg(struct i2c_adapter *adapter,
 
 	read = msg->flags & I2C_M_RD ? 1 : 0;
 
-	TXFIFO_WR(smbus, MTXFIFO_START | (msg->addr << 1) | read);
+	TXFIFO_WR(smbus, MTXFIFO_START | i2c_8bit_addr_from_msg(msg));
 
 	if (read) {
 		TXFIFO_WR(smbus, msg->len | MTXFIFO_READ |
-- 
2.11.0
