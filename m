Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 6D68BDDEC1
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Jan 2007 07:57:53 +1100 (EST)
Date: Mon, 22 Jan 2007 23:55:33 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/5] [POWERPC] cpm2: CPM2 interrupt controller fix
Message-ID: <20070122235533.6f9f8d09@localhost.localdomain>
In-Reply-To: <1169495737.1582.7.camel@localhost.localdomain>
References: <20070113004150.1224.58427.stgit@localhost.localdomain>
	<17844.35471.554647.189851@cargo.ozlabs.ibm.com>
	<20070122164316.79569af9@localhost.localdomain>
	<1169495737.1582.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary=Sig_GRt+RiG3D2HcZf++JwShQaR;
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

--Sig_GRt+RiG3D2HcZf++JwShQaR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 23 Jan 2007 06:55:37 +1100
Benjamin Herrenschmidt wrote:

> On Mon, 2007-01-22 at 16:43 +0300, Vitaly Bordug wrote:
> > On Mon, 22 Jan 2007 20:57:35 +1100
> > Paul Mackerras wrote:
> >=20
> > > Vitaly Bordug writes:
> > >=20
> > > > This contains important fixes for the CPM2 PIC code. Eliminated
> > > > CPM_IRQ_OFFSET, pulling the respective interrupt numbers from
> > > > the interrupt mapping. Updated devicetree files to reflect that.
> > > > Changed direct IC-related IO accesses to the IO accessors. Fixed
> > > > all the sense values to keep coherency with ipic. In the current
> > > > code, CPM2 stuff will have no IRQs and hence could be hardly
> > > > usable.
> > >=20
> > > You seem to be adding significant stuff;
> > > include/asm-powerpc/mpc8260.h is new, and there is this hunk in
> > > your patch 4/5:
>=20
> > As I said, new io.h in powerpc broke compilation for both 8272 and
> > 8560 that were committted.
>=20
> I missed that report of breakage, can you give me more details on what
> happens ?
>=20
>=20

Compilation fails on locating various CPM-related defines, that used to be =
in ppc/io.h. So, not to mangle new io.h I've added=20
mpc8260.h to have them defined there. This is not that beautiful, but stuff=
 that is claimed to be supported should work
and at least not bail out the compiler :).

I have appropriate fix in the queue, that gets rid of global IMMAP pointer =
yet keeping ppc happy, but the patch is to significant to get into the curr=
ent kernel.

--
Sincerely, Vitaly

--Sig_GRt+RiG3D2HcZf++JwShQaR
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFFtSTFuOg9JvQhSEsRAlVuAJwNt6V7O1LjLSNGudejKBfln61fxwCdGkFN
zmm0ajb5bKG0RxvCOmgmCSs=
=mE5V
-----END PGP SIGNATURE-----

--Sig_GRt+RiG3D2HcZf++JwShQaR--
