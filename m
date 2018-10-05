Return-Path: <SRS0=9KTJ=MR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 296AEC00449
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 12:48:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C3EA20875
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 12:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="c2cd0JUT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C3EA20875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42RV1T0j7KzF3S6
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 22:48:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="c2cd0JUT";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42RTyS6QvkzF3R0
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Oct 2018 22:46:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=canb.auug.org.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au
 header.b="c2cd0JUT"; dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42RTyS0BWXz9s7W;
 Fri,  5 Oct 2018 22:46:07 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
 s=201702; t=1538743568;
 bh=kZ8YHf7LMkSrPJX1qYsUSDTKEmCCls6e5+J1C0ZeCvw=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=c2cd0JUTS7+yGDV9+ZjiWOni/Gvh/dLtUt03p1ig3rRGw1kOjOC+4ptk9oEzZ0bRM
 s/hogmcGLC0eT2Hau60M/Bpk2BjvnuedXVB9GkTHUV1dTe0ZvfAQEb3CQCD4h8qJkZ
 9tu3OyWdalJIUELYDe7G4D4y4FyhWe1vlXBEgk2GckVeIjR57FilPjSBtY7hF30IVW
 kK9iUNEEu/y3WEoZC1cgIx14MaqszrHNeEa3CHaTrcJ26sqnGxGxUviJ5C7IceE8Yq
 bp0DUszH/h0kOsELkl0u4ia3h1sTnhLBMzB1D6DakzpFfFjNXf0lIlrC+DfnQ9N2u/
 m7/CC5QD2jXcA==
Date: Fri, 5 Oct 2018 22:46:06 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: linux-next: build failure after merge of the akpm tree
Message-ID: <20181005224606.2372fece@canb.auug.org.au>
In-Reply-To: <87d0sok3dm.fsf@concordia.ellerman.id.au>
References: <20181005161406.73ef8727@canb.auug.org.au>
 <87d0sok3dm.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Vss.RuVkbVq2Ytp_cX61Awd"; protocol="application/pgp-signature"
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
 Linux-Next Mailing List <linux-next@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

--Sig_/Vss.RuVkbVq2Ytp_cX61Awd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On Fri, 05 Oct 2018 22:02:45 +1000 Michael Ellerman <mpe@ellerman.id.au> wr=
ote:
>
> Ah fudge, what are the chances we add a new include of bootmem.h just as
> Mike's removing bootmem.

In my experience, it was almost certain ... almost every API removal
conflicts with new added uses.  :-)

> I could just apply that to my tree. memblock.h is where early_memtest() is
> actually defined anyway.

However min_low_pfn and max_low_pfn are defined in bootmem.h until
after it is removed.

--=20
Cheers,
Stephen Rothwell

--Sig_/Vss.RuVkbVq2Ytp_cX61Awd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlu3XQ4ACgkQAVBC80lX
0GyI1Af/b457Gsh24moiyWRAUs9XuZnTCmO7kcIrjxJ2cDnqUnfYWL5Kewvzc+Pu
fs/MYPLiKZ80JOW6oVoCmmVjr1sRZbxcVHJNPmWk73KLIomsfHuYMPBU4u1secC6
kq8yXGA6AqdYkxOWOsnt36Z6V/WYb/vjr+m5h07AqfCkoNh4BxSx9DR3sX3qZDzo
U7VS7sY1LZ7t7J5TklQuoRbXkPfgZT3IXuQIjIJuYKtIPPoB8LwNrg9ZIIgo/d5u
nonuhc8IZjZvo8QSojKjJL9VG5VGI+g8+YXi8XIP5VeGClIDLiKNCF3shEC3LHbb
zglQqbL6n/aTPDOPuuYLcNWDWy2O3w==
=UriJ
-----END PGP SIGNATURE-----

--Sig_/Vss.RuVkbVq2Ytp_cX61Awd--
