Return-Path: <glikely@secretlab.ca>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179]) by ozlabs.org (Postfix) with ESMTP id D03E4B7D64
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 18 Jun 2010 02:37:54 +1000 (EST)
Received: by gyd10 with SMTP id 10so106720gyd.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 17 Jun 2010 09:37:52 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <6EAB45775B71486B8E72844E797E1D0F@kos>
References: <57F24E98919C4D22A784127E6CF1C9DA@kos>
	<AANLkTimArb-UjJMe84Qrd4iNquGHEehbGW1Uciq_zGYm@mail.gmail.com>
	<EBEDB9C789D344D9A8D459B6FCB1A0AD@kos>
	<AANLkTinBJgwL9qcw0Ouzuvc55C1Gs2KtIoY2NbBy34V2@mail.gmail.com>
	<162C87D14617439384076F797228B1EF@kos>
	<AANLkTim8kD9PH7BqOIV0GvElIfOgUDMw1VfWcOJhj-8r@mail.gmail.com>
	<6EAB45775B71486B8E72844E797E1D0F@kos>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 17 Jun 2010 10:37:32 -0600
Message-ID: <AANLkTilWdUcjK29QAJki75miWQt7Hzv8KWOXrtCvtPi8@mail.gmail.com>
Subject: Re: Porting a driver to powerpc using FDT
To: Chris Alfred <c.alfred@internode.on.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Chris, thanks for the write up.  Some comments below, and I'm also
in the process of writing better documentation for all of this.  You
can find it here:

http://devicetree.org/Device_Tree_Usage

That page describes how the device tree is structured.  I'm about to
start another page on how Linux uses the device tree.  That page
should cover the same topics that you describe below.

On Thu, Jun 17, 2010 at 5:11 AM, Chris Alfred <c.alfred@internode.on.net> w=
rote:
>> virtual-devices {
>> =A0 =A0 =A0 =A0 compatible =3D "simple-bus";
>> =A0 =A0 =A0 =A0 dsa {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "<vendor>,jkc5200n8-dsa";
>> =A0 =A0 =A0 =A0 };
>> };
>
> Ok, after correcting the names, the basic OF driver is probed.
>
> Now to try and use probe to register the DSA platform driver with the
> OF driver as its parent.
>
>
> =3D=3D=3D=3D=3D=3D=3D
>
> For those interested in how to get a very basic OF (uses FDT) driver
> going, the steps I did are below.
>
> 'myvendor' is your company name, and 'mydevice' is the name of the
> device - use better names in real code.
>
> (1) The .dts file - this is the Flattened Device Tree (FDT)
> descriptor:
>
> =A0 =A0/ {
> =A0 =A0 =A0 =A0...
>
> =A0 =A0 =A0 =A0 virtual-device {
> =A0 =A0 =A0 =A0 =A0compatible =3D "simple-bus";
> =A0 =A0 =A0 =A0 =A0mydevice0 {
> =A0 =A0 =A0 =A0 =A0 compatible =3D "myvendor,mydevice";
> =A0 =A0 =A0 =A0 =A0};
> =A0 =A0 =A0 =A0 };
>
> =A0 =A0 =A0 =A0...
> =A0 =A0};
>
> =A0 =A0For my board "simple-bus" is an already defined bus in the .dts.
> In my case the .dts had:

This comment raised warning flags for me.  Can you post your new
current device tree?  It sounds like you put your DSA device into the
localbus node.  You shouldn't need to do that.  Many nodes in a single
tree can claim compatibility with "simple-bus".

>
> =A0 =A0/ {
> =A0 =A0 =A0 =A0...
>
> =A0 =A0 =A0 =A0localbus {
> =A0 =A0 =A0 =A0 =A0compatible =3D
> "fsl,mpc5200b-lpb","fsl,mpc5200-lpb","simple-bus";
>
> =A0 =A0 =A0 =A0 =A0...
> =A0 =A0 =A0 =A0 };
>
> =A0 =A0 =A0 =A0...
> =A0 =A0};
>
> (2) Create the OF driver:
>
> =A0 =A0#include <linux/of.h>
> =A0 =A0#include <linux/kernel.h>
> =A0 =A0#include <linux/of_platform.h>
>
> =A0 =A0static int __devinit mydevice_probe(struct of_device *ofdev, const
> struct of_device_id *match)
> =A0 =A0{
> =A0 =A0 printk("mydevice_probe\n");
> =A0 =A0 return 0;
> =A0 =A0}
>
> =A0 =A0static int mydevice_remove(struct of_device *ofdev)

