Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 8C1E7DDE9F
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Mar 2007 02:10:30 +1100 (EST)
Date: Sun, 18 Mar 2007 02:10:35 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] [POWERPC] Wire up sys_sync_file_range
Message-Id: <20070318021035.efccad50.sfr@canb.auug.org.au>
In-Reply-To: <20070309152201.027c2bf5.sfr@canb.auug.org.au>
References: <20070309152201.027c2bf5.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Sun__18_Mar_2007_02_10_35_+1100_wZ+TDjjVNp=krbQ9"
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org,
	David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Sun__18_Mar_2007_02_10_35_+1100_wZ+TDjjVNp=krbQ9
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Fri, 9 Mar 2007 15:22:01 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> +asmlinkage long compat_sys_sync_file_range(int fd, u32 unused,
> +		u32 offset_high, u32 offset_low,
> +		u32 nbytes_high, u32 nbytes_low,
> +		compat_uint_t flags)
> +{
> +	return sys_sync_file_range(fd, (loff_t)offset_high << 32 | offset_low,
> +			(loff_t)nbytes_high << 32 | nbytes_low,
> +			(unsigned int)flags);
> +}

As pointed out elsewhere, this won't work as it needs to many registers
(we only have 6 for syscall args).  Probably our best bet is to follow in
arm's footsteps and create a wrapper that puts the flags arg after fd.

Comments?
--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sun__18_Mar_2007_02_10_35_+1100_wZ+TDjjVNp=krbQ9
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFF/ATwFdBgD/zoJvwRAlsPAJ9doEJ10W/+gh+9NqKomLZT49JTswCfZbjn
pQkaUdrNDXe8JCwJ+YLrOZs=
=XsXg
-----END PGP SIGNATURE-----

--Signature=_Sun__18_Mar_2007_02_10_35_+1100_wZ+TDjjVNp=krbQ9--
