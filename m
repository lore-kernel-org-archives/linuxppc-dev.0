Return-Path: <SRS0=3VWP=OF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68479C43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Nov 2018 06:52:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFC0920672
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Nov 2018 06:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="rl0kJpn/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFC0920672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 433Hdn3xcbzDq5m
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Nov 2018 17:51:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="rl0kJpn/";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 433HZv3XhWzDqLp
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Nov 2018 17:49:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=canb.auug.org.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au
 header.b="rl0kJpn/"; dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 433HZt5RhQz9s29;
 Mon, 26 Nov 2018 17:49:26 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
 s=201702; t=1543214967;
 bh=QyAHgJclR3Od9eZAxmJdB6Grt792p9FemdPL75EHgdU=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=rl0kJpn/X97eEC/WErj6z2AeGxLRhz7m/HRQgfHT3KQ9vyymjLGmDBEFyeyYQ7VYt
 hsYSLBNIvgzgrfJNIbyPjZM7U55qMq0ICKxDbkNSxstsGfeUvWb3ejXVZNlRL5H7c/
 c2iYMHpftuZPLG3cODQp75Yg7TGwv/94mXE7Z1FoQlwO1Xy6WCz2BhKDHGIqzSCq65
 22RJob5c5jaEqveQ4A8Svx/P4cKhOVnpD2LI+ygseCQnsuV6YJNDRyVh9II9lVkzpL
 ImTiYlsrA9YwocRjpAb5o3ZSURrFWqyAwcMuL7bSggwEr0qNYrMwfGjRoxr6gdYOyh
 16JzmWZakiFEg==
Date: Mon, 26 Nov 2018 17:49:26 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kees Cook <keescook@google.com>
Subject: Re: New linux-next KCFLAGS
Message-ID: <20181126174926.65889a69@canb.auug.org.au>
In-Reply-To: <CAGXu5jL38a1Tx_LW9_j0sEHwLFGpuX-r2Y7dJq32eoED8BFrhw@mail.gmail.com>
References: <CAGXu5jL9WDRVCzPP0V2cvFHWfwAfd74kBNX9O+0frFkD26ti1Q@mail.gmail.com>
 <20181126084841.13679afd@canb.auug.org.au>
 <CAGXu5jL38a1Tx_LW9_j0sEHwLFGpuX-r2Y7dJq32eoED8BFrhw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/d/66+aAjXxMl/m6lPFIyzJH"; protocol="application/pgp-signature"
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

--Sig_/d/66+aAjXxMl/m6lPFIyzJH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Kees,

On Sun, 25 Nov 2018 21:46:20 -0800 Kees Cook <keescook@google.com> wrote:
>
> Excellent! (Though, wait, does this mean everyone _else_ will see this
> too? I'm worried that will be way too noisy...)

Ah, yes, you may be right.  everyone will see them :-(

I may have to figure out another way to do this for tomorrow.

--=20
Cheers,
Stephen Rothwell

--Sig_/d/66+aAjXxMl/m6lPFIyzJH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlv7l3YACgkQAVBC80lX
0GyBmQf/VaEIN5ETWV7cV2cYamRSO737SvNHD7FuJh6BAW8HTXTwE5G7CTm+udDE
4ZS3Hhuy50qPAy06irV1Whik6SI8TIETNiSvkyA6v5Kkseo84KiTxNKcyMl/qAy1
hw0iheRleVjoJ4Xfo/LUkMHc8pMeZvoNQW0KpKRtEmvL83w1B+WEMPlqSQ699lAT
Rb2Gw05aJVJdO+MXyhxuk2Pj8vY+xdpwYJtOLKSQhlfxRTd3vAJPwpxv4DACAgQH
M6ftIQ7+4NjdcWATQ7fvJELD1zZcRBtTsT1cIDOUG4DIL/2ig56PjCr01whk1kxO
BEcUzBa8ukgy83gi7S4lKiPHwpgLbw==
=+atM
-----END PGP SIGNATURE-----

--Sig_/d/66+aAjXxMl/m6lPFIyzJH--
