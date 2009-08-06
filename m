Return-Path: <Frank.Prepelica@ubidyne.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 966C4B6F20
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  6 Aug 2009 17:56:12 +1000 (EST)
Received: from mail.ubidyne.com (mail.ubidyne.com [212.211.133.238])
	by ozlabs.org (Postfix) with ESMTP id AB269DDD0B
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Aug 2009 17:56:09 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: uio driver cannot be registered to uio subsystem
Date: Thu, 6 Aug 2009 09:56:06 +0200
Message-ID: <29DC34A6B43468409F5A371CFE34E849DFCBD0@ex01.ads.ubidyne.de>
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

Hi everbody,

I've got an custom uio interrupt driver. The driver will be registered
as platfrom driver.

static int __init uio_irq3_init(void)
{
   return platform_driver_register(&uio_irq3_driver);
}

After starting the kernel the driver is registered under
/sys/bus/platform/drivers. (I guess this is supposed to happen)
BUT as I can see the uio_irq3_probe() function isn't called and
therefore the driver will not be registered to the
UIO subsystem! (there are no devices in /sys/class/)

What went wrong? Which process is responsible for calling the probe
function?=20

I also tried to compile the uio drivers which are provided by the kernel
itself. But after starting the kernel not one of these drivers appears
in /sys/class/ too!=20

Can anybody please tell what I am doing wrong? Pls see below, too!

Thanks in advance!
Kind regrads

Frank Prepelica
Software Design Engineer

Ubidyne GmbH
Lise-Meitner-Str.-14
89081 Ulm - Germany


Here is the code for the driver if needed!
<------- snip

#include <linux/uio_driver.h>
#include <linux/platform_device.h>
#include <linux/module.h>


struct uio_pdrv_irq3 {
	struct uio_info *uioinfo;
	spinlock_t lock;
	unsigned long flags;
};


static irqreturn_t interrupt_handler_irq3(int irq, struct uio_info
*dev_info)
{
	eturn IRQ_HANDLED;
}


static int uio_irq3_irqcontrol(struct uio_info *dev_info, s32 irq_on)
{
    printk("IRQCONTROL");
    return 0;
}


static int uio_irq3_probe(struct platform_device *pdev)
{
	struct uio_info *uioinfo =3D pdev->dev.platform_data;
	struct uio_pdrv_irq3 *priv;
	int ret =3D -EINVAL;   =20
   =20
	priv =3D kzalloc(sizeof(*priv), GFP_KERNEL);
	if (!priv) {
		ret =3D -ENOMEM;
		dev_err(&pdev->dev, "unable to kmalloc\n");
		goto bad0;
	}   =20
   =20
    priv->uioinfo =3D uioinfo;
    priv->flags =3D 0;
    uioinfo->irq_flags |=3D IRQF_DISABLED | IRQF_TRIGGER_FALLING;
    uioinfo->irq =3D 19;
    uioinfo->handler =3D interrupt_handler_irq3;
    uioinfo->irqcontrol =3D uio_irq3_irqcontrol;
    uioinfo->priv =3D priv;

    uio_register_device(&pdev->dev, priv->uioinfo);
        return -ENODEV;
   =20
	platform_set_drvdata(pdev, priv);
	return 0;   =20
   =20
 bad0:
	return ret;   =20
}

static int uio_irq3_remove(struct platform_device *pdev)
{
    struct uio_pdrv_irq3 *priv =3D platform_get_drvdata(pdev);
	uio_unregister_device(priv->uioinfo);
	return 0;
}


static struct platform_driver uio_irq3_driver =3D {
	.probe		=3D uio_irq3_probe,
	.remove		=3D uio_irq3_remove,
    	.driver =3D {
        .name =3D "IRQ3",
        .owner =3D THIS_MODULE,
    },
};

static int __init uio_irq3_init(void)
{
	return platform_driver_register(&uio_irq3_driver);
}

static void __exit uio_irq3_exit(void)
{
	platform_device_unregister(&uio_irq3_driver);
}


module_init(uio_irq3_init);
module_exit(uio_irq3_exit);


MODULE_LICENSE("tbd");
MODULE_AUTHOR("tbd");
MODULE_DESCRIPTION("IRQ3 Interrupt Handler - CPLD Interrupts");

<------- snap
