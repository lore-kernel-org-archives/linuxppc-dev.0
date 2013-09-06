Return-Path: <R58495@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0184.outbound.messaging.microsoft.com [213.199.154.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C50442C0182
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Sep 2013 01:44:08 +1000 (EST)
From: York Sun <yorksun@freescale.com>
To: <galak@kernel.crashing.org>
Subject: [PATCH 4/7] power/mpc85xx: Add delay after enabling I2C master
Date: Fri, 6 Sep 2013 08:43:16 -0700
Message-ID: <1378482199-10581-4-git-send-email-yorksun@freescale.com>
In-Reply-To: <1378482199-10581-1-git-send-email-yorksun@freescale.com>
References: <1378482199-10581-1-git-send-email-yorksun@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, York Sun <yorksun@freescale.com>,
 linux-i2c@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Erratum A-006037 indicates I2C controller executes the write to I2CCR only
after it sees SCL idle for 64K cycle of internal I2C controller clocks. If
during this waiting period, I2C controller is disabled (I2CCR[MEN] set to
0), then the controller could end in bad state, and hang the future access
to I2C register.

The mpc_i2c_fixup() function tries to recover the bus from a stalled state
where the 9th clock pulse wasn't generated. However, this workaround
disables and enables I2C controller without meeting waiting requirement of
this erratum.

This erratum applies to some 85xx SoCs. It is safe to apply to all of them
for mpc_i2c_fixup().

Signed-off-by: York Sun <yorksun@freescale.com>
Reviewed-by: Wood Scott-B07421 <scottwood@freescale.com>
Reviewed-by: Fleming Andrew-AFLEMING <AFLEMING@freescale.com>
Tested-by: Fleming Andrew-AFLEMING <AFLEMING@freescale.com>
CC: linux-i2c@vger.kernel.org
---
 drivers/i2c/busses/i2c-mpc.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
index b80c768..55dce43 100644
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -106,7 +106,12 @@ static irqreturn_t mpc_i2c_isr(int irq, void *dev_id)
 static void mpc_i2c_fixup(struct mpc_i2c *i2c)
 {
 	int k;
-	u32 delay_val = 1000000 / i2c->real_clk + 1;
+	u32 delay_val;
+#ifdef CONFIG_PPC_85xx
+	delay_val = 65536 / (fsl_get_sys_freq() / 2000000);	/* 64K cycle */
+#else
+	delay_val = 1000000 / i2c->real_clk + 1;
+#endif
 
 	if (delay_val < 2)
 		delay_val = 2;
@@ -116,7 +121,11 @@ static void mpc_i2c_fixup(struct mpc_i2c *i2c)
 		writeccr(i2c, CCR_MSTA | CCR_MTX | CCR_MEN);
 		udelay(delay_val);
 		writeccr(i2c, CCR_MEN);
+#ifdef CONFIG_PPC_85xx
+		udelay(delay_val);
+#else
 		udelay(delay_val << 1);
+#endif
 	}
 }
 
-- 
1.7.9.5
