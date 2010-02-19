Return-Path: <albrecht.dress@arcor.de>
Received: from smtp6.netcologne.de (smtp6.netcologne.de [194.8.194.26])
	by ozlabs.org (Postfix) with ESMTP id 44DDAB7C67
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 20 Feb 2010 05:04:21 +1100 (EST)
Date: Fri, 19 Feb 2010 19:04:09 +0100
From: Albrecht =?iso-8859-1?b?RHJl3w==?= <albrecht.dress@arcor.de>
Subject: Re: MPC5200B XLB Configuration Issues, FEC RFIFO Events, ATA Crashes
To: Roman Fietze <roman.fietze@telemotive.de>
In-Reply-To: <1265312112.2256.1@antares> (from albrecht.dress@arcor.de on
	Thu Feb  4 20:35:12 2010)
Message-Id: <1266602657.2227.0@antares>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg=PGP-SHA1; boundary="=-Xz4DHeX8SPku0pSXpiVF"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--=-Xz4DHeX8SPku0pSXpiVF
Content-Type: text/plain; charset=ISO-8859-1; DelSp=Yes; Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Roman:

Sorry for the long delay, I had to fix some other stuff first, before I cou=
ld launch the test...  Here is just a short intermediate result.

Am 04.02.10 20:35 schrieb(en) Albrecht Dre=DF:
> Actually, I forgot that I have to explicitly enable libata dma on the 520=
0b, due to the known silicon bugs...  I will repeat my tests with the prope=
r configuration, stay tuned.
>=20
>>> ... a signal processor attached to the localbus, using bestcomm and the=
 fifo for the bulk transfer
>>=20
>> Are you using an own driver, or are you using Grant's SCLPC+SDMA driver?=
 BD task?
>=20
> Basically Grant's driver, but with a slightly modified variant of the gen=
_bd task.  The signal processor is a LE, and I managed to insert the LE/BE =
conversion into the bestcomm task (see also <http://patchwork.ozlabs.org/pa=
tch/35038/>).  Unfortunately, there is no good documentation of the engine;=
 I would like to also shift crc calculation into bestcomm, which seems to b=
e possible in principle, but I never got it running.
>=20
>> The best thing is to run very ugly tests with very high load for at leas=
t 24h.

I today launched my test application, on kernel 2.6.32 with a few minor twe=
aks, which runs 4 threads in parallel, all first writing a number of data b=
locks, then doing a sync() when appropriate, and reading reading them all b=
ack and checking the contents (md5 hash):
- one writes/reads back 256 files of 256k each to a nfs3 share on a Xeon se=
rver, using a 100 MBit line;
- one writes/reads back one 1 MByte block using BestComm to a Localbus devi=
ce (see quote above);
- two write/read back 128 files of 64k each to two CF cards w/ vfat, both a=
ttached to the ata (master/slave).

Booting with 'libata.force=3Dmwdma2', this tests reproducibly freezes the s=
ystem *within a few minutes*, in one case leaving the vfat fs on one card c=
ompletely broken.  The system didn't throw a panic, it was always simply st=
uck - no response to the serial console, nothing.

Booting *without* this option (i.e. using pio for the cf cards), the system=
 seems to run flawlessly.  I will continue the test over the weekend (now a=
ctive for ~5 hours), but it looks as if I can reproduce your problem.  Next=
 week, I'll try your fix (hope I don't wear out the cf cards...), and re-ru=
n the test.

Best, Albrecht.

--=-Xz4DHeX8SPku0pSXpiVF
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iD8DBQBLftKhn/9unNAn/9ERAg/sAKCVE2pnqy+8WoTstcgSoGHl0PuKyACfU/Yj
XGGgi7AOGB2MfORNMNMPthA=
=EtAW
-----END PGP SIGNATURE-----

--=-Xz4DHeX8SPku0pSXpiVF--
