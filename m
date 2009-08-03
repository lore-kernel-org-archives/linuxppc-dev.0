Return-Path: <Frank.Prepelica@ubidyne.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 1B682B7063
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  3 Aug 2009 23:08:03 +1000 (EST)
Received: from mail.ubidyne.com (mail.ubidyne.com [212.211.133.238])
	by ozlabs.org (Postfix) with ESMTP id 3017CDDDA0
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Aug 2009 23:08:00 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Kernel fault with simple UIO interrupt driver in 2.6.30.4
Date: Mon, 3 Aug 2009 15:07:54 +0200
Message-ID: <29DC34A6B43468409F5A371CFE34E849DFC9A1@ex01.ads.ubidyne.de>
From: "Frank Prepelica" <Frank.Prepelica@ubidyne.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

due to a new revision of our custimized board, i need to port our =
current kernel (2.6.24)
to the latest kernel version 2.6.30.4.

Among other things the UIO interrupt driver makes some trouble. The =
driver runs
smoothly on 2.6.24 but I'll get kernel faults when running in 2.6.30.4.

It's a very simple interrupt driver which will be register for a certain =
external=20
cpu interrupt and informs our application via /dev/uioX when an =
interrupt occurs.

Is there anything that changed in the uio framework that could cause the
kernel fault with our uio driver?


Our driver looks like follow
<------------------------------------------------------------------------=
---------
#include <linux/uio_driver.h>
#include <linux/platform_device.h>
#include <linux/module.h>


static irqreturn_t interrupt_handler_irq4(int irq, struct uio_info =
*dev_info)
{
	return IRQ_HANDLED;
}

static struct uio_info uio_irq4_info =3D {
	.name =3D "IRQ4 Kernel Driver",
	.version =3D "1.0.1",
	.irq =3D 20,
	.irq_flags =3DIRQF_DISABLED | IRQF_SHARED | IRQF_TRIGGER_FALLING,
	.handler=3D interrupt_handler_irq4,
};

static int uio_irq4_probe(struct device *dev)
{
	if (uio_register_device(dev, &uio_irq4_info)) {
		kfree((void *)uio_irq4_info.mem[0].addr);
		return -ENODEV;
	}
	else
	{
		return 0;
	}
}


static int uio_irq4_remove(struct device *dev)
{
	uio_unregister_device(&uio_irq4_info);
	return 0;
}


static void uio_irq4_shutdown(struct device *dev)
{

}


static struct platform_device *uio_irq4_device;

static struct device_driver uio_irq4_driver =3D {
	.name		=3D "IRQ4",
	.bus		=3D &platform_bus_type,
	.probe		=3D uio_irq4_probe,
	.remove		=3D uio_irq4_remove,
	.shutdown	=3D uio_irq4_shutdown,
};

/*
* Main initialization/remove routines
*/
static int __init uio_irq4_init(void)
{
	uio_irq4_device =3D platform_device_register_simple("IRQ4", -1,
							   NULL, 0);
	if (IS_ERR(uio_irq4_device))
		return PTR_ERR(uio_irq4_device);

	return driver_register(&uio_irq4_driver);
}

static void __exit uio_irq4_exit(void)
{
	platform_device_unregister(uio_irq4_device);
	driver_unregister(&uio_irq4_driver);
}


module_init(uio_irq4_init);
module_exit(uio_irq4_exit);


MODULE_LICENSE("tbd");
MODULE_AUTHOR("Frank Prepelica, Ubidyne GmbH");
MODULE_DESCRIPTION("IRQ4 Interrupt Handler - CPLD Interrupts");
<------------------------------------------------------------------------=
---------



Any help is highly appreciated!

Kind Regards

Frank Prepelica
Software Design Engineer

Ubidyne GmbH
Lise-Meitner-Str.-14
89081 Ulm - Germany

Phone:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +49 731 88 00 71 58
Fax:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +49 731 88 00 71 99
Email:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
frank.prepelica@ubidyne.com
Homepage:=A0=A0=A0=A0=A0=A0 www.ubidyne.com
=A0
Registered office: Ulm
District court of Ulm: HRB 5295
Managing Directors:
Dipl. Ing. Ken Hawk
Dipl. Ing. Beat M=FCller
Dipl. Ing. Mike Levis
