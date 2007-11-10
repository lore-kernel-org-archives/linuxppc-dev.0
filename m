Return-Path: <jonsmirl@gmail.com>
Message-ID: <9e4733910711101516n64870e40rbd1fcbe3d123fcc3@mail.gmail.com>
Date: Sat, 10 Nov 2007 18:16:12 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Subject: Re: IRQs in i2c-mpc.c
In-Reply-To: <3DBBAC12-579B-4C1F-9C9E-D085FB22B687@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910711101144r3f8745dbs572aefa8658e1312@mail.gmail.com>
	<3DBBAC12-579B-4C1F-9C9E-D085FB22B687@kernel.crashing.org>
Cc: PowerPC dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 11/10/07, Kumar Gala <galak@kernel.crashing.org> wrote:
> Looking at the current driver it looks like we could get ride of if
> check since the previous code checked the return of platform_get_irq().

The code was a snippet from the larger patch that is converting i2c
from being a platform driver to a of_platform driver.

The question is, what to do about a missing IRQ tag in the device tree
or a IRQ of zero. What is an error and what should be ignored, etc.

+static int mpc_i2c_probe(struct of_device *op, const struct
of_device_id *match)
 {
 	int result = 0;
 	struct mpc_i2c *i2c;
-	struct fsl_i2c_platform_data *pdata;
-	struct resource *r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-
-	pdata = (struct fsl_i2c_platform_data *) pdev->dev.platform_data;

 	if (!(i2c = kzalloc(sizeof(*i2c), GFP_KERNEL))) {
 		return -ENOMEM;
 	}

-	i2c->irq = platform_get_irq(pdev, 0);
-	if (i2c->irq < 0) {
-		result = -ENXIO;
-		goto fail_get_irq;
-	}
-	i2c->flags = pdata->device_flags;
-	init_waitqueue_head(&i2c->queue);
+	if (of_get_property(op->node, "dfsrr", NULL))
+		i2c->flags |= FSL_I2C_DEV_SEPARATE_DFSRR;

-	i2c->base = ioremap((phys_addr_t)r->start, MPC_I2C_REGION);
+	if (of_device_is_compatible(op->node, "mpc5200-i2c"))
+		i2c->flags |= FSL_I2C_DEV_CLOCK_5200;

+	init_waitqueue_head(&i2c->queue);
+
+	i2c->base = of_iomap(op->node, 0);
 	if (!i2c->base) {
 		printk(KERN_ERR "i2c-mpc - failed to map controller\n");
 		result = -ENOMEM;
 		goto fail_map;
 	}

+	i2c->irq = irq_of_parse_and_map(op->node, 0);
+	if (i2c->irq < 0) {
+		result = -ENXIO;
+		goto fail_irq;
+	}
+	
 	if (i2c->irq != 0)
 		if ((result = request_irq(i2c->irq, mpc_i2c_isr,
-					  IRQF_SHARED, "i2c-mpc", i2c)) < 0) {
-			printk(KERN_ERR
-			       "i2c-mpc - failed to attach interrupt\n");
+					  	IRQF_SHARED, "i2c-mpc", i2c)) < 0) {
+			printk(KERN_ERR "i2c-mpc - failed to attach interrupt\n");
 			goto fail_irq;
 		}

 	mpc_i2c_setclock(i2c);
-	platform_set_drvdata(pdev, i2c);
+	
+	dev_set_drvdata(&op->dev, i2c);

 	i2c->adap = mpc_ops;
-	i2c->adap.nr = pdev->id;
 	i2c_set_adapdata(&i2c->adap, i2c);
-	i2c->adap.dev.parent = &pdev->dev;
-	if ((result = i2c_add_numbered_adapter(&i2c->adap)) < 0) {
+	i2c->adap.dev.parent = &op->dev;
+	if ((result = i2c_add_adapter(&i2c->adap)) < 0) {
 		printk(KERN_ERR "i2c-mpc - failed to add adapter\n");
 		goto fail_add;
 	}
+	
+	of_register_i2c_devices(&i2c->adap, op->node);

 	return result;

-      fail_add:
+fail_add:
 	if (i2c->irq != 0)
 		free_irq(i2c->irq, i2c);
-      fail_irq:
+fail_irq:
 	iounmap(i2c->base);
-      fail_map:
-      fail_get_irq:
+fail_map:
 	kfree(i2c);
 	return result;
 };



-- 
Jon Smirl
jonsmirl@gmail.com
