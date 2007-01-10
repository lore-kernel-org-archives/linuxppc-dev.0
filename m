Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 5A5E5DDDF6
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jan 2007 07:52:33 +1100 (EST)
Date: Wed, 10 Jan 2007 23:13:22 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/5] [POWERPC] cpm2: Updates for CPM2 pic
Message-ID: <20070110231322.12c8add7@localhost.localdomain>
In-Reply-To: <B1664D59-5C48-45DF-8C53-5E1AE6AEDAF4@kernel.crashing.org>
References: <20070110011124.20342.38130.stgit@localhost.localdomain>
	<B1664D59-5C48-45DF-8C53-5E1AE6AEDAF4@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_ozx6f6VP2Q/pvlP6_Rze07s";
	protocol="application/pgp-signature"; micalg=PGP-SHA1
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Sig_ozx6f6VP2Q/pvlP6_Rze07s
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 10 Jan 2007 11:02:52 -0600
Kumar Gala wrote:

>=20
> On Jan 9, 2007, at 7:11 PM, Vitaly Bordug wrote:
>=20
> >
> > This contains important fixes for the CPM2 PIC code. Eliminated
> > CPM_IRQ_OFFSET, pulling the respective interrupt numbers from the =20
> > interrupt
> > mapping. Updated devicetree files to reflect that. Changed direct
> > IC-related IO accesses to the IO accessors.
> >
> > Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
> > ---
>=20
> [snip]
>=20
> > diff --git a/include/asm-powerpc/mpc8260.h b/include/asm-powerpc/=20
> > mpc8260.h
> > new file mode 100644
> > index 0000000..c2adcb0
> > --- /dev/null
> > +++ b/include/asm-powerpc/mpc8260.h
> > @@ -0,0 +1,32 @@
> > +/*
> > + * Since there are many different boards and no standard =20
> > configuration,
> > + * we have a unique include file for each.  Rather than change
> > every
> > + * file that has to include MPC8260 configuration, they all include
> > + * this one and the configuration switching is done here.
> > + */
> > +#ifdef __KERNEL__
> > +#ifndef __ASM_PPC_MPC8260_H__
> > +#define __ASM_PPC_MPC8260_H__
> > +
> > +
> > +#ifdef CONFIG_8260
> > +
> > +#if defined(CONFIG_PQ2ADS) || defined (CONFIG_PQ2FADS)
> > +#include <platforms/82xx/pq2ads.h>
> > +#endif
>=20
> What's defined in pq2ads.h that is needed by other code?
>=20
holding CPM_MAP_ADDR -- not everywhere in the current code it could be pull=
ed from the devtree.
Actually, I have it addressed, but that is pretty big mod that could not be=
 called bugfix and will hopefully be merged in next window.

> > +
> > +#ifdef CONFIG_PCI_8260
> > +#include <platforms/82xx/m82xx_pci.h>
> > +#endif
> > +
> > +#ifndef _ISA_MEM_BASE
> > +#define _ISA_MEM_BASE   0
> > +#endif
> > +
> > +#ifndef PCI_DRAM_OFFSET
> > +#define PCI_DRAM_OFFSET 0
> > +#endif
> > +
> > +#endif /* CONFIG_8260 */
> > +#endif /* !__ASM_PPC_MPC8260_H__ */
> > +#endif /* __KERNEL__ */
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-dev
>=20

--Sig_ozx6f6VP2Q/pvlP6_Rze07s
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFFpUjjuOg9JvQhSEsRAqGpAJ4y6WeiAwui59yjG84kE1LQsctQDgCfQCL5
Mq2DCoZbNSdIwjvJs/X1iI4=
=iC6X
-----END PGP SIGNATURE-----

--Sig_ozx6f6VP2Q/pvlP6_Rze07s--
