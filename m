Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 294CFDDEFA
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Jun 2007 05:58:04 +1000 (EST)
Date: Mon, 4 Jun 2007 21:57:59 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 4/5] powerpc: Add of_register_i2c_devices().
In-Reply-To: <20070518100908.aa803cc6.sfr@canb.auug.org.au>
Message-ID: <Pine.LNX.4.60.0706042119290.3653@poirot.grange>
References: <20070517143856.GD29795@ld0162-tx32.am.freescale.net>
	<20070518100908.aa803cc6.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I need this patch, as well as "Scott Wood: [PATCH 5/5] powerpc: Call 
of_register_i2c_devices() for fsl-i2c." 
(http://ozlabs.org/pipermail/linuxppc-dev/2007-May/036333.html) to keep 
linkstation working after the migration of the rtc-rs5c372 driver to the 
new i2c api.

On Fri, 18 May 2007, Stephen Rothwell wrote:

> On Thu, 17 May 2007 09:38:56 -0500 Scott Wood <scottwood@freescale.com> wrote:
> >
> > +		addr = get_property(node, "reg", &len);
> 
> get_property has been replaced by of_get_property.
> 
> > +		name = get_property(node, "compatible", NULL);
> 
> ditto.

Taking care of these corrections, and also using platform device id for 
i2c adapter number, as suggested by Grant Likely (added to cc:) in 
"[PATCH] Make i2c-mpc driver use i2c_add_numbered_adapter" 
(http://ozlabs.org/pipermail/linuxppc-dev/2007-May/036079.html), and using 
"model" of-property, if available, to specify the exact model of the i2c 
device, below is the updated version of the original patch of the hijacked 
thread. Not sure what I shall do with sign-offs... I think, I'll post it 
with none first, wait for Scott Woods comment and his sign-off, and then 
add mine.

Please notice, these two patches suffice to be able to use i2c device 
definitions from of. the "[PATCH 3/5] powerpc: Document device nodes for 
I2C devices." is just documentation, that nobody needs anyway (/me hides), 
and "[PATCH 2/5] i2c: Allow preallocation of I2C bus numbers." was pretty 
controversal too, so, they can be addressed later again...

Thanks
Guennadi
---
Guennadi Liakhovetski

diff --git a/arch/powerpc/kernel/prom_parse.c b/arch/powerpc/kernel/prom_parse.c
index 3786dcc..9caf96d 100644
--- a/arch/powerpc/kernel/prom_parse.c
+++ b/arch/powerpc/kernel/prom_parse.c
@@ -1067,3 +1067,49 @@ void __iomem *of_iomap(struct device_node *np, int index)
 	return ioremap(res.start, 1 + res.end - res.start);
 }
 EXPORT_SYMBOL(of_iomap);
+
+#ifdef CONFIG_I2C
+#include <linux/i2c.h>
+
+void of_register_i2c_devices(struct device_node *adap_node, int bus_num)
+{
+	struct device_node *node = NULL;
+
+	while ((node = of_get_next_child(adap_node, node))) {
+		struct i2c_board_info info;
+		const u32 *addr;
+		const char *name, *model;
+		int len;
+
+		addr = of_get_property(node, "reg", &len);
+		if (!addr || len < sizeof(int) || *addr > 0xffff)
+			continue;
+
+		info.irq = irq_of_parse_and_map(node, 0);
+		if (info.irq == NO_IRQ)
+			info.irq = -1;
+
+		name = of_get_property(node, "compatible", NULL);
+		if (!name)
+			name = node->name;
+		if (!name)
+			continue;
+
+		model = of_get_property(node, "model", NULL);
+		if (!model)
+			model = name;
+
+		/* FIXME: the i2c code should allow drivers to specify
+		 * multiple match names; board code shouldn't need to
+		 * know what driver will handle a given type.
+		 */
+
+		snprintf(info.driver_name, KOBJ_NAME_LEN, name);
+		snprintf(info.type, KOBJ_NAME_LEN, model);
+		info.platform_data = NULL;
+		info.addr = *addr;
+
+		i2c_register_board_info(bus_num, &info, 1);
+	}
+}
+#endif /* CONFIG_I2C */
diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
index c6b6898..a769efc 100644
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -327,9 +327,10 @@ static int fsl_i2c_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, i2c);
 
 	i2c->adap = mpc_ops;
+	i2c->adap.nr = pdev->id;
 	i2c_set_adapdata(&i2c->adap, i2c);
 	i2c->adap.dev.parent = &pdev->dev;
-	if ((result = i2c_add_adapter(&i2c->adap)) < 0) {
+	if ((result = i2c_add_numbered_adapter(&i2c->adap)) < 0) {
 		printk(KERN_ERR "i2c-mpc - failed to add adapter\n");
 		goto fail_add;
 	}
diff --git a/include/asm-powerpc/prom.h b/include/asm-powerpc/prom.h
index 6845af9..ed085e1 100644
--- a/include/asm-powerpc/prom.h
+++ b/include/asm-powerpc/prom.h
@@ -305,6 +305,7 @@ extern int of_irq_map_raw(struct device_node *parent, const u32 *intspec,
 			  u32 ointsize, const u32 *addr,
 			  struct of_irq *out_irq);
 
+void of_register_i2c_devices(struct device_node *adap_node, int bus_num);
 
 /**
  * of_irq_map_one - Resolve an interrupt for a device
