Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A66931A0A5E
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Oct 2014 15:22:18 +1000 (EST)
Message-ID: <1412227337.6143.0.camel@ale.ozlabs.ibm.com>
Subject: Re: [PATCH v2 06/17] powerpc/powernv: Split out set MSI IRQ chip code
From: Michael Neuling <mikey@neuling.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Date: Thu, 02 Oct 2014 15:22:17 +1000
In-Reply-To: <20141002015729.D379414016B@ozlabs.org>
References: <20141002015729.D379414016B@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: cbe-oss-dev@lists.ozlabs.org, arnd@arndb.de, "Aneesh
 Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, greg@kroah.com,
 linux-kernel@vger.kernel.org, imunsie@au.ibm.com, linuxppc-dev@ozlabs.org,
 anton@samba.org, jk@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-10-02 at 11:57 +1000, Michael Ellerman wrote:
> On Tue, 2014-30-09 at 10:34:55 UTC, Michael Neuling wrote:
> > From: Ian Munsie <imunsie@au1.ibm.com>
> >=20
> > Some of the MSI IRQ code in pnv_pci_ioda_msi_setup() is generically use=
ful so
> > split it out.
> >=20
> > This will be used by some of the cxl PCIe code later.
> >=20
> > diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/p=
latforms/powernv/pci-ioda.c
> > index df241b1..329164f 100644
> > --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> > +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> > @@ -1306,14 +1306,36 @@ static void pnv_ioda2_msi_eoi(struct irq_data *=
d)
> >  	icp_native_eoi(d);
> >  }
> > =20
> > +
> > +static void set_msi_irq_chip(struct pnv_phb *phb, unsigned int virq)
> > +{
> > +	struct irq_data *idata;
> > +	struct irq_chip *ichip;
> > +
> > +	if (phb->type !=3D PNV_PHB_IODA2)
> > +		return;
> > +
> > +	/*
> > +	 * Change the IRQ chip for the MSI interrupts on PHB3.
> > +	 * The corresponding IRQ chip should be populated for
> > +	 * the first time.
>=20
> Seeing as you're moving this comment can you clarify the wording.

Ok.

Mikey
