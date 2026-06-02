Return-Path: <linuxppc-dev+bounces-21915-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 971F8CD6E60
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2026 16:02:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gVFvm2FHBz2xLm;
	Wed, 03 Jun 2026 02:02:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::ac"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780416132;
	cv=none; b=LHiM6QU8e956pg3bHihINhWR7gel6bQ7dfyy9ZzdjstbBIoSFQC2Xh834ZnqDXZF4n8NorSOxguoBnqUxRWhXyrLpASD9s1i3ISuf72ICeDGuScYqGf5LZan309lYb59dj+do8p3WnwdHV0HZuV2MJTgoMW0UOZ6wNSNGa3bFlkbefbRruoZHnZbRa+ppPp92ShJvNGlvzLe6y/wzA74Y9gDTtBl11jGamSt0EWrMUahH27m7AyBQl9dBvufovYeeSxsQ/tSgisROOOUVvK0rJBFncKYcgKopTWqhSXAR7hAcB4jT/vJjP+F1EAHGpPcr3SnBtEL68de5GdEEQECYw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780416132; c=relaxed/relaxed;
	bh=h7D3Hfi0Dpuf1GZg49Dj/JWwEeIPExhLmM7yWKRJcKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FZz+CyPbpLIoshblwsjOcWqZ1i/rznL8P3UayRUtdsRNgTAH78uNlOcFuaheHmDM7x5KH3sCLMcItATl55xDJMGatCGbWKpn09WMVcUad+eTM8Q7ZC9RMTfUlKvIpU7fJm0pseesp5moLiW0wwSjZnkta3PGlLnXaDu41LPTRrmJq8dSrlXGeDrwCgdBnaJGW4wMAy3JKzwfqMquANYwCidHLVwzhUlp7MMlNLfQkRZgaISqdmSR3igTuwz9a2SHrDzUWbb/+v7qdOjGubXKqjPKb4LFbh+TQ3eD7gnRfwiEAUTsfEfjf2MpUo7TULTN/bo714R28KF43nHa8OyyQA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Zc8ywOEH; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::ac; helo=out-172.mta0.migadu.com; envelope-from=andrew.jones@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Zc8ywOEH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::ac; helo=out-172.mta0.migadu.com; envelope-from=andrew.jones@linux.dev; receiver=lists.ozlabs.org)
X-Greylist: delayed 424 seconds by postgrey-1.37 at boromir; Wed, 03 Jun 2026 02:02:08 AEST
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [IPv6:2001:41d0:1004:224b::ac])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gVFvh2Mnmz2xLk
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Jun 2026 02:02:08 +1000 (AEST)
Date: Tue, 2 Jun 2026 10:54:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780415682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h7D3Hfi0Dpuf1GZg49Dj/JWwEeIPExhLmM7yWKRJcKE=;
	b=Zc8ywOEHAOTHCeJMDiLqrbZHl+VQh6Fmd2t+5oknS5CMq6ehvHBrBX1ljRMtdGw+uVP3yd
	7aaOJDWVYJinMXzjj3gLMefi+qtY7czMEU/vF3g0SNzHpaO3wibMxyrw3l24HFFN9OE14F
	jxVv/V8PM1kj6h7BHoOyHMPYTQ7kDT4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Andrew Jones <andrew.jones@linux.dev>
To: Chinmay Rath <rathc@linux.ibm.com>
Cc: thuth@redhat.com, npiggin@gmail.com, harshpb@linux.ibm.com, 
	lvivier@redhat.com, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	sbhat@linux.ibm.com
Subject: Re: [kvm-unit-tests RFC PATCH 2/6] configure: Make arch_libdir a
 first-class entity
Message-ID: <emxfxob3hs2kqjmdbtucwr65dlywqapsz76ow7ebnqhf5vmrtq@i2wodbzjs5cb>
References: <20260602064806.3101025-1-rathc@linux.ibm.com>
 <20260602064806.3101025-3-rathc@linux.ibm.com>
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
In-Reply-To: <20260602064806.3101025-3-rathc@linux.ibm.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Jun 02, 2026 at 12:18:02PM +0530, Chinmay Rath wrote:
> From: Nicholas Piggin <npiggin@gmail.com>
> 
> arch_libdir was brought in to improve the heuristic determination of
> the lib/ directory based on arch and testdir names, but it did not
> entirely clean that mess up.
> 
> Remove the arch_libdir->arch->testdir heuristic and just require
> everybody sets arch_libdir correctly. Fail if the lib/arch or
> lib/arch/asm directories can not be found.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
> ---
>  Makefile  |  2 +-
>  configure | 20 ++++++++++++--------
>  2 files changed, 13 insertions(+), 9 deletions(-)
>

Reviewed-by: Andrew Jones <andrew.jones@linux.dev>

