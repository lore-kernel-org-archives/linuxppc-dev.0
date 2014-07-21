Return-Path: <nikhil.badola@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0206.outbound.protection.outlook.com [207.46.163.206])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D01521A020C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Jul 2014 19:47:58 +1000 (EST)
From: "nikhil.badola@freescale.com" <nikhil.badola@freescale.com>
To: Denis Kirjanov <kirjanov@gmail.com>
Subject: RE: [PATCH] powerpc : dma-mapping : Check null condition for
 dev->archdata.dma_ops
Date: Mon, 21 Jul 2014 09:47:44 +0000
Message-ID: <7915139669ac4176b4af2854db24713c@BN1PR0301MB0593.namprd03.prod.outlook.com>
References: <1405677892-7201-1-git-send-email-nikhil.badola@freescale.com>
 <CAHj3AVmD1ecGor_z_bsVRty7KSh8CL1TW20=YGk60SXV1hjOtg@mail.gmail.com>
In-Reply-To: <CAHj3AVmD1ecGor_z_bsVRty7KSh8CL1TW20=YGk60SXV1hjOtg@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Denis Kirjanov [mailto:kirjanov@gmail.com]
> Sent: Friday, July 18, 2014 7:21 PM
> To: Badola Nikhil-B46172
> Cc: linuxppc-dev@lists.ozlabs.org
> Subject: Re: [PATCH] powerpc : dma-mapping : Check null condition for dev=
-
> >archdata.dma_ops
>=20
> On 7/18/14, Nikhil Badola <nikhil.badola@freescale.com> wrote:
> > Modifies get_dma_ops() implementation on ppc arch to check null
> > condition
>  which means that dma is not supported.
>=20
> Could you please describe the use case where the ops is null.

The use case in which ops are null is while running USB in Gadget and Otg m=
ode.

For PPC architecture, whenever a platform device is registered, pdev->dev i=
s=20
assigned dma_ops.=20
In USB, one single chipidea platform device is registered for any mode (hos=
t, gadget or otg)
whose dev, as explained above, has dma_ops set and this dev is assigned to =
 ci->dev(dev of chipidea struct)
which is used by host controller device. That is why we don't need the abov=
e null case checking in
host mode. But when we run usb in gadget/otg mode, the device structure use=
d is ci->gadget.dev
which does not have dma_ops set and it crashes when dma transaction starts =
when it calls get_dma_ops()
which returns NULL.

A similar approach is used in ARM architecture which checks for null condit=
ion and returns=20
common dma_ops
>=20
> > for dev->archdata.dma_ops; returns common dma_direct_ops structure in
> > case its NULL
> >
> > Signed-off-by: Nikhil Badola <nikhil.badola@freescale.com>
> > ---
> >  arch/powerpc/include/asm/dma-mapping.h | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/powerpc/include/asm/dma-mapping.h
> > b/arch/powerpc/include/asm/dma-mapping.h
> > index 150866b..d73bae8 100644
> > --- a/arch/powerpc/include/asm/dma-mapping.h
> > +++ b/arch/powerpc/include/asm/dma-mapping.h
> > @@ -86,10 +86,12 @@ static inline struct dma_map_ops
> > *get_dma_ops(struct device *dev)
> >  	 */
> >  	if (unlikely(dev =3D=3D NULL))
> >  		return NULL;
> > -
> > -	return dev->archdata.dma_ops;
> > +	if (dev->archdata.dma_ops)
> > +		return dev->archdata.dma_ops;
> > +	return &dma_direct_ops;
> >  }
> >
> > +
> >  static inline void set_dma_ops(struct device *dev, struct dma_map_ops
> > *ops)  {
> >  	dev->archdata.dma_ops =3D ops;
> > --
> > 1.7.11.7
> >
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@lists.ozlabs.org
> > https://lists.ozlabs.org/listinfo/linuxppc-dev
>=20
>=20
> --
> Regards,
> Denis

Regards,
Nikhil
