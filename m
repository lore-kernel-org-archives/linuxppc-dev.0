Return-Path: <wg@grandegger.com>
Message-ID: <488982B5.4070102@grandegger.com>
Date: Fri, 25 Jul 2008 09:37:25 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: i2c-mpc: make speed registers configurable via FDT
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The I2C driver for the MPC currently uses a fixed speed hard-coded into
the driver. This patch adds the FDT properties "fdr" and "dfsrr" for the
corresponding I2C registers to make the speed configurable via FDT, 
e.g.:

    i2c@3100 {
        compatible = "fsl-i2c";
        reg = <0x3100 0x100>;
        interrupts = <43 2>;
        interrupt-parent = <&mpic>;
        dfsrr = <0x20>;
        fdr = <0x03>;
    };

Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
---
 Documentation/powerpc/dts-bindings/fsl/i2c.txt |    9 +++--
 drivers/i2c/busses/i2c-mpc.c                   |   45 ++++++++++++++++++++-----
 2 files changed, 42 insertions(+), 12 deletions(-)

Index: linux-2.6-galak/drivers/i2c/busses/i2c-mpc.c
===================================================================
--- linux-2.6-galak.orig/drivers/i2c/busses/i2c-mpc.c
+++ linux-2.6-galak/drivers/i2c/busses/i2c-mpc.c
@@ -56,6 +56,8 @@ struct mpc_i2c {
 	struct i2c_adapter adap;
 	int irq;
 	u32 flags;
+	u32 fdr;
+	u32 dfsrr;
 };
 
 static __inline__ void writeccr(struct mpc_i2c *i2c, u32 x)
@@ -156,13 +158,16 @@ static int i2c_wait(struct mpc_i2c *i2c,
 static void mpc_i2c_setclock(struct mpc_i2c *i2c)
 {
 	/* Set clock and filters */
+	pr_debug("I2C: flags=%#x fdr=%#x dfsrr=%#x\n",
+		 i2c->flags, i2c->fdr, i2c->dfsrr);
 	if (i2c->flags & FSL_I2C_DEV_SEPARATE_DFSRR) {
-		writeb(0x31, i2c->base + MPC_I2C_FDR);
-		writeb(0x10, i2c->base + MPC_I2C_DFSRR);
-	} else if (i2c->flags & FSL_I2C_DEV_CLOCK_5200)
-		writeb(0x3f, i2c->base + MPC_I2C_FDR);
-	else
-		writel(0x1031, i2c->base + MPC_I2C_FDR);
+		writeb(i2c->fdr, i2c->base + MPC_I2C_FDR);
+		writeb(i2c->dfsrr, i2c->base + MPC_I2C_DFSRR);
+	} else if (i2c->flags & FSL_I2C_DEV_CLOCK_5200) {
+		writeb(i2c->fdr, i2c->base + MPC_I2C_FDR);
+	} else {
+		writel(i2c->fdr, i2c->base + MPC_I2C_FDR);
+	}
 }
 
 static void mpc_i2c_start(struct mpc_i2c *i2c)
@@ -320,18 +325,40 @@ static int __devinit fsl_i2c_probe(struc
 {
 	int result = 0;
 	struct mpc_i2c *i2c;
+	const u32 *prop;
+	int prop_len;
 
 	i2c = kzalloc(sizeof(*i2c), GFP_KERNEL);
 	if (!i2c)
 		return -ENOMEM;
 
-	if (of_get_property(op->node, "dfsrr", NULL))
-		i2c->flags |= FSL_I2C_DEV_SEPARATE_DFSRR;
-
 	if (of_device_is_compatible(op->node, "fsl,mpc5200-i2c") ||
 			of_device_is_compatible(op->node, "mpc5200-i2c"))
 		i2c->flags |= FSL_I2C_DEV_CLOCK_5200;
 
+	prop = of_get_property(op->node, "dfsrr", &prop_len);
+	if (prop) {
+		i2c->flags |= FSL_I2C_DEV_SEPARATE_DFSRR;
+		if (prop_len == sizeof(*prop))
+			i2c->dfsrr = *prop;
+		else
+			/* Set resonable default value */
+			i2c->dfsrr = 0x10;
+	}
+
+	prop = of_get_property(op->node, "fdr", &prop_len);
+	if (prop && prop_len == sizeof(*prop)) {
+		i2c->fdr = *prop;
+	} else {
+		/* Set resonable default values */
+		if (i2c->flags & FSL_I2C_DEV_SEPARATE_DFSRR)
+			i2c->fdr = 0x31;
+		else if (i2c->flags & FSL_I2C_DEV_CLOCK_5200)
+			i2c->fdr = 0x3f;
+		else
+			i2c->fdr = 0x1031;
+	}
+
 	init_waitqueue_head(&i2c->queue);
 
 	i2c->base = of_iomap(op->node, 0);
Index: linux-2.6-galak/Documentation/powerpc/dts-bindings/fsl/i2c.txt
===================================================================
--- linux-2.6-galak.orig/Documentation/powerpc/dts-bindings/fsl/i2c.txt
+++ linux-2.6-galak/Documentation/powerpc/dts-bindings/fsl/i2c.txt
@@ -16,10 +16,12 @@ Recommended properties :
    controller you have.
  - interrupt-parent : the phandle for the interrupt controller that
    services interrupts for this device.
- - dfsrr : boolean; if defined, indicates that this I2C device has
-   a digital filter sampling rate register
  - fsl5200-clocking : boolean; if defined, indicated that this device
    uses the FSL 5200 clocking mechanism.
+ - dfsrr : boolean or <v>; if defined, indicates that this I2C device has
+   a digital filter sampling rate register. Optionally you can specify a
+   value v for the this register.
+ - fdr : <v>, if defined, the FDR register will be set to the value v.
 
 Example :
 	i2c@3000 {
@@ -28,5 +30,6 @@ Example :
 		reg = <3000 18>;
 		device_type = "i2c";
 		compatible  = "fsl-i2c";
-		dfsrr;
+		fdr = <0x20>
+		dfsrr = <0x03>;
 	};
