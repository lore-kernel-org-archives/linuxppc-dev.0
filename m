Return-Path: <linuxppc-dev+bounces-22124-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21B97CD6E79
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Jun 2026 12:07:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gX0Y82W10z2yNn;
	Fri, 05 Jun 2026 22:07:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=180.181.231.80
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780661228;
	cv=none; b=bBEHbTJT1ESamqAooU6qILZt7oC7f5Uk+aA8DTvoo+94JXd0eg8JmRjW+mqHY/+bVk4e92i810mZAdyUP0mgm0ZCmuYA6VDAO+C7lUD9WKurcMAqFp/Jun4vcZ6mJ/mzS1SUZV+UyvB+PHvHTEyKeYYVf3eRdNqhxJfOHOYnUW4LKUQo60l3E2ylnA5nczKQkYePQ3Fu5f3I4aWXT0YNsacvOzhRYoxKNlzL1YVBIyTvfyG5KgJFsSvbRmPCc/eEIAhWoVM5jSnIdAfZbKaLLmxtWMzhb+nG+aBLHmjHgRRvfNNYdUV2JJ8Tm8IVWF7qxWTqnFbhBVz6CyuC+agv8A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780661228; c=relaxed/relaxed;
	bh=lUIlwDRbVjok4ajTygSVNKHvLUaeGdfxBXTjvFFHo5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cebo6CbhCRL0d4QqYTclmzOQuSn5EBbEKEzuSX3lC7baJLuv4NMbWxnpv7/h+qFRL5VM+7DEFfzyoRXU+Eyp24BVvAvQMgYTREKTyjownf98TUNLA5/lHTdBsPihquJGt285CO/L62/ghmTgZfYlMw2hYf1mk+ADzDIJOSiW6RFJIEP6cRoLtpV5asR6fZJrHOPjyFgpMpGds7flTeY4HVHuRdoIyfZe58MnuXB6MCVG5mFKd8PdRip8VDh+YrvMXARmonmbZKDWbeEBxemSqoqxZUSiaqhNqH2pc8TgZKvv23BRwaAFjtp7XsLrw6LPhxzvpDKQmbgT0OBCVu/HTA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; dkim=pass (2048-bit key; unprotected) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.a=rsa-sha256 header.s=h01 header.b=NDP3QGkF; dkim-atps=neutral; spf=pass (client-ip=180.181.231.80; helo=abb.hmeau.com; envelope-from=herbert@gondor.apana.org.au; receiver=lists.ozlabs.org) smtp.mailfrom=gondor.apana.org.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.a=rsa-sha256 header.s=h01 header.b=NDP3QGkF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gondor.apana.org.au (client-ip=180.181.231.80; helo=abb.hmeau.com; envelope-from=herbert@gondor.apana.org.au; receiver=lists.ozlabs.org)
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gX0Y75YPQz2xnK
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jun 2026 22:07:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=lUIlwDRbVjok4ajTygSVNKHvLUaeGdfxBXTjvFFHo5M=; 
	b=NDP3QGkFA4vtpHDzQ2UJGolDWjWukJR87ouH3CfqwnMcwyX38SSecaG2dCq0ldYwctFl8/2l0yD
	BG2x9sEVJOHBYuxYIh43lNeDuM2zh5Ln9zSEZPzVLpMGF8JTNBrPxB6RP35dfuYoMvFgebBcAMGLP
	oK0YAi33OwIugsdraTEJJQeFVTxD9IIvKt93Xv0J7GoJQes6m7nsL5iHQExpHd8qMNUgEp/8SA6mZ
	dbICrcnwC0mM/w4ZvaHQya+k2L6JtVRifO3eDbuGEGeP+quV6zKLA5Jp9ZYF/iwZp2YN/WJpFMfkT
	Sw8zpHTKBT6VZNBSUFD9OAX4hteqkyMKM64Q==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wVSuT-002olj-0h;
	Fri, 05 Jun 2026 19:40:22 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 05 Jun 2026 19:40:21 +0800
