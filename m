Return-Path: <linuxppc-dev+bounces-26209-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D715C61DF0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2026 04:39:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYGVM21Z8z2xLf;
	Mon, 31 Aug 2026 14:39:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788151163;
	cv=none; b=W61bzKPxelP7sQcRsPNjCw/QbNuQ6x5Wnv9tJ4SCEej5P733cABwVAWWpMhANL70+Sh5MNJr5suBfZ7UtATjrFbo6WrcDMEezBIzcC0CCX6yvCFPERaaOgwv6jkgfd+gdCUAo1gyiI10Xwr6PbFIOHVorjtXtlD3+gLp33K1ZT9yQbGNMuOsk9hdLOgfbqJdhyC/P7mzi7IGQ+tXFWgZjzQYYai5sEdj7zjrMawlKlfBlHS7DIkP2QFdmU48JUpsTjFl+AqZilCUZDbdSe/xELa7CygcCH3wFf1J5oHJcSllTtwRS+8H4hHem6w1BqM4BsoDJHYJK1zwg0BD/2xISA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788151163; c=relaxed/relaxed;
	bh=W/oA8S1L4pWxs3ISigp4Fn5q6oJEvgV8RtCJCWRw4Ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VjdqGzGXuARHoS2/+mZEI0hM+UEh0YI5rqoirEp49whYseSwcXZGZ7ZllsDTztu8m56aThQaWagH6EXtRQMC+dbHxbp0A8DXyjt6by73e8oVotrezQqSTctMf4zjNWxwGrDH3GfYVQT6OerQ0Iz7T3hHCMMIFfoEPDxUxSKitNbX3SlQHgm+mA/5zf4gKQEdzgwOK6kA9wlv9GX8mHOITxxaWBoXkEawK5agk4h4CLtijzqwDtLOCnCctkTSBvW6EE96yts+VUv4i6W1q8moelqdEksihpz31YzHXx3Eni8XYQoHE/qWi6mmfiw2tzf7C4svAc4c+1WqaSs+d2FPkQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OmO95laM; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OmO95laM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYGVL0gLRz2xKh
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2026 14:39:21 +1000 (AEST)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-398a4dcf289so2122339a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Aug 2026 21:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788151158; x=1788755958; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=W/oA8S1L4pWxs3ISigp4Fn5q6oJEvgV8RtCJCWRw4Ns=;
        b=OmO95laMQ8oCoMXDNg6u3RS5iWe3F+ydvkXzYDEhVPalrRj926gYl//EhuWZIpHUTp
         JJgXVoz32B49n7Klu1HqGBO6eFD/vQ0BEXXjmk8Sm+e1wWPs79I7ppCCdMT3v3Q9TZoW
         gCr0R1zkMSLnkZy12Rheyccr0QYnRlHGX6u+eI9zR4uY0uyXR+l5wVogTbFWs2vb3p9D
         smyxj2LzbQPaNmr6wL6Rb2nWhgGt/32ucr1hu1izyq++QMl2VkbD5fEQmmvKAgGVpa1k
         MQ7hyqzfBd5kuJZ9ASTCrivvLJwfLhlIj8CVDahw+NVo5jMqDjSafYmSLoHeUAUiAwuf
         Qf8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788151158; x=1788755958;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W/oA8S1L4pWxs3ISigp4Fn5q6oJEvgV8RtCJCWRw4Ns=;
        b=KxxxgpfbZvvEm/TjtuC7ifL5ynuS96VFxZnNAkA3Xu682uAEUbzDjIgOdcblhpFd/d
         oWham622deppQ/5bVxTwrN2VJkUI9aJBp5FkgYYdow3K0lWveS8JoxQls4KOc0ck+82Y
         bJR84vgz5B+/phQkaVcjgTFUWSejK90jXHfcZOtsDWQmAL+8Jq3ZhHZ4V5h23bv07y2v
         d25r42rUzt5V1m9uEzgRo03Ae2GsitN6nZmqj8A/81b0bYHn+T/5ZWOfFBPZH5G1LkSm
         0wUFcUivY8No2ySA0bMHnjMomFTp4eABRqMB2500m17h6D1VE23PK+6hsR3nbratwPSi
         rYkQ==
X-Forwarded-Encrypted: i=1; AKwUvBx/DNMSERH0AHe2UsnmyuCKTKKYkcNVkYhJk8fqwAqjBn/MoV4LbM6ZOXJXDgTc6kYEuZOsDNtlYwe5R4k=@lists.ozlabs.org
X-Gm-Message-State: AFuF++krSffLaaGsmzWQfVjVsGlTnye+LMvBoy9OBpAVE9qpLfRyAwCJ
	JK0MEEvai3ZpkpsG55sfMRAqeIBI7jk8uWkr8NFcI4FNfN9uLO3URTga
