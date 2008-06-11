Return-Path: <jonsmirl@gmail.com>
Message-ID: <9e4733910806110914v2fb9e4a3o3736663bd54a03cd@mail.gmail.com>
Date: Wed, 11 Jun 2008 12:14:08 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Wolfram Sang" <w.sang@pengutronix.de>
Subject: Re: [i2c] [PATCH] Convert i2c-mpc from a platform driver to an
	of_platform one
In-Reply-To: <20080611160048.GB4257@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910806101940o7f2f9863jb5e556ee2fc39a7e@mail.gmail.com>
	<20080611160048.GB4257@pengutronix.de>
Cc: linuxppc-dev list <Linuxppc-dev@ozlabs.org>, Linux I2C <i2c@lm-sensors.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 6/11/08, Wolfram Sang <w.sang@pengutronix.de> wrote:
> On Tue, Jun 10, 2008 at 10:40:45PM -0400, Jon Smirl wrote:
>  > Convert i2c-mpc from a platform driver into an of_platform driver.
>  > This patch is much smaller since Jochen already added
>  > of_find_i2c_driver(). Versions of this have been posted before.
>  >
>  > Signed-ff-by: Jon Smirl <jonsmirl@gmail.com>
>
>
> Typo: Signed-off... (I'm curious, do such typos enforce resending the
>  patch?)


I just cut and pasted this version to get the comments. Next pass I
will send it using stgit which will add the right signed-off line and
fix the wrapping.


