Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id D96C9DDE05
	for <linuxppc-dev@ozlabs.org>; Sun, 29 Jun 2008 13:20:13 +1000 (EST)
Date: Sat, 28 Jun 2008 23:20:10 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: [RFC] Non-numbered ibm iic driver
Message-ID: <20080628232010.2bff2dcc@lappy.seanm.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a patch to the ibm iic driver that uses the non-numbered
i2c call and therefore does not need an index. Instead, it registers the
ibm iic, then walks all the child nodes and adds them. This is required
for new style drivers, old style drivers "just work".

The warp has both a new style driver (ad7414) and old style (eeprom)
devices.

This patch is completely function but not a complete patch (the index
code is not needed for example). It is just for comment.

The warp.dts needed for this to work is, I believe, in Josh's next tree.

Cheers,
   Sean

P.S. Do I need a signed-off-by for an RFC?

Signed-off-by: Sean MacLennan <smaclennan@pikatech.com>
---

diff --git a/drivers/i2c/busses/i2c-ibm_iic.c b/drivers/i2c/busses/i2c-ibm_iic.c
index 85dbf34..0ec6849 100644
--- a/drivers/i2c/busses/i2c-ibm_iic.c
+++ b/drivers/i2c/busses/i2c-ibm_iic.c
@@ -753,7 +753,7 @@ static int __devinit iic_probe(struct ocp_device *ocp){
 	 */
 	adap->nr = dev->idx >= 0 ? dev->idx : 0;
 
-	if ((ret = i2c_add_numbered_adapter(adap)) < 0) {
+	if ((ret = i2c_add_adapter(adap)) < 0) {
 		printk(KERN_ERR "ibm-iic%d: failed to register i2c adapter\n",
 			dev->idx);
 		goto fail;
@@ -874,6 +874,7 @@ static int __devinit iic_probe(struct of_device *ofdev,
 			       const struct of_device_id *match)
 {
 	struct device_node *np = ofdev->node;
+	struct device_node *child;
 	struct ibm_iic_private *dev;
 	struct i2c_adapter *adap;
 	const u32 *indexp, *freq;
@@ -939,12 +940,33 @@ static int __devinit iic_probe(struct of_device *ofdev,
 	adap->timeout = 1;
 	adap->nr = dev->idx;
 
-	ret = i2c_add_numbered_adapter(adap);
+	ret = i2c_add_adapter(adap);
 	if (ret  < 0) {
 		dev_err(&ofdev->dev, "failed to register i2c adapter\n");
 		goto error_cleanup;
 	}
 
+	for_each_child_of_node(np, child) {
+		struct i2c_board_info info;
+		const u32 *reg;
+
+		reg = of_get_property(child, "reg", NULL);
+		if (!reg) {
+			printk(KERN_ERR "Could not find address for %s\n",
+			       child->name);
+			continue;
+		}
+
+		memset(&info, 0, sizeof(info));
+		strlcpy(info.type, child->name, I2C_NAME_SIZE);
+		info.addr = *reg;
+
+		if (!i2c_new_device(adap, &info))
+			printk(KERN_ERR "Could not add i2c device %s.\n",
+			       child->name);
+	}
+
+
 	dev_info(&ofdev->dev, "using %s mode\n",
 		 dev->fast_mode ? "fast (400 kHz)" : "standard (100 kHz)");
 
