Return-Path: <michael@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id C2A96B7093
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Sep 2009 17:03:20 +1000 (EST)
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B3AFADDD04
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Sep 2009 17:03:20 +1000 (EST)
Subject: Re: [PATCH] powerpc: perf_counters: Reduce stack usage of
	power_check_constraints
From: Michael Ellerman <michael@ellerman.id.au>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <19112.40097.974792.747829@drongo.ozlabs.ibm.com>
References: <19112.40097.974792.747829@drongo.ozlabs.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-SJFVuRtwBQeDlQCNdPzq"
Date: Thu, 10 Sep 2009 17:03:18 +1000
Message-Id: <1252566198.6566.0.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-SJFVuRtwBQeDlQCNdPzq
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2009-09-10 at 16:28 +1000, Paul Mackerras wrote:
> Michael Ellerman reported stack-frame size warnings being produced
> for power_check_constraints(), which uses an 8*8 array of u64 and
> two 8*8 arrays of unsigned long, which are currently allocated on the
> stack, along with some other smaller variables.  These arrays come
> to 1.5kB on 64-bit or 1kB on 32-bit, which is a bit too much for the
> stack.
>=20
> This fixes the problem by putting these arrays in the existing
> per-cpu cpu_hw_counters struct.  This is OK because two of the call
> sites have interrupts disabled already; for the third call site we
> use get_cpu_var, which disables preemption, so we know we won't
> get a context switch while we're in power_check_constraints().
> Note that power_check_constraints() can be called during context
> switch but is not called from interrupts.

Yep, it does indeed fix the build warning :D

cheers

--=-SJFVuRtwBQeDlQCNdPzq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEUEABECAAYFAkqopLMACgkQdSjSd0sB4dIG0gCXdFRpe2GSfYI9TB0LSzmHTab4
QgCfe/ooOtEFM9HIdYU1bC43hjWDep0=
=8FKc
-----END PGP SIGNATURE-----

--=-SJFVuRtwBQeDlQCNdPzq--
