Return-Path: <jdl@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 66CB5DDF54
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Apr 2007 00:47:19 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l3OElDcp027519
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Apr 2007 07:47:13 -0700 (MST)
Received: from az33exm24.fsl.freescale.net (az33exm24.am.freescale.net
	[10.64.32.14])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l3OElBtv011518
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Apr 2007 09:47:11 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 1/6] Start split out of common open firmware code
Date: Tue, 24 Apr 2007 07:47:10 -0700
Message-ID: <AF0367BA48C55940A43CCF08DF35553C011ECCD1@az33exm24.fsl.freescale.net>
In-Reply-To: <f64705c9250a93dcb7a4015b9a0d5667@kernel.crashing.org>
References: <20070403105217.7b9fea08.sfr@canb.auug.org.au><20070403222841.a2c6af1c.sfr@canb.auug.org.au><20070403223000.5d44b2f1.sfr@canb.auug.org.au><20070403223136.6ecdabbd.sfr@canb.auug.org.au><20070403223257.cb8c4d15.sfr@canb.auug.org.au><20070403223535.dd6731d6.sfr@canb.auug.org.au><20070403223738.03386a13.sfr@canb.auug.org.au><20070403223914.35bf04e1.sfr@canb.auug.org.au><20070403224039.913af749.sfr@canb.auug.org.au><20070403224205.807cffe0.sfr@canb.auug.org.au><20070403224340.5533abc9.sfr@canb.auug.org.au><20070403224505.5d5a1495.sfr@canb.auug.org.au><20070403224610.b61c7377.sfr@canb.auug.org.au><20070403224937.f6a07e56.sfr@canb.auug.org.au><20070403225059.e735b5e4.sfr@canb.auug.org.au><20070403225222.88e92221.sfr@canb.auug.org.au><20070403230505.f96ea210.sfr@canb.auug.org.au><20070403232406.ab9a3c86.sfr@canb.auug.org.au><20070412141905.6f30efd3.sfr@canb.auug.org.au><20070412153424.bf3957f4.sfr@canb.auug.org.au><20070424223245.78f4fdfb.sfr@canb.auug
	.org.au> <f64705c9! 250a93dcb 7a4015b9a0d5667@kernel.crashing.org>
From: "Loeliger Jon-LOELIGER" <jdl@freescale.com>
To: "Segher Boessenkool" <segher@kernel.crashing.org>,
	"Stephen Rothwell" <sfr@canb.auug.org.au>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org,
	"David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=20
> > +int of_n_addr_cells(struct device_node *np)
> > +{
> > +	const int *ip;
> > +
> > +	do {
> > +		if (np->parent)
> > +			np =3D np->parent;
> > +		ip =3D of_get_property(np, "#address-cells", NULL);
> > +		if (ip)
> > +			return *ip;
> > +	} while (np->parent);
> > +	/* No #address-cells property for the root node */
> > +	return OF_ROOT_NODE_ADDR_CELLS_DEFAULT;
> > +}
> > +EXPORT_SYMBOL(of_n_addr_cells);
>=20
> While I realise your patch is just moving stuff around,
> can this be fixed please?  A missing "#address-cells"
> property means "two cells", not "inherit from parent".
> The few platforms with a broken tree should just be
> fixed (patch the tree in the bootwrapper, or perhaps
> _do_ use this workaround, but only on the affected
> platforms).
>=20
> > +int of_n_size_cells(struct device_node *np)
>=20
> Same here (the default is one cell though).

Agreed.  We actually discussed this quite some time ago.

Thanks,
jdl

PS -- Any fixes for the DTC would be welcomed patches too! :-)