__devexit

> =A0 =A0{
> =A0 =A0 printk("mydevice_remove\n");
> =A0 =A0 return 0;
> =A0 =A0}
>
>
> =A0 =A0static const struct of_device_id mydevice_match[] =3D {
> =A0 =A0 {
> =A0 =A0 =A0.compatible =3D "myvendor,mydevice",
> =A0 =A0 },
> =A0 =A0 {}
> =A0 =A0};
>
> =A0 =A0static struct of_platform_driver mydevice_driver =3D {
> =A0 =A0 .name =3D "mydevice-driver",
> =A0 =A0 .match_table =3D mydevice_match,
> =A0 =A0 .probe =3D mydevice_probe,
> =A0 =A0 .remove =3D mydevice_remove,
> =A0 =A0};

.remove =3D __devexit_P(mydevice_remove),

>
> =A0 =A0static int __init mydevice_driver_init(void)
> =A0 =A0{
> =A0 =A0 printk("mydevice_drver_init\n");
>
> =A0 =A0 if (of_register_platform_driver(&mydevice_driver))
> =A0 =A0 =A0printk(KERN_ERR "Unable to register platform driver\n");
>
> =A0 =A0 return 0;
> =A0 =A0}
> =A0 =A0module_init(mydevice_driver_init);

Should actually be:
    static int __init mydevice_driver_init(void)
    {
     printk("mydevice_drver_init\n");
     return of_register_platform_driver(&mydevice_driver);
    }
    module_init(mydevice_driver_init);

The driver core will report an error if registration fails.

>
> =A0 =A0static void __exit mydevice_driver_cleanup(void)
> =A0 =A0{
> =A0 =A0 printk("mydevice_driver_cleanup\n");
>
> =A0 =A0 of_unregister_platform_driver(&mydevice_driver);
> =A0 =A0}
> =A0 =A0module_exit(mydevice_driver_cleanup);
>
> =A0 =A0MODULE_DESCRIPTION("mydevice driver");
> =A0 =A0MODULE_AUTHOR("name <email>");
> =A0 =A0MODULE_LICENSE("GPL v2");
> =A0 =A0MODULE_ALIAS("platform:mydevice-driver");
>
> (3) Change the appropriate Makefile and Kconfig to compile the OF
> driver.
>
> During kernel boot you should see the lines:
>
> =A0 =A0mydevice_driver_init
> =A0 =A0mydevice_probe
>
> If not, you probably have one of the strings (text in " ") incorrect.
>
> In /sys/bus/of_platform/drivers, you should have a directory named
> 'mydevice-driver'.
>
> In /sys/bus/of_platform/drivers/mydevice-driver you should have a
> directory named 'mydevice0.1'. The name 'mydevice0' comes from the
> .dts above.

which will be a symlink to the actual device location in the internal
Linux device hierarchy.

>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Brief explaination of how I think this is all tied together:
>
> (1) The Flattened Device Tree is included with the compiled kernel
> image.

Generally not.  Usually the device tree is passed in via u-boot.
There is a form (cuImage) that links the dtb into the kernel, but that
is not recommended, and is only used for supporting old version of
u-boot that cannot pass the dtb at boot.

> (2) The module_init(...) macro is like declaring a 'main' for drivers.
> The kernel calls all of the functions declared in the module_init(...)
> macros during startup.

yes.

> (3) When a device driver is registered via
> of_register_platform_driver(), this invokes a scan of the FDT to find
> matches with strings in the .match_table. If a match is found, the
> .probe is called for the created device instance.

Not quite.  Registering drivers does not cause a scan of the DT.
Instead, it looks in the list of registered devices to see if there is
anything to bind against.  The devices are actually registered at boot
time in the function of_platform_bus_probe() which on the mpc5200 is
called by the function mpc52xx_declare_of_platform_devices().

Drivers won't bind against anything that isn't already registered as a
device in the Linux device model.

Cheers,
g.
