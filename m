Return-Path: <SRS0=hRxk=V3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8BBFC7618E
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jul 2019 03:52:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 331E3206B8
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jul 2019 03:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="JYSVdS4k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 331E3206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45yN1D5V2czDqP3
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jul 2019 13:52:32 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45yMz05x9qzDqNH
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jul 2019 13:50:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=canb.auug.org.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au
 header.b="JYSVdS4k"; dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 45yMz0299Rz9s00;
 Tue, 30 Jul 2019 13:50:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
 s=201702; t=1564458636;
 bh=Yvzpix6R99hIAP/kK5fdreE053WURZoH24UdGW8qNys=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=JYSVdS4kc7aEN85ti4B8Z9885Ik6rr0l6Pw9NXrMgab7QYnBCAZ4PAgC3dHE2lLfq
 4TI90tn+7HDs9C8iLlOxbojM4wqQw6w8L786v4QBbYU0nHcYWYMM2vN78CqrQbjw7Q
 DILXd05p8vwBAp1Yb1oDIrAPPgunEWQPQZhmHFbH38YqpYHDQQ4eGn9VWyh6jWxfKP
 uCF0QIxbAbYW2MRCAHKAXTjzD402KKtElyIbJmMdffeEDy9cvWi4P2k4bolwzBni+H
 m/k2QOgjTiBoe/HvidWIuSeth3s1BhSRL7VK0BGVCb2EEPrNBSOtuH2zyj3zLJSl4o
 zHFL1ZiLWrbNA==
Date: Tue, 30 Jul 2019 13:50:35 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] powerpc/kvm: Fall through switch case explicitly
Message-ID: <20190730135035.25441b40@canb.auug.org.au>
In-Reply-To: <c77774e0-c613-64fc-c61f-e9ff73b4db17@embeddedor.com>
References: <20190729055536.25591-1-santosh@fossix.org>
 <20190729181651.4b9586a7@canb.auug.org.au>
 <30ecba4e-a232-ad28-4c1a-5a173a7ac7cc@embeddedor.com>
 <20190730131849.4d704abe@canb.auug.org.au>
 <c77774e0-c613-64fc-c61f-e9ff73b4db17@embeddedor.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/wIrtWj3nIbI1ltfaYd10Dvd";
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
Cc: Santosh Sivaraj <santosh@fossix.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Kees Cook <keescook@chromium.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

--Sig_/wIrtWj3nIbI1ltfaYd10Dvd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Gustavo,

On Mon, 29 Jul 2019 22:30:34 -0500 "Gustavo A. R. Silva" <gustavo@embeddedo=
r.com> wrote:
>
> If no one takes it by tomorrow, I'll take it in my tree.

I am assuming that Michael Ellerman will take it into his fixes tree
and send it to Lunis fairly soon as it actually breaks some powerpc
builds.

--=20
Cheers,
Stephen Rothwell

--Sig_/wIrtWj3nIbI1ltfaYd10Dvd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0/vosACgkQAVBC80lX
0GwOTQf/c6cjzNcwsyeaWE7QI8FxRkVfPLMRcRKcg7vY09BHRh5GrkaApzMjxKJY
b7T8l0j30WUVC5RrK4k79ZO2YtjKe1ZtkiSJXbu6DcH8J+0yxlZggX8UbmSZ8oEG
g1ItRy9xeLMr2pgb9g65zzzEELFhHOCl1wRFIsmrxFvUou/nr7bT/KoMJMftcP1G
H1/aOVtz+0aRv7oiLJQ/utZ0kPcwPQjezA2ZCQlTfdVWPkyI0s7MUHUC5vQw0iQw
YSMuNmNfojeIX3HTlpTti4lQEBVhFggQ6lTkv6UXjjDNCnwbUK2yf40cKvpOnIjv
57nQuSiSTJEFJFfYTiVjYqk2IjEAOA==
=pUhw
-----END PGP SIGNATURE-----

--Sig_/wIrtWj3nIbI1ltfaYd10Dvd--
