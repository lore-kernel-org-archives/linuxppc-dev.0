Return-Path: <albrecht.dress@arcor.de>
Received: from smtp6.netcologne.de (smtp6.netcologne.de [194.8.194.26])
	by ozlabs.org (Postfix) with ESMTP id 4DA15B7B7F
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Oct 2009 06:42:23 +1100 (EST)
Date: Mon, 05 Oct 2009 21:42:13 +0200
From: Albrecht =?iso-8859-1?b?RHJl3w==?= <albrecht.dress@arcor.de>
Subject: Re: [PATCH/v2] powerpc/5200: make BestComm gen_bd microcode
	exchangeable
To: Grant Likely <grant.likely@secretlab.ca>, Linux PPC Development
	<linuxppc-dev@ozlabs.org>
In-Reply-To: <fa686aa40910051116l6439eef7xc9f75c6ac4368094@mail.gmail.com>
	(from grant.likely@secretlab.ca on Mon Oct  5 20:16:26 2009)
Message-Id: <1254771740.5503.2@antares>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg=PGP-SHA1; boundary="=-L5dlEsfWiBH9E0Y1n6LQ"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--=-L5dlEsfWiBH9E0Y1n6LQ
Content-Type: text/plain; charset=UTF-8; DelSp=Yes; Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 05.10.09 20:16 schrieb(en) Grant Likely:
> Hmmm.  I've not been comfortable with this change, but it took me a while=
 to put my finger on exactly why.  In principle, I think it is a good idea.=
  However, I don't want to merge it without any in-tree users.

I could provide my modified microcode (which differs in two words only), fo=
r the "standard" task, just with byte swapping for the LPB, but I wonder if=
 it is of much use.  No progress with crc32 calculation in BestComm so far.=
.. :-(

> The other concern is that I don't like that the patch is only applicable =
to gen_bd tasks.

IMHO the big difference between gen_bd on one hand and ATA and FEC on the o=
ther is that (afaik) we have *no* other choice than using the implemented t=
asks for the latter two, obviously using the Freescale's example microcode.=
  Gen_bd can apparently be used for a plenty of purposes, including LPB (as=
 shown in your driver), maybe PCI (there are examples in Freescale's code),=
 PSC, etc.  Thus, the FEC and ATA drivers should not have an option as to c=
hange the microcode, whereas it is just convenient for gen_bd.

> I've been thinking about this for a while, and I'm not exactly thrilled w=
ith the bestcomm layout which keeps the bestcomm firmware separate from the=
 only driver that actually uses it (ie FEC firmware & support code is separ=
ate from the FEC driver.  Same for ATA).  I don't like the fact that code w=
hich is only ever used by the ATA driver is maintained completely separate =
from it.

That's a good point!  The separate microcode files for ATA and FEC are some=
what confusing.  I guess it's a result of simply copying the Freescale exam=
ples into separate files (and that might be a good reason for keeping the m=
icrocode separated).  Maybe create new sub-folders below arch/powerpc/sysde=
v/bestcomm for fec, ata, and gen_bd?  At least some documentation would be =
great.

> But I may be splitting hairs here and maybe I shouldn't be too concerned =
about it.  Regardless, I'd think I'd rather see something that isn't totall=
y gen_bd specific.  Perhaps *microcode should be part of the bcom_task stru=
cture?

See above - I believe FEC and ATA are somewhat special as they need *exactl=
y* the provided microcode.  And if something cannot be changed without brea=
king the functionality, there should not be a chance to do so... ;-)

Just my =E2=82=AC0.01, though...

Cheers, Albrecht.

--=-L5dlEsfWiBH9E0Y1n6LQ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iD8DBQBKykwcn/9unNAn/9ERAkV3AJ9XD59UZWbSvLZQn2E4cIgym0s+QgCfZABY
ELPgqLQz6qih3dccm3ri8a0=
=lNp5
-----END PGP SIGNATURE-----

--=-L5dlEsfWiBH9E0Y1n6LQ--
