Return-Path: <vapier@gentoo.org>
Received: from smtp.gentoo.org (smtp.gentoo.org [140.211.166.183])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4450DDE17A
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 02:51:01 +1000 (EST)
From: Mike Frysinger <vapier@gentoo.org>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [patch] use __attribute__ in asm-powerpc
Date: Mon, 16 Jul 2007 12:51:37 -0400
References: <200707142336.10343.vapier@gentoo.org>
	<Pine.LNX.4.62.0707161117150.1072@pademelon.sonytel.be>
In-Reply-To: <Pine.LNX.4.62.0707161117150.1072@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1377632.05SH6qtCS7";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200707161251.40449.vapier@gentoo.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart1377632.05SH6qtCS7
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 16 July 2007, Geert Uytterhoeven wrote:
> On Sat, 14 Jul 2007, Mike Frysinger wrote:
> > Pretty much everyone uses "__attribute__" or "attribute", no one
> > uses "__attribute".  This patch tweaks the three places in asm-powerpc
> > where this comes up.  While only asm-powerpc/types.h is interesting (for
> > userspace), I did asm-powerpc/processor.h as well for consistency.
> >
> > Signed-off-by: Mike Frysinger <vapier@gentoo.org>
> > ---
> > diff --git a/include/asm-powerpc/processor.h
> > b/include/asm-powerpc/processor.h index d947b16..2ce6ea6 100644
> > --- a/include/asm-powerpc/processor.h
> > +++ b/include/asm-powerpc/processor.h
> > @@ -153,9 +153,9 @@ struct thread_struct {
> >  	unsigned long	dabr;		/* Data address breakpoint register */
> >  #ifdef CONFIG_ALTIVEC
> >  	/* Complete AltiVec register set */
> > -	vector128	vr[32] __attribute((aligned(16)));
> > +	vector128	vr[32] __attribute__((aligned(16)));
>
> If the code is not exported to userspace (and thus not subject to differe=
nt
> compilers), I think the preferred form is plain `attribute'.

i never said asm-powerpc/processor.h was exported to userspace ... i did sa=
y=20
that i changed the file to be consistent with all other files.
=2Dmike

--nextPart1377632.05SH6qtCS7
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.5 (GNU/Linux)

iQIVAwUARpuiHEFjO5/oN/WBAQIDjA/+MvlW71LHzAfh+9uBhXWFQZt0NwUr+V+2
4x//AQ56ZYdQS8Y2T0t7RmiES0DwUc7NyxaI5onGBZpp8mb7Vv/pGKejJuCN/IBD
HtZwFvg+y74HwVegL9VE1x4axYv8vPZyBkq8mU6Sl6ATfIKiB4f0Noffn6TH+wUl
Blf4Bx1meny4KORuzqxbVjn74KOHwqw9qO+GezQCHh84cz2YMttuUwKLCY9L76GV
dytgoYGS8JOmOzFshLwNG0zOyYO3TcI4pYa4LpSvlpfpeLZSGDEx2XZ6nTSh0m+y
QSMExx0wLT1uI0GxmVP0UiBd7blB8rypo3F5BeesbNB+olO6tJo4flXcHsDunVGd
QRRXfbEDJavTdcsT6EhIAUzJz8cLSuAfBWUkxFDKtsHUDOn9gj54tjpLvpotiJBF
wyk/1Ro0kOsqstbmmhh1nnY3UhuFtbEsXTWCJgCrFK7GuRylxLFG4mhQmD7VMcWH
6AwCnXpQnWYQrA0Pxkh0F8WzdrnozBskc7HoH8u2p2UR6RlYL90plzSdSzwugawi
Nhm6/UEz2VX4xBgUsQZyABIRpx+mNF85WmZkEuDV8YcrOzZaL6bnC7o8lh7rZOfa
eyQyxpfI6D2eegsEuXyo332aXlyRdArAgcJitGGFptNp9LnuFmF7sNKXCL7Z1SmQ
r7QVn8m6XBg=
=CFNW
-----END PGP SIGNATURE-----

--nextPart1377632.05SH6qtCS7--
