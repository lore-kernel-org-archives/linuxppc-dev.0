Return-Path: <linuxppc-dev+bounces-18922-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 608EA10ED64F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Mar 2026 10:07:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhxBr4sj4z2yrS;
	Fri, 27 Mar 2026 21:07:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=180.181.231.80
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774606020;
	cv=none; b=YqybjRQxCIDo1hXJ3sx8ADT94N1oA0M7ealK6O8NNW3vlRgZHRyUEqezTDFyMk/T1OMHfC+wTqgfa3s8i1sj+Uv8YanabywEep6rYxszdbckD5RQdwkuxXUcWddaKEVs3PT+stXkTxvLe99c1OthQM6zi4nBVcFScHXJsB7AtcpSHNIpTODtnnt0WscSmrpGB6XjwhpsgqSALdD06Zwc/LJSQ1l7VTHUQooWwycSn2xb0ojAsp5J6YeCFB9H5ykS94NBRDgp6R+V3nIHLPaVKsnTuuqi7E8k6Yu21axaHaLedr/di/H/X6irxfLRmCZk8A06vB/o4w+B4ZfxUD22Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774606020; c=relaxed/relaxed;
	bh=lOW6hBhzRdBbEJxmwfJeE8L+H5z0momZPOfQVcGg08I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WkyW/tShidZE6DzO9oH7vWB3sz+MXDERjdxheFhB7jpm6KL/zg3v7vRihPbXfyYpbtCM+ZmJ3LpnJea6fy77GgtgLU4I8y2SPbVSSnG7GqmMbF7e742cFbMblZQvb6fvzMOY7W8gW2DkNaeE4CxC8WIdHZw9HVcnq7l6F+O9yWFIbxfWqAmwvKVkEx6dGX7Hfijrt5P3PU2qiiFFkmHeXChsOTWX+FD3SYZkyJwVUBg1WnRHPRUSXp02SyyuPtLWVdfqaC1Ne7o81xItylgRH8rdSgffRBuHK7nk7juBN7kYNhhzUkVGEPXllQDUXKG+8SYWvrNfxqJWIfTysep7qA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; dkim=pass (2048-bit key; unprotected) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.a=rsa-sha256 header.s=h01 header.b=fCwsOXor; dkim-atps=neutral; spf=pass (client-ip=180.181.231.80; helo=abb.hmeau.com; envelope-from=herbert@gondor.apana.org.au; receiver=lists.ozlabs.org) smtp.mailfrom=gondor.apana.org.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.a=rsa-sha256 header.s=h01 header.b=fCwsOXor;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gondor.apana.org.au (client-ip=180.181.231.80; helo=abb.hmeau.com; envelope-from=herbert@gondor.apana.org.au; receiver=lists.ozlabs.org)
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhxBq5tKgz2yjm
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2026 21:06:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=lOW6hBhzRdBbEJxmwfJeE8L+H5z0momZPOfQVcGg08I=; 
	b=fCwsOXorstWIWwmDXDlY7q3VI9hWP0uLLCP2mJH61FAWwmJocqU8uCt/P77Ntn9Bswc/Rzwp2N8
	5rp3f/4HWk54mhGNO+cuqxd+bw6ieYrTr9pExoRmGjw5fwP/ONplWtWtlfKQZjk+Cp3vFuwUPMJR2
	1WmETXAdGMihYhDXQ4etl8F3A7D6bV10rkhPIxbZkSgb3dgF4FWR9rtA4q3TRqk1nTmzZ5ktDZVER
	MQx03liEuDQJKY9mPBWHRXAhrtbNgLDCc9dpA8q/dGgDG1/cwCPTlsUOtEwmqnGUO6bUvwRBj6ygf
	0Nds4UhPoAzkgMGUf3d80TwkVVycA7e7g0uA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1w63g7-001bmd-12;
	Fri, 27 Mar 2026 18:06:51 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 27 Mar 2026 19:06:50 +0900
Date: Fri, 27 Mar 2026 19:06:50 +0900
From: Herbert Xu <herbert@gondor.apana.org.au>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Haren Myneni <haren@us.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] crypto: nx - Fix packed layout in struct
 nx842_crypto_header
Message-ID: <acZWugqQs1PBgojz@gondor.apana.org.au>
References: <abnmUvHzhgS9xA-m@kspp>
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
In-Reply-To: <abnmUvHzhgS9xA-m@kspp>

On Tue, Mar 17, 2026 at 05:40:02PM -0600, Gustavo A. R. Silva wrote:
> struct nx842_crypto_header is declared with the __packed attribute,
> however	the fields grouped with struct_group_tagged() were not packed.
> This caused the grouped header portion of the structure to lose the
> packed layout guarantees of the containing structure.
> 
> Fix this by replacing struct_group_tagged() with __struct_group(...,
> ..., __packed, ...) so the grouped fields are packed, and the original
> layout is preserved, restoring the intended packed layout of the
> structure.
> 
> Before changes:
> struct nx842_crypto_header {
> 	union {
> 		struct {
> 			__be16     magic;                /*     0     2 */
> 			__be16     ignore;               /*     2     2 */
> 			u8         groups;               /*     4     1 */
> 		};                                       /*     0     6 */
> 		struct nx842_crypto_header_hdr hdr;      /*     0     6 */
> 	};                                               /*     0     6 */
> 	struct nx842_crypto_header_group group[];        /*     6     0 */
> 
> 	/* size: 6, cachelines: 1, members: 2 */
> 	/* last cacheline: 6 bytes */
> } __attribute__((__packed__));
> 
> After changes:
> struct nx842_crypto_header {
> 	union {
> 		struct {
> 			__be16     magic;                /*     0     2 */
> 			__be16     ignore;               /*     2     2 */
> 			u8         groups;               /*     4     1 */
> 		} __attribute__((__packed__));           /*     0     5 */
> 		struct nx842_crypto_header_hdr hdr;      /*     0     5 */
> 	};                                               /*     0     5 */
> 	struct nx842_crypto_header_group group[];        /*     5     0 */
> 
> 	/* size: 5, cachelines: 1, members: 2 */
> 	/* last cacheline: 5 bytes */
> } __attribute__((__packed__));
> 
> Fixes: 1e6b251ce175 ("crypto: nx - Avoid -Wflex-array-member-not-at-end warning")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/crypto/nx/nx-842.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

