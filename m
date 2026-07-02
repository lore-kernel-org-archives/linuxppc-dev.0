Return-Path: <linuxppc-dev+bounces-23358-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2F84C43327
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Jul 2026 05:28:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4grQQm1lG7z2yXj;
	Thu, 02 Jul 2026 15:28:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782970112;
	cv=none; b=V4h0np3aCX3V9oLxXVnitNxI2EYrJl5dXuHAu2cRwKzgU3Ufa544KaVQgjFONRCeNZZ9W6Xa8XX87VCWCRpUByXv1vty69bwp+jgN9fkdfUnkVg7lbSPekssgjWXx1GLK3nFmdl2hwVKNWIcJoNFeD+imOe1OqHJIRy86D/5pXNp4AKf5CNVDTtkBKDAJqYiu27JZE828MVp99e3T855wtYhCf2nEkfFwMi5Ng+9Z5Qwt/xUeDrLgM1lt80VPscHTsoNo0FrR9HS3NVRZQdEOYLAGjco55wyZA77QTQ5HKrGwc5tOp+bGJ++pHAlV+FVAFYOi7bZltwYQIJ73DAwrA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782970112; c=relaxed/relaxed;
	bh=f0ElEvUWjV6Gy4pknAoeXdTvp5XxbDAUQK5u4tzfIXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZZBe77HNdW/s8g4YheeQysguhkON2SULayFS6HPsiZm9rKNSFIzj/osZBeRlTHRTa4UBVmeZ+HDpTweTaY1OcKg7M9HK7n+tM20qtw7GPpY7KGqoyUnDDTwNuPxgViGvpLXORvT8X6UbJdroeDjXashWQEAIsbQ4G+xaLAq2dGiUEfIss/NGh5DaiduA9Ax2Jsp4yPZREvIvv6dwC9mr/MY/tEdAfYgPEBds+BoTWRZxiRPGVaDU/PkietPkq43lEDzeMORqSIc4tPnKivX02njBNkiZVm7jgRTfh/VCV2jTLkOioeTDiF0kZn/spN2ZwTX5iq9pzrcjrPUXNffAGw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BbqJdGgP; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52f; helo=mail-pg1-x52f.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BbqJdGgP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52f; helo=mail-pg1-x52f.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4grQQk4Jmhz2yRM
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Jul 2026 15:28:29 +1000 (AEST)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-c9e607d81fcso459584a12.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 22:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782970108; x=1783574908; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f0ElEvUWjV6Gy4pknAoeXdTvp5XxbDAUQK5u4tzfIXk=;
        b=BbqJdGgPA1UN5M3+Zd5pWAYuN/QMoTKj9yOebvWpPLNV/zHy4qbNpfYgwayOf6BNx1
         5IEjX2lZNGYkbsKxPY2RrANIJpZ1fB4vz8YfwSJEN+ve47XuI9oPEXybrSPDTY4qY8GV
         BkzudO13xF9ozvZFShn+4PdPGhwJrtqz5EKyt4PTZLzuM6j4nc+3UXjz3NAZjSQYfa33
         oJbtC065B/sBUDtOuugG/TNVSHhk4ftZiW0Flv3fKsgBuO280ExDM/n/WlnUvmqorbWs
         v9HcWBCJtZhqq/TE7WWl3trfFvD/VGBCkFYjopdvFvV00jsqjvLDZnfb5JFcfP//KFru
         hBGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782970108; x=1783574908;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f0ElEvUWjV6Gy4pknAoeXdTvp5XxbDAUQK5u4tzfIXk=;
        b=gaWJXH2xvnvqPwyE1RNKGnVhT3ssPXzpAVOmJwsE1A4DT9ps/fB0as/Sbn6NefTyGt
         hGr0m5/vwiRhgvnaVB3ZvReEehXz+jafp43VN0TgIFCwrk6XkMpNGaASvyuePxsvk5/q
         lsibJanzNpofR+z6FsuW9pN3Rktc7dIG2qa01U7xWNVN5ILqyD5N8aPcRAaef5+IF0Va
         ZWT5qSNNkmh9l15dewopqty1Z97/p6xe023M4H8jhWHNrsRUso6LEwjIG+tzzs2fsz1i
         QsxpJNfvKSiEsAUJXuJdglEdMO2rWM7IgpaB0PlQAFsCOsuc4Ib9Xpi8OrtnnDw5uv9L
         YA1Q==
X-Gm-Message-State: AOJu0YxQdP5kOgmji28KgzMphNS4ELQjTeDHG4KwG14XfzZFnj4Itg3N
	0KoraieoalZvO9FkxDqmMCBmEqWkIuQ2uXBJC8GUyB6ovk1pc6ZXkDyv