>
>  Tested-by: Wolfram Sang <w.sang@pengutronix.de>
>
>
>  >
>  > --
>  >
>  >  drivers/i2c/busses/i2c-mpc.c |  105 +++++++++++++++++++++++++-----------------
>  >  1 files changed, 63 insertions(+), 42 deletions(-)
>  >
>  >
>  > diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
>  > index a076129..76d8091 100644
>  > --- a/drivers/i2c/busses/i2c-mpc.c
>  > +++ b/drivers/i2c/busses/i2c-mpc.c
>  > @@ -18,6 +18,8 @@
>  >  #include <linux/sched.h>
>  >  #include <linux/init.h>
>  >  #include <linux/platform_device.h>
>  > +#include <linux/of_platform.h>
>  > +#include <linux/of_i2c.h>
>  >
>  >  #include <asm/io.h>
>  >  #include <linux/fsl_devices.h>
>  > @@ -25,13 +27,13 @@
>  >  #include <linux/interrupt.h>
>  >  #include <linux/delay.h>
>  >
>  > -#define MPC_I2C_ADDR  0x00
>  > +#define DRV_NAME "mpc-i2c"
>  > +
>  >  #define MPC_I2C_FDR  0x04
>  >  #define MPC_I2C_CR   0x08
>  >  #define MPC_I2C_SR   0x0c
>  >  #define MPC_I2C_DR   0x10
>  >  #define MPC_I2C_DFSRR 0x14
>  > -#define MPC_I2C_REGION 0x20
>  >
>  >  #define CCR_MEN  0x80
>  >  #define CCR_MIEN 0x40
>  > @@ -315,102 +317,121 @@ static struct i2c_adapter mpc_ops = {
>  >       .timeout = 1,
>  >  };
>  >
>  > -static int fsl_i2c_probe(struct platform_device *pdev)
>  > +static int fsl_i2c_probe(struct of_device *op, const struct
>  > of_device_id *match)
>
>
> The above two lines have to be concatenated, otherwise the patch will
>  not apply. Also, __devinit?
>
>
>  >  {
>  >       int result = 0;
>  >       struct mpc_i2c *i2c;
>  > -     struct fsl_i2c_platform_data *pdata;
>  > -     struct resource *r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  > -
>  > -     pdata = (struct fsl_i2c_platform_data *) pdev->dev.platform_data;
>  >
>  >       i2c = kzalloc(sizeof(*i2c), GFP_KERNEL);
>  >       if (!i2c)
>  >               return -ENOMEM;
>  >
>  > -     i2c->irq = platform_get_irq(pdev, 0);
>  > -     if (i2c->irq < 0)
>  > -             i2c->irq = NO_IRQ; /* Use polling */
>  > +     if (of_get_property(op->node, "dfsrr", NULL))
>  > +             i2c->flags |= FSL_I2C_DEV_SEPARATE_DFSRR;
>  >
>  > -     i2c->flags = pdata->device_flags;
>  > -     init_waitqueue_head(&i2c->queue);
>  > +     if (of_device_is_compatible(op->node, "mpc5200-i2c"))
>  > +             i2c->flags |= FSL_I2C_DEV_CLOCK_5200;
>  >
>  > -     i2c->base = ioremap((phys_addr_t)r->start, MPC_I2C_REGION);
>  > +     init_waitqueue_head(&i2c->queue);
>  >
>  > +     i2c->base = of_iomap(op->node, 0);
>  >       if (!i2c->base) {
>  >               printk(KERN_ERR "i2c-mpc - failed to map controller\n");
>  >               result = -ENOMEM;
>  >               goto fail_map;
>  >       }
>  >
>  > -     if (i2c->irq != NO_IRQ)
>  > -             if ((result = request_irq(i2c->irq, mpc_i2c_isr,
>  > -                                       IRQF_SHARED, "i2c-mpc", i2c)) < 0) {
>  > -                     printk(KERN_ERR
>  > -                            "i2c-mpc - failed to attach interrupt\n");
>  > -                     goto fail_irq;
>  > -             }
>  > +     i2c->irq = irq_of_parse_and_map(op->node, 0);
>  > +     if (i2c->irq == NO_IRQ) {
>  > +             result = -ENXIO;
>
>
> Minor thing, but I wonder if -EINVAL is more appropriate?
>
>
>  > +             goto fail_irq;
>  > +     }
>  > +
>  > +     result = request_irq(i2c->irq, mpc_i2c_isr,
>  > +                                             IRQF_SHARED, "i2c-mpc", i2c);
>  > +     if (result < 0) {
>  > +             printk(KERN_ERR "i2c-mpc - failed to attach interrupt\n");
>  > +             goto fail_request;
>  > +     }
>  >
>  >       mpc_i2c_setclock(i2c);
>  > -     platform_set_drvdata(pdev, i2c);
>  > +
>  > +     dev_set_drvdata(&op->dev, i2c);
>  >
>  >       i2c->adap = mpc_ops;
>  > -     i2c->adap.nr = pdev->id;
>  >       i2c_set_adapdata(&i2c->adap, i2c);
>  > -     i2c->adap.dev.parent = &pdev->dev;
>  > -     if ((result = i2c_add_numbered_adapter(&i2c->adap)) < 0) {
>  > +     i2c->adap.dev.parent = &op->dev;
>  > +
>  > +     result = i2c_add_adapter(&i2c->adap);
>  > +     if (result < 0) {
>  >               printk(KERN_ERR "i2c-mpc - failed to add adapter\n");
>  >               goto fail_add;
>  >       }
>  > +     of_register_i2c_devices(&i2c->adap, op->node);
>  >
>  >       return result;
>  >
>  > -      fail_add:
>  > -     if (i2c->irq != NO_IRQ)
>  > -             free_irq(i2c->irq, i2c);
>  > -      fail_irq:
>  > + fail_add:
>  > +     dev_set_drvdata(&op->dev, NULL);
>  > +     free_irq(i2c->irq, i2c);
>  > + fail_request:
>  > +     irq_dispose_mapping(i2c->irq);
>  > + fail_irq:
>  >       iounmap(i2c->base);
>  > -      fail_map:
>  > + fail_map:
>  >       kfree(i2c);
>  >       return result;
>  >  };
>  >
>  > -static int fsl_i2c_remove(struct platform_device *pdev)
>  > +static int fsl_i2c_remove(struct of_device *op)
>
>
> __devexit?
>
>
>  >  {
>  > -     struct mpc_i2c *i2c = platform_get_drvdata(pdev);
>  > +     struct mpc_i2c *i2c = dev_get_drvdata(&op->dev);
>  >
>  >       i2c_del_adapter(&i2c->adap);
>  > -     platform_set_drvdata(pdev, NULL);
>  > +     dev_set_drvdata(&op->dev, NULL);
>  >
>  >       if (i2c->irq != NO_IRQ)
>  >               free_irq(i2c->irq, i2c);
>  >
>  > +     irq_dispose_mapping(i2c->irq);
>  >       iounmap(i2c->base);
>  >       kfree(i2c);
>  >       return 0;
>  >  };
>  >
>  > -/* work with hotplug and coldplug */
>  > -MODULE_ALIAS("platform:fsl-i2c");
>  > +static const struct of_device_id mpc_i2c_of_match[] = {
>  > +     {
>  > +             .compatible     = "fsl-i2c",
>  > +     },
>  > +     {},
>  > +};
>  > +MODULE_DEVICE_TABLE(of, mpc_i2c_of_match);
>  > +
>  >
>  >  /* Structure for a device driver */
>  > -static struct platform_driver fsl_i2c_driver = {
>  > -     .probe = fsl_i2c_probe,
>  > -     .remove = fsl_i2c_remove,
>  > -     .driver = {
>  > -             .owner = THIS_MODULE,
>  > -             .name = "fsl-i2c",
>  > +static struct of_platform_driver mpc_i2c_driver = {
>  > +     .match_table    = mpc_i2c_of_match,
>  > +     .probe          = fsl_i2c_probe,
>  > +     .remove         = __devexit_p(fsl_i2c_remove),
>  > +     .driver         = {
>  > +             .owner  = THIS_MODULE,
>  > +             .name   = DRV_NAME,
>  >       },
>  >  };
>  >
>  >  static int __init fsl_i2c_init(void)
>  >  {
>  > -     return platform_driver_register(&fsl_i2c_driver);
>  > +     int rv;
>  > +
>  > +     rv = of_register_platform_driver(&mpc_i2c_driver);
>  > +     if (rv)
>  > +             printk(KERN_ERR DRV_NAME " of_register_platform_driver failed (%i)\n", rv);
>  > +     return rv;
>  >  }
>  >
>  >  static void __exit fsl_i2c_exit(void)
>  >  {
>  > -     platform_driver_unregister(&fsl_i2c_driver);
>  > +     of_unregister_platform_driver(&mpc_i2c_driver);
>  >  }
>  >
>  >  module_init(fsl_i2c_init);
>  >
>
> > _______________________________________________
>  > i2c mailing list
>  > i2c@lm-sensors.org
>  > http://lists.lm-sensors.org/mailman/listinfo/i2c
>
>  Kind regards,
>
>    Wolfram
>
>
>  --
>   Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
>   Pengutronix - Linux Solutions for Science and Industry
>
> -----BEGIN PGP SIGNATURE-----
>  Version: GnuPG v1.4.6 (GNU/Linux)
>
>  iD8DBQFIT/awD27XaX1/VRsRAoPrAJ0eWru6TJizVxfksnhS3KjZ7WHhmACcCbXJ
>  YsAUtKZSxlJAV5r/G22BlaE=
>  =YX24
>  -----END PGP SIGNATURE-----
>
>
>


-- 
Jon Smirl
jonsmirl@gmail.com
