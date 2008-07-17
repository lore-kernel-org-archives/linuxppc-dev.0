Return-Path: <wg@grandegger.com>
Message-ID: <487F20EC.9040503@grandegger.com>
Date: Thu, 17 Jul 2008 12:37:32 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Linuxppc-dev@ozlabs.org
Subject: [PATCH] i2c-mpc: suppress I2C device probing
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Jean Delvare <khali@linux-fr.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch suppresses I2C device probing by clearing the class field
of the "struct i2c_adapter" for the MPC I2C bus adapters. Some board
configurations which rely on probing must be fixed up by adding a
proper I2C device node to the DTS file, like the TQM85xx modules.

Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
---
 drivers/i2c/busses/i2c-mpc.c |    1 -
 1 file changed, 1 deletion(-)

Index: powerpc/drivers/i2c/busses/i2c-mpc.c
===================================================================
--- powerpc.orig/drivers/i2c/busses/i2c-mpc.c
+++ powerpc/drivers/i2c/busses/i2c-mpc.c
@@ -312,7 +312,6 @@ static struct i2c_adapter mpc_ops = {
 	.name = "MPC adapter",
 	.id = I2C_HW_MPC107,
 	.algo = &mpc_algo,
-	.class = I2C_CLASS_HWMON | I2C_CLASS_SPD,
 	.timeout = 1,
 };
 
