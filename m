Return-Path: <jonsmirl@gmail.com>
Message-ID: <9e4733910711111716oea3572fq9bc42221f805e11@mail.gmail.com>
Date: Sun, 11 Nov 2007 20:16:43 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: benh@kernel.crashing.org
Subject: Re: Gianfar ethernet device
In-Reply-To: <1194829680.18185.10.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910711111511v36aa3504s3b55438698a4b4a8@mail.gmail.com>
	<9e4733910711111530g1f50d6e6hfaa76b4f051b5887@mail.gmail.com>
	<1194825876.18185.3.camel@pasglop>
	<9e4733910711111622v5ad6fdd2jd30989819d05615d@mail.gmail.com>
	<1194829680.18185.10.camel@pasglop>
Cc: PowerPC dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 11/11/07, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
> > The real solution is that gianfar support belongs in a device driver,
> > not in a common file. That whole fsl_soc.c file is a catch-all of
> > things that belong in device drivers. I haven't looked at every line
> > in it, but 90%+ of the code should be moved into device drivers.
> >
> > I'm preparing a patch that moves the i2c driver out of fsl_soc.c and
> > into i2c_mpc.c.
>
> The problem is how do you instantiate it. I'm working on some solution
> for that but it's not there yet.

Are there powerpc platforms without device trees?

Standard of_platform driver works fine to instantiate the i2c driver
on mpc5200.

static struct of_device_id mpc_i2c_of_match[] = {
	{
		.compatible	= "fsl-i2c",
	},
};
MODULE_DEVICE_TABLE(of, mpc_i2c_of_match);

/* Structure for a device driver */
static struct of_platform_driver mpc_i2c_driver = {
	.match_table	= mpc_i2c_of_match,
	.probe		= mpc_i2c_probe,
	.remove		= __devexit_p(mpc_i2c_remove),
	.driver		= {
		.owner	= THIS_MODULE,
		.name	= DRV_NAME,
	},
};

static int __init mpc_i2c_init(void)
{
	int rv;

	rv = of_register_platform_driver(&mpc_i2c_driver);
	if (rv) {
		printk(KERN_ERR DRV_NAME " of_register_platform_driver failed (%i)\n", rv);
		return rv;
	}
	return 0;
}

module_init(mpc_i2c_init);

----------------------------------------------------------------------------------------------

i2c and alsa soc core instantiate like this, asoc v2 is not in tree
yet. These cores used to create platform drivers, but that was wrong,
they don't have any hardware associated with them.

static int __init i2c_init(void)
{
	int retval;

	retval = bus_register(&i2c_bus_type);
	if (retval)
		return retval;
	return class_register(&i2c_adapter_class);
}

subsys_initcall(i2c_init);

-- 
Jon Smirl
jonsmirl@gmail.com
