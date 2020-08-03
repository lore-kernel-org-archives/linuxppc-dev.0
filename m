Return-Path: <SRS0=LND+=BN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B560C433DF
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2020 05:01:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91D652068F
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2020 05:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="QQAcTy+N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91D652068F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BKm1k1Gs9zDqSC
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2020 15:01:14 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BKlzZ4vpczDqRr
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Aug 2020 14:59:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=canb.auug.org.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au
 header.a=rsa-sha256 header.s=201702 header.b=QQAcTy+N; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4BKlzY1RNmz9s1x;
 Mon,  3 Aug 2020 14:59:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
 s=201702; t=1596430762;
 bh=MPhLnoYZ1H5ZvLDWHdju+j3itySzNLNR+DZxYy9IYNw=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=QQAcTy+NeF/H+YtJdcgnyqiwVBl+3dAeUgIc/CElGZRCnphjUhbGe5K9KcHunBFpR
 tCbo/SeRBBZS8I9wVXYEkjymC2cFBLpa8xcxN+zQiEopmTuVd1EXOyjbUSotq3yViw
 AgC+AQb7rer1tNoxVwP9eX4g4qm4tJwZd6aWLqnodhNATEWxOujoVE2aVlLqoLk8Aa
 BHqGkn3hxhM1m/i+yfc9P7MMv/MA7aq6oTXhnuqDgGdUi3IEVXPd+Bo+OuuHXwdhz1
 tkoBoEE2oo+1S2yzA1owsIiYwg2Goev88O56jWESos4Coz9KUiGESLMcduyQLldQLZ
 icRQJTv35wb6g==
Date: Mon, 3 Aug 2020 14:59:20 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc: fix up PPC_FSL_BOOK3E build
Message-ID: <20200803145920.72a6fa4b@canb.auug.org.au>
In-Reply-To: <20200803135447.3833067d@canb.auug.org.au>
References: <20200803135447.3833067d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/_a6zgj=YiioLKMMN9YZ42FX";
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
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Linux PowerPC List <linuxppc-dev@lists.ozlabs.org>, Willy Tarreau <w@1wt.eu>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

--Sig_/_a6zgj=YiioLKMMN9YZ42FX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 3 Aug 2020 13:54:47 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Commit
>=20
>   1c9df907da83 ("random: fix circular include dependency on arm64 after a=
ddition of percpu.h")
>=20
> exposed a curcular include dependency:
>=20
> asm/mmu.h includes asm/percpu.h, which includes asm/paca.h, which
> includes asm/mmu.h
>=20
> So fix it by extracting the small part of asm/mmu.h that needs
> asm/percu.h into a new file and including that where necessary.
>=20
> Cc: Willy Tarreau <w@1wt.eu>
> Cc: <stable@kernel.org>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

I should have put:

Fixes: 1c9df907da83 ("random: fix circular include dependency on arm64 afte=
r addition of percpu.h")

--=20
Cheers,
Stephen Rothwell

--Sig_/_a6zgj=YiioLKMMN9YZ42FX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl8nmagACgkQAVBC80lX
0GzdnAf/efDjHOIC93+8ioQY0UcLlTfk9I7vm8keK3/kCYBUUFSV0y/ewUjRYz4s
4WYVm0Xj00VX9FkiGB8lhoO0nGsf+P9O2k59Y6kQwndAldplPwcjzIgsSDSx+LBm
/aBItNNDfabEUMp67T2ybKCfy1h08wsInmM9gl0V2z1Mo1r4ax3StistxUzQwGj5
fScto/C2aistdWaybnT3Y8AQTMJhxBXkuZoc4s2aMEYC7JxVN/goi3ItOyC37GLL
LR8a1XvjS3sdDZ7gGsY8PXBSB4AmDMx5UPNHAxQk0vKFOQqveoSNxoskOWUEKNrZ
Px72hWk/2AInQqviFzFMMzsPmqw3og==
=Ghwq
-----END PGP SIGNATURE-----

--Sig_/_a6zgj=YiioLKMMN9YZ42FX--
