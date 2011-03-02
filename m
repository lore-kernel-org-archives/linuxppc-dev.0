Return-Path: <albrecht.dress@arcor.de>
Received: from cc-smtpout3.netcologne.de (cc-smtpout3.netcologne.de
	[89.1.8.213]) by ozlabs.org (Postfix) with ESMTP id 5C97BB70D4
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Mar 2011 07:16:51 +1100 (EST)
Date: Wed, 02 Mar 2011 21:16:36 +0100
From: Albrecht =?iso-8859-1?b?RHJl3w==?= <albrecht.dress@arcor.de>
Subject: Re: [OT - MPC5200B] strange framing, break problems with uart
To: Henk Stegeman <henk.stegeman@gmail.com>
In-Reply-To: <AANLkTi=gqFLtM7f01GFVKdSibxz4q5J9LtHrpOcH_1ta@mail.gmail.com>
	(from henk.stegeman@gmail.com on Tue Mar  1 23:28:47 2011)
Message-Id: <1299097003.1795.0@antares>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg=PGP-SHA1; boundary="=-PId3oMF7lh6KkzRwPGbA"
Cc: Linux PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--=-PId3oMF7lh6KkzRwPGbA
Content-Type: text/plain; charset=us-ascii; DelSp=Yes; Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Henk:

Am 01.03.11 23:28 schrieb(en) Henk Stegeman:
> Today I noticed corrupted and missing chunks of data on the 5200 with the=
 2.6.37 uart driver in 2.6.37.
> I don't have these problems when I use the driver from 2.6.33 (with minor=
 changes to make it fit in 2.6.37).

Hmm, I hope it's not related to my my baud rate divisor selection patch... =
:-/

> While looking for a reason/solution online I came across your problem rep=
ort. I hope to investigate my problem further soon, but was also wondering =
if you found a cause/early solution for your problem yet, just in case they=
 could be related.

Well, my problem occurs when the '5200B is connected to a FTDI usb/serial c=
onverter (FT2232D) chip, and when both are configured to use rts/cts hw han=
dshake.

After some discussions with Freescale's and FTDI's support, the reason seem=
s to be that the FTDI chips continues to send zero up to 4 chars *after* th=
e RTSn line has been deactivated by the '5200B (actually, this is the behav=
iour of many uart's).  However, the manual says that the '5200B should repo=
rt overruns (and not breaks and/or framing errors) in this case.  Although =
I asked several times, the guy at Freescale did not say a word about this, =
but just blamed FTDI.  So, at best their manual is plain wrong...  Interest=
ingly, if I switch rts/cts off, I *do* get overrun errors.  Strange!

The solution for me seems to write my own driver - as I know (unlike "usual=
" serial connections) the packet sizes I expect, I can utilise the PSC's fi=
fo and issue an IRQ when it's almost (FIFO size minus 16 chars seems to be =
bullet-proof after first tests even at 3 MBaud) full.  In the ISR I /manual=
ly/ deactivate RTSn, a tasklet empties the FIFO and asserts RTSn again.  As=
 a positive side effect, it drastically reduces the number of interrupts.  =
Using Bestcomm would probably be better, but I didn't get it working (still=
 get the cpu irq's, and the task doesn't run).

Not sure if this information is helpful for you...

Cheers,
Albrecht.

--=-PId3oMF7lh6KkzRwPGbA
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iD8DBQBNbqWrn/9unNAn/9ERAs8ZAJ96K8ds/rCFibXmNEDXUy7X+WjHXgCbBQbm
io7s5vRUcDLjw3n2Jznq/OY=
=rzz8
-----END PGP SIGNATURE-----

--=-PId3oMF7lh6KkzRwPGbA--
