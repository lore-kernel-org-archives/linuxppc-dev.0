Return-Path: <andrew.dennison@motec.com.au>
Received: from mail.netspace.net.au (thunder.netspace.net.au [203.10.110.71])
	by ozlabs.org (Postfix) with ESMTP id 3A1D067AAD
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  9 Feb 2005 09:18:17 +1100 (EST)
Received: from motec.com.au (dsl-210-15-234-78.VIC.netspace.net.au
	[210.15.234.78])
	by mail.netspace.net.au (Postfix) with SMTP id 33F9C4311E
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  9 Feb 2005 08:58:28 +1100 (EST)
From: "Andrew Dennison" <andrew.dennison@motec.com.au>
To: =?iso-8859-1?Q?'Bj=F6rn_=D6stby'?= <Bjorn.Ostby@combitechsystems.com>,
	<linuxppc-embedded@ozlabs.org>
Date: Wed, 9 Feb 2005 08:58:28 +1100
Message-ID: <001e01c50e29$52738e80$4000a8c0@CAT>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_001F_01C50E85.85E40680"
In-Reply-To: <004B1D7A5257174C9044A1B7BD0E60ED0178CBE7@ratatosk.combitechsystems.com>
Subject: RE: RTAI+ELDK Compile Problems
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------=_NextPart_000_001F_01C50E85.85E40680
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Tuesday, 8 February 2005 10:09 PM, =
linuxppc-embedded-bounces@ozlabs.org
wrote:

> I've got a major problem trying to compile RTAI using the
> ELDK cross compiler.
> I'm using ELDK version 3.1, and my target is ppc_8xx (823). I
> have followed the instructions given at
> ftp://ftp.denx.de/pub/RTAI/24.1.12/README.install
> <ftp://ftp.denx.de/pub/RTAI/24.1.12/README.install> , using the
>=20
> linuxppc_2_4_devel kernel (2004_04_30_1320) and rtai-24.1.12-denx.
>=20
> Now, the rtai patch works fine, and the kernel compiles, but
> when I try to compile rtai
> The following error occurs:
>=20
> /opt/eldk-3.1/ppc_8xx/usr/src/rtai-24.1.12/include/asm/rtai_srq.h: In
> function `rtai_srq':
> /opt/eldk-3.1/ppc_8xx/usr/src/rtai-24.1.12/include/asm/rtai_srq.h:32:
> error: asm-specifier for variable `__sc_3' conflicts with asm clobber
> list =20
>=20

I had a problem like this a while ago with gcc 3.3.2 (see this list from
22 March 2004) - seems later gcc versions are more pedantic about the =
way
the clobber list is specified, at least that is what some googling =
seemed
to indicate.

Attached patch worked for me when I was using linuxppc_devel patched =
with
patch-denx-linuxppc_2_4_devel-LABEL_2003_12_22_1500-ltt and
rtai-24.1.12-denx.tar.bz2.

------=_NextPart_000_001F_01C50E85.85E40680
Content-Type: application/octet-stream;
	name="rtai-24.1.12-denx.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="rtai-24.1.12-denx.patch"

diff -ur rtai-24.1.12.orig/include/asm-ppc/rtai_srq.h =
rtai-24.1.12/include/asm-ppc/rtai_srq.h=0A=
--- rtai-24.1.12.orig/include/asm-ppc/rtai_srq.h	Tue Oct 24 11:32:28 2000=0A=
+++ rtai-24.1.12/include/asm-ppc/rtai_srq.h	Thu Mar 18 14:38:35 2004=0A=
@@ -33,8 +33,7 @@=0A=
 		("trap         \n\t"=0A=
 		: "=3D&r" (__sc_3), "=3D&r" (__sc_4)=0A=
 		: "0"   (__sc_3), "1"   (__sc_4),=0A=
-	          "r"   (__sc_0)=0A=
-		: "r0", "r3", "r4" );=0A=
+	          "r"   (__sc_0));=0A=
 	((unsigned long *)&retval)[0] =3D __sc_3;=0A=
 	((unsigned long *)&retval)[1] =3D __sc_4;=0A=
 	return retval;=0A=

------=_NextPart_000_001F_01C50E85.85E40680--
