Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 27807DDE1C
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Mar 2007 21:23:17 +1100 (EST)
Date: Thu, 15 Mar 2007 21:23:19 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] [POWERPC] Wire up sys_sync_file_range
Message-Id: <20070315212319.d60d0457.sfr@canb.auug.org.au>
In-Reply-To: <20070309115901.GA29723@linux-mips.org>
References: <20070309152201.027c2bf5.sfr@canb.auug.org.au>
	<1173423341.3461.548.camel@pmac.infradead.org>
	<20070308.231341.41635421.davem@davemloft.net>
	<20070309115901.GA29723@linux-mips.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__15_Mar_2007_21_23_19_+1100_kihYA12gGGvukcz_"
Cc: linux-arch@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org,
	dwmw2@infradead.org, David Miller <davem@davemloft.net>,
	rmk@arm.linux.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__15_Mar_2007_21_23_19_+1100_kihYA12gGGvukcz_
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Fri, 9 Mar 2007 11:59:02 +0000 Ralf Baechle <ralf@linux-mips.org> wrote:
>
> I'd rather let the C compiler sort it out:
>
> asmlinkage long compat_sys_sync_file_range(int fd, int dummy,
> 	loff_t offset, loff_t nbytes, unsigned int flags)
> {
> 	sys_sync_file_range(fd, offset, nbytes, flags);
> }
>
> Which looks like it could be portable to PPC even, so maybe a little cpp
> magic like:
>
> #ifdef CONFIG_ABI_NEEDS_PADDING_
> #define PAD_64BIT_ARG(x)	unsigned int x,
> #else
> #define PAD_64BIT_ARG(x)
> #endif
>
> [...]
> asmlinkage long sys_sync_file_range(int fd,  PAD_64BIT_ARG(pad1)
> 	loff_t offset, loff_t nbytes, unsigned int flags)

Except the compat routines are built with a 64 bit compiler and the
callinf convention is different for 64 bit.  i.e. on ppc64 that routine
uses a single register for each parameter, while on 32 bit it uses 2
registers for each of the loff_t's.  It is this difference that we have
to cope with in the 64 bit kernel when the user process is 32 bit.
--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__15_Mar_2007_21_23_19_+1100_kihYA12gGGvukcz_
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFF+R6bFdBgD/zoJvwRAjf+AJsFGNfgc87UVwgabU7WyQPDCOBVXgCcC0jk
gtjvcdo3/Iz79r5iI86FSKE=
=TKPp
-----END PGP SIGNATURE-----

--Signature=_Thu__15_Mar_2007_21_23_19_+1100_kihYA12gGGvukcz_--
