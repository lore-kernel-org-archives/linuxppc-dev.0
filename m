Return-Path: <avorontsov@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 5FDB3DE6B6
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Apr 2008 03:01:16 +1000 (EST)
Date: Fri, 25 Apr 2008 21:01:15 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 3/6] [POWERPC] QE: prepare QE PIO code for GPIO LIB support
Message-ID: <20080425170115.GC12154@polina.dev.rtsoft.ru>
References: <20080425170014.GA11669@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080425170014.GA11669@polina.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

- split and export __par_io_config_pin() out of par_io_config_pin(), so we
  could use the prefixed version with GPIO LIB API;
- rename struct port_regs to qe_pio_regs, and place it into qe.h;
- rename #define NUM_OF_PINS to QE_PIO_PINS, and place it into qe.h.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/sysdev/qe_lib/qe_io.c |   94 +++++++++++++++++-------------------
 include/asm-powerpc/qe.h           |   19 +++++++
 2 files changed, 64 insertions(+), 49 deletions(-)

diff --git a/arch/powerpc/sysdev/qe_lib/qe_io.c b/arch/powerpc/sysdev/qe_lib/qe_io.c
index 93916a4..7c87460 100644
--- a/arch/powerpc/sysdev/qe_lib/qe_io.c
+++ b/arch/powerpc/sysdev/qe_lib/qe_io.c
@@ -28,21 +28,7 @@
 
 #undef DEBUG
 
-#define NUM_OF_PINS	32
-
-struct port_regs {
-	__be32	cpodr;		/* Open drain register */
-	__be32	cpdata;		/* Data register */
-	__be32	cpdir1;		/* Direction register */
-	__be32	cpdir2;		/* Direction register */
-	__be32	cppar1;		/* Pin assignment register */
-	__be32	cppar2;		/* Pin assignment register */
-#ifdef CONFIG_PPC_85xx
-	u8	pad[8];
-#endif
-};
-
-static struct port_regs __iomem *par_io;
+static struct qe_pio_regs __iomem *par_io;
 static int num_par_io_ports = 0;
 
 int par_io_init(struct device_node *np)
@@ -64,69 +50,79 @@ int par_io_init(struct device_node *np)
 	return 0;
 }
 
-int par_io_config_pin(u8 port, u8 pin, int dir, int open_drain,
-		      int assignment, int has_irq)
+void __par_io_config_pin(struct qe_pio_regs __iomem *par_io, u8 pin, int dir,
+			 int open_drain, int assignment, int has_irq)
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
-	pin_mask1bit = (u32) (1 << (NUM_OF_PINS - (pin + 1)));
+	pin_mask1bit = (u32) (1 << (QE_PIO_PINS - (pin + 1)));
 
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
-	tmp_val = (pin > (NUM_OF_PINS / 2) - 1) ?
-		in_be32(&par_io[port].cpdir2) :
-		in_be32(&par_io[port].cpdir1);
+	tmp_val = (pin > (QE_PIO_PINS / 2) - 1) ?
+		in_be32(&par_io->cpdir2) :
+		in_be32(&par_io->cpdir1);
 
 	/* get all bits mask for 2 bit per port */
-	pin_mask2bits = (u32) (0x3 << (NUM_OF_PINS -
-				(pin % (NUM_OF_PINS / 2) + 1) * 2));
+	pin_mask2bits = (u32) (0x3 << (QE_PIO_PINS -
+				(pin % (QE_PIO_PINS / 2) + 1) * 2));
 
 	/* Get the final mask we need for the right definition */
-	new_mask2bits = (u32) (dir << (NUM_OF_PINS -
-				(pin % (NUM_OF_PINS / 2) + 1) * 2));
+	new_mask2bits = (u32) (dir << (QE_PIO_PINS -
+				(pin % (QE_PIO_PINS / 2) + 1) * 2));
 
 	/* clear and set 2 bits mask */
-	if (pin > (NUM_OF_PINS / 2) - 1) {
-		out_be32(&par_io[port].cpdir2,
+	if (pin > (QE_PIO_PINS / 2) - 1) {
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
-	tmp_val = (pin > (NUM_OF_PINS / 2) - 1) ?
-		in_be32(&par_io[port].cppar2) :
-		in_be32(&par_io[port].cppar1);
+	tmp_val = (pin > (QE_PIO_PINS / 2) - 1) ?
+		in_be32(&par_io->cppar2) :
+		in_be32(&par_io->cppar1);
 
-	new_mask2bits = (u32) (assignment << (NUM_OF_PINS -
-			(pin % (NUM_OF_PINS / 2) + 1) * 2));
+	new_mask2bits = (u32) (assignment << (QE_PIO_PINS -
+			(pin % (QE_PIO_PINS / 2) + 1) * 2));
 	/* clear and set 2 bits mask */
-	if (pin > (NUM_OF_PINS / 2) - 1) {
-		out_be32(&par_io[port].cppar2,
+	if (pin > (QE_PIO_PINS / 2) - 1) {
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
+EXPORT_SYMBOL(__par_io_config_pin);
+
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
@@ -137,10 +133,10 @@ int par_io_data_set(u8 port, u8 pin, u8 val)
 
 	if (port >= num_par_io_ports)
 		return -EINVAL;
-	if (pin >= NUM_OF_PINS)
+	if (pin >= QE_PIO_PINS)
 		return -EINVAL;
 	/* calculate pin location */
-	pin_mask = (u32) (1 << (NUM_OF_PINS - 1 - pin));
+	pin_mask = (u32) (1 << (QE_PIO_PINS - 1 - pin));
 
 	tmp_val = in_be32(&par_io[port].cpdata);
 
diff --git a/include/asm-powerpc/qe.h b/include/asm-powerpc/qe.h
index d217288..c4523ac 100644
--- a/include/asm-powerpc/qe.h
+++ b/include/asm-powerpc/qe.h
@@ -84,8 +84,27 @@ extern spinlock_t cmxgcr_lock;
 
 /* Export QE common operations */
 extern void qe_reset(void);
+
+/* QE PIO */
+#define QE_PIO_PINS 32
+
+struct qe_pio_regs {
+	__be32	cpodr;		/* Open drain register */
+	__be32	cpdata;		/* Data register */
+	__be32	cpdir1;		/* Direction register */
+	__be32	cpdir2;		/* Direction register */
+	__be32	cppar1;		/* Pin assignment register */
+	__be32	cppar2;		/* Pin assignment register */
+#ifdef CONFIG_PPC_85xx
+	u8	pad[8];
+#endif
+};
+
 extern int par_io_init(struct device_node *np);
 extern int par_io_of_config(struct device_node *np);
+extern void __par_io_config_pin(struct qe_pio_regs __iomem *par_io, u8 pin,
+				int dir, int open_drain, int assignment,
+				int has_irq);
 extern int par_io_config_pin(u8 port, u8 pin, int dir, int open_drain,
 			     int assignment, int has_irq);
 extern int par_io_data_set(u8 port, u8 pin, u8 val);
-- 
1.5.5.1
