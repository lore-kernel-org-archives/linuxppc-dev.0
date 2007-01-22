Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 67131DDEE6
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Jan 2007 09:53:23 +1100 (EST)
Date: Tue, 23 Jan 2007 00:42:03 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/5] [POWERPC] cpm2: CPM2 interrupt controller fix
Message-ID: <20070123004203.5a3007fa@localhost.localdomain>
In-Reply-To: <1169500388.1582.14.camel@localhost.localdomain>
References: <20070113004150.1224.58427.stgit@localhost.localdomain>
	<17844.35471.554647.189851@cargo.ozlabs.ibm.com>
	<20070122164316.79569af9@localhost.localdomain>
	<1169495737.1582.7.camel@localhost.localdomain>
	<20070122235533.6f9f8d09@localhost.localdomain>
	<1169500388.1582.14.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_WBv.hL4bVrITzNx/IbX2FSQ";
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

--Sig_WBv.hL4bVrITzNx/IbX2FSQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 23 Jan 2007 08:13:08 +1100
Benjamin Herrenschmidt wrote:

>=20
> > Compilation fails on locating various CPM-related defines, that
> > used to be in ppc/io.h. So, not to mangle new io.h I've added
> > mpc8260.h to have them defined there. This is not that beautiful,
> > but stuff that is claimed to be supported should work and at least
> > not bail out the compiler :).
> >=20
> > I have appropriate fix in the queue, that gets rid of global IMMAP
> > pointer yet keeping ppc happy, but the patch is to significant to
> > get into the current kernel.
>=20
> What about an fsl_cpm.h instead if that CPM exists on more than just
> 8260 ? (If not, that's ok then)

Because other than cpm-related that are common, it has some
board-specific defines,
that are accomplished old-way by

+#if defined(CONFIG_PQ2ADS) || defined (CONFIG_PQ2FADS)=20
+#include <platforms/82xx/pq2ads.h>
+#endif                                               =20

That was pointed out by Kumar already, but he agreed that proper approach i=
s much more significant to=20
be considered as bugfix.

After my forthcoming CPM cleanup series we'll be able to get rid of this he=
ader... Well, most of it at least, I need to=20
double-check. Anyway, this approach is the closest to what have been hit by=
 the io.h removal (just peek into ppc/ version :) )=09

Thanks
--
Sincerely, Vitaly

--Sig_WBv.hL4bVrITzNx/IbX2FSQ
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFFtS+ruOg9JvQhSEsRAviZAJ94OCSNdPqnmCOmpKlXVIs7eah44QCghO0q
1dM7Nbim8JwYqJG7WByzmQg=
=yvQW
-----END PGP SIGNATURE-----

--Sig_WBv.hL4bVrITzNx/IbX2FSQ--
