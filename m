Return-Path: <haokexin@gmail.com>
Received: from mail-pa0-x233.google.com (mail-pa0-x233.google.com
 [IPv6:2607:f8b0:400e:c03::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A0E591A0295
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2015 12:11:40 +1000 (AEST)
Received: by padbj2 with SMTP id bj2so7984007pad.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 19:11:38 -0700 (PDT)
Date: Tue, 22 Sep 2015 10:11:29 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] powerpc: fsl_pci: cast the regs->nip to void * when
 passing it to probe_kernel_address()
Message-ID: <20150922021128.GG25724@pek-khao-d1.corp.ad.wrs.com>
References: <1442827370-26854-1-git-send-email-haokexin@gmail.com>
 <1442887697.18408.1.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="sLx0z+5FKKtIVDwd"
In-Reply-To: <1442887697.18408.1.camel@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--sLx0z+5FKKtIVDwd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2015 at 12:08:17PM +1000, Michael Ellerman wrote:
> On Mon, 2015-09-21 at 17:22 +0800, Kevin Hao wrote:
> > With the reimplementation of probe_kernel_address() in commit
> > ecc83243e1d4 ("uaccess: reimplement probe_kernel_address() using
> > probe_kernel_read()"), the explication of the cast for the addr
> > parameter has been dropped. So we have to explicitly cast the
> > regs->nip to void * when passing it to probe_kernel_address() in
> > order to fix the following build error:
> >   arch/powerpc/sysdev/fsl_pci.c: In function 'fsl_pci_mcheck_exception':
> >   arch/powerpc/sysdev/fsl_pci.c:1002:4: error: passing argument 2 of 'p=
robe_kernel_read' makes pointer from integer without a cast [-Werror]
> >       ret =3D probe_kernel_address(regs->nip, inst);
> >       ^
> >=20
> > Signed-off-by: Kevin Hao <haokexin@gmail.com>
> > ---
> >=20
> > This is against linux-next.
>=20
> You should be sending this to Andrew Morton, the author of the patch that
> caused the breakage. Or at the very least CC'ing him.

OK, will repost.

Thanks,
Kevin

--sLx0z+5FKKtIVDwd
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWALjNAAoJEJNY7TDerrFxVQ4H/AqN1Y9ziz619siC7gO7MWwn
+6VpH+xY9TM6ylmkCKBHA6/Q/scgE1pyhiiBH9p2RaWtSugA5oTQCsfPt5l7k8ov
KsdvyeKEemfI4pKC7zPwWhrxPTOapvFF/8irAR+xUACcm6qdiyqktG7dTs8wUxuI
Nm/rFZ5DWL85hQCK7cZOc6VtsZixqRZYA1JqlFNTmeRtqIztGoiVK/LwQu2zPxmn
b9Im85jPLNNnSe8aB9YRP99Q5UmAZkKbnqzl1OaQNcScckFkfsd1+J1ncuUvcQcB
c4rKFB82N2Bs+nBsESyPRPPiY3E09NXUP0lBj7gHEV6E4sWyYTJunP9ebiQW2UE=
=TGn+
-----END PGP SIGNATURE-----

--sLx0z+5FKKtIVDwd--
