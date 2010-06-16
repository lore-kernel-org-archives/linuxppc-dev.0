Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179]) by ozlabs.org (Postfix) with ESMTP id 6C878B7D84
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 17 Jun 2010 08:43:42 +1000 (EST)
Received: by gxk5 with SMTP id 5so1356828gxk.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 16 Jun 2010 15:43:39 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <EBEDB9C789D344D9A8D459B6FCB1A0AD@kos>
References: <57F24E98919C4D22A784127E6CF1C9DA@kos>
	<AANLkTimArb-UjJMe84Qrd4iNquGHEehbGW1Uciq_zGYm@mail.gmail.com>
	<EBEDB9C789D344D9A8D459B6FCB1A0AD@kos>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 16 Jun 2010 16:43:19 -0600
Message-ID: <AANLkTinBJgwL9qcw0Ouzuvc55C1Gs2KtIoY2NbBy34V2@mail.gmail.com>
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

On Wed, Jun 16, 2010 at 4:06 PM, Chris Alfred <c.alfred@internode.on.net> w=
rote:
> Grant Likely wrote:
>> On Tue, Jun 15, 2010 at 4:19 PM, Chris Alfred
>> <c.alfred@internode.on.net> wrote:
>>> I am trying to port a DSA (Distributed Switch Architecture) driver
>>> for the Micrel KS8995M managed switch connected to a MPC5200. There
>>> is an SPI interface and MII interface managed by the DSA driver.
>>>
>>> I can't understand how probe gets called when the flatted device
>>> tree
>>> (FDT) system is used, and how to bind such a driver using the FDT
>>> (if
>>> you have to at all).
>>>
>>> The DSA driver is initialised via:
>>>
>>> // net/dsa/dsa.c
>>>
>>> static struct platform_driver dsa_driver =3D {
>>> .probe =3D dsa_probe,
>>> .remove =3D dsa_remove,
>>> .shutdown =3D dsa_shutdown,
>>> .driver =3D {
>>> .name =3D "dsa",
>>> .owner =3D THIS_MODULE,
>>> },
>>> };
>>>
>>> static int __init dsa_init_module(void)
>>> {
>>> return platform_driver_register(&dsa_driver);
>>> }
>>>
>>> dsa_init_module is being called; but how do I get the system to
>>> call
>>> .probe?
>>
>> To avoid writing new machine-specific code in
>> arch/powerpc/platforms,
>> then I recommend that you add a node to your .dts file to describe
>> the
>> DSA complex and write a very simple of_platform_driver that binds
>> against it. =A0Then use the probe hook to extract data out of the
>> device
>> tree node (if needed) and register the appropriate platform_device
>> (don't forget to make the of_device the parent of the
>> platform_device). =A0This can be considered a temporary solution, but
>> it
>> will not break when I make the infrastructure changes, and then you
>> can migrate over to the new method at your leisure.
>
>
> Thanks for the great response.
>
> I still have some learning to do. To start, I tried to get a simple
> of_platform_driver going.
> In my .dts I added:
>
> =A0 =A0/ {
> =A0 =A0 =A0 =A0...
> =A0 =A0 =A0 =A0 dsa {
> =A0 =A0 =A0 =A0 =A0compatible =3D "dsa-of";

This is too generic.  Until there is a real generic binding for DSA
devices, use a name specific to your board.  An of driver can bind to
more than one compatible value.  Don't forget to include the vendor
prefix in your compatible value.

> =A0 =A0 =A0 =A0 =A0reg =3D <0 0>; =A0 // TODO: might need config values e=
.g. number
> of phys, cpu port

Just drop this property until you have real data to populate it with.
For a virtual device like this you probably don't need a reg property.
 What you probably do need in this node is references (phandles) to
the node for the marvel switch which I imagine hangs off of an MDIO or
SPI bus.

> =A0 =A0 =A0 =A0 };
> =A0 =A0 =A0 =A0...
> =A0 =A0};
>
> I created net/dsa/dsa_of.c - the simple of_platform_driver that will
> bind to the DSA platform driver (in net/dsa/dsa.c):
>
> =A0 =A0#include <linux/of.h>
> =A0 =A0#include <linux/kernel.h>
> =A0 =A0#include <linux/of_platform.h>
>
> =A0 =A0static int __devinit dsa_of_probe(struct of_device *ofdev, const
> struct of_device_id *match)
> =A0 =A0{
> =A0 =A0 printk("dsa_of_probe\n");
> =A0 =A0 return 0;
> =A0 =A0}
>
> =A0 =A0static int dsa_of_remove(struct of_device *ofdev)
> =A0 =A0{
> =A0 =A0 printk("dsa_of_remove\n");
> =A0 =A0 return 0;
> =A0 =A0}
>
>
> =A0 =A0static const struct of_device_id dsa_of_match[] =3D {
> =A0 =A0 {
> =A0 =A0 =A0.compatible =3D "dsa-of",
> =A0 =A0 },
> =A0 =A0 {}
> =A0 =A0};
>
> =A0 =A0static struct of_platform_driver dsa_of_driver =3D {
> =A0 =A0 .name =3D "dsa-of",
> =A0 =A0 .match_table =3D dsa_of_match,
> =A0 =A0 .probe =3D dsa_of_probe,
> =A0 =A0 .remove =3D dsa_of_remove,
> =A0 =A0};
>
> =A0 =A0static int __init dsa_of_init(void)
> =A0 =A0{
> =A0 =A0 printk("dsa_of_init\n");
>
> =A0 =A0 if (of_register_platform_driver(&dsa_of_driver))
> =A0 =A0 =A0printk(KERN_ERR "Unable to register DSA OF platform driver\n")=
;
>
> =A0 =A0 return 0;
> =A0 =A0}
> =A0 =A0module_init(dsa_of_init);
>
> =A0 =A0static void __exit dsa_of_cleanup(void)
> =A0 =A0{
> =A0 =A0 printk("dsa_of_cleanup\n");
>
> =A0 =A0 of_unregister_platform_driver(&dsa_of_driver);
> =A0 =A0}
> =A0 =A0module_exit(dsa_of_cleanup);
>
> =A0 =A0MODULE_DESCRIPTION("DSA OF platform driver");
> =A0 =A0MODULE_AUTHOR("Chris Alfred <chris@greyfog.com.au");
> =A0 =A0MODULE_LICENSE("GPL v2");
>
> dsa_of_init is successfully called; but dsa_of_probe is not called.

That means the node is not being used to register an of_device.  I
need some more information to suggest how best to fix this.  What SoC
are you using?  What file in arch/powerpc/platforms/* is used to setup
your machine?  It would help to have a copy of your full .dts file.

Cheers,
g.
