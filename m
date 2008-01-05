Return-Path: <SRS0=i/5s=R3=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id A8F1CDDE26
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Jan 2008 23:50:08 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] i2c-ibm_iic driver
Date: Sat, 5 Jan 2008 13:49:34 +0100
References: <477EF225.4070505@pikatech.com> <200801051224.52693.arnd@arndb.de>
In-Reply-To: <200801051224.52693.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200801051349.34488.sr@denx.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Saturday 05 January 2008, Arnd Bergmann wrote:
> On Saturday 05 January 2008, Sean MacLennan wrote:
> > I converted the i2c-ibm_iic driver from an ocp driver to an of_platform
> > driver. Since this driver is in the kernel.org kernel, should I rename
> > it and keep the old one around? I notice this was done with the emac
> > network driver.
>
> The interesting question is whether there are any functional users in
> arch/ppc left for the original driver. If all platforms that used
> to use i2c-ibm_iic are broken already, you can can go ahead with
> the conversion.

No, they are not all broken. We still have to support arch/ppc till mid of=
=20
this year.

> Otherwise, there are two options:=20
>
> 1. duplicate the driver like you suggested
> 2. make the same driver both a ocp and of_platform, depending on
> the configuration options.
>
> Since most of the driver is untouched by your patch, I'd lean to
> the second option, but of course, that is more work for you.

I did send a patch for such a combined driver a few months ago:

http://patchwork.ozlabs.org/linuxppc/patch?person=3D305&id=3D14181

There were still same open issues and I didn't find the time till now to=20
address them. It would be great if you could take care of these issues and=
=20
submit a reworked version.

