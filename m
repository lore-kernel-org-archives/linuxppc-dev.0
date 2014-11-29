Return-Path: <danielle.costantino@gmail.com>
Received: from mail-pa0-x231.google.com (mail-pa0-x231.google.com
 [IPv6:2607:f8b0:400e:c03::231])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4A2B81A0A74
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Nov 2014 08:58:46 +1100 (AEDT)
Received: by mail-pa0-f49.google.com with SMTP id eu11so8638616pac.36
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Nov 2014 13:58:43 -0800 (PST)
Message-ID: <547A4192.30102@gmail.com>
Date: Sat, 29 Nov 2014 13:58:42 -0800
From: Danielle Costantino <danielle.costantino@gmail.com>
MIME-Version: 1.0
To: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH] i2c: mpc: add register documentation to Freescale I2C driver
Content-Type: text/plain; charset=utf-8; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, linux-i2c@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

i2c: mpc: add register documentation to Freescale I2C driver

return -ETIMEDOUT for all time-out error conditions and warn on 
arbitration lost.

Signed-off-by: Danielle Costantino <danielle.costantino@gmail.com>

diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
index 4c5d7d9..28d9245 100644
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -36,26 +36,31 @@
  #define MPC_I2C_CLOCK_LEGACY   0
  #define MPC_I2C_CLOCK_PRESERVE (~0U)

-#define MPC_I2C_FDR   0x04
-#define MPC_I2C_CR    0x08
-#define MPC_I2C_SR    0x0c
-#define MPC_I2C_DR    0x10
-#define MPC_I2C_DFSRR 0x14
+#define    MPC_I2C_ADR        0x00    /* I2C address register */
+#define    MPC_I2C_FDR        0x04    /* I2C frequency divider register */
+#define    MPC_I2C_CR        0x08    /* I2C control register */
+#define    MPC_I2C_SR        0x0C    /* I2C status register */
+#define    MPC_I2C_DR        0x10    /* I2C data register */
+#define    MPC_I2C_DFSRR    0x14    /* I2C digital filter sampling rate 
register */

-#define CCR_MEN  0x80
-#define CCR_MIEN 0x40
-#define CCR_MSTA 0x20
-#define CCR_MTX  0x10
-#define CCR_TXAK 0x08
-#define CCR_RSTA 0x04
+/* I2C Control Register (MPC_I2C_CR): */
+#define CCR_MEN  0x80    /* Module enable */
+#define CCR_MIEN 0x40    /* Module interrupt enable */
+#define CCR_MSTA 0x20    /* Master/slave mode START */
+#define CCR_MTX  0x10    /* Transmit/receive mode select */
+#define CCR_TXAK 0x08    /* Transfer acknowledge */
+#define CCR_RSTA 0x04    /* Repeated START */
+#define CCR_BCST 0x01    /* Broadcast */

-#define CSR_MCF  0x80
-#define CSR_MAAS 0x40
-#define CSR_MBB  0x20
-#define CSR_MAL  0x10
-#define CSR_SRW  0x04
-#define CSR_MIF  0x02
-#define CSR_RXAK 0x01
+/* I2C Status Register (MPC_I2C_SR): */
+#define CSR_MCF  0x80    /* Data transfer */
+#define CSR_MAAS 0x40    /* Addressed as a slave */
+#define CSR_MBB  0x20    /* Bus busy */
+#define CSR_MAL  0x10    /* Arbitration lost */
+#define CSR_BCSTM 0x08    /* Broadcast match */
+#define CSR_SRW  0x04    /* Slave read/write */
+#define CSR_MIF  0x02    /* Module interrupt */
+#define CSR_RXAK 0x01    /* Received acknowledge */

  struct mpc_i2c {
      struct device *dev;
@@ -158,12 +163,12 @@
          return result;

      if (!(cmd_err & CSR_MCF)) {
-        dev_dbg(i2c->dev, "unfinished\n");
+        dev_warn(i2c->dev, "unfinished\n");
          return -EIO;
      }

      if (cmd_err & CSR_MAL) {
-        dev_dbg(i2c->dev, "MAL\n");
+        dev_err(i2c->dev, "Arbitration lost\n");
          return -EAGAIN;
      }

@@ -554,7 +559,7 @@
                         i2c->base + MPC_I2C_SR);
                  mpc_i2c_fixup(i2c);
              }
-            return -EIO;
+            return -ETIMEDOUT;
          }
          schedule();
      }
@@ -590,7 +595,7 @@
                         i2c->base + MPC_I2C_SR);
                  mpc_i2c_fixup(i2c);
              }
-            return -EIO;
+            return -ETIMEDOUT;
          }
          cond_resched();
      }