X-Gm-Gg: AYBFou3WNwduN4/r0OTI0Y15MqtNx0Z/Ah2GofWfAbbbk173luXcI3dFrc9hIzu5kzt
	0pkNY92qmBY1EAKM3x1rAMGmj/lt7eo40A/6EkHPBKHlOvnma+TdIZMtIi9iO10fybI3M773rvY
	LWeW9vdgvwy12jVGj5RepUo/1tNXH6TNCZYqC5LiJp250SAUjWjD7qvvnZl55BovZ+EEJcMyukV
	zlRchnljUP5cwFCl8421sfzMIqi2P1x868BDtqKw6ar6LKvu6DilW0p7CE3GkL+CRU4g9xF7GgL
	YcrCelUq2tiEoBYjZb1q/9CTU4to/z/y6vX3kS7i59s/PrXd+ymumECf3SQvwszTmd++1byc+oX
	2+yvm+iBZKAIG/5j8NuYw6q9zRFgy4K9oFq0PtwmInt2+7inTVkydlG967oH9Q92OAgbWCPx1w2
	wOEcWjskxF4nmaYxWlV8opBdlUri5KkUuylh6bwze3eH6Ci7wLJJ5BqpS4pv+2RevNSK9fZFMt/
	obXRRUAyYJpzXTWuLFf78OUE3+5f83rPQ==
X-Received: by 2002:a17:90b:28c8:b0:392:b509:b1a5 with SMTP id 98e67ed59e1d1-398f846047amr1327503a91.14.1788151157676;
        Sun, 30 Aug 2026 21:39:17 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([49.43.112.37])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396b0fd5c34sm19298269a91.8.2026.08.30.21.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 21:39:17 -0700 (PDT)
Date: Mon, 31 Aug 2026 10:09:12 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: tglx@kernel.org, maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, chleroy@kernel.org, sbhat@linux.ibm.com
Subject: Re: [PATCH] powerpc/entry: Clear TIF_SYSCALL_RET before syscall
 error return
Message-ID: <apUBdKP1ytHSvuQd@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260828053811.1042300-1-sshegde@linux.ibm.com>
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
In-Reply-To: <20260828053811.1042300-1-sshegde@linux.ibm.com>

On Fri, Aug 28, 2026 at 11:08:11AM +0530, Shrikanth Hegde wrote:
> Shivaprasad reported a boot failure due to userspace processes crash on
> abort() from libc.so.6. It was bisected to merge request
> commit '3424d8c18a7d ("Merge tag  'core-entry-2026-08-17' of 
> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip")'
> 
> Upon checking the merge, when syscall_enter_from_user_mode_randomize_stack
> fails, which could happen when a tracer like seccomp or ptrace intercepts
> and skips the syscall, the code returns to userspace immediately without
> clearing the intermediate flag which was set.
> 
> When the next syscall is made, it immediately aborts the valid syscall
> since the flag is still set. Hence clear the flag on occurrence of first
> failure.
> 
> Reported-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> Closes: https://lore.kernel.org/all/e301014d-568f-4ed5-bc64-b8a85ca0b1e1@linux.ibm.com/
> Fixes: 3424d8c18a7d ("Merge tag 'core-entry-2026-08-17' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip")
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> ---
> PS: I have kept the block below since earlier code was checking it
> regardless of result of syscall_enter_from_user_mode. If it turns out
> to be a redundant, it can be removed later.
> 
I think it is redundant as of now. The TIF_SYSCALL_RET flag is set when
error is set by the ptrace or seccomp, If the error value is set then
the syscall_enter_from_user_mode_randomize_stack will return false.
Hence the next check will become redundant. 

I also see that TIF_SYSCALL_RET is also set when processing the ptrace
syscall, Which can leave the flag set for next syscall execution. Which
can again trigger the same issue.

Regards,
Mukesh
>  arch/powerpc/kernel/syscall.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/syscall.c b/arch/powerpc/kernel/syscall.c
> index 4916c205c4bb..fbefe1927b10 100644
> --- a/arch/powerpc/kernel/syscall.c
> +++ b/arch/powerpc/kernel/syscall.c
> @@ -18,8 +18,10 @@ notrace long system_call_exception(struct pt_regs *regs, unsigned long r0)
>  	long ret;
>  	syscall_fn f;
>  
> -	if (unlikely(!syscall_enter_from_user_mode_randomize_stack(regs, &r0)))
> +	if (unlikely(!syscall_enter_from_user_mode_randomize_stack(regs, &r0))) {
> +		clear_thread_flag(TIF_SYSCALL_RET);
>  		return syscall_get_error(current, regs);
> +	}
>  
>  	if (unlikely(test_and_clear_thread_flag(TIF_SYSCALL_RET)))
>  		return syscall_get_error(current, regs);
> -- 
> 2.47.3
> 

