Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 17FEC1A0D48
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Nov 2015 10:17:03 +1100 (AEDT)
Message-ID: <1446765422.3325.7.camel@neuling.org>
Subject: Re: [PATCH] cxl: use correct operator when writing pcie config
 space values
From: Michael Neuling <mikey@neuling.org>
To: Daniel Axtens <dja@axtens.net>, Andrew Donnellan
 <andrew.donnellan@au1.ibm.com>, linuxppc-dev@ozlabs.org
Cc: imunsie@au1.ibm.com
Date: Fri, 06 Nov 2015 10:17:02 +1100
In-Reply-To: <87oaf8hwt2.fsf@gamma.ozlabs.ibm.com>
References: <1446603849-26796-1-git-send-email-andrew.donnellan@au1.ibm.com>
 <87oaf8hwt2.fsf@gamma.ozlabs.ibm.com>
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

On Fri, 2015-11-06 at 10:05 +1100, Daniel Axtens wrote:
> Andrew Donnellan <andrew.donnellan@au1.ibm.com> writes:
>=20
> > When writing a value to config space, cxl_pcie_write_config() calls
> > cxl_pcie_config_info() to obtain a mask and shift value, shifts the
> > new
> > value accordingly, then uses the mask to combine the shifted value
> > with the
> > existing value at the address as part of a read-modify-write
> > pattern.
> >=20
> > Currently, we use a logical OR operator rather than a bitwise OR
> > operator,
> > which means any use of this function results in an incorrect value
> > being
> > written. Replace the logical OR operator with a bitwise OR operator
> > so the
> > value is written correctly.
> >=20
> > Reported-by: Michael Ellerman <mpe@ellerman.id.au>
> > Cc: stable@vger.kernel.org
>=20
> Given that there are no current users of this function, does this
> need
> to go to stable? Does it actually fix a real (as opposed to
> theoretical)
> bug?

Agreed.  Not really needed in stable.

Mikey

>=20
> Regards,
> Daniel
>=20
> > Fixes: 6f7f0b3df6d4 ("cxl: Add AFU virtual PHB and kernel API")
> > Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> > ---
> >  drivers/misc/cxl/vphb.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/misc/cxl/vphb.c b/drivers/misc/cxl/vphb.c
> > index 94b5208..9be09bb 100644
> > --- a/drivers/misc/cxl/vphb.c
> > +++ b/drivers/misc/cxl/vphb.c
> > @@ -203,7 +203,7 @@ static int cxl_pcie_write_config(struct pci_bus
> > *bus, unsigned int devfn,
> >  	mask <<=3D shift;
> >  	val <<=3D shift;
> > =20
> > -	v =3D (in_le32(ioaddr) & ~mask) || (val & mask);
> > +	v =3D (in_le32(ioaddr) & ~mask) | (val & mask);
> > =20
> >  	out_le32(ioaddr, v);
> >  	return PCIBIOS_SUCCESSFUL;
