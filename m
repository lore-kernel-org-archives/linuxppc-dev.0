Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rW5jy5JJkzDqlg
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jun 2016 13:45:10 +1000 (AEST)
Received: from localhost.localdomain (localhost [127.0.0.1])
 by ozlabs.org (Postfix) with ESMTP id 3rW5jy47sdz9t17
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jun 2016 13:45:10 +1000 (AEST)
Message-ID: <1466135110.4722.5.camel@neuling.org>
Subject: Re: [PATCH] cxl: Make vPHB device node match adapter's
From: Michael Neuling <mikey@neuling.org>
To: Ian Munsie <imunsie@au1.ibm.com>, Frederic Barrat
 <fbarrat@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Fri, 17 Jun 2016 13:45:10 +1000
In-Reply-To: <1466027386-sup-9561@x230.ozlabs.ibm.com>
References: <1466001736-3074-1-git-send-email-fbarrat@linux.vnet.ibm.com>
 <1466027386-sup-9561@x230.ozlabs.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-06-16 at 07:53 +1000, Ian Munsie wrote:
> This could probably use a description in the commit message, perhaps
> including output showing the before/after difference this makes to
> lsvpd, but otherwise it looks fine to me.
>=20
> @Mikey - this look OK to you?

Yeah I think this is a good idea.

IIRC, we had something like this really early on but hit some random issue
and pulled it out before posting.

Mikey

> Acked-by: Ian Munsie <imunsie@au1.ibm.com>
>=20
> Excerpts from Frederic Barrat's message of 2016-06-15 16:42:16 +0200:
> >=20
> > Tested by cxlflash on bare-metal and powerVM.
> >=20
> > Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> > ---
> > =C2=A0drivers/misc/cxl/vphb.c | 21 ++++++++++-----------
> > =C2=A01 file changed, 10 insertions(+), 11 deletions(-)
> >=20
> > diff --git a/drivers/misc/cxl/vphb.c b/drivers/misc/cxl/vphb.c
> > index cdc7723..012b6aa 100644
> > --- a/drivers/misc/cxl/vphb.c
> > +++ b/drivers/misc/cxl/vphb.c
> > @@ -208,20 +208,19 @@ static struct pci_controller_ops
> > cxl_pci_controller_ops =3D
> > =C2=A0
> > =C2=A0int cxl_pci_vphb_add(struct cxl_afu *afu)
> > =C2=A0{
> > -=C2=A0=C2=A0=C2=A0=C2=A0struct pci_dev *phys_dev;
> > -=C2=A0=C2=A0=C2=A0=C2=A0struct pci_controller *phb, *phys_phb;
> > +=C2=A0=C2=A0=C2=A0=C2=A0struct pci_controller *phb;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct device_node *vphb_dn;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct device *parent;
> > =C2=A0
> > -=C2=A0=C2=A0=C2=A0=C2=A0if (cpu_has_feature(CPU_FTR_HVMODE)) {
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0phys_dev =3D to_pci_de=
v(afu->adapter->dev.parent);
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0phys_phb =3D pci_bus_t=
o_host(phys_dev->bus);
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0vphb_dn =3D phys_phb->=
dn;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0parent =3D &phys_dev->=
dev;
> > -=C2=A0=C2=A0=C2=A0=C2=A0} else {
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0vphb_dn =3D afu->adapt=
er->dev.parent->of_node;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0parent =3D afu->adapte=
r->dev.parent;
> > -=C2=A0=C2=A0=C2=A0=C2=A0}
> > +=C2=A0=C2=A0=C2=A0=C2=A0/* The parent device is the adapter. Reuse the=
 device node of
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* the adapter.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* We don't seem to care what device node=
 is used for the vPHB,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* but tools such as lsvpd walk up the de=
vice parents looking
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* for a valid location code, so we might=
 as well show devices
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* attached to the adapter as being locat=
ed on that adapter.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*/
> > +=C2=A0=C2=A0=C2=A0=C2=A0parent =3D afu->adapter->dev.parent;
> > +=C2=A0=C2=A0=C2=A0=C2=A0vphb_dn =3D parent->of_node;
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Alloc and setup PHB data structure */
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0phb =3D pcibios_alloc_controller(vphb_dn)=
;
