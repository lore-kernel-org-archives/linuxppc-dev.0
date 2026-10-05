Return-Path: <linuxppc-dev+bounces-28924-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 063C9CA5FCE
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Oct 2026 10:05:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hyw4F1Ttnz2y7p;
	Mon, 05 Oct 2026 21:05:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791194717;
	cv=none; b=WQze05qwwq3gmHRDj56Tv710icKbvQVZotptAwi4CPmcPwimnOwGP7+S7EvKOEb0pGjz2JwwQ4SHBozri6iub7HwhHEFKTSM+Gc6aZudtK997ZSNmhLi45g14PHgEerb8apI6TadoRSqgMiBUG6m68I7oyrVCqM9+IRsTiPVdkshTVA8eb1KmY20CzaZ6AuXrH2NC9UxNyoODg1r4ULaO5xgu/twe8AAVGM0zQsjRN/L99T7EvOokOQO4CIkhWERaxQ8/HnFf8kyWnbudLZaT7bpaJySIviz4hX0KbsepuUqNHHoBsU4roymI8a1cYG1yXpoVpo7SHSrStkfQOqhEw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791194717; c=relaxed/relaxed;
	bh=RbmlOi1nGG3+a2z8L1s863EzCm/o39cVEUMyhcapV9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TwZB1GEE7+jLyF8bxrGlj7cKndTnrtJi5gkKV+iFwLRA6bdDqzxJeGf+waNbye11ta8rc5x5uolqgmGVEEhO23+Wh7T9D6XvsTRc1MxAbrL2XVn9M5vImaA5IqEYOyOa+FdBAJ0IWO3/TLFj/w+oIhEMDV3Y9S4xpNh7iYpIdPGbHUQUo5lKJaZIekqd9Ce1dy+DweM2HirXRR/GeOQ6Ss9wDgnCC5YDPS8l92n5ilwRGH4nP8dfM0/+ZiO9goo2PAEz2wtKTkxohAKSpLBexkKXIW0f4iLLXDb3NW2YOAXvqpv+7LL1kNLor0U9jkQ35LTpGAwprJgwmspx5Pbz6A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nbdTYaz5; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kees@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nbdTYaz5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kees@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hyw4D15xcz2y7Y
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Oct 2026 21:05:16 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id F0FB2411D0;
	Mon,  5 Oct 2026 10:05:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C75B21F000FF;
	Mon,  5 Oct 2026 10:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791194712;
	bh=RbmlOi1nGG3+a2z8L1s863EzCm/o39cVEUMyhcapV9Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nbdTYaz5G5Vkm8F9hfuQAM0E0M1F5n3QWdYI5CrJ18VVF4g5ez2EotxymSCFYDWME
	 3yDzw+8uah/GcVop/IKDGdRijkxrUpylpwXVIV0YDghdLk4hMtObdGQgLeeXATPvPv
	 ApeEf/6jesqm5R/1nQsZK6bkoweYBvg5XFQOsImy5jyX9SMXxwKlSruYVO45eiN65m
	 MldLiX/5LBwCxjJAsyNWLJbxi0a207TQ7iZCkcYS0S/vCp7PE6y2MDb904rQocX3y+
	 qHaoevr+sVWKgJHJIdYcHCs9tjR7zt/WJTmmAN4gWx/heUF+zEDulsT/4EWQrSBHk4
	 ZWcF8RB/RSCeg==
Date: Mon, 5 Oct 2026 03:05:12 -0700
From: Kees Cook <kees@kernel.org>
To: bot+bpf-ci@kernel.org
Cc: morbo@google.com, akpm@linux-foundation.org, david@davidgow.net,
	pmladek@suse.com, senozhatsky@chromium.org, shuvampandey1@gmail.com,
	rostedt@goodmis.org, corbet@lwn.net, gnoack@google.com,
	willy@infradead.org, mic@digikod.net,
	andriy.shevchenko@linux.intel.com, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, jikos@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
	memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
	yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
	ihor.solodrai@linux.dev, chleroy@kernel.org,
	u.kleine-koenig@baylibre.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, npiggin@gmail.com, sbhat@linux.ibm.com,
	blum@kernel.org, alison.schofield@intel.com, dave.jiang@intel.com,
	gregkh@linuxfoundation.org, lgs201920130244@gmail.com,
	iweiny@kernel.org, u.kleine-koenig@pengutronix.de,
	vishal.l.verma@intel.com, rdunlap@infradead.org,
	skhan@linuxfoundation.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
	linux-trace-k@lists.ozlabs.org, ernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, nvdimm@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org,
	martin.lau@kernel.org, mason@kernel.org
Subject: Re: [PATCH v4 01/11] seq_buf: Do not print an empty line from an
 overflowed seq_buf_do_printk()
Message-ID: <20261005100502.86b595-kees@kernel.org>
References: <20261003035921.1918874-1-kees@kernel.org>
 <aa721817952d2aff37a77588339c61d5090f1589203451243ed88149bf00f1d5@mail.kernel.org>
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
In-Reply-To: <aa721817952d2aff37a77588339c61d5090f1589203451243ed88149bf00f1d5@mail.kernel.org>

On Sat, Oct 03, 2026 at 04:50:50AM +0000, bot+bpf-ci@kernel.org wrote:
> TL;DR: The new KUnit test may fail spuriously, and stop detecting the bug,
> when console_loglevel suppresses KERN_INFO (quiet, loglevel=N) or
> CONFIG_PRINTK=n, since the capture console never sees records.

That's a pointless state to handle: KUnit reports its own results at
KERN_INFO, so with a console that hides KERN_INFO, or with printk
compiled out, all of KUnit is unusable, not just this test.

-Kees

-- 
Kees Cook

