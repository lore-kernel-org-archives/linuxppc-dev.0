Return-Path: <avorontsov@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id E1A55DDF58
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Apr 2008 21:16:59 +1000 (EST)
Date: Wed, 30 Apr 2008 15:16:56 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH 6/6] [POWERPC] booting-without-of: add FHCI USB, FSL
	MCU, FSL UPM and GPIO LEDs bindings
Message-ID: <20080430111656.GA14148@polina.dev.rtsoft.ru>
References: <20080429185920.GA19735@polina.dev.rtsoft.ru>
	<20080429190057.GF21203@polina.dev.rtsoft.ru>
	<48182FA6.5010900@grandegger.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <48182FA6.5010900@grandegger.com>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 30, 2008 at 10:36:54AM +0200, Wolfgang Grandegger wrote:
> Hi Anton,
[...]
> > +	upm@1,0 {
> > +		#address-cells = <0>;
> > +		#size-cells = <0>;
> > +		compatible = "fsl,upm-nand";
> > +		reg = <1 0 1>;
> > +		fsl,upm-addr-offset = <16>;
> > +		fsl,upm-cmd-offset = <8>;
> > +		gpios = <&qe_pio_e 18 0>;
> > +
> > +		flash {
> > +			#address-cells = <1>;
> > +			#size-cells = <1>;
> > +			compatible = "stmicro,NAND512W3A2BN6E";
> > +
> > +			partition@0 {
> > +				...
> > +			};
> > +		};
> > +	};
> 
> Where can I find the code for that binding? fsl_upm_nand.c from
> http://patchwork.ozlabs.org/linuxppc/patch?q=upm&id=17306 does not parse
> OF partitions. Are there any plans to push the fsl_upm_nand driver
> upstream?

David already pushed UPM NAND driver upstream, but true, it was an "old"
version, i.e. without approved bindings. I'll send the update (inlining
here) if/when these bindings will be applied to the powerpc tree.

- - - -
From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: [NAND] update FSL UPM NAND driver for the new OF bindings

- get rid of fsl,wait-pattern and fsl,wait-write. I think this isn't
  chip-specific, and we should always do waits. I saw one board that
  didn't need fsl,wait-pattern, but I assume it was exception that
  proves general rule;
- get rid of chip-delay. Today there are no users for this, and if
  anyone really need this they should push the OF bindings beforehand;
- Now flash chips should be child nodes of the FSL UPM nand controller;
- Implement OF partition parsing.

Signed-off-by: not yet.
---
 drivers/mtd/nand/fsl_upm.c |   62 +++++++++++++++++++++++++++-----------------
 1 files changed, 38 insertions(+), 24 deletions(-)

diff --git a/drivers/mtd/nand/fsl_upm.c b/drivers/mtd/nand/fsl_upm.c
index 1ebfd87..f91c950 100644
--- a/drivers/mtd/nand/fsl_upm.c
+++ b/drivers/mtd/nand/fsl_upm.c
@@ -36,9 +36,6 @@ struct fsl_upm_nand {
 	uint8_t upm_cmd_offset;
 	void __iomem *io_base;
 	int rnb_gpio;
-	const uint32_t *wait_pattern;
-	const uint32_t *wait_write;
-	int chip_delay;
 };
 
 #define to_fsl_upm_nand(mtd) container_of(mtd, struct fsl_upm_nand, mtd)
@@ -89,8 +86,7 @@ static void fun_cmd_ctrl(struct mtd_info *mtd, int cmd, unsigned int ctrl)
 
 	fsl_upm_run_pattern(&fun->upm, fun->io_base, cmd);
 
-	if (fun->wait_pattern)
-		fun_wait_rnb(fun);
+	fun_wait_rnb(fun);
 }
 
 static uint8_t fun_read_byte(struct mtd_info *mtd)
@@ -116,14 +112,16 @@ static void fun_write_buf(struct mtd_info *mtd, const uint8_t *buf, int len)
 
 	for (i = 0; i < len; i++) {
 		out_8(fun->chip.IO_ADDR_W, buf[i]);
-		if (fun->wait_write)
-			fun_wait_rnb(fun);
+		fun_wait_rnb(fun);
 	}
 }
 