> Your patch otherwise looks good, but I have a few comments on
>
> details:
> > --- a/drivers/i2c/busses/Kconfig
> > +++ b/drivers/i2c/busses/Kconfig
> > @@ -241,7 +241,6 @@ config I2C_PIIX4
> > =A0
> > =A0config I2C_IBM_IIC
> > =A0=A0=A0=A0=A0=A0=A0=A0tristate "IBM PPC 4xx on-chip I2C interface"
> > -=A0=A0=A0=A0=A0=A0=A0depends on IBM_OCP
> > =A0=A0=A0=A0=A0=A0=A0=A0help
> > =A0=A0=A0=A0=A0=A0=A0=A0 =A0Say Y here if you want to use IIC periphera=
l found on
> > =A0=A0=A0=A0=A0=A0=A0=A0 =A0embedded IBM PPC 4xx based systems.
>
> In any way, this one now needs to depend on PPC_MERGE now, you
> could even make it depend on PPC_4xx, but it's often better to
> allow building the driver when you can, even if it doesn't make
> sense on your hardware. This gives a better compile coverage.
>
> > diff --git a/drivers/i2c/busses/i2c-ibm_iic.c
> > b/drivers/i2c/busses/i2c-ibm_iic.c index 9b43ff7..838006f 100644
> > --- a/drivers/i2c/busses/i2c-ibm_iic.c
> > +++ b/drivers/i2c/busses/i2c-ibm_iic.c
> > @@ -3,6 +3,10 @@
> > =A0 *
> > =A0 * Support for the IIC peripheral on IBM PPC 4xx
> > =A0 *
> > + * Copyright (c) 2008 PIKA Technologies
> > + * Sean MacLennan <smaclennan@pikatech.com>
> > + * =A0Converted to an of_platform_driver.
> > + *
>
> Changelogs in the file itself are discouraged. In this case, it's just
> one line, so it's not really harmful.
>
> I think the convention is for copyrights to be in chronological order,
> so you should put the copyright below Eugene's.
>
> > =A0 * Copyright (c) 2003, 2004 Zultys Technologies.
> > =A0 * Eugene Surovegin <eugene.surovegin@zultys.com> or <ebs@ebshome.ne=
t>
> > =A0 *
> >
> >
> > +=A0=A0=A0=A0=A0=A0=A0dev->idx =3D index++;
> > +
> > +=A0=A0=A0=A0=A0=A0=A0dev_set_drvdata(&ofdev->dev, dev);
> > +
> > +=A0=A0=A0=A0=A0=A0=A0if((addrp =3D of_get_address(np, 0, NULL, NULL)) =
=3D=3D NULL ||
> > +=A0=A0=A0=A0=A0=A0=A0 =A0 (addr =3D of_translate_address(np, addrp)) =
=3D=3D OF_BAD_ADDR) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0printk(KERN_CRIT "ibm-iic=
%d: Unable to get iic
> > address\n", +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 =A0 dev->idx);
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0ret =3D -EBUSY;
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0goto fail1;
> > =A0=A0=A0=A0=A0=A0=A0=A0}
> > =A0
> > -=A0=A0=A0=A0=A0=A0=A0if (!(dev->vaddr =3D ioremap(ocp->def->paddr, siz=
eof(struct
> > iic_regs)))){ +=A0=A0=A0=A0=A0=A0=A0if (!(dev->vaddr =3D ioremap(addr, =
sizeof(struct
> > iic_regs)))){ printk(KERN_CRIT "ibm-iic%d: failed to ioremap device
> > registers\n", dev->idx);
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0ret =3D -ENXIO;
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0goto fail2;
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0goto fail1;
> > =A0=A0=A0=A0=A0=A0=A0=A0}
>
> Use of_iomap here to save a few lines.
>
> > =A0=A0=A0=A0=A0=A0=A0=A0init_waitqueue_head(&dev->wq);
> > =A0
> > -=A0=A0=A0=A0=A0=A0=A0dev->irq =3D iic_force_poll ? -1 : ocp->def->irq;
> > -=A0=A0=A0=A0=A0=A0=A0if (dev->irq >=3D 0){
> > +=A0=A0=A0=A0=A0=A0=A0if(iic_force_poll)
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0dev->irq =3D -1;
> > +=A0=A0=A0=A0=A0=A0=A0else if((dev->irq =3D irq_of_parse_and_map(np, 0)=
) =3D=3D NO_IRQ) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0printk(KERN_ERR __FILE__ =
": irq_of_parse_and_map
> > failed\n"); +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0dev->irq =3D =
=2D1;
> > +=A0=A0=A0=A0=A0=A0=A0}
> > +
> > +=A0=A0=A0=A0=A0=A0=A0if (dev->irq >=3D 0) {
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0/* Disable interrupts u=
ntil we finish initialization,
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0 assumes level-sens=
itive IRQ setup...
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 */
>
> This was in the original driver, but I think it's wrong anyway:
> irq =3D=3D 0 could be valid, so you shouldn't compare against that
> in general. Use NO_IRQ as a symbolic way to express an invalid
> IRQ (yes, I'm aware that NO_IRQ is currently defined to 0).
>
> > @@ -711,23 +722,30 @@ static int __devinit iic_probe(struct ocp_device
> > *ocp){=20
> > =A0=A0=A0=A0=A0=A0=A0=A0if (dev->irq < 0)
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0printk(KERN_WARNING "ib=
m-iic%d: using polling mode\n",
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0d=
ev->idx);
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
=A0 dev->idx);
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
> > =A0=A0=A0=A0=A0=A0=A0=A0/* Board specific settings */
> > -=A0=A0=A0=A0=A0=A0=A0dev->fast_mode =3D iic_force_fast ? 1 : (iic_data=
 ?
> > iic_data->fast_mode : 0); +=A0=A0=A0=A0=A0=A0=A0dev->fast_mode =3D iic_=
force_fast ? 1 :
> > 0;
>
> If there is a good reason to specify fast or slow mode per board, you may
> want to make that a property in the device node.
>
> > +
> > +static struct of_device_id ibm_iic_match[] =3D
> > =A0{
> > -=A0=A0=A0=A0=A0=A0=A0{ .vendor =3D OCP_VENDOR_IBM, .function =3D OCP_F=
UNC_IIC },
> > -=A0=A0=A0=A0=A0=A0=A0{ .vendor =3D OCP_VENDOR_INVALID }
> > +=A0=A0=A0=A0=A0=A0=A0{ .type =3D "i2c", .compatible =3D "ibm,iic", },
> > +=A0=A0=A0=A0=A0=A0=A0{}
> > =A0};
>
> This is probably not specific enough. I'm rather sure that someone at IBM
> has implemented an i2c chip that this driver doesn't support. Maybe
>
> 	.compatible =3D "ibm,405-iic"
>
> or similar would be a better thing to check for.

	.compatible =3D "ibm,4xx-iic"

please, since 405 and 440 have the same I2C controller.

Best regards,
Stefan