X-Gm-Gg: AfdE7cn014bVp8NAALBjRVsqJxCMgPjWjGB/AfhId53LW0NwLYhyI2jw/B8HYfaV33c
	eEe1L4YPCYsxaGkWorKtYKvg5ruuAHXjlIR6UGWi+Q3jP3zbEdyZ0x7jHt+DqrSKmolGq/uzemq
	LGPXgLOgAl0oUdHLBhFcZcoI56srXtXin3rlu/6/W/60QHYP7b0R2qyVyzZiYxBI4RGyAY8jJGr
	CoxnRGq2X03YQTDHxt7ZnkDUxqtrg5KK4VvSts4CcLgHV+D6tzo/58OE5BRVJXp4HPWlw13G0eJ
	u2RXmg4s0SarNaCJ/Jq4jz+7mF7XJ8cYI5WKZ/0ke4PfQeFzthLmtgfoiAW2y+bBYSL4n5iv90C
	kGlGJ/RkGVNFn4zS+QCHI5jfiEToLmlfLOl9vP/mGw4AFpOZJ4x3xVZSvYwLFQot6yRuIyJeEq2
	SA/AVi9iMkuIJjEZ/IYZ1WAmyHAbEn9jxt7i+D1QH4+o82WAbSQZvsLk86aTIl
X-Received: by 2002:a05:6a20:2451:b0:3bf:6c08:2b2f with SMTP id adf61e73a8af0-3bff4303132mr4324775637.55.1782970107539;
        Wed, 01 Jul 2026 22:28:27 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9e8eb0ee85sm682627a12.3.2026.07.01.22.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 22:28:27 -0700 (PDT)
Date: Thu, 2 Jul 2026 10:58:21 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, 
	adityag@linux.ibm.com, mahesh@linux.ibm.com
Subject: Re: [PATCH] powerpc/64s: Clarify copy_and_flush() cache sync loop
 comment
Message-ID: <akX1w9E-RaEFI8tD@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260701182756.273019-1-nikhilks@linux.ibm.com>
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
In-Reply-To: <20260701182756.273019-1-nikhilks@linux.ibm.com>

On Wed, Jul 01, 2026 at 11:57:56PM +0530, Nikhil Kumar Singh wrote:
> The value loaded into r0 in copy_and_flush() represents the number of
> 8-byte words processed between cache synchronization operations.
> 
> The existing comment refers to cache line size, which can make it appear
> that the value is a cache line size in bytes rather than a loop count.
> Clarify the comment to explain that the loop processes 8 words (64 bytes)
> per cache synchronization iteration, and that increasing the value would
> skip cache maintenance for intermediate cache lines.
> 
> This is a comment-only change with no functional impact.
> 
> Signed-off-by: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
> ---
>  arch/powerpc/kernel/head_64.S | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
> index 63432a33ec49..e21c2bce8f7e 100644
> --- a/arch/powerpc/kernel/head_64.S
> +++ b/arch/powerpc/kernel/head_64.S
> @@ -713,14 +713,14 @@ p_end: .8byte _end - copy_to_here
>  _GLOBAL(copy_and_flush)
>  	addi	r5,r5,-8
>  	addi	r6,r6,-8
> -4:	li	r0,8			/* Use the smallest common	*/
> -					/* denominator cache line	*/
> -					/* size.  This results in	*/
> -					/* extra cache line flushes	*/
> -					/* but operation is correct.	*/
> -					/* Can't get cache line size	*/
> -					/* from NACA as it is being	*/
> -					/* moved too.			*/
> +4:	li	r0,8			/* r0 is the number of 8-byte words       */
> +					/* to copy per cache sync iteration.      */
> +					/* 8 words * 8 bytes = 64 bytes. 64B is   */
> +					/* the current default cache line size.   */
> +					/* This is a loop count, not a byte       */
> +					/* count. Increasing it will skip         */
> +					/* dcbst/icbi for lines in between and    */
> +					/* leave stale instructions in icache.    */
>  
You dropped 2 pieces of information here, That we can't use NACA and
that we are doing an extra cache line flush(atleast in case of P10).

Also use tab instead of spaces before commment close per line "*/" can
you keep the last character aligned to rest of the file. It looks
little nicer.

Regards,
Mukesh
>  	mtctr	r0			/* put # words/line in ctr	*/
>  3:	addi	r6,r6,8			/* copy a cache line		*/
> -- 
> 2.43.5
> 

