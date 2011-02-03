Return-Path: <albrecht.dress@arcor.de>
Received: from cc-smtpout3.netcologne.de (cc-smtpout3.netcologne.de
	[89.1.8.213]) by ozlabs.org (Postfix) with ESMTP id 24BB2B70EA
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Feb 2011 05:44:35 +1100 (EST)
Received: from cc-smtpin1.netcologne.de (cc-smtpin1.netcologne.de [89.1.8.201])
	by cc-smtpout3.netcologne.de (Postfix) with ESMTP id 8E4AA1238C
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Feb 2011 19:34:41 +0100 (CET)
Received: from antares (xdsl-89-0-96-22.netcologne.de [89.0.96.22])
	by cc-smtpin1.netcologne.de (Postfix) with ESMTP id 637DD11E8D
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Feb 2011 19:34:41 +0100 (CET)
Received: from antares (antares [127.0.0.1])
	by antares (Postfix) with ESMTPS id 010D6BA01B
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Feb 2011 19:34:41 +0100 (CET)
Date: Thu, 03 Feb 2011 19:34:32 +0100
From: Albrecht =?iso-8859-1?b?RHJl3w==?= <albrecht.dress@arcor.de>
Subject: [OT - MPC5200B] strange framing, break problems with uart
To: Linux PPC Development <linuxppc-dev@ozlabs.org>
Message-Id: <1296758080.1854.0@antares>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg=PGP-SHA1; boundary="=-Sb/913HnqO4WOa9WE5yg"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--=-Sb/913HnqO4WOa9WE5yg
Content-Type: text/plain; charset=us-ascii; DelSp=Yes; Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

sorry for a slightly off-topic question, but I hope someone here on the lis=
t may be able to help me...

I have a strange problem with the psc uart of the mpc5200b, running 2.6.32.=
26 (still), with my baud rate divisor selection patch [1].

The uart runs at 115.2 kBaud with rtc/cts handshake to send bigger chunks o=
f data to the '5200.  I noticed "missing" data in the input stream, and ins=
pected the uart status using the TIOCGICOUNT ioctl which tells me that a bu=
nch of framing and break errors occurred.  I "tapped" the RxD line and conn=
ected it via a level shifter to a standard 16450-style uart in a (much fast=
er) Linux PC, and *that* one receives the *complete* stream *without any* b=
reak or framing errors!

I also looked at the waveforms with an oscilloscope, and they look pretty f=
ine.  The port configuration should also be ok, re-checked with a bdi3000 j=
tag debugger - it's PSC3, set to '1100', with PSC3_0 .. PSC3_3 being used h=
ere.

This leads me to the assumption that either the hardware handshake or the L=
inux driver or both are broken...  any insight would be highly appreciated!

Cheers,
Albrecht.


[1] <http://patchwork.ozlabs.org/patch/48884/>; included in 2.6.37

--=-Sb/913HnqO4WOa9WE5yg
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iD8DBQBNSvU/n/9unNAn/9ERAk8dAJ41FwBKfD+dxsNHBukAWfYqqTtyLgCgrxcC
v4QanRfm7rBqJuyObihDp2M=
=dt8T
-----END PGP SIGNATURE-----

--=-Sb/913HnqO4WOa9WE5yg--
