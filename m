Return-Path: <albrecht.dress@arcor.de>
Received: from smtp6.netcologne.de (smtp6.netcologne.de [194.8.194.26])
	by ozlabs.org (Postfix) with ESMTP id 68503B7BCC
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Oct 2009 04:40:18 +1000 (EST)
Date: Wed, 30 Sep 2009 20:34:15 +0200
From: Albrecht =?iso-8859-1?b?RHJl3w==?= <albrecht.dress@arcor.de>
Subject: Re: [PATCH] powerpc/5200: add LocalPlus bus FIFO device driver
To: John Bonesio <bones@secretlab.ca>
In-Reply-To: <20090929204248.16225.22818.stgit@riker> (from
	bones@secretlab.ca on Tue Sep 29 22:43:42 2009)
Message-Id: <1254335663.3681.0@antares>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg=PGP-SHA1; boundary="=-fnWOf/JbixxowXAZgfA8"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--=-fnWOf/JbixxowXAZgfA8
Content-Type: text/plain; charset=us-ascii; DelSp=Yes; Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi John:

Cool stuff - Grant's original one also helped me a lot to get Bestcomm =20
running for me (I use it only for read dma)!

Am 29.09.09 22:43 schrieb(en) John Bonesio:
[snip]
> +		 * It may be worth experimenting with the ALARM value =20
> to see if
> +		 * there is a performance impacit.  However, if it is =20
> wrong there
> +		 * is a risk of DMA not transferring the last chunk of =20
> data
> +		 */
> +		if (write) {
> +			out_be32(lpbfifo.regs + LPBFIFO_REG_FIFO_ALARM, =20
> 0x1e4);
> +			out_8(lpbfifo.regs + LPBFIFO_REG_FIFO_CONTROL, =20
> 7);
> +			lpbfifo.bcom_cur_task =3D lpbfifo.bcom_tx_task;
> +		} else {
> +			out_be32(lpbfifo.regs + LPBFIFO_REG_FIFO_ALARM, =20
> 0x1ff);
> +			out_8(lpbfifo.regs + LPBFIFO_REG_FIFO_CONTROL, =20
> 0);
> +			lpbfifo.bcom_cur_task =3D lpbfifo.bcom_rx_task;

Hmmm, the MPC5200B User's manual, sect. 9.7.3.3 LPC Rx/Tx FIFO Control =20
Register (pg. 323) seems to imply that only 0 or 1 are valid settings =20
here.  Where does the 7 come from?

[snip]
> +			 * In the DMA read case, the DMA doesn't =20
> complete,
> +			 * possibly due to incorrect watermarks in the =20
> ALARM
> +			 * and CONTROL regs. For now instead of trying =20
> to
> +			 * determine the right watermarks that will =20
> make this
> +			 * work, just increase the number of bytes the =20
> FIFO is
> +			 * expecting.

My experience is that for reads I have to set a granularity of 0 (as =20
you already do) *and* set the 'flush' bit in the SCLPC Control =20
Register.  See the remarks for that bit in the MPC5200B User's manual, =20
pg. 318.  With these settings and my driver, I made several tests =20
reading blocks (in one Bestcomm operation) between 16 bytes and 2 =20
MBytes, and *never* had any problem, so your remark here makes me =20
somewhat nervous!

In my dma read tests, the watermark (LPC Rx/Tx FIFO Alarm Register) =20
seems to have only a (small) performance impact.  If I set the =20
watermark to 0 (i.e. fill the fifo completely), I *never* saw any =20
under- or overruns.  My assumption is that the fifo would stop reading =20
the peripheral when it is full, and only resume when Bestcomm emptied =20
it at least partly.  You you know if that is really the case?

[snip]
> +
> +	bit_fields =3D req->cs << 24 | 0x000008;
> +	if (!write)
> +		bit_fields |=3D 0x010000; /* read mode */

See above - should be "bit_fields |=3D 0x030000" IMHO...

[snip]
> +	/* Request the Bestcomm receive (fifo --> memory) task and IRQ =20
> */
> +	lpbfifo.bcom_rx_task =3D
> +		bcom_gen_bd_rx_init(2, res.start + =20
> LPBFIFO_REG_FIFO_DATA,
> +				    BCOM_INITIATOR_SCLPC, =20
> BCOM_IPR_SCLPC,
> +				    16*1024*1024);

Is the limit really correct?  The manual (sect. 9.7.2.1 SCLPC Packet =20
Size Register, pg. 316) says the maximum packet size is 16 M - 1 byte.

Cheers,
Albrecht.

--=-fnWOf/JbixxowXAZgfA8
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iD8DBQBKw6Svn/9unNAn/9ERAhndAJ9flh+b36w1tzmioazgvjXtlnGIwgCeM4j/
qiGH3MGRvkAA6ytqQnF+90s=
=v8H7
-----END PGP SIGNATURE-----

--=-fnWOf/JbixxowXAZgfA8--
