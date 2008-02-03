Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id B60A0DDF04
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Feb 2008 04:10:05 +1100 (EST)
Received: from localhost (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP id 7120E8814
	for <linuxppc-dev@ozlabs.org>; Sun,  3 Feb 2008 22:10:13 +0400 (SAMT)
Date: Sun, 3 Feb 2008 20:09:54 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 02/11] [POWERPC] QE: split par_io_config_pin()
Message-ID: <20080203170954.GB28024@localhost.localdomain>
References: <20080203170820.GA18520@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080203170820.GA18520@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch splits par_io_config_pin so we can use it with GPIO LIB API.

Also add a comment regarding #ifdef CONFIG_PPC_85xx being legacy.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/sysdev/qe_lib/qe_io.c |   60 +++++++++++++++++++++++------------
 1 files changed, 39 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/sysdev/qe_lib/qe_io.c b/arch/powerpc/sysdev/qe_lib/qe_io.c
index e53ea4d..aef893b 100644
--- a/arch/powerpc/sysdev/qe_lib/qe_io.c
+++ b/arch/powerpc/sysdev/qe_lib/qe_io.c
@@ -37,6 +37,10 @@ struct port_regs {
 	__be32	cppar1;		/* Pin assignment register */
 	__be32	cppar2;		/* Pin assignment register */
 #ifdef CONFIG_PPC_85xx
+	/*
+	 * This is needed for legacy support only, should go away,
+	 * because we started using per-bank gpio chips.
+	 */
 	u8	pad[8];
 #endif
 };
@@ -63,28 +67,29 @@ int par_io_init(struct device_node *np)
 	return 0;
 }
 
-int par_io_config_pin(u8 port, u8 pin, int dir, int open_drain,
-		      int assignment, int has_irq)
+static void __par_io_config_pin(struct port_regs __iomem *par_io,
+				u8 pin, int dir, int open_drain,
+				int assignment, int has_irq)
 {
-	u32 pin_mask1bit, pin_mask2bits, new_mask2bits, tmp_val;
-
-	if (!par_io)
-		return -1;
+	u32 pin_mask1bit;
+	u32 pin_mask2bits;
+	u32 new_mask2bits;
+	u32 tmp_val;
 
 	/* calculate pin location for single and 2 bits information */
 	pin_mask1bit = (u32) (1 << (NUM_OF_PINS - (pin + 1)));
 
 	/* Set open drain, if required */
-	tmp_val = in_be32(&par_io[port].cpodr);
+	tmp_val = in_be32(&par_io->cpodr);
 	if (open_drain)
-		out_be32(&par_io[port].cpodr, pin_mask1bit | tmp_val);
+		out_be32(&par_io->cpodr, pin_mask1bit | tmp_val);
 	else
-		out_be32(&par_io[port].cpodr, ~pin_mask1bit & tmp_val);
+		out_be32(&par_io->cpodr, ~pin_mask1bit & tmp_val);
 
 	/* define direction */
 	tmp_val = (pin > (NUM_OF_PINS / 2) - 1) ?
-		in_be32(&par_io[port].cpdir2) :
-		in_be32(&par_io[port].cpdir1);
+		in_be32(&par_io->cpdir2) :
+		in_be32(&par_io->cpdir1);
 
 	/* get all bits mask for 2 bit per port */
 	pin_mask2bits = (u32) (0x3 << (NUM_OF_PINS -
@@ -96,36 +101,49 @@ int par_io_config_pin(u8 port, u8 pin, int dir, int open_drain,
 
 	/* clear and set 2 bits mask */
 	if (pin > (NUM_OF_PINS / 2) - 1) {
-		out_be32(&par_io[port].cpdir2,
+		out_be32(&par_io->cpdir2,
 			 ~pin_mask2bits & tmp_val);
 		tmp_val &= ~pin_mask2bits;
-		out_be32(&par_io[port].cpdir2, new_mask2bits | tmp_val);
+		out_be32(&par_io->cpdir2, new_mask2bits | tmp_val);
 	} else {
-		out_be32(&par_io[port].cpdir1,
+		out_be32(&par_io->cpdir1,
 			 ~pin_mask2bits & tmp_val);
 		tmp_val &= ~pin_mask2bits;
-		out_be32(&par_io[port].cpdir1, new_mask2bits | tmp_val);
+		out_be32(&par_io->cpdir1, new_mask2bits | tmp_val);
 	}
 	/* define pin assignment */
 	tmp_val = (pin > (NUM_OF_PINS / 2) - 1) ?
-		in_be32(&par_io[port].cppar2) :
-		in_be32(&par_io[port].cppar1);
+		in_be32(&par_io->cppar2) :
+		in_be32(&par_io->cppar1);
 
 	new_mask2bits = (u32) (assignment << (NUM_OF_PINS -
 			(pin % (NUM_OF_PINS / 2) + 1) * 2));
 	/* clear and set 2 bits mask */
 	if (pin > (NUM_OF_PINS / 2) - 1) {
-		out_be32(&par_io[port].cppar2,
+		out_be32(&par_io->cppar2,
 			 ~pin_mask2bits & tmp_val);
 		tmp_val &= ~pin_mask2bits;
-		out_be32(&par_io[port].cppar2, new_mask2bits | tmp_val);
+		out_be32(&par_io->cppar2, new_mask2bits | tmp_val);
 	} else {
-		out_be32(&par_io[port].cppar1,
+		out_be32(&par_io->cppar1,
 			 ~pin_mask2bits & tmp_val);
 		tmp_val &= ~pin_mask2bits;
-		out_be32(&par_io[port].cppar1, new_mask2bits | tmp_val);
+		out_be32(&par_io->cppar1, new_mask2bits | tmp_val);
 	}
+}
+
+/*
+ * This is "legacy" function that takes port number as an argument
+ * instead of pointer to the appropriate bank.
+ */
+int par_io_config_pin(u8 port, u8 pin, int dir, int open_drain,
+		      int assignment, int has_irq)
+{
+	if (!par_io || port >= num_par_io_ports)
+		return -EINVAL;
 
+	__par_io_config_pin(&par_io[port], pin, dir, open_drain, assignment,
+			    has_irq);
 	return 0;
 }
 EXPORT_SYMBOL(par_io_config_pin);
-- 
1.5.2.2
