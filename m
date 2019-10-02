Return-Path: <SRS0=frIq=X3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA0EC35280
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Oct 2019 06:53:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29263215EA
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Oct 2019 06:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="LgRYLVhA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29263215EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46jn025n57zDqDK
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Oct 2019 16:53:06 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46jmy2207bzDqV1
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Oct 2019 16:51:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=canb.auug.org.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au
 header.b="LgRYLVhA"; dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 46jmy04J7Qz9sPL;
 Wed,  2 Oct 2019 16:51:20 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
 s=201702; t=1569999081;
 bh=ovxAl5uOUliXRc9fNQlkGlMy3gklUVsepeXTrYR9c80=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=LgRYLVhA6+HmJeFzJnjYWHhNHPiAHCZjm4Jm4lyzDIBYsVicKj6eUGdn+aJi731SE
 EYKlGQ1f7AvBGN26K2RQNFqQSCgt+VJphMpMXSgtkC9MKjX45bekAuk8BSAmRsC9/t
 uBmNwpR2T8de2N4Rkr5i9xigPS88U6eUeuQoI+t1/tqwPVfy9AC5+1NKTyMOGVI0/s
 8ehC4BpFLk7m9US+4nSIPr1D1+WeBXqgiXhEP1G0zllIk9QWSl5WunrhgofJ+iypvi
 yymuXEsIJZEQH55PF4iEsWwKyHh6A4j6nkv4tijMWzuh0FDwjZa5dph7Bq7jdIbajk
 /+zSLEMf7Q0Vw==
Date: Wed, 2 Oct 2019 16:51:19 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Laurent Dufour <ldufour@linux.ibm.com>
Subject: Re: [PATCH] powerpc/pseries: Remove confusing warning message.
Message-ID: <20191002165119.2a3d1791@canb.auug.org.au>
In-Reply-To: <20191001132928.72555-1-ldufour@linux.ibm.com>
References: <20191001132928.72555-1-ldufour@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/AIIknVOCfFA0xQnlgm_sxkq";
 protocol="application/pgp-signature"; micalg=pgp-sha256
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
Cc: linux-kernel@vger.kernel.org, npiggin@gmail.com, linux-mm@kvack.org,
 paulus@samba.org, aneesh.kumar@linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

--Sig_/AIIknVOCfFA0xQnlgm_sxkq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Laurent,

On Tue,  1 Oct 2019 15:29:28 +0200 Laurent Dufour <ldufour@linux.ibm.com> w=
rote:
>
> Fixes: 1211ee61b4a8 ("powerpc/pseries: Read TLB Block Invalidate Characte=
ristics")
> Reported-by: Stephen Rothwell <sfr@linux.ibm.com>

Please use my external email address <sfr@canb.auug.org.au>, thanks.

--=20
Cheers,
Stephen Rothwell

--Sig_/AIIknVOCfFA0xQnlgm_sxkq
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl2USOcACgkQAVBC80lX
0GwwEAf/cRL7HXJok9Y3fupcfvNbhTUiejF5JlvpNT2ao2CfWejue1IZuJCZVc/c
brY1YAAIM6EUJSefxNIo9cYJjedv4tkd2Di1HDHUSNuIPtZJ+6r+XZvfGuGnktTe
AR4vNvw8tZKgrIU4JUqD8llmi3GLJnc5uEfg3x6BkVGFZziuWqyH2tiOjoOYzSN2
CEWRPPvbNBvsAqDoiXtp3TmpKc8pxm5PmBqzS1CZxGh1ydbir2YhcN+JJeBp3S2z
U4r075Vln3ByjDztnRfHfAT+0JtY5khOuozC2EPjvnpPFtxwNvlQL6RTJfXyu+Za
lzMR+y76oZLmFWN56QAJsri52zPsUQ==
=TqBQ
-----END PGP SIGNATURE-----

--Sig_/AIIknVOCfFA0xQnlgm_sxkq--
