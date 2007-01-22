Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 55E6DDE1D5
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Jan 2007 01:06:01 +1100 (EST)
Date: Mon, 22 Jan 2007 17:04:53 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 3/5] [FS_ENET] OF-related fixup for FEC and SCC MAC's
Message-ID: <20070122170453.1fee7c74@localhost.localdomain>
In-Reply-To: <17844.36037.859630.386937@cargo.ozlabs.ibm.com>
References: <20070113004150.1224.58427.stgit@localhost.localdomain>
	<20070113004213.1224.39653.stgit@localhost.localdomain>
	<17844.36037.859630.386937@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_I53nBeJCJt/Gg_u+eXFDuCh";
	protocol="application/pgp-signature"; micalg=PGP-SHA1
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Sig_I53nBeJCJt/Gg_u+eXFDuCh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 22 Jan 2007 21:07:01 +1100
Paul Mackerras wrote:

> Vitaly Bordug writes:
>=20
> > +#ifndef CONFIG_PPC_MERGE
> >  	FW(fecp, ivec, (fep->interrupt / 2) << 29);
> > -=09
> > +#else
> > +	FW(fecp, ivec, (irq_map[fep->interrupt].hwirq / 2) << 29);
> > +#endif
>=20
> This would be much cleaner if you use virq_to_hw() and add a
> definition of virq_to_hw to the asm-ppc headers, so that you can avoid
> putting ifdefs in code.
>=20
Well, first of all it is netdev stuff(as being in drivers/net) and here for=
 reference only. virq_to_hw approach seems very interesting though...

> Also, it seems a bit bogus to be using the hardware interrupt number
> directly here.
>=20
FEC is sort of external and requires such a surgery iirc

> Is it just 82xx that uses this driver, or do other chips (85xx?) use
> it too?
>
It exists on 8560ads (and alike) and mpc8xx (mostly). mpc82xx usually is fe=
aturing FCC.
=20
--
Thanks, Vitaly

--Sig_I53nBeJCJt/Gg_u+eXFDuCh
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFFtMSFuOg9JvQhSEsRAnlpAJ9ZjYRaXVWkhJrh4lDoLiCX1IwMugCgkbRH
EsN8CHsD/5DXaEs/D536pdU=
=JfN4
-----END PGP SIGNATURE-----

--Sig_I53nBeJCJt/Gg_u+eXFDuCh--
