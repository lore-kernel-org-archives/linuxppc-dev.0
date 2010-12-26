Return-Path: <joerg@alea.gnuu.de>
Received: from uucp.gnuu.de (uucp.gnuu.de [83.246.114.63])
	by ozlabs.org (Postfix) with ESMTP id EFF56B70DF
	for <linuxppc-dev@ozlabs.org>; Sun, 26 Dec 2010 21:50:43 +1100 (EST)
Date: Sun, 26 Dec 2010 01:30:42 +0100
From: =?iso-8859-1?Q?J=F6rg?= Sommer <joerg@alea.gnuu.de>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Oops in trace_hardirqs_on (powerpc)
Message-ID: <20101226003042.GA2065@alea.gnuu.de>
References: <20100806233157.GA7117@alea.gnuu.de>
	<1285184671.26872.127.camel@gandalf.stny.rr.com>
	<20100927125037.GA4497@alea.gnuu.de>
	<1285639094.2989.1.camel@frodo>
	<20101219132705.GE6615@alea.gnuu.de>
	<1293072176.22802.6.camel@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
In-Reply-To: <1293072176.22802.6.camel@gandalf.stny.rr.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>, Ingo Molnar <mingo@redhat.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Steven,

Steven Rostedt hat am Wed 22. Dec, 21:42 (-0500) geschrieben:
> On Sun, 2010-12-19 at 14:27 +0100, J=F6rg Sommer wrote:
> > Did you've fixed this problem? The bug report is still marked as open.
> > https://bugzilla.kernel.org/show_bug.cgi?id=3D16573
> >=20
>=20
> I just posted a patch to that BZ. I have it here below too. Could you
> see if it fixes you problem. I only fixed the one place that you
> reported, it may need more fixes (and in that case a macro to do the
> work).
>=20
> I hit the same bug on my ppc64 box, and have a fix for that, that I'll
> post to LKML tomorrow.
>=20
> -- Steve
>=20
> diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_3=
2.S
> index ed4aeb9..915cc03 100644
> --- a/arch/powerpc/kernel/entry_32.S
> +++ b/arch/powerpc/kernel/entry_32.S
> @@ -879,7 +879,18 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_TYPE_47x)
>  	 */
>  	andi.	r10,r9,MSR_EE
>  	beq	1f
> +	/*
> +	 * Since the ftrace irqsoff latency trace checks CALLER_ADDR1,
> +	 * which is the stack frame here, we need to force a stack frame
> +	 * in case we came from user space.
> +	 */
> +	stwu	r1,-32(r1)
> +	mflr	r0
> +	stw	r0,4(r1)
> +	stwu	r1,-32(r1)
>  	bl	trace_hardirqs_on
> +	lwz	r1,0(r1)
> +	lwz	r1,0(r1)
>  	lwz	r9,_MSR(r1)
>  1:
>  #endif /* CONFIG_TRACE_IRQFLAGS */

This patch eliminates the oopses.

Bye, J=F6rg.
--=20
Der Kl=FCgere gibt so lange nach bis er der Dumme ist.

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature http://en.wikipedia.org/wiki/OpenPGP
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk0WjLIACgkQwe0mZwH1VIDObgCfcYFXXdeYW4SX7wjo9TBnB4cC
iA0An3l8Y4NI9D9gZ6tNbg80PZymUOJ4
=16/F
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--
