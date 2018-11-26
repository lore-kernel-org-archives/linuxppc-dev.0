Return-Path: <SRS0=3VWP=OF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC15BC43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Nov 2018 07:00:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F01EB20672
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Nov 2018 07:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="sBrQLM3i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F01EB20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 433Hq474b0zDqLy
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Nov 2018 18:00:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="sBrQLM3i";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 433Hl96dv6zDqBH
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Nov 2018 17:56:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=canb.auug.org.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au
 header.b="sBrQLM3i"; dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 433Hl93Sxmz9rxp;
 Mon, 26 Nov 2018 17:56:37 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
 s=201702; t=1543215397;
 bh=JrNdPOF6cTscv0FIjSIk72febkJ73qcP1E9vzgLEw0o=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=sBrQLM3i18GOM8Ac2sRUW6sgcJB0B+QMsQ1w1a0oBGw1RbEt62YFasrXne5J4p8dZ
 wh1xPLle4kif2GGa4lLS23SVNaKYvTbLb0cihCYlYRaVgYISOnngSQaiuPAh2QWYlO
 +QHnOu/l75nRLTQA7IzWMx+9zzgArF47LD08wr6pSJBiDluW8EhUl3E8mLvqr2id/r
 CqP1xMlte+HcJ9dy7Q2m4TaybZUKUwQHmgnaxtTv+PaxZLZD4hHM03fN47bZY0eHsu
 Oz5Snybb659ckygrFDFybJE9RJBjDwiuQjeqe9gotodnmMyDXVTG/3vEGBPr1NnNNI
 Yxm+98HeFwplQ==
Date: Mon, 26 Nov 2018 17:56:37 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kees Cook <keescook@google.com>
Subject: Re: New linux-next KCFLAGS
Message-ID: <20181126175637.283b3137@canb.auug.org.au>
In-Reply-To: <20181126174926.65889a69@canb.auug.org.au>
References: <CAGXu5jL9WDRVCzPP0V2cvFHWfwAfd74kBNX9O+0frFkD26ti1Q@mail.gmail.com>
 <20181126084841.13679afd@canb.auug.org.au>
 <CAGXu5jL38a1Tx_LW9_j0sEHwLFGpuX-r2Y7dJq32eoED8BFrhw@mail.gmail.com>
 <20181126174926.65889a69@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/_RjSVHK+yOma+ez7ssPU+ir"; protocol="application/pgp-signature"
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
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

--Sig_/_RjSVHK+yOma+ez7ssPU+ir
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Kees,

On Mon, 26 Nov 2018 17:49:26 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> On Sun, 25 Nov 2018 21:46:20 -0800 Kees Cook <keescook@google.com> wrote:
> >
> > Excellent! (Though, wait, does this mean everyone _else_ will see this
> > too? I'm worried that will be way too noisy...) =20
>=20
> Ah, yes, you may be right.  everyone will see them :-(
>=20
> I may have to figure out another way to do this for tomorrow.

For today, I will just revert the commit that adds the flag at the
end or my merging run.  People will only see the warnings if they are
bisecting.

--=20
Cheers,
Stephen Rothwell

--Sig_/_RjSVHK+yOma+ez7ssPU+ir
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlv7mSUACgkQAVBC80lX
0GwsZwf+Jk/YUvKYuEv9Mn+hc4YCN2gz1xijPlFF/GwmtR7Yz0NDxK9LKVlOJnbP
MSJqzeWRxmrIhWy+bVJd5LB/Wo20Etl8br41nJdjfT9itexS4rbJiYfnzAZ+kWr2
lhG8MeOnyXX1S4q4TkWftYjhVq/5xogcq+AjJmeggFY/PvbJ3/+JdCTtuwY2TgmA
FNzSJUdTBYWiIRM4WPYJeV2sDBzpg+im08km84RpPA7gAcyjw9JIJzJ/VbXtw48A
1k6HAV758uW6Tj2g4f2Ld57LR4xV4F4G40Hk+LFKx4/cmL6u2+YMerlXbq1qJw0N
HOYyW+yFdMg1RAi+v0JDzrr9ymDT+A==
=dnX7
-----END PGP SIGNATURE-----

--Sig_/_RjSVHK+yOma+ez7ssPU+ir--
