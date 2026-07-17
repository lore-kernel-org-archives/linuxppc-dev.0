Return-Path: <linuxppc-dev+bounces-24338-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7530AC44507
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Jul 2026 09:00:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h1kPy6ZwVz3byZ;
	Fri, 17 Jul 2026 19:00:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=180.181.231.80
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784278806;
	cv=none; b=dCW4aXgAfO3ciq7NsZ2NXfVxGvckJ/b3VyfZ++wkMLGT0OX9OqhahvLZJ1jE8+Cfm+I8OwVFfjTA2PIyYu+k7aYMNnLLRl4hmyoEk3B1mQ6KwVbYt+c+SeJ/fdRQeqMVK8lA620UKd2CaxE1NxfCvNKNoygII93BBEo9Rw0d91mVChWEzaluEf1kImPfv88g35JS+sWzNd2GSDJzisEhyv34QT1W6Ky6YPtraIhfzG39s5dy9kus3zL3pqPKNj1BTjf/fEMBvBH5TIHqaiJSATj60Y5jHtKzE3cmJEA3XE89N45ZUw4Ei6rjvEbVrJ5FwNLt/RAqwqE0nHkJE2qtHw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784278806; c=relaxed/relaxed;
	bh=/uwwzJv9rSUgDKy6TMSdODfdguuexpxWZhu6PXoHUC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PJndh7aLqW8d22aHy70dtisOl70gmoArt4uhLvUD//t42qgxdHbOeC8D4sAFwxkF0A+JEGbu5uHI+r9KmUrNdusZTofMmdOtWkI4ufOwAVe1VAgbZGkIvdTZ4Iq+W6xmIzpC8ArzM9dR3uYBwUSwrb7rk/ca8WUtcnAfVABdhbxICacNg7KImJ4iczx0b27904CzeuQXp6gyT1aDkgI9YJOVhN+ik5qvdz5t3O/nPRlm0FWYzCODO14hSpWWOUewRB64wRB+7x/yWZ4+fKoW9ee//EvcJukxgF743sm2x0EeIBVgpN5FPk0UOdPgoSh9dJvNcaDh5FaF0pzqg/WNTg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; dkim=pass (2048-bit key; unprotected) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.a=rsa-sha256 header.s=h01 header.b=UogLas1I; dkim-atps=neutral; spf=pass (client-ip=180.181.231.80; helo=abb.hmeau.com; envelope-from=herbert@gondor.apana.org.au; receiver=lists.ozlabs.org) smtp.mailfrom=gondor.apana.org.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.a=rsa-sha256 header.s=h01 header.b=UogLas1I;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gondor.apana.org.au (client-ip=180.181.231.80; helo=abb.hmeau.com; envelope-from=herbert@gondor.apana.org.au; receiver=lists.ozlabs.org)
X-Greylist: delayed 2525 seconds by postgrey-1.37 at boromir; Fri, 17 Jul 2026 19:00:04 AEST
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h1kPw1n6Sz3bxR
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2026 19:00:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=/uwwzJv9rSUgDKy6TMSdODfdguuexpxWZhu6PXoHUC0=; 
	b=UogLas1I7hV6QI+awXiZecVbouUfwPKx2LO/IbiiAcerY3i7D5PmR0uqAhq1LH3n7tVInKhQ/5v
	r2vSeolfbvowZIALRDWeU6rE5bK9Y9zayMlvveL1i9a2N9w9EJS55Ntv3AMRvftt6Td/vXpfol9S/
	yqvVXun/e/d/UKfrojPXZJyqtkATC7TPh61uOFEVyzr3NQV8rr7QeiMRPAkayI0LkqUiXxCDkbCuW
	9RyHteRjc5YOonGVwsb7niBZjB9VK2c7n0Qx554qlGaWTN1HRYcg43xKIrb0imkcGFtrC7X+sgNFi
	/63O3aKHWdr6NLh10if7XFkEZ7vRX8havUhQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.98.2 #2 (Debian))
	id 1wkdlX-0000000EOD5-01x2;
	Fri, 17 Jul 2026 16:17:52 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 17 Jul 2026 18:17:50 +1000
Date: Fri, 17 Jul 2026 18:17:50 +1000
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Breno =?iso-8859-1?Q?Leit=E3o?= <leitao@debian.org>,
	Nayna Jain <nayna@linux.ibm.com>,
	Paulo Flabiano Smorigo <pfsmorigo@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: powerpc/aes - use bool for encryption/decryption
 flag
Message-ID: <alnlLg-LmvQwTDjU@gondor.apana.org.au>
References: <20260711145216.747128-3-thorsten.blum@linux.dev>
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
In-Reply-To: <20260711145216.747128-3-thorsten.blum@linux.dev>

On Sat, Jul 11, 2026 at 04:52:17PM +0200, Thorsten Blum wrote:
> Use bool for the CBC encryption/decryption flag passed through
> p8_aes_cbc_crypt() to aes_p8_cbc_encrypt().
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  arch/powerpc/crypto/aes_cbc.c | 6 +++---
>  include/crypto/aes.h          | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

