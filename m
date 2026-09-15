Return-Path: <linuxppc-dev+bounces-27445-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5847CC88E77
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 19:35:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hksg64ZmMz2yDD;
	Wed, 16 Sep 2026 05:35:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c01:e000:3a1::42"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789500914;
	cv=none; b=hDMQJ5QSPhhm78P+QnfwRTBA0o7UT+B0DA0R9oixAOpUMz/lN52b6ajL3MwY54CO/3fTj/oHu1y4waP74z67RQ5b1r77km27tsLI6DmR3xs0minvwmpVsmnXEx2G5oSxpyU3QiK8/uKfadSNMf87rAlq9SxyiJlNaGVQAm0E0H2zcFNrcWYB59qDhtBmLyBKd10xNaA68C6jWwWDvemkSiCVSLP0Jv0WMlxM3ieuCZiSkwMt+vR74Fqj47ZLDa1rG2RFiHXHwh9hCdKBUfUUzae5Phqfkq9kzFo9HZnzQdoFTlP6u7gJxvEgrXeaJyE3m/kFZw45hXSXILkewrLXPA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789500914; c=relaxed/relaxed;
	bh=CCS4ywA5oohfMKVA8PHgc+vaVYFqVV6V3sd1dJYizNk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NUDZ2KzChUmiuZeq316ywgVTMIghOR1JhEnjl7y9ZSP6rYL0md4fcCKcvtAHW+/2W0066RohGfN1OzSo2523e9np6AuR8INQFnLhqLdm0ERKhaKUw1OI3JfDBavUJ08Lt57J6szcRmtMfddlsS/YBQxcCLT+PotNEfBbJ6IA8RH7pux1aDj78uhDoaPCtgvpH8Wjtmaf6OHYa3Q3NdVSeusjutiZdKLbkz1CmhQDVlZhYvMhlgpc2twhMQOztRIf4b6XW4PqKdeHfxu2aahCAdVeBo2GliAiRqySLz5FCv9HZbn9OcOj5VHAtriiLmrubgqwhZjI0OSrqWRUqvrqTQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lwn.net; dkim=pass (2048-bit key; unprotected) header.d=lwn.net header.i=@lwn.net header.a=rsa-sha256 header.s=20201203 header.b=NokrHQA/; dkim-atps=neutral; spf=pass (client-ip=2600:3c01:e000:3a1::42; helo=ms.lwn.net; envelope-from=corbet@lwn.net; receiver=lists.ozlabs.org) smtp.mailfrom=lwn.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=lwn.net header.i=@lwn.net header.a=rsa-sha256 header.s=20201203 header.b=NokrHQA/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lwn.net (client-ip=2600:3c01:e000:3a1::42; helo=ms.lwn.net; envelope-from=corbet@lwn.net; receiver=lists.ozlabs.org)
X-Greylist: delayed 497 seconds by postgrey-1.37 at boromir; Wed, 16 Sep 2026 05:35:12 AEST
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hksg40mcTz2y2f
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2026 05:35:12 +1000 (AEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E51BA408B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1789500410; bh=CCS4ywA5oohfMKVA8PHgc+vaVYFqVV6V3sd1dJYizNk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=NokrHQA/Xh8zx1qPWbPypi/rKm1WeIVf/pEq5ouX8LoFDBvN8jlacYY2bQPJYIFXs
	 827Z+Mlsa7lbO8V5Q3jQV3eYFqxwHk+2scTgWQO1qToft8XrEG5CEnNmRs54O7MOYT
	 l8bQSDjV1gNRrUWGFhto/kiOYyTXDvdeC/tvHGxnYHjywqgaxQ9srdV05rfxI26nKM
	 gjpRwugC7vxMZMmkz7Yn17kqOTl1VVBXf5huoz+VZMctHJqxOUHBr1WD4O6vrzrnbO
	 6PxO4Je8+7eRGHLdlNynbqax6tbXv3dpW8v4TrKwGu76C2uSL2KvUQGuXYrcm6cWr6
	 GbKS5EEs0ZqHQ==
Received: from localhost (unknown [IPv6:2601:280:4600:814::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id E51BA408B4;
	Tue, 15 Sep 2026 19:26:49 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Karl Mehltretter <kmehltretter@gmail.com>, Madhavan Srinivasan
 <maddy@linux.ibm.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>, Haren Myneni
 <haren@us.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org, linux-doc@vger.kernel.org, Shuah Khan
 <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, Ritesh
 Harjani <ritesh.list@gmail.com>
Subject: Re: [PATCH v2] docs: powerpc: vas-api: Fix the structure name and
 the ioctl number in the example
In-Reply-To: <20260907004925.10948-1-kmehltretter@gmail.com>
References: <20260907004925.10948-1-kmehltretter@gmail.com>
Date: Tue, 15 Sep 2026 13:26:48 -0600
Message-ID: <87cxue8gef.fsf@trenco.lwn.net>
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
Content-Type: text/plain

Karl Mehltretter <kmehltretter@gmail.com> writes:

> struct vas_setup_attr does not exist; the name is struct
> vas_tx_win_open_attr. The example also defines VAS_TX_WIN_OPEN with the
> request number 1, while arch/powerpc/include/uapi/asm/vas-api.h has used
> 0x20 since the ioctl was added.
>
> Use struct vas_tx_win_open_attr and 0x20.
>
> Fixes: c12e38b1d52e ("Documentation/powerpc: VAS API")
> Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
> v2: also fix the ioctl request number in the example (Ritesh)
> v1: https://lore.kernel.org/r/20260905104313.43620-1-kmehltretter@gmail.com/
>
>  Documentation/arch/powerpc/vas-api.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/arch/powerpc/vas-api.rst b/Documentation/arch/powerpc/vas-api.rst
> index 1d0d055356e3..f74ea9fbc8a0 100644
> --- a/Documentation/arch/powerpc/vas-api.rst
> +++ b/Documentation/arch/powerpc/vas-api.rst
> @@ -136,7 +136,7 @@ a connection with NX co-processor engine:
>  	follows::
>  
>  		#define VAS_MAGIC 'v'
> -		#define VAS_TX_WIN_OPEN _IOW(VAS_MAGIC, 1,
> +		#define VAS_TX_WIN_OPEN _IOW(VAS_MAGIC, 0x20,
>  						struct vas_tx_win_open_attr)
>  
>  		struct vas_tx_win_open_attr attr;
> @@ -265,7 +265,7 @@ Simple example
>  		{
>  			int rc, fd;
>  			void *addr;
> -			struct vas_setup_attr txattr;
> +			struct vas_tx_win_open_attr txattr;
>  

Applied, thanks.

jon

