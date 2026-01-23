Return-Path: <linuxppc-dev+bounces-16205-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57621D6CFDE
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Jan 2026 06:38:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dy7Xz0sqwz2xJ5;
	Fri, 23 Jan 2026 17:38:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=180.181.231.80
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769150291;
	cv=none; b=oFV+zyEvOQKK/VOzpDf8MQ3giEcCyrhSkVSeCAyxJ02M9UF2m8EIvj8+gH8+Uoqm08D7gLwrimHcZFnvbQFnW+DMer/PxUiZ6yteuC7hRQkxZACsVTN/1BQHgQAKBjsZaQeuxP9DjBFatwhrCHyTUnltEvsP1RFz8MG7owNwVlg4xbumvpTEKwD5LgiUHJkiPpQR7vmobYMUQeFYck1+52FC7kdy2nPk3N+Xp9gdpIiVuhUZP4Vhrff/CGNkRgDvQ+IeMn//nXY/Z1s2X5KHSRQSYOpJ1nEpJqxeXhyeykwXL0jRbZeM6rrsfh+6rFRWKjwx7oQ50G9+aEmgXZAHaA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769150291; c=relaxed/relaxed;
	bh=RtzXpZGCFHahrFkdIvoMtF+cksQkU5NJKlrOBq+TlvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lRaECz/nIqrAvbA+XzoBU4W1REll7Y8PJ2s21fi5j616JRNOaiwJDK4+s++UHBZdz13qowuKC79AIKB4QazNXc2nHilqda8MvVncLTeFJDPqsjcUr40fatwSlDssqh4kH3+7DelCzvib5lpDowSqNy88BKC9HrW6mmBV3xUMp/T72p8yYTw6xTkoFF7A2CNdp+E1OfvpomwJ28yClx0EhqWrn9FT3jrcQDq0XaTZdudgWiojXSDVlRO9sb1rnbFRa3EUpdNCQZbKqNQKmz+ELkHA1PHQdPVpfySbKIJpuNLKtOjsIeWumaZbLvckpvmAEKwJ2pWRZLG9k2J0cDrELQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; dkim=pass (2048-bit key; unprotected) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.a=rsa-sha256 header.s=h01 header.b=SM/p64lV; dkim-atps=neutral; spf=pass (client-ip=180.181.231.80; helo=abb.hmeau.com; envelope-from=herbert@gondor.apana.org.au; receiver=lists.ozlabs.org) smtp.mailfrom=gondor.apana.org.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.a=rsa-sha256 header.s=h01 header.b=SM/p64lV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gondor.apana.org.au (client-ip=180.181.231.80; helo=abb.hmeau.com; envelope-from=herbert@gondor.apana.org.au; receiver=lists.ozlabs.org)
X-Greylist: delayed 2265 seconds by postgrey-1.37 at boromir; Fri, 23 Jan 2026 17:38:08 AEDT
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dy7Xw5lsQz2xHt
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jan 2026 17:38:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=RtzXpZGCFHahrFkdIvoMtF+cksQkU5NJKlrOBq+TlvI=; 
	b=SM/p64lV1r/oqDXv6IiKK+J+XhrASzraHpgIi5pDQ8V+XHbYMdZ9ZU7rZJU6G6mMsv8ox+ZvTNE
	9uf5yTwA5/dzRsaEA1ROptPyNCebVGYQE5uSfNJlPIj58cun+mh5McCf5ZX9HhJ3jGem2ZvaHPnpX
	2TyYqrj3UKeOCnsy61B2kr+CMP8piBPzJNNLqvD6qRHgFdXYwxW8WmMitaqsIhmbrN+NsE2fdk8tm
	xg4GJ0LM2I8+3Qpq2igVkleWawnkfrKw7mKawHOfaXrSJzPUQcpu2UF/6qUqeT1sSI3yeUCY8KDlG
	VmWYHe0YxMSuaPlKK34OdCzL+mAl4Hsi2k3A==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1vjADG-001VPV-21;
	Fri, 23 Jan 2026 14:00:07 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 23 Jan 2026 14:00:06 +0800
Date: Fri, 23 Jan 2026 14:00:06 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: nx - Simplify with scoped for each OF child loop
Message-ID: <aXMOZvjqHcAfWaEz@gondor.apana.org.au>
References: <20260102125011.65046-2-krzysztof.kozlowski@oss.qualcomm.com>
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
In-Reply-To: <20260102125011.65046-2-krzysztof.kozlowski@oss.qualcomm.com>

On Fri, Jan 02, 2026 at 01:50:12PM +0100, Krzysztof Kozlowski wrote:
> Use scoped for-each loop when iterating over device nodes to make code a
> bit simpler.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>  drivers/crypto/nx/nx-common-powernv.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

