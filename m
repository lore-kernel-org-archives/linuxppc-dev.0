Return-Path: <michael@ellerman.id.au>
Subject: Re: Getting the IRQ number (Was: Basic driver devel questions ?)
From: Michael Ellerman <michael@ellerman.id.au>
To: Guillaume Dargaud <dargaud@lpsc.in2p3.fr>
In-Reply-To: <201012081118.13977.dargaud@lpsc.in2p3.fr>
References: <201012011115.00960.dargaud@lpsc.in2p3.fr>
	<201012061544.40124.dargaud@lpsc.in2p3.fr>
	<1291770234.2041.102.camel@concordia>
	<201012081118.13977.dargaud@lpsc.in2p3.fr>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-5ZZ0M5nJqYZQw/u6nI/R"
Date: Thu, 09 Dec 2010 00:45:10 +1100
Message-ID: <1291815910.12093.15.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-5ZZ0M5nJqYZQw/u6nI/R
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2010-12-08 at 11:18 +0100, Guillaume Dargaud wrote:
> Thanks again for your detailed answer,
> I'm learning, but not as fast as my colleagues with a deadline want me to=
 !

:)

> > The platform code does that. That function create devices on the
> > platform bus by examining the device tree. It looks for nodes that are
> > compatible with the compatible strings you give it, and treats them as
> > busses, ie. creates devices for all child nodes of those nodes.
>=20
> Is there a way to enable some debug output from it, to see what's going o=
n ?

Not really, but there probably should be.

> > > ...hmm I had to "git pull" in order for this to compile your snippet.
> > > That's really recent! Unfortunately i need to reflash my device with =
the
> > > new kernel before i can begin testing my module.
> >=20
> > It shouldn't be that recent, what kernel version were you using?
>=20
> I had to go from 2.6.34 to 2.6.35, xilinx git tree.

Ah that is the problem I think.

Sorry I assumed you were working on mainline. In 2.6.35 you still need
to use an of_platform_driver, I'll describe below.

> > platform_device_register() tends to be for cases where you can't
> > discover or probe a device, but you "know" that it exists.
>=20
> When you see something in /sys/devices/plb.0/, it means that you don't ne=
ed=20
> platform_device_register, right ?

That's right.

> > Yes, "make tags", then use vim :)
>=20
> Great, that works.

Cool.

> OK, here's the relevant part of my code, ripped directly from your sample=
,=20
> with a few additions and different variable names. Why do you think=20
> xad_driver_probe() is not being called ?

As I said above in 2.6.35 platform drivers and of_platform drivers were
still separate. So your device is on the of_platform_bus (ie. was
discovered using the device tree), but your driver is on the
platform_bus. Yes this is very confusing.

So basically you need to change all occurrences of platform_driver to
of_platform_driver.

