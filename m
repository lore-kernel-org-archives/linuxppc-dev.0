Return-Path: <albrecht.dress@arcor.de>
Received: from smtp6.netcologne.de (smtp6.netcologne.de [194.8.194.26])
	by ozlabs.org (Postfix) with ESMTP id 1A30CB7D31
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  5 Feb 2010 06:35:16 +1100 (EST)
Date: Thu, 04 Feb 2010 20:35:12 +0100
From: Albrecht =?iso-8859-1?b?RHJl3w==?= <albrecht.dress@arcor.de>
Subject: Re: MPC5200B XLB Configuration Issues, FEC RFIFO Events, ATA Crashes
To: Roman Fietze <roman.fietze@telemotive.de>
In-Reply-To: <201002030716.31280.roman.fietze@telemotive.de> (from
	roman.fietze@telemotive.de on Wed Feb  3 07:16:31 2010)
Message-Id: <1265312112.2256.1@antares>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg=PGP-SHA1; boundary="=-hWn7wCkfgYSzxn655QI8"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--=-hWn7wCkfgYSzxn655QI8
Content-Type: text/plain; charset=us-ascii; DelSp=Yes; Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Roman:

Am 03.02.10 07:16 schrieb(en) Roman Fietze:
> Sorry for the delay ... your mail got stuck in a Notes "spam filter".

Never mind.  I didn't know yet that I'm *such* a nasty guy... ;-)

> Are you using MWDMA2 with the compact flash cards? What is the load on th=
e different (DMA) channels? ATA reads or writes?

Actually, I forgot that I have to explicitly enable libata dma on the 5200b=
, due to the known silicon bugs...  I will repeat my tests with the proper =
configuration, stay tuned.

>> ... a signal processor attached to the localbus, using bestcomm and the =
fifo for the bulk transfer
>=20
> Are you using an own driver, or are you using Grant's SCLPC+SDMA driver? =
BD task?

Basically Grant's driver, but with a slightly modified variant of the gen_b=
d task.  The signal processor is a LE, and I managed to insert the LE/BE co=
nversion into the bestcomm task (see also <http://patchwork.ozlabs.org/patc=
h/35038/>).  Unfortunately, there is no good documentation of the engine; I=
 would like to also shift crc calculation into bestcomm, which seems to be =
possible in principle, but I never got it running.

> The best thing is to run very ugly tests with very high load for at least=
 24h.

Thanks again for this tip!  I hope I manage to run a test over the weekend.=
  Throughput onto the cf cards is not critical for me (so I could live with=
 pio there), but I'm a little afraid I might also see similar effects with =
fec and the signal processor (in particular, the latter *is* critical).

Thanks, Albrecht.

--=-hWn7wCkfgYSzxn655QI8
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iD8DBQBLayFwn/9unNAn/9ERAv14AJ0VNLnjRnvU20YB+fXWePnStc6iXQCgk7Wk
H12CLMkcMtKPg/8vjep2dl8=
=4ies
-----END PGP SIGNATURE-----

--=-hWn7wCkfgYSzxn655QI8--
