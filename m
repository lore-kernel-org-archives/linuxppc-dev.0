Return-Path: <albrecht.dress@arcor.de>
Received: from smtp6.netcologne.de (smtp6.netcologne.de [194.8.194.26])
	by ozlabs.org (Postfix) with ESMTP id B1AA5B7BB4
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Oct 2009 05:31:35 +1000 (EST)
Date: Thu, 01 Oct 2009 21:31:25 +0200
From: Albrecht =?iso-8859-1?b?RHJl3w==?= <albrecht.dress@arcor.de>
Subject: Re: [PATCH] powerpc/5200: add LocalPlus bus FIFO device driver
To: John Bonesio <bones@secretlab.ca>
In-Reply-To: <1254422721.689.0.camel@riker> (from bones@secretlab.ca on Thu
	Oct  1 20:45:21 2009)
Message-Id: <1254425492.3252.0@antares>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg=PGP-SHA1; boundary="=-BiIDt2cqqBH1MvntAwZU"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--=-BiIDt2cqqBH1MvntAwZU
Content-Type: text/plain; charset=us-ascii; DelSp=Yes; Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi John:

Am 01.10.09 20:45 schrieb(en) John Bonesio:
> Nowhere in the text does it say 0 and 1 are the only possible values. =20
> And since GR is a 3 bit field instead of a 1 bit field, that implied =20
> that to me that other values are allowed.
>=20
> I can see how one could read the text as saying 0 and 1 are the only =20
> values allowed. However, empirical the testing I've done, seems to =20
> indicate that the '7' is a valid value, as it produced different =20
> behavior than 1.

Thanks for the clarification!

> I've put in the suggested change to set the 'flush' bit. It didn't =20
> seem to help. I'm not sure what else might be different between my =20
> system and yours.

My board is a self-designed one, roughly Icecube-based, with a 5200B.  =20
The peripheral (actually a second processor) is attached in 16-bit mode =20
to the LPB.  The main data flow goes to the 5200, so I have only a task =20
for reading data.  As the block transfer is only one part (but with a =20
huge block size) in a transaction, I allocate only one block for the =20
task, i.e. I call bcom_gen_bd_rx_init(1, ...).

The transaction size is always a multiple of 4 bytes, and I use the =20
same value for the FIFO packet size and struct bcom_bd::status.  In the =20
Control reg, I set CS, BPT=3D4, DAI, RWb and Flush.  I can isolate the =20
code launching Bestcomm if you're interested.

I ran some further tests today, which are a little confusing...

When a Bestcomm IRQ arrives, the call to bcom_buffer_done() (in the =20
isr) will always return 0.  If I just ignore that, and call =20
bcom_retrieve_buffer() anyway, the status value will also be 0.  =20
However, the data block is transferred completely, and it is correct (I =20
separately transmit a crc32, which matches, and the data block itself =20
looks fine).  Actually, I'm not really sure what this means...

BTW, I noticed that the Bestcomm IRQ arrives *before* the FIFO IRQ, =20
which IMHO is a little unlogical.  It may be a result of setting the =20
granularity to 0 and the FIFO Alarm level to 4 (which should trigger =20
Bestcomm only if one u32 is free in the FIFO - is that correct?  At =20
least the drawing on Pg. 11 in Freescale's AN2604 implies that.).

> We were testing using the Bestcomm on a framebuffer to refresh the =20
> display. Without the watermarks, the DMA was getting clogged.

I see.  In my case, only the /overall/ time and cpu load for the =20
transaction are critical, and there I didn't notice significant =20
differences.

Cheers,
Albrecht.

--=-BiIDt2cqqBH1MvntAwZU
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iD8DBQBKxQOUn/9unNAn/9ERAgJ3AJ9LswVMDDt+d5WZGFPE/g841ZkBMQCeM0Td
9PthTN8Hy/WyzMT/LBV6cRs=
=NIhI
-----END PGP SIGNATURE-----

--=-BiIDt2cqqBH1MvntAwZU--
