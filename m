Return-Path: <fmhess@speakeasy.net>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id C43B3B709B
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  6 Jun 2009 23:43:09 +1000 (EST)
From: Frank Mori Hess <fmhess@speakeasy.net>
To: Greg KH <greg@kroah.com>
Subject: Re: [BUILD FAILURE 01/04] Next June 04:PPC64 randconfig
	[drivers/staging/comedi/drivers.o]
Date: Sat, 6 Jun 2009 09:36:17 -0400
References: <20090605182625.24093.7808.sendpatchset@elm3a191.beaverton.ibm.com>
	<1244261806.31984.36.camel@pasglop>
	<20090606055103.GA9446@kroah.com>
In-Reply-To: <20090606055103.GA9446@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1334805.Ii2zXVS4iC";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200906060936.22322.fmhess@speakeasy.net>
Cc: sachinp@linux.vnet.ibm.com, Frank Mori Hess <fmhess@users.sourceforge.net>,
	sfr@canb.auug.org.au, linux-kernel@vger.kernel.org,
	Linuxppc-dev@ozlabs.org, Ian Abbott <abbotti@mev.co.uk>,
	linux-next@vger.kernel.org, paulus@samba.org,
	Geert.Uytterhoeven@sonycom.com, geert@linux-m68k.org,
	subrata@linux.vnet.ibm.com, David Miller <davem@davemloft.net>
Reply-To: fmhess@users.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--nextPart1334805.Ii2zXVS4iC
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 06 June 2009, Greg KH wrote:
> Frank and Ian, any thoughts about the vmap call in the
> comedi_buf_alloc() call?  Why is it using PAGE_KERNEL_NOCACHE, and what
> is the prealloc_buf buffer used for?

It is a circular buffer used to hold data streaming either to or from a=20
board (for example when producing an analog output waveform).  Reads and=20
writes to the device files read/write to the circular buffer, plus a few=20
drivers do dma directly to/from it.  I personally don't have a problem=20
with requiring drivers to have their own dma buffers and making them copy=20
data between their private dma buffers and the main circular buffer.  I=20
guess the original design wanted to support zero-copy dma.


--nextPart1334805.Ii2zXVS4iC
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iD8DBQBKKnDT5vihyNWuA4URAm5TAJ9uya8bxVj7LuYrvxrcOgiaZyFqNACg1QmH
YUnOo4ea6+gFgDXBWgPrrd4=
=vopu
-----END PGP SIGNATURE-----

--nextPart1334805.Ii2zXVS4iC--