-static int __devinit fun_chip_init(struct fsl_upm_nand *fun)
+static int __devinit fun_chip_init(struct fsl_upm_nand *fun,
+				   const struct device_node *upm_np,
+				   const struct resource *io_res)
 {
 	int ret;
+	struct device_node *flash_np;
 #ifdef CONFIG_MTD_PARTITIONS
 	static const char *part_types[] = { "cmdlinepart", NULL, };
 #endif
@@ -131,7 +129,7 @@ static int __devinit fun_chip_init(struct fsl_upm_nand *fun)
 	fun->chip.IO_ADDR_R = fun->io_base;
 	fun->chip.IO_ADDR_W = fun->io_base;
 	fun->chip.cmd_ctrl = fun_cmd_ctrl;
-	fun->chip.chip_delay = fun->chip_delay;
+	fun->chip.chip_delay = 50;
 	fun->chip.read_byte = fun_read_byte;
 	fun->chip.read_buf = fun_read_buf;
 	fun->chip.write_buf = fun_write_buf;
@@ -143,18 +141,42 @@ static int __devinit fun_chip_init(struct fsl_upm_nand *fun)
 	fun->mtd.priv = &fun->chip;
 	fun->mtd.owner = THIS_MODULE;
 
+	flash_np = of_get_next_child(upm_np, NULL);
+	if (!flash_np)
+		return -ENODEV;
+
+	fun->mtd.name = kasprintf(GFP_KERNEL, "%x.%s", io_res->start,
+				  flash_np->name);
+	if (!fun->mtd.name) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
 	ret = nand_scan(&fun->mtd, 1);
 	if (ret)
-		return ret;
-
-	fun->mtd.name = fun->dev->bus_id;
+		goto err;
 
 #ifdef CONFIG_MTD_PARTITIONS
 	ret = parse_mtd_partitions(&fun->mtd, part_types, &fun->parts, 0);
+
+#ifdef CONFIG_MTD_OF_PARTS
+	if (ret <= 0) {
+		ret = of_mtd_parse_partitions(fun->dev, &fun->mtd,
+					flash_np, &fun->parts);
+		if (ret < 0) {
+			ret = -EINVAL;
+			goto err;
+		}
+	}
+#endif
 	if (ret > 0)
-		return add_mtd_partitions(&fun->mtd, fun->parts, ret);
+		ret = add_mtd_partitions(&fun->mtd, fun->parts, ret);
+	else
 #endif
-	return add_mtd_device(&fun->mtd);
+		ret = add_mtd_device(&fun->mtd);
+err:
+	of_node_put(flash_np);
+	return ret;
 }
 
 static int __devinit fun_probe(struct of_device *ofdev,
@@ -220,17 +242,8 @@ static int __devinit fun_probe(struct of_device *ofdev,
 
 	fun->dev = &ofdev->dev;
 	fun->last_ctrl = NAND_CLE;
-	fun->wait_pattern = of_get_property(ofdev->node, "fsl,wait-pattern",
-					    NULL);
-	fun->wait_write = of_get_property(ofdev->node, "fsl,wait-write", NULL);
-
-	prop = of_get_property(ofdev->node, "chip-delay", NULL);
-	if (prop)
-		fun->chip_delay = *prop;
-	else
-		fun->chip_delay = 50;
 
-	ret = fun_chip_init(fun);
+	ret = fun_chip_init(fun, ofdev->node, &io_res);
 	if (ret)
 		goto err2;
 
@@ -251,6 +264,7 @@ static int __devexit fun_remove(struct of_device *ofdev)
 	struct fsl_upm_nand *fun = dev_get_drvdata(&ofdev->dev);
 
 	nand_release(&fun->mtd);
+	kfree(fun->mtd.name);
 
 	if (fun->rnb_gpio >= 0)
 		gpio_free(fun->rnb_gpio);
-- 
1.5.5.1
