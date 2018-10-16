Return-Path: <SRS0=rnOA=M4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED65C04EB9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 02:23:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40125208D9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 02:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="O6ps0C+m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40125208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Yzcv0PNDzF326
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 13:23:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="O6ps0C+m";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42YzXJ3qTJzF3WV
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Oct 2018 13:19:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=canb.auug.org.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au
 header.b="O6ps0C+m"; dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42YzXJ1QNHz9sCT;
 Tue, 16 Oct 2018 13:19:28 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
 s=201702; t=1539656368;
 bh=JGKbPkIJTpQICeV106B4lunVFzv8Q93qlHtDURju9Mw=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=O6ps0C+m1qX/BEMje/tXWeYkxaEF2d6VXsD/gMib25wrFE85BrpfOeH/MEllN1kmJ
 rbg0D0PMIkYfCEaJiWjF+cjk1Cj3fnbn2dlXVusBI5JM2O26kCUwfst8b+/OvS+zov
 tbnZfir5B7bpHpkitQz17AT41DazAkFn194XBSjRiegRaEJyPi/k0LSvpbQO+hOVww
 Dxzf3fsSbZkY9wIb9w80UR2KQzIkB8VOjcZFCrol/fdATgm2tnAYOxdSJcPE0IkxRn
 qrCEa5WmFclR7Iqa7V+wry3PS6g7JJpMMnKLOTQ9P1BPkYnVyIxW8cwTodwdFL28KA
 hSbWIayiCLZfg==
Date: Tue, 16 Oct 2018 13:19:27 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Guenter Roeck <linux@roeck-us.net>
Subject: Re: linux-next: Tree for Oct 15
Message-ID: <20181016131927.6ceba6ab@canb.auug.org.au>
In-Reply-To: <20181016130216.3a417381@canb.auug.org.au>
References: <20181015192546.15faf3a1@canb.auug.org.au>
 <20181015193914.GA9881@roeck-us.net>
 <20181016073359.3fa7bb32@canb.auug.org.au>
 <20181015222213.GA31415@roeck-us.net>
 <20181016130216.3a417381@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/j_E700Tl6v3gnhQuir/=FN3"; protocol="application/pgp-signature"
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
 Mike Rapoport <rppt@linux.vnet.ibm.com>,
 Linux-Next Mailing List <linux-next@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

--Sig_/j_E700Tl6v3gnhQuir/=FN3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 16 Oct 2018 13:02:16 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Reverting fe3d2a45e8079fdd7d4da1ff07f4b40bc3cb499f (and the following 2
> commits) produces a kernel that boots.

Instead of that, I applied this patch on top of linux-next and it boots
and produces a stack trace ...

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 16 Oct 2018 13:07:01 +1100
Subject: [PATCH] mm/memblock.c: use dump_stack() instead of WARN_ON_ONCE for
 the alignment checks

Using WARN_ON_ONCE too early causes the PowerPC kernel to fail.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 mm/memblock.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index 5fefc70253ee..f2ef3915a356 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1298,8 +1298,10 @@ static phys_addr_t __init memblock_alloc_range_nid(p=
hys_addr_t size,
 {
 	phys_addr_t found;
=20
-	if (WARN_ON_ONCE(!align))
+	if (!align) {
+		dump_stack();
 		align =3D SMP_CACHE_BYTES;
+	}
=20
 	found =3D memblock_find_in_range_node(size, align, start, end, nid,
 					    flags);
@@ -1423,8 +1425,10 @@ static void * __init memblock_alloc_internal(
 	if (WARN_ON_ONCE(slab_is_available()))
 		return kzalloc_node(size, GFP_NOWAIT, nid);
=20
-	if (WARN_ON_ONCE(!align))
+	if (!align) {
+		dump_stack();
 		align =3D SMP_CACHE_BYTES;
+	}
=20
 	if (max_addr > memblock.current_limit)
 		max_addr =3D memblock.current_limit;
--=20
2.18.0

So, patch "memblock: stop using implicit alignment to SMP_CACHE_BYTES"
should *not* remove the 0 -> SMP_CACHE_BYTES update from mm/memblock.c
and just add the dump_stack().
--=20
Cheers,
Stephen Rothwell

--Sig_/j_E700Tl6v3gnhQuir/=FN3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlvFSq8ACgkQAVBC80lX
0Gz+ywf/T90EMZ0R3tFjrcmUpFEmGa2TFSBV6p/JeR+noxv+SOMpS8u9NuxxzUQr
eU7HgWqjyJ+pWsq5AfzalpVL4LBFHx1sVUFOe+K1DP2cYWO3njbQgOCKMfK5eRvu
hQYvktyvomKwCg+95pHtoPrLbrvL+TcmdW7dGv+naFC8tnvRY4o8w9zxqdAnmeF9
6eFa0CFta79sUGQSi6lZNZyzziw7FI/tBz3VaFmr99uaPnPdBHlaSv3hTKgT2lKs
kKpqRBkFmDh9ebca6r4/du9w8H4dC/3y0aRL6P3ZsE3KfovXRfN2br24KcXQOQ5Q
VbBg3u6MSG7cZGD9tdzGPZI1D3DYeA==
=PHN3
-----END PGP SIGNATURE-----

--Sig_/j_E700Tl6v3gnhQuir/=FN3--
