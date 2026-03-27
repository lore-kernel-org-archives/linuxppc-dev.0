Return-Path: <linuxppc-dev+bounces-18920-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5096C10ED640
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Mar 2026 10:06:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhxBb6Dkkz2yjp;
	Fri, 27 Mar 2026 21:06:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=180.181.231.80
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774606007;
	cv=none; b=d7B1jJcTK7wXz1U52dS8BsR8R3eQ7W2RWsWPrTHLxsmp21t2ea40uXsxkh8xb0GsP/fEqhe0rIaUPq7B+qsjsJtFAcP5YmExa9PePoAg01VhCuLGmjm2HXUHgNFyLOMKHlk6ZF+9hWRiZNDtxfD6br8kGLe7rFagwKsraEpP/2pNcLHxU5INc8jXt56c/xO+P10W6XBhLRDHT7up8h4eBZQQnTmac+2BAS+k/2lgB1J1BPkWB0ndBWZ5tdAXvf8awjOv+DbR9OvNVuyMk8jBOye3xqOL1tmcRGD0ft45VywOG89Vsehe+AEB0lfDOj6QdBlEbWAgj2poMrdb9t1/Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774606007; c=relaxed/relaxed;
	bh=4QzfYaLe/rXOHs+mVzfwGVshXWnq3+lcNx4XDowLmVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FODdHlbn8EaeSKbuoPaUf0sZSK8o5gjxzUwaMWeALp8MdTvPznrHM7vMGx9ZGs92F0kOe+I6XAwCLB7wOP5XCJrP2SMwCWkCYiP6yH+NeIYn7ZZslpdCof1sMsqeWpra+I6etwARF6OgynP/JLGA2TbXbhYKcoGIcxINj+QRNvJhf2hOa+ZI3xSQ9Mj2Fi7vblZuHkt+oO3S/BBtHXVUoUQ1Yypbpj3bJv9Ud7WJ/FwuprWBaLYR3eqC3wwr8TgKTgLflNksz2xGqcYEDdVyz5TNj5Fw+Dpwc2hpnmaYz6O0MoRB5B6g6trzhbR1PoOFHt/MckYVkCJit1TTH4zPTQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; dkim=pass (2048-bit key; unprotected) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.a=rsa-sha256 header.s=h01 header.b=a0ZUXc74; dkim-atps=neutral; spf=pass (client-ip=180.181.231.80; helo=abb.hmeau.com; envelope-from=herbert@gondor.apana.org.au; receiver=lists.ozlabs.org) smtp.mailfrom=gondor.apana.org.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.a=rsa-sha256 header.s=h01 header.b=a0ZUXc74;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gondor.apana.org.au (client-ip=180.181.231.80; helo=abb.hmeau.com; envelope-from=herbert@gondor.apana.org.au; receiver=lists.ozlabs.org)
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhxBY3jQ1z2yjm
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2026 21:06:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=4QzfYaLe/rXOHs+mVzfwGVshXWnq3+lcNx4XDowLmVY=; 
	b=a0ZUXc74/1e6kzIhdvVuxxUMrsvKdlw6sre0AwUe7RMDlU42cTHobkKWmwFjMIdZKdhFySCK5Lu
	6O5QBrh13CvDfIe7CkDax5OA884h//hU10X0UtlyRgn8eBd6NImAonJOna5naVY8Yhlp1CXAHfVyk
	HM/rGBhpk0en4bUjSfuu4Zz4p0VbnAEInBJ2LltuPJ0bSICwDTSjL3DBYqQ1FiXOAtwlI/buXtZB/
	12UEe59s3U668P1RMc8BsWYl749mNTmW23d2ZpwW/WazmaXMrB8+klHwTAjAF45yacdIrSBSiZKVC
	aBaQ6lvpR5K7BbUv1uHCBcMGWOSEGo/2BKvg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1w63fn-001bmP-2t;
	Fri, 27 Mar 2026 18:06:31 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 27 Mar 2026 19:06:30 +0900
Date: Fri, 27 Mar 2026 19:06:30 +0900
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Haren Myneni <haren@us.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] crypto: nx - annotate struct nx842_crypto_header with
 __counted_by
Message-ID: <acZWps0gefzjyktn@gondor.apana.org.au>
References: <20260317201804.1393389-3-thorsten.blum@linux.dev>
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
In-Reply-To: <20260317201804.1393389-3-thorsten.blum@linux.dev>

On Tue, Mar 17, 2026 at 09:18:06PM +0100, Thorsten Blum wrote:
> Add the __counted_by() compiler attribute to the flexible array member
> 'group' to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
> CONFIG_FORTIFY_SOURCE.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/crypto/nx/nx-842.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

