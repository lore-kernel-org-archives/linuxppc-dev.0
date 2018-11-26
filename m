Return-Path: <SRS0=3VWP=OF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B728AC43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Nov 2018 14:03:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFCF420817
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Nov 2018 14:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="bJqAlk94"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFCF420817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 433TCV6839zDqWp
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Nov 2018 01:03:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="bJqAlk94";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 433T8P2hlCzDqWR
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Nov 2018 01:00:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=canb.auug.org.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au
 header.b="bJqAlk94"; dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 433T8N2n9Vz9s0t;
 Tue, 27 Nov 2018 01:00:36 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
 s=201702; t=1543240836;
 bh=uKqTnx6lsjczDMI9juIcNyreY61NrodjtUUNL+4i15s=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=bJqAlk94Kbma4ElqHa4KxdSUGq/P93NlBCnQT1Amd05/Ny/OVf/2cU188Rqb3/7xI
 7SdEGf5+/qPdFY2RXnv61MNij4WHYdOetvORv/kQ6/QkswAtvJtdFzwGN7+7ie0PcP
 rkYAnaqhf0IC5cL8aTaE307z6/Bewy8MaUYv7RVsIulYeoJ6s/riLIF/F044t0sqi0
 mUoVAIyjBrOq09ms1CHoclVSLwEQggd+FNsfvlSwNs8DhuZ2Z+/ehakhYp1aw82RBr
 0vhfxOL7gR40m49TAaySjquLbA1bJ/Va1pEEewGhmwRHRT2AvpBAze3Ibb9ZVSLjWj
 7uoAQirWrDHGg==
Date: Tue, 27 Nov 2018 01:00:35 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kees Cook <keescook@google.com>
Subject: Re: New linux-next KCFLAGS
Message-ID: <20181127010035.1385b60b@canb.auug.org.au>
In-Reply-To: <20181126174926.65889a69@canb.auug.org.au>
References: <CAGXu5jL9WDRVCzPP0V2cvFHWfwAfd74kBNX9O+0frFkD26ti1Q@mail.gmail.com>
 <20181126084841.13679afd@canb.auug.org.au>
 <CAGXu5jL38a1Tx_LW9_j0sEHwLFGpuX-r2Y7dJq32eoED8BFrhw@mail.gmail.com>
 <20181126174926.65889a69@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/6YnTm28M7/ujvJMiIhCAye="; protocol="application/pgp-signature"
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

--Sig_/6YnTm28M7/ujvJMiIhCAye=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

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

OK, starting tomorrow (later today), I have just added
-Wimplicit-fallthrough to KCFLAGS in my build scripts.

--=20
Cheers,
Stephen Rothwell

--Sig_/6YnTm28M7/ujvJMiIhCAye=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlv7/IMACgkQAVBC80lX
0GyyXgf8Dik4qv/B+IbmbteGTm3HBEz2U+g7CCeRw/DHIw86clsJ7LnvV5/0uyYA
AtZw8UHexWnT6n6C61bwEnPXzITXaRHqXta+oJGSGQUT6LZ9rNMT6e1R5iUn1Y55
7hykazjjmsHfcUWYl8JD7KjO2er6E4Kl+Wzu4hn63d5YTMi8uLqaPQbL9d/Qejg8
ZmZI52SY3vGB2LH2qtsmUlFhKIqpQXTbyDIAz8/ieGlQu7wWXTwFqa2JkQ/8P39T
1S5pKBl3uYenOk7xAo6QUMgxD/rBlVw1/1rytQ1eEZmh5Eids15c68EQAe6Mv6QR
Hjg0BjrMlC6xixP5U2g59ogbkClwQg==
=eaUX
-----END PGP SIGNATURE-----

--Sig_/6YnTm28M7/ujvJMiIhCAye=--
