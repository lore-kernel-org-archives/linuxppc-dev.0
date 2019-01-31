Return-Path: <SRS0=ULCe=QH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D2A0C169C4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 07:15:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F23982087F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 07:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="MtFxrPn1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F23982087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43qs1t0sHJzDqYW
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 18:14:58 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43qs0471cZzDq6Q
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Jan 2019 18:13:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=canb.auug.org.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au
 header.b="MtFxrPn1"; dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43qs040yCQz9sDX;
 Thu, 31 Jan 2019 18:13:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
 s=201702; t=1548918804;
 bh=Sh+qWcZmCFTXDL4E2MTdKlxXnuDL5PJc0pFwnB2iMPs=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=MtFxrPn1Ru+WF6o5vmogBy7yYbHW8VbUFfU6X6AXkuuh3w0aE2hNAxj9b7Ro+YSfT
 318tSdf8Xwb7GNIixvIuRuRMi4EYFEksSM3T8CvR5qGRR/cIeq6bfGVVe318aRv+Td
 VM7609QVyz1opG2zl80ftvpo1Nw7PXQdiG+XEYpU4yYpzo4/gb/t9a6dZlUFW7SFJd
 K5qKLpBMCLgyoFte3fyDrCBEw4MOFauUCnnvhxoxeABWquF0jTsUoRYuFr+YkXfzJe
 0wrmu6Weyu1EnkF9XhRVJ46QzM3PpJmWQnTHNX0YW4dIv3K9VNp1awk1v72FjWB3sd
 ffV786sXQ5qag==
Date: Thu, 31 Jan 2019 18:13:15 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: linux-next: powerpc le qemu boot failure after merge of the
 akpm tree
Message-ID: <20190131181315.7075054c@canb.auug.org.au>
In-Reply-To: <20190131063930.GA28876@rapoport-lnx>
References: <20190131163854.307e17ab@canb.auug.org.au>
 <20190131170629.2cc20600@canb.auug.org.au>
 <962e7dd7-779b-2c32-59db-9ced6751dede@c-s.fr>
 <20190131063930.GA28876@rapoport-lnx>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Begdjz6ZnAceTu6a=esW_K="; protocol="application/pgp-signature"
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

--Sig_/Begdjz6ZnAceTu6a=esW_K=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Mike,

On Thu, 31 Jan 2019 08:39:30 +0200 Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> On Thu, Jan 31, 2019 at 07:15:26AM +0100, Christophe Leroy wrote:
> >=20
> > Le 31/01/2019 =C3=A0 07:06, Stephen Rothwell a =C3=A9crit=C2=A0: =20
> > >>My qemu boot of the powerpc pseries_le_defconfig config failed like t=
his:
> > >>
> > >>htab_hash_mask    =3D 0x1ffff
> > >>-----------------------------------------------------
> > >>numa:   NODE_DATA [mem 0x7ffe7000-0x7ffebfff]
> > >>Kernel panic - not syncing: sparse_buffer_init: Failed to allocate 21=
47483648 bytes align=3D0x10000 nid=3D0 from=3Dfffffffffffffff =20
>=20
> This means that sparse_buffer_init tries to allocate 2G for the sparsemap=
_buf...
>=20
> Stephen, how many memory do you give to your VM?

Exactly 2G.

     qemu-system-ppc64 -M pseries -m 2G ....

The boot normally continue like this:

    rfi-flush: fallback displacement flush available
    count-cache-flush: software flush disabled.
    stf-barrier: hwsync barrier available
    PCI host bridge /pci@800000020000000  ranges:
      IO 0x0000200000000000..0x000020000000ffff -> 0x0000000000000000
     MEM 0x0000200080000000..0x00002000ffffffff -> 0x0000000080000000
     MEM 0x0000210000000000..0x000021ffffffffff -> 0x0000210000000000
    PPC64 nvram contains 65536 bytes
    barrier-nospec: using ORI speculation barrier
    Zone ranges:
      Normal   [mem 0x0000000000000000-0x000000007fffffff]
    Movable zone start for each node
    Early memory node ranges
      node   0: [mem 0x0000000000000000-0x000000007fffffff]
    Initmem setup node 0 [mem 0x0000000000000000-0x000000007fffffff]

--=20
Cheers,
Stephen Rothwell

--Sig_/Begdjz6ZnAceTu6a=esW_K=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxSoAsACgkQAVBC80lX
0GxEMgf/VRv09NYFHoUPNG66k6XeBsetwQXhtNaX4Sml3GO6x2Dpr0tieVJTxc3L
FHecP5pPqRrEnnopnwTQdVrXc0NY/SnJyYnailD3S+XqzhgxaefGye80tlwbHtNb
Ww8mGnuTjQInOkwQQvma3DQpn37jotf7Rq8kLnAxu4UV3iMwk8rX4YFVc6/cnpQ4
/U7Nr5eBN8TcDOozjlEYWzezGp+b2ow1pX2xYbHKn7EUzrG3L7usHbw0ZCTa15ON
nee8do/07Z1KUxP7FAmac2u83+oWcR0cK3JcT4ODzQlBBsKZY5Z6q7irUI20CTKP
ccafb4iTjc0/we1rdH670XqRUK0u0Q==
=UW+q
-----END PGP SIGNATURE-----

--Sig_/Begdjz6ZnAceTu6a=esW_K=--