Date: Fri, 5 Jun 2026 19:40:21 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Sam James <sam@gentoo.org>
Cc: Breno =?iso-8859-1?Q?Leit=E3o?= <leitao@debian.org>,
	Nayna Jain <nayna@linux.ibm.com>,
	Paulo Flabiano Smorigo <pfsmorigo@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Ard Biesheuvel <ardb@kernel.org>,
	Eric Biggers <ebiggers@google.com>,
	Eric Biggers <ebiggers@kernel.org>, stable@vger.kernel.org,
	Calvin Buckley <calvin@cmpct.info>,
	Brad Spengler <brad.spengler@opensrcsec.com>,
	linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] crypto: nx: fix nx_crypto_ctx_exit argument
Message-ID: <aiK1pSrxD7bnQDy2@gondor.apana.org.au>
References: <b8b1b6fe740187c70349cd04a820d57324e0f70c.1779509289.git.sam@gentoo.org>
 <844faa8a75585e4088c95c052dd0ecd189bc3a64.1779695779.git.sam@gentoo.org>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <844faa8a75585e4088c95c052dd0ecd189bc3a64.1779695779.git.sam@gentoo.org>

On Mon, May 25, 2026 at 08:56:19AM +0100, Sam James wrote:
> nx_crypto_ctx_shash_exit calls nx_crypto_ctx_exit with crypto_shash_ctx(...)
> but crypto_shash_ctx gives a nx_crypto_ctx *, not a crypto_tfm *.
> 
> Fix the type in nx_crypto_ctx_exit and drop the bogus crypto_tfm_ctx
> call.
> 
> This fixes the following oops:
> 
>   BUG: Unable to handle kernel data access at 0xc0403effffffffc8
>   Faulting instruction address: 0xc000000000396cb4
>   Oops: Kernel access of bad area, sig: 11 [#15]
>   Call Trace:
>    nx_crypto_ctx_shash_exit+0x24/0x60
>    crypto_shash_exit_tfm+0x28/0x40
>    crypto_destroy_tfm+0x98/0x140
>    crypto_exit_ahash_using_shash+0x20/0x40
>    crypto_destroy_tfm+0x98/0x140
>    hash_release+0x1c/0x30
>    alg_sock_destruct+0x38/0x60
>    __sk_destruct+0x48/0x2b0
>    af_alg_release+0x58/0xb0
>    __sock_release+0x68/0x150
>    sock_close+0x20/0x40
>    __fput+0x110/0x3a0
>    sys_close+0x48/0xa0
>    system_call_exception+0x140/0x2d0
>    system_call_common+0xf4/0x258
> 
> .. which came from hardlink(1) opportunistically using AF_ALG.
> 
> The same problem exists with nx_crypto_ctx_skcipher_exit getting a context
> it wasn't expecting, but apparently nobody hit that for years.
> 
> Cc: Eric Biggers <ebiggers@kernel.org>
> Cc: stable@vger.kernel.org
> Fixes: bfd9efddf990 ("crypto: nx - convert AES-ECB to skcipher API")
> Fixes: 9420e628e7d8 ("crypto: nx - Use API partial block handling")
> Acked-by: Breno Leitao <leitao@debian.org>
> Reviewed-by: Eric Biggers <ebiggers@kernel.org>
> Reported-by: Calvin Buckley <calvin@cmpct.info>
> Tested-by: Calvin Buckley <calvin@cmpct.info>
> Suggested-by: Brad Spengler <brad.spengler@opensrcsec.com>
> Signed-off-by: Sam James <sam@gentoo.org>
> ---
> v3: Fix doc tag.
> v2: Add stable cc, fix doc for tfm param.
> 
> v1: https://lore.kernel.org/all/a3e89c1e8342ffa415b0d29725a0571a4f355d34.1779472902.git.sam@gentoo.org/
> v2: https://lore.kernel.org/all/b8b1b6fe740187c70349cd04a820d57324e0f70c.1779509289.git.sam@gentoo.org/
> 
>  drivers/crypto/nx/nx.c | 6 ++----
>  drivers/crypto/nx/nx.h | 2 +-
>  2 files changed, 3 insertions(+), 5 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

