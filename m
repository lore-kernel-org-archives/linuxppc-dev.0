Return-Path: <haokexin@gmail.com>
Received: from mail-pa0-x22b.google.com (mail-pa0-x22b.google.com
 [IPv6:2607:f8b0:400e:c03::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DD5351A02C4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2015 12:25:19 +1000 (AEST)
Received: by pacex6 with SMTP id ex6so133458162pac.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 19:25:18 -0700 (PDT)
Date: Tue, 22 Sep 2015 10:25:09 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: fsl_pci: cast the regs->nip to void * when
 passing it to probe_kernel_address()
Message-ID: <20150922022509.GH25724@pek-khao-d1.corp.ad.wrs.com>
References: <1442827370-26854-1-git-send-email-haokexin@gmail.com>
 <1442888219.19102.213.camel@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="OpLPJvDmhXTZE4Lg"
In-Reply-To: <1442888219.19102.213.camel@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--OpLPJvDmhXTZE4Lg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2015 at 09:16:59PM -0500, Scott Wood wrote:
> On Mon, 2015-09-21 at 17:22 +0800, Kevin Hao wrote:
> > With the reimplementation of probe_kernel_address() in commit
> > ecc83243e1d4 ("uaccess: reimplement probe_kernel_address() using
> > probe_kernel_read()"), the explication of the cast for the addr
> > parameter has been dropped. So we have to explicitly cast the
> > regs->nip to void * when passing it to probe_kernel_address() in
> > order to fix the following build error:
> >   arch/powerpc/sysdev/fsl_pci.c: In function 'fsl_pci_mcheck_exception':
> >   arch/powerpc/sysdev/fsl_pci.c:1002:4: error: passing argument 2 of=20
> > 'probe_kernel_read' makes pointer from integer without a cast [-Werror]
> >       ret =3D probe_kernel_address(regs->nip, inst);
> >       ^
> >=20
> > Signed-off-by: Kevin Hao <haokexin@gmail.com>
> > ---
> >=20
> > This is against linux-next.
>=20
> I don't see ecc83243e1d4 in linux-next.  What tree is it in?

It's a patch from Andrew Morton. But it seems that the patches commit id
=66rom Andrew's tree are not constant. Anyway I just fetched the latest
linux-next tree and found this issue was already fixed by commit 3a5f4236fe=
c1
("uaccess-reimplement-probe_kernel_address-using-probe_kernel_read-fix-fix"=
).

Thanks,
Kevin

--OpLPJvDmhXTZE4Lg
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWALwCAAoJEJNY7TDerrFxiT0H/AniBX6rvWY511smVFMRx2IP
1yALcLrio1c4P7TMdTq22VFvGi/kdOYuNIZcfYWfCUot84LeXlqZghuULAfIyUa5
YB8BGilSh7xS0JIDu/MHtI4e6iKtGViqW/1YnMNwZ5sh5yOAdx5JWLCSJ82gRKm1
BcQN2gRYip/BndX+5S4vJg51akqmacxrWwg/77dxwBrXWeeBEyWgjqA6KxTsGLcP
KoIgpPrr+6D8LrmUv0jxgy6SwPjPKD1s0CZfMBte1aU6gxGQcpy6iOkBa/xSa+SE
C3mDiu1GzPjwB+RAIqDhy2TeCe4M1nS6Tb40+yphZ83mE/e9ZGFdcr46fpHn5sM=
=UtWS
-----END PGP SIGNATURE-----

--OpLPJvDmhXTZE4Lg--
