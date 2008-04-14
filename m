Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id BB7C6DDFF3
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Apr 2008 18:33:34 +1000 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 5/5] WDT driver
Date: Mon, 14 Apr 2008 10:33:27 +0200
References: <20080412134831.424480cf@lappy.seanm.ca>
	<20080412141146.3050e521@lappy.seanm.ca>
In-Reply-To: <20080412141146.3050e521@lappy.seanm.ca>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4430278.Ezm6H6ZhpW";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200804141033.29929.laurentp@cse-semaphore.com>
Cc: Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart4430278.Ezm6H6ZhpW
Content-Type: text/plain;
  charset="ansi_x3.4-1968"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 12 April 2008 20:11, Sean MacLennan wrote:
> Signed-off-by: Sean MacLennan <smaclennan@pikatech.com>
>=20
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 254d115..e73a3ea 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -697,6 +697,14 @@ config BOOKE_WDT
>  	  Please see Documentation/watchdog/watchdog-api.txt for
>  	  more information.
> =20
> +config PIKA_WDT
> +	tristate "PIKA FPGA Watchdog"
> +	depends on WARP
> +	default y
> +	help
> +	 This enables the watchdog in the PIKA FPGA. Currently used on
> +	 the Warp platform.
> +
>  # PPC64 Architecture
> =20
>  config WATCHDOG_RTAS
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index f3fb170..09758c5 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -105,6 +105,7 @@ obj-$(CONFIG_MPC5200_WDT) +=3D mpc5200_wdt.o
>  obj-$(CONFIG_83xx_WDT) +=3D mpc83xx_wdt.o
>  obj-$(CONFIG_MV64X60_WDT) +=3D mv64x60_wdt.o
>  obj-$(CONFIG_BOOKE_WDT) +=3D booke_wdt.o
> +obj-$(CONFIG_PIKA_WDT) +=3D pika_wdt.o
> =20
>  # PPC64 Architecture
>  obj-$(CONFIG_WATCHDOG_RTAS) +=3D wdrtas.o
> diff --git a/drivers/watchdog/pika_wdt.c b/drivers/watchdog/pika_wdt.c
> new file mode 100644
> index 0000000..b84ac07
> --- /dev/null
> +++ b/drivers/watchdog/pika_wdt.c
> @@ -0,0 +1,113 @@
> +/*
> + * PIKA FPGA based Watchdog Timer
> + *
> + * Copyright (c) 2008 PIKA Technologies
> + *   Sean MacLennan <smaclennan at pikatech.com>
> + */
> +
> +#include <linux/module.h>
> +#include <linux/fs.h>
> +#include <linux/miscdevice.h>
> +#include <linux/reboot.h>
> +#include <linux/uaccess.h>
> +#include <linux/io.h>
> +#include <linux/of_platform.h>
> +#include <linux/watchdog.h>
> +
> +
> +static void __iomem *pikawdt_fpga;
> +
> +
> +static inline void pikawdt_ping(void)
> +{
> +	unsigned reset =3D in_be32(pikawdt_fpga + 0x14);
> +	reset |=3D 0xf80; /* enable with max timeout - 15 seconds */
> +	out_be32(pikawdt_fpga + 0x14, reset);

What about

setbits32((u32 __iomem *)(pikawdt_fpga + 0x14), 0xf80);

> +}
> +
> +static int pikawdt_open(struct inode *inode, struct file *file)
> +{
> +	printk(KERN_INFO "PIKA WDT started...\n");
> +
> +	pikawdt_ping();
> +
> +	return 0;
> +}
> +
> +static int pikawdt_release(struct inode *inode, struct file *file)
> +{
> +	pikawdt_ping(); /* one last time */
> +	return 0;
> +}
> +
> +static ssize_t pikawdt_write(struct file *file, const char __user *buf,
> +			     size_t count, loff_t *ppos)
> +{
> +	pikawdt_ping();
> +	return count;
> +}
> +
> +/* We support the bare minimum to be conformant. */
> +static int pikawdt_ioctl(struct inode *inode, struct file *file,
> +			 unsigned int cmd, unsigned long arg)
> +{
> +	if (cmd =3D=3D WDIOC_KEEPALIVE) {
> +		pikawdt_ping();
> +		return 0;
> +	} else
> +		return -EINVAL;
> +}
> +
> +static const struct file_operations pikawdt_fops =3D {
> +	.owner		=3D THIS_MODULE,
> +	.open		=3D pikawdt_open,
> +	.release	=3D pikawdt_release,
> +	.write		=3D pikawdt_write,
> +	.ioctl		=3D pikawdt_ioctl,
> +};
> +
> +static struct miscdevice pikawdt_miscdev =3D {
> +	.minor	=3D WATCHDOG_MINOR,
> +	.name	=3D "watchdog",
> +	.fops	=3D &pikawdt_fops,
> +};
> +
> +static int __init pikawdt_init(void)
> +{
> +	struct device_node *np;
> +	int ret;
> +
> +	np =3D of_find_compatible_node(NULL, NULL, "pika,fpga");
> +	if (np =3D=3D NULL) {
> +		printk(KERN_ERR "pikawdt: Unable to find fpga.\n");
> +		return -ENOENT;
> +	}
> +
> +	pikawdt_fpga =3D of_iomap(np, 0);
> +
> +	of_node_put(np);
> +
> +	if (pikawdt_fpga =3D=3D NULL) {
> +		printk(KERN_ERR "pikawdt: Unable to map fpga.\n");
> +		return -ENOENT;
> +	}
> +
> +	ret =3D misc_register(&pikawdt_miscdev);
> +	if (ret) {
> +		iounmap(pikawdt_fpga);
> +		printk(KERN_ERR "pikawdt: Unable to register miscdev.\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +module_init(pikawdt_init);
> +
> +
> +static void __exit pikawdt_exit(void)
> +{
> +	misc_deregister(&pikawdt_miscdev);
> +
> +	iounmap(pikawdt_fpga);
> +}
> +module_exit(pikawdt_exit);
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>=20
>=20

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart4430278.Ezm6H6ZhpW
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBIAxbZ8y9gWxC9vpcRAn3oAJ0fl8DWG35+uH8xG501qME2bdLNvACdEben
bs3R0ztfcEBya832LuuDt7U=
=RX9r
-----END PGP SIGNATURE-----

--nextPart4430278.Ezm6H6ZhpW--
