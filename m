Return-Path: <SRS0=ULCe=QH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D909BC169C4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 05:42:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57A922087F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 05:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="e7MhdO1i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57A922087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43qpyn30K9zDqSl
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 16:42:09 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43qpv543zCzDq6B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Jan 2019 16:38:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=canb.auug.org.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au
 header.b="e7MhdO1i"; dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43qpv341WSz9sBb;
 Thu, 31 Jan 2019 16:38:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
 s=201702; t=1548913135;
 bh=QbRkFz2eSuxgAk/k8V5DjMoNfUAh9wTJI0QF91SW+nA=;
 h=Date:From:To:Cc:Subject:From;
 b=e7MhdO1idGS0ykWNXq09oeqGBKEkUA7yjhFtb1nrbXhEeEn9q4ULgkwZrDuWxYp4D
 62OXn08eFvWbjZqa673uPByamKIKR7ujYZMIZQqDnSTsKs7jXrUtdCfuVJDMn2NNqa
 4dKsjWI5Lc55kLdrbd0hvK3D9N5Y/cUMUb1uZijj+8bcHOxTaV0Me6XaoJK8p243qR
 BZtnUy+zh/hnDafc1ugdeohCQai5ZpwBRJqLPPte6ErS97JWHzSK2k9kj1HI6KEB1Z
 jL6o+0Aor2A0ZCxhtp16lUZD0i8ip1cHu2OFTHMMRqfz1F92XMVQW620aPR9I7QuuD
 +f3WyJJobEDBw==
Date: Thu, 31 Jan 2019 16:38:54 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: linux-next: powerpcle qemu boot failure after merge of the akpm tree
Message-ID: <20190131163854.307e17ab@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ntkEG4.kWchexs_2hOHxgT1"; protocol="application/pgp-signature"
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
 Mike Rapoport <rppt@linux.ibm.com>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

--Sig_/ntkEG4.kWchexs_2hOHxgT1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

[I am guessing that is is something in Andrew's tree that has caused
this.]

My qemu boot of the powerpc pseries_le_defconfig config failed like this:

htab_hash_mask    =3D 0x1ffff
-----------------------------------------------------
numa:   NODE_DATA [mem 0x7ffe7000-0x7ffebfff]
Kernel panic - not syncing: sparse_buffer_init: Failed to allocate 21474836=
48 bytes align=3D0x10000 nid=3D0 from=3Dfffffffffffffff
CPU: 0 PID: 0 Comm: swapper Not tainted 5.0.0-rc4 #2
Call Trace:
[c00000000105bbd0] [c000000000b1345c] dump_stack+0xb0/0xf4 (unreliable)
[c00000000105bc10] [c000000000111120] panic+0x168/0x3b8
[c00000000105bcb0] [c000000000e701c8] sparse_init_nid+0x178/0x550
[c00000000105bd70] [c000000000e709b4] sparse_init+0x210/0x238
[c00000000105bdb0] [c000000000e468f4] initmem_init+0x1e0/0x260
[c00000000105be80] [c000000000e3b9b0] setup_arch+0x354/0x3d4
[c00000000105bef0] [c000000000e33afc] start_kernel+0x98/0x648
[c00000000105bf90] [c00000000000b270] start_here_common+0x1c/0x52c

--=20
Cheers,
Stephen Rothwell

--Sig_/ntkEG4.kWchexs_2hOHxgT1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxSie4ACgkQAVBC80lX
0GyoNwf8D5nWY24NFrP/NjzcK9jc58lkkCPf1DekarNUeR5vdhoLXoFXw4v1ShJz
EXdvMvCwmCG6eAVANIyRxPpZIwUEKPYOmRE0nP5SIUBoPPt04WLB70SPmPFeaECL
3CBDDSB8ZkTYLXTRHCWKfwYIHzvktXqf7gTSG73gxTaOv+4bHh3MA3jRZ/3WQJ7/
EA0m/G3nsfZWVrjyKbiaA0ONS/QRN9tYkMtnrV8S/DVE/U06eSrSeJeKpYZA1FDr
zPijbbOEY87VgncKCVw/0DOZjdttM/k7uMyR6Gk15ZjbPa2w11IgrbX9MD2zo2tx
Pm4vgyN0qKKrRuZePOflXndb5x5PNQ==
=bVoJ
-----END PGP SIGNATURE-----

--Sig_/ntkEG4.kWchexs_2hOHxgT1--
