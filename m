Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 67AF2B7CE8
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Jan 2010 19:04:00 +1100 (EST)
Date: Tue, 26 Jan 2010 09:03:56 +0100
From: Anatolij Gustschin <agust@denx.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 07/11] dma: Add MPC512x DMA driver
Message-ID: <20100126090356.37256823@wker>
In-Reply-To: <fa686aa41001210922h280be005pda88e5859b2769f1@mail.gmail.com>
References: <1263932653-3634-1-git-send-email-agust@denx.de>
	<1263932653-3634-8-git-send-email-agust@denx.de>
	<fa686aa41001210922h280be005pda88e5859b2769f1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: wd@denx.de, dzu@denx.de, linuxppc-dev@ozlabs.org,
	Dan Williams <dan.j.williams@intel.com>, Piotr Ziecik <kosmo@semihalf.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 21 Jan 2010 10:22:27 -0700
Grant Likely <grant.likely@secretlab.ca> wrote:

> On Tue, Jan 19, 2010 at 1:24 PM, Anatolij Gustschin <agust@denx.de> wrote:
> > From: Piotr Ziecik <kosmo@semihalf.com>
> >
> > Adds initial version of MPC512x DMA driver.
> > Only memory to memory transfers are currenly supported.
>=20
> Comments below on brief review.  I've not looked at the code in-depth.

> > ...
> > =C2=A0drivers/dma/Kconfig =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A07 +
> > =C2=A0drivers/dma/Makefile =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A01 +
> > =C2=A0drivers/dma/mpc512x_dma.c | =C2=A0636 +++++++++++++++++++++++++++=
++++++++++++++++++
> > =C2=A0drivers/dma/mpc512x_dma.h | =C2=A0192 ++++++++++++++
>=20
> Unless the stuff in the .h file is used by other .c files, it really
> belongs in mpc512x_dma.c

Ok, will be moved to .c file in next version.

>=20
> > +static int __init mpc_dma_probe(struct of_device *op,
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const struc=
t of_device_id *match)
>=20
> __devinit
>=20
> > +static void __exit mpc_dma_remove(struct of_device *op)
>=20
> __devexit

Ok.

> > +{
> > + =C2=A0 =C2=A0 =C2=A0 struct device *dev =3D &op->dev;
> > + =C2=A0 =C2=A0 =C2=A0 struct mpc_dma *mdma =3D dev_get_drvdata(dev);
> > +
> > + =C2=A0 =C2=A0 =C2=A0 devm_free_irq(dev, mdma->irq, mdma);
> > +}
>=20
> No unregistration of the dma device?  No unmapping?  No kfree()?

I will add unregistration of the dma device. Unmapping and
freeing should be done automatically on driver detach, mapping
and allocation is done by devm_ioremap() and devm_kzalloc().

> > +static struct of_platform_driver mpc_dma_driver =3D {
> > + =C2=A0 =C2=A0 =C2=A0 .match_table =C2=A0 =C2=A0=3D mpc_dma_match,
> > + =C2=A0 =C2=A0 =C2=A0 .probe =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D mpc=
_dma_probe,
> > + =C2=A0 =C2=A0 =C2=A0 .remove =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D __exit_p=
(mpc_dma_remove),
>=20
> __devexit_p()

Ok.

> > +module_exit(mpc_dma_exit);
> > +
> > +/* MODULE API */
>=20
> Meaningless comment.

Ok, will remove it.

Thanks,
Anatolij
