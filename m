Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xTB4G6RdgzDr1g
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Aug 2017 13:55:42 +1000 (AEST)
Date: Fri, 11 Aug 2017 13:55:38 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>,
 Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 02/10] powerpc/xive: guest exploitation of the XIVE
 interrupt controller
Message-ID: <20170811035538.GX13670@umbus.fritz.box>
References: <1502182579-990-1-git-send-email-clg@kaod.org>
 <1502182579-990-3-git-send-email-clg@kaod.org>
 <20170809035306.GC13670@umbus.fritz.box>
 <f82c1111-3dd3-f378-0ff6-222bffc07a35@kaod.org>
 <20170810042849.GU13670@umbus.fritz.box>
 <e1759aa5-68d0-54ef-87fd-32908ff9ffbc@kaod.org>
 <1502364964.2563.64.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ixLxI13kJ3fj8Y4v"
In-Reply-To: <1502364964.2563.64.camel@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--ixLxI13kJ3fj8Y4v
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 10, 2017 at 09:36:04PM +1000, Benjamin Herrenschmidt wrote:
> On Thu, 2017-08-10 at 09:19 +0200, C=E9dric Le Goater wrote:
> > > > > > +  /* Perform the acknowledge hypervisor to register cycle */
> > > > > > +  ack =3D be16_to_cpu(__raw_readw(xive_tima + TM_SPC_ACK_OS_RE=
G));
> > > > >=20
> > > > > Why do you need the raw_readw() + be16_to_cpu + mb, rather than o=
ne of
> > > > > the higher level IO helpers?
> > > >=20
> > > > This is one of the many ways to do MMIOs on the TIMA. This memory=
=20
> > > > region defines a set of offsets and sizes for which loads and=20
> > > > stores have different effects.=20
> > > >=20
> > > > See the arch/powerpc/include/asm/xive-regs.h file and=20
> > > > arch/powerpc/kvm/book3s_xive_template.c for some more usage.
> > >=20
> > > Sure, much like any IO region.  My point is, why do you want this kind
> > > of complex combo, rather than say an in_be16() or readw_be().
> > >=20
> >=20
> > The code is inherited from the native backend.=20
> >=20
> > I think this is because we know what we are doing and we skip=20
> > the synchronization routines of the higher level IO helpers.=20
> > That might not be necessary for sPAPR. Ben ?=20
>=20
> It's a performance optimisation, we know we don't need the
> sync,twi,isync crap of the higher level accessor here.

Ok.  A comment mentioning this would be good - unless you're very
familiar with the code and hardware it's not going to be obvious if
the nonstandard IO accessors are for legitimate performance reasons,
or just cargo-culting.


--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ixLxI13kJ3fj8Y4v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmNKrcACgkQbDjKyiDZ
s5LFMhAA1e5lSqNe3JrvN9ggc1LuHzA6yqyL0IMZSLQaLYA8YR8kw+WRsawQSdQn
UJz4GWgCgYbNS+BHfgsCMYnTmcqF5GMmQiZ6elh+PJrrHYQ9S70zWc6TXDAJWyBy
aBlWWfNsPuV+T/ikbYquAfvSxKuaABo/b7KO1vbMeldhNebri8S+gDQ8ljU0lsKx
ZCAp3GQogDuXD22gor+kmo9Ej50dONAh3jzBeQ66jI3fU71YX7N5IpslT9l+iT33
308d32Q1Q18x4JxsVDZEKqoSXt1twY+LATnKOP/yKPyzTBJ9FqHs3e6sWAXtqogU
qYafAlzzxDxDtg8z+gNKns0B6j3gRKvkCOOiUGy/CCfHbabCCEKgCVBgf3fVhoE3
edQq+tHDRq9qJAYtei2vUGwqZzM//hvULL/d6a8datwOHpj7BTQZPVVoog7lKpN7
K6Dn/Q2bYAzjhRvEhNiAPd0mhUAn4flZpiVba/+LlDATLqSfxQ8nK+a/QCdPJ0bJ
9HzwnU+sIuSK+rOwiNlCs8TxxFX7dlJoasuPIr/WDyAxdISkzTs1ofPtqrZYyHnM
lBoFTgxvVQFArK8t8We/Dw8fPexVW5Q0C+pJurtYfBZvpwn4w0Mqech81UHJTTyo
z6IZ2x4bjTFPW4A5ljBrdiM/NAMt2DArWRETakhICuWFTQYA+yY=
=ELFC
-----END PGP SIGNATURE-----

--ixLxI13kJ3fj8Y4v--