> #include <linux/kernel.h>
> #include <linux/init.h>
> #include <asm/device.h>
> #include <linux/platform_device.h>
> #include <linux/cdev.h>         // char device
> #include <linux/fs.h>
> #include <linux/of.h>
> #include <linux/interrupt.h>
>=20
> #define DEVNAME "xps-acqui-data"
> #define NAME "xad"              // This is only used for printk
>=20
> #define SD "{%s %d} "
> #define FL , __func__, __LINE__
>=20
> static dev_t first;
> static unsigned int count =3D 1;
> static int my_major =3D 241, my_minor =3D 0;
> // You must run "mknod /dev/xad c 241 0" in a shell at least once
>=20
> struct cdev *my_cdev=3DNULL;
> struct platform_device *pdev=3DNULL;
>=20
> typedef struct XadDevice {
>   struct resource *hw_region;
>   struct device *dev;
>   int irq;
> } tXadDevice;
> tXadDevice Xad;
>=20
> // There should be something in:
> // ll /sys/devices/plb.0/c9800000.xps-acqui-data
> static const struct of_device_id xad_device_id[] =3D {                   =
   =20
>         { .compatible     =3D "xlnx,xps-acqui-data-3.00.a" },     // Must=
 match=20
> the DTS
>         {}
> };
>=20
>  =20
> static irqreturn_t XadIsr(int irq, void *dev_id) {
>   printk(KERN_INFO SD "IRQ:%d\n" FL, irq);
>   return IRQ_HANDLED;
> }
>=20
> /////////////////////////////////////////////////////////////////////////=
//////
> // Platform Bus Support
> /////////////////////////////////////////////////////////////////////////=
//////
>=20
> static int  xad_driver_probe(struct platform_device *device /*,
>                             const struct of_device_id *device_id*/ ) {

So you need to switch the prototype here to:

static int xad_driver_probe(struct of_platform_device *ofdev,
                            const struct of_device_id *device_id) {

>   struct device_node *dn =3D device->dev.of_node;
>   int rc;
>=20
>   pr_devel("Probing %s\n", dn->full_name);
>  =20
>   Xad.irq =3D irq_of_parse_and_map(dn, 0);
>   rc=3Drequest_irq(Xad.irq, XadIsr, IRQF_TRIGGER_RISING  | IRQF_DISABLED,=
=20
> "XadIsr", &Xad);
>   if (rc) printk(KERN_INFO SD "Failled IRQ request: %d\n" FL, rc);
>  =20
>   return 0;
> }
>=20
> static int __devexit xad_driver_remove(struct platform_device *device) {
>   printk(KERN_INFO SD "Removing...\n" FL);
>   return 0;
> }
>=20
> static struct platform_driver xad_driver =3D {

Becomes of_platform_driver

>   .probe  =3D xad_driver_probe,
>   .remove =3D xad_driver_remove,
>   .driver =3D {
>     .owner =3D THIS_MODULE,
>     .name =3D "xad-driver",
>         .of_match_table =3D xad_device_id,
>   },
> };
>=20
>=20
> /////////////////////////////////////////////////////////////////////////=
//////
> // This section deals with the /dev/xad device
> /////////////////////////////////////////////////////////////////////////=
//////
> static int xad_open(struct inode *node, struct file *filep) {
>   printk (KERN_INFO SD "OPENING device: %s\n" FL, NAME);
>   return 0;
> }
>=20
> static int xad_release(struct inode *node, struct file *filep) {
>   printk (KERN_INFO SD "RELEASING device: %s\n" FL, NAME);
>   return 0;
> }
>=20
> static int  xad_ioctl(struct inode *node, struct file *filep, unsigned in=
t cmd,=20
> unsigned long arg) {
>   printk (KERN_INFO SD "IOCTL on device: %s, cmd:%d, arg:%lu\n" FL, NAME,=
 cmd,=20
> arg);
>   return 0;
> }
>=20
> static struct file_operations fops =3D {
>   .owner   =3D THIS_MODULE,
>   .open    =3D xad_open,
>   .release =3D xad_release,
>   .ioctl   =3D xad_ioctl,
> };
>=20
>=20
> /////////////////////////////////////////////////////////////////////////=
//////
> // Called on insmod
> static int __init xad_init(void) {
>   int rc=3D0;
>   printk(KERN_INFO SD "Module %s: loading...\n" FL, NAME);
>  =20
>   // Deal with the device
>   first =3D MKDEV (my_major, my_minor);
>   register_chrdev_region(first, count, DEVNAME);
>   my_cdev =3D cdev_alloc ();
>   if (NULL=3D=3Dmy_cdev) goto Err;
>  =20
>   cdev_init(my_cdev, &fops);
>   cdev_add (my_cdev, first, count);
>=20
>   printk(KERN_INFO SD "Module %s: Major=3D%d, Minor=3D%d, Count=3D%d\n" F=
L, NAME,=20
> my_major, my_minor, count);
>=20
>   // Driver
>   rc =3D platform_driver_register(&xad_driver);

Should be of_register_platform_driver()

> //  rc =3D platform_driver_probe(&xad_driver, xad_driver_probe);
>   if (rc) goto err_plat;
>=20
>   // Device
>   pdev=3Dplatform_device_register_simple("xps-acqui-data", -1, NULL, 0);
>   if (IS_ERR(pdev)) {
>           rc =3D PTR_ERR(pdev);
>           platform_driver_unregister(&xad_driver);
>           goto err_plat;
>   }
>=20
>=20
>   return 0;
>=20
> err_plat:
>   unregister_chrdev_region(first, count);
> Err:
>   printk(KERN_ERR SD "Module %s: Failed loading rc=3D%d\n" FL, NAME, rc);
>   return rc;
> }
>=20
> /////////////////////////////////////////////////////////////////////////=
//////
> // Called on rmmod
> static void xad_exit(void) {
>   platform_device_unregister(pdev); pdev=3DNULL;
>   platform_driver_unregister(&xad_driver);
>  =20
>   cdev_del (my_cdev); my_cdev=3DNULL;
>   unregister_chrdev_region (first, count);
>   printk(KERN_INFO SD "Module %s unloaded\n" FL, NAME);
> }
>=20
> module_init(xad_init);
> module_exit(xad_exit);
>=20
> MODULE_AUTHOR("Guillaume Dargaud");
> MODULE_LICENSE("GPL");
>=20
>=20

cheers


--=-5ZZ0M5nJqYZQw/u6nI/R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkz/i9wACgkQdSjSd0sB4dK/NQCdGcPPNF2mb+bIyNsjrs9yshGT
5FMAoL7GeuYcG+4UKQaRTNcwAxMx+MhQ
=gUeM
-----END PGP SIGNATURE-----

--=-5ZZ0M5nJqYZQw/u6nI/R--
