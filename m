Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 1B00DDDDED
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Nov 2008 21:21:37 +1100 (EST)
Date: Thu, 13 Nov 2008 21:21:21 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Yuri Tikhonov <yur@emcraft.com>
Subject: Re: [PATCH] xsysace: use resource_size_t instead of unsigned long
Message-Id: <20081113212121.e7a9f5fe.sfr@canb.auug.org.au>
In-Reply-To: <200811131143.17752.yur@emcraft.com>
References: <200811131143.17752.yur@emcraft.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__13_Nov_2008_21_21_21_+1100_Vnx4uizXowUDlsiM"
Cc: Ilya Yanok <yanok@emcraft.com>, Detlev Zundel <dzu@denx.de>, Wolfgang,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__13_Nov_2008_21_21_21_+1100_Vnx4uizXowUDlsiM
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Yuri,

On Thu, 13 Nov 2008 11:43:17 +0300 Yuri Tikhonov <yur@emcraft.com> wrote:
>
> -	dev_dbg(ace->dev, "physaddr=3D0x%lx irq=3D%i\n", ace->physaddr, ace->ir=
q);
> +	dev_dbg(ace->dev, "physaddr=3D0x%llx irq=3D%i\n", (u64)ace->physaddr, a=
ce->irq);

You should cast the physaddr to "unsigned long long" as "u64" is
"unsigned long" on some architectures.  The same is needed in other
places as well.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__13_Nov_2008_21_21_21_+1100_Vnx4uizXowUDlsiM
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkkb/6EACgkQjjKRsyhoI8wiTgCePjrm9Y10duP0TWuRfNLCJZJr
iCQAnjxvR/sTUu2/GrgcESdm1jeRONVB
=4C8A
-----END PGP SIGNATURE-----

--Signature=_Thu__13_Nov_2008_21_21_21_+1100_Vnx4uizXowUDlsiM--
