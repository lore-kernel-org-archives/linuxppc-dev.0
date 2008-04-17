Return-Path: <avorontsov@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 85FD1DEB78
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 05:28:51 +1000 (EST)
Date: Thu, 17 Apr 2008 23:28:50 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 3/5] [POWERPC] QE: split par_io_config_pin()
Message-ID: <20080417192850.GC28286@polina.dev.rtsoft.ru>
References: <20080417192656.GA19107@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <20080417192656.GA19107@polina.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
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
index 93916a4..a3f9c3f 100644
--- a/arch/powerpc/sysdev/qe_lib/qe_io.c
+++ b/arch/powerpc/sysdev/qe_lib/qe_io.c
@@ -38,6 +38,10 @@ struct port_regs {
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
@@ -64,28 +68,29 @@ int par_io_init(struct device_node *np)
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
@@ -97,36 +102,49 @@ int par_io_config_pin(u8 port, u8 pin, int dir, int open_drain,
 
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
1.5.5
