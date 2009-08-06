Return-Path: <michael@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 397E2B7080
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  7 Aug 2009 00:15:42 +1000 (EST)
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2AE42DDD04
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Aug 2009 00:15:42 +1000 (EST)
Subject: Re: AW: Kernel fault with simple UIO interrupt driver in 2.6.30.4
From: Michael Ellerman <michael@ellerman.id.au>
To: Frank Prepelica <Frank.Prepelica@ubidyne.com>
In-Reply-To: <29DC34A6B43468409F5A371CFE34E849DFCA3D@ex01.ads.ubidyne.de>
References: <29DC34A6B43468409F5A371CFE34E849DFCA3D@ex01.ads.ubidyne.de>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-NMTInsw5RvcNncEVaoNt"
Date: Fri, 07 Aug 2009 00:15:40 +1000
Message-Id: <1249568140.20200.19.camel@concordia>
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


--=-NMTInsw5RvcNncEVaoNt
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2009-08-04 at 09:23 +0200, Frank Prepelica wrote:
> Oh okay, I didnt think anybody would need it :)

> IRQ 20/IRQ3 Kernel Driver: IRQF_DISABLED is not guaranteed on shared IRQs
> Unable to handle kernel paging request for instruction fetch
> Faulting instruction address: 0x00000000
> Oops: Kernel access of bad area, sig: 11 [#1]
> MPC831x RDB
> Modules linked in:
> NIP: 00000000 LR: c004755c CTR: 00000000
> REGS: c7827d50 TRAP: 0400   Not tainted  (2.6.30.4)
> MSR: 20001032 <ME,IR,DR>  CR: 28000022  XER: 20000000
> TASK =3D c7828000[1] 'swapper' THREAD: c7826000
> GPR00: 00000002 c7827e00 c7828000 00000014 00000002 00000014 c73adb7c c06=
bb460
> GPR08: 00000000 00000000 00000014 00000000 00000000 00000000 07fff000 000=
00001
> GPR16: ffffffff 00000000 007fff00 07ff9794 00000000 00000000 007ffeb0 000=
00000
> GPR24: c73ad180 c02d70a4 c0574f28 00009032 00000014 00000000 c73adb40 c05=
74f08
> Call Trace:
> [c7827e00] [c00474e4] 0xc00474e4 (unreliable)
> [c7827e20] [c0047754] 0xc0047754
> [c7827e50] [c019c568] 0xc019c568
> [c7827e90] [c019c7f8] 0xc019c7f8
> [c7827ea0] [c0177a80] 0xc0177a80
> [c7827ec0] [c0177b94] 0xc0177b94
> [c7827ee0] [c01764d8] 0xc01764d8
> [c7827f10] [c0177590] 0xc0177590
> [c7827f20] [c017703c] 0xc017703c
> [c7827f40] [c0178080] 0xc0178080
> [c7827f60] [c0319884] 0xc0319884
> [c7827f70] [c00038dc] 0xc00038dc
> [c7827fe0] [c03037c0] 0xc03037c0
> [c7827ff0] [c0010778] 0xc0010778

It would be more useful with symbols :)

But, you can see that it's taking a 400, ie. faulting on instruction
fetch - which suggests your driver is causing the kernel to try and
execute at instruction 0x0 - why I'm not sure.

cheers


--=-NMTInsw5RvcNncEVaoNt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkp65YgACgkQdSjSd0sB4dKkfQCgmyJrviL95F0vO2z843a11zan
b/EAoKtwrmI3woXyuc3A9t3i3FGtD/w7
=UVEz
-----END PGP SIGNATURE-----

--=-NMTInsw5RvcNncEVaoNt--
