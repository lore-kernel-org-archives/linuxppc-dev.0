Return-Path: <linuxppc-dev+bounces-18495-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C3121098796
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Mar 2026 15:06:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fcm9s2894z2ygD;
	Sat, 21 Mar 2026 02:06:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.177
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774019201;
	cv=none; b=iafInpNpodusvoJBYsHgbpWepjtTllaoaK1+M3vLPMaC9NlOiF62T7+hnwS0Oi0OdivQKVlgGwGmky3RBXzmFCQOckhw1SYwgdsyuVeMssgdwnbfPYMZ160aagymmV1kQNVFeRBTqVTpx/Vr+s456+pjDd2cFTQHI7kbf4Pyg/+y9wRsIIhe1xp2yHLNB4YzBg6yeef2A0S7yser35bmr/L7qcYEKk6U6KWqNJhq0TbleeB9mFsIYCrcvL1HJ1Q0S7eFzb96nNPuo9D5cVTxQMqKqo/tASj0GGq3ruxQgkNmbSALo4ZQvCC2wONOmiMtxW2mf4PR/MYYfREbt9rFmA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774019201; c=relaxed/relaxed;
	bh=PM0ecKAgG32QvB1q4aNjle0Vk2lnfC0MirltUTa1XaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bbvz51YJUqjVqfWG2cxDw2KRwbxWZ8wyo3AWERLeO4lsMUJlOYh54KazIjawcYQhJgmUP2b5xYxgnlApZuDRf2CEuqp+TIOOfhby2+MdGMqGlZm2Zm6Vv8Lnho89ULmt+Jd4ImDsjZTlRn8Ce1zl4iaYkwKla0pmTzJZLK+HIOTaMo3QLbEaSkYr7agC5JEAPdOfF4fnvoLIF7k1ttePYVfpVWUtIORpeYJMnXeVHWnNzyCk9viZzE+fwy9WOy7iDrM1SDwGYm4l0asGJYOGMaPYGaSahlDHlFGGn6J6MAF8vgSykuZ9xNa7pezDT0K7o5nucsK3+uTcNR08Xqp1RQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=NcLxmILw; dkim-atps=neutral; spf=pass (client-ip=95.215.58.177; helo=out-177.mta1.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=NcLxmILw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.177; helo=out-177.mta1.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org)
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fcm9l6qyfz2yY9
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Mar 2026 02:06:34 +1100 (AEDT)
Date: Fri, 20 Mar 2026 16:06:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774019173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PM0ecKAgG32QvB1q4aNjle0Vk2lnfC0MirltUTa1XaE=;
	b=NcLxmILw2TOdpNaObDp5OgcX9bNJH2V5AALnfEbAl2pNVhALD6ziRtUXejDg+29FQGKQLp
	TrwRNU0wwUFk5L5L9zeRyrJj5UoCoNQyQ/cwcssFf5XfD+x5kxWEbePikVbap/czQdCMUa
	vG9osed2XollmYfkkBuneNIRfZbT5fM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Haren Myneni <haren@us.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] crypto: nx - Fix packed layout in struct
 nx842_crypto_header
Message-ID: <ab1iXryB4x0YwA3w@linux.dev>
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
X-Migadu-Flow: FLOW_OUT

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

Reviewed-by: Thorsten Blum <thorsten.blum@linux.dev>

