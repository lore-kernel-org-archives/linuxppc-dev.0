Return-Path: <linuxppc-dev+bounces-22859-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED463CDB46B
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Jun 2026 13:57:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gjtDl320vz2xPb;
	Sun, 21 Jun 2026 23:57:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1134"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782050231;
	cv=none; b=EZM8a9rSbDD+WMdE5ghpKaLErXPqanWpXozTgNE8LXZmuCObl1OWuvsIxNEJnoZTpBTBG+xP5pmMbRkOLdINFnEdUieeCOVOFuMyWRPjq3tHJKxSq0pl72L7CzaSpAB7mqeSXMdY2IhIPhKd/e1rmRHb19QFeT/RuRemMYqXbcaMyNtHv+j/HYsDOBHJL9unWwdZJtTLBTDuSeEB/B+CtGYJAsVWAKEzbfkvLorhele3vERpq9kJO0jhMM1Hzr2aeT6oF4GNytRagpgtz5/tJNyki4reyoti4Ib7E1sxh+M8BaHYVJazbdrsp6LPX9Vn4e5KcGKxvu7dYD4akuZb2A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782050231; c=relaxed/relaxed;
	bh=Sv1dki/80aNeWwp+36abGEnVJza7FGEeP7NOY9gPTvc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MGb6zVJqTa+Q71OvRyoBiC3kEbqhnO1pv0fn/NK5yWi4YIrlrCGrTb3gLZ2K35vLIEUeQ2TUNfMHm27v9RVKxVSIpAeVjYm3CM2WfngmgkPerZwS7c42c/N9fPGgUjStQ0nofrHfoApw56uA2nEEMShEmj4ifA7NhRrzoesbQnRp55jL6b7j6peO04ZPCZ6PCWUau00s7OYQO5EANVqIEa8QxubRhMuKjhNuDa2MEj3/45ni3AopaVz3uMVaJ+n5O0GBKyqv38pJoZzWR6Mxdz7geez7ql12nBt7WXZh/ckkA5wmAD9Pq60l5ArFX8XuTutW5x+ysWo+1hGcge8vqA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZftML+5f; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1134; helo=mail-yw1-x1134.google.com; envelope-from=yury.norov@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZftML+5f;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1134; helo=mail-yw1-x1134.google.com; envelope-from=yury.norov@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gjtDk12xtz2xPL
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Jun 2026 23:57:08 +1000 (AEST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-7fdeab38240so30526847b3.2
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Jun 2026 06:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782050226; x=1782655026; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Sv1dki/80aNeWwp+36abGEnVJza7FGEeP7NOY9gPTvc=;
        b=ZftML+5f/pa3skt+QoUaZ2IPTeScz9AVOqd9gt5KHY5pMGwdmGWAxhE9BeCWHad6NW
         xJsOh4IPHmaUB8ApsdebWxdHB6+P6sWdeq1/g39Q0gKWFKQM13CALN4sMXqvZc6sKwV7
         Qb6mfEYa9iM8oIMm8Ly4WVW1cP74kwMMkhgDiVXA/Q/Ejk5F09CWG0+gGMRZaY43SkOq
         cf9CrkJdW3hBhnVBf9b1cc0a9kXN49Qu0DNx6AWnA6dx3ndSvl5cP4PfNhk1i3fBbU4K
         L1xnE3hZUsdDN7P4JGtXPPQiiUZYopJcsrzLq1aMEyicxFoWx7UgSPmDHVUmXhm1ixfF
         R2og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782050226; x=1782655026;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sv1dki/80aNeWwp+36abGEnVJza7FGEeP7NOY9gPTvc=;
        b=C3WfBuSdv9AotOenyXvRTWo+fPNasogHHSsEIe+1mN+s0DuVNCacidzcYImKkJLCeG
         gllAf/SRCTZZr2yug7NNSzhCTwRFoLbjbMZZB5SChknRSbf8VaTXtfoPJSudnWUE/FEQ
         l/7MDJzV5xeCT3LZ7XUiycxLTfWRnyhXfTRocqJGHXiAv11K2WeyTAy5HB75bT9casq4
         mVaE0jgz+YiU/sMETD/BUZ9fDmiW4RXQSNADbsPsBzTShuitV7GLfNva20wcZhyVYAI2
         CpVFampbszRRCONg6VskSaYgYOxSo2WNKqfZQ/VPPvwBDrBX1RPNdKFq8Y4rgama69Cd
         nKow==
X-Forwarded-Encrypted: i=1; AHgh+Rqk0vA8PYw7FU5yiy/OLAi65Kf9kvH01tUJyzqdOykWEjxtYXrev6e892SSGJiftVx/ofVcA8yaiygFgm8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz9yCA2QFayGciuumf1/OfkIjVbKIV+YDwPHzpOihqEdirHwKr0
	YsEyzSv5FAFRheEdog7IU0eCNKtdOsaG15r6xjE4pS5dnC/RInwPvRIy
X-Gm-Gg: AfdE7cnOk9TzYoxpXK4Dky1+kqi9ejSrgubbOdBcDVYSodYq2lq978uKKe/ejOQKNVm
	p4KQPg6BDMrTpTQJ6IQEEOosXmPm/5R9BrlSvmfEM2AJicbPbYGofqpYAvgFMvCXK4YDLNJ+VIz
	U8ir/ZyXcMeofBfHXCTIzqQdH0XilvlIIYjrV0jGjMRyCi47w9ZRHK72lgotczAcwTYt0EiPOsH
	BvO4AntyvM8R/obPAYonlzlJJgYEy6D05NBGfFqscCfjlt6xhWySJoXKXuu4d+pWiPfN1lPqzmh
	UEoowLOTIMU4wW18PXccXXgko5u7tWSnzHt4BFOzjVz0FjP2ItGkBePUoEh5PVJdxpOP29JkBPG
	B26faWnB5yL2w1wuzhx3yOBFbaOiuByD7ZOioW0QB+td4CMxHT7PPeKsCE4fyV6Hq4xX1BhCitO
	rP33h9CPrKrJi4h4WmMcXamj5pwI3g5kb5skQ=
X-Received: by 2002:a05:690c:4b8b:b0:7c5:f6c:d311 with SMTP id 00721157ae682-80131d97bdamr100779827b3.13.1782050226417;
        Sun, 21 Jun 2026 06:57:06 -0700 (PDT)
Received: from localhost (user-24-214-85-55.knology.net. [24.214.85.55])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8025c96fdb3sm21073127b3.1.2026.06.21.06.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 06:57:06 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
X-Google-Original-From: Yury Norov <ynorov@nvidia.com>
Date: Sun, 21 Jun 2026 09:57:05 -0400
To: Yury Norov <yury.norov@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	Thomas Gleixner <tglx@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Julia Lawall <julia.lawall@inria.fr>, linux-doc@vger.kernel.org,
	linux-kbuild@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	dri-devel@lists.freedesktop.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-rdma@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-nfs@vger.kernel.org, kvm@vger.kernel.org,
	intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH 2/2] tracing: Add CONFIG_TRACE_PRINTK_DEBUGGING to clean
 up kernel.h
Message-ID: <ajftsRwe19fPTP1r@yury>
References: <20260621093430.264983361@kernel.org>
 <20260621093811.168514984@kernel.org>
 <20260621054721.7cde38f0@fedora>
 <ajfphe4Z8BrfYoUX@yury>
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
In-Reply-To: <ajfphe4Z8BrfYoUX@yury>

On Sun, Jun 21, 2026 at 09:39:17AM -0400, Yury Norov wrote:
> On Sun, Jun 21, 2026 at 05:47:21AM -0400, Steven Rostedt wrote:
> > On Sun, 21 Jun 2026 05:34:32 -0400
> > Steven Rostedt <rostedt@kernel.org> wrote:
> > 
> > > Instead of having trace_printk.h included in kernel.h, create a config
> > > TRACE_PRINTK_DEBUGGING that when set will update the CFLAGS in the
> > > Makefile to allow developers to add trace_printk() without the need to add
> > > the include for it. Having it included in the Makefile keeps it from being
> > > in the dependency chain and it will not waste extra CPU cycles for those
> > > building the kernel without using trace_printk.
> > 
> > Bah, I only tested with the config option enabled, and missed some
> > dependencies with it disabled.
> 
> Yes you did.
>  
> > For instance, rcu.h also uses ftrace_dump() so that too needs to go
> > into kernel.h.
> 
> No, it shouldn't.
> 
> > I also need to add a few more includes to trace_printk.h.
> 
> > OK, I need to run this through all my tests to find where else I missed
> > adding the includes. But the idea should hopefully satisfy everyone.
> 
> If you include it under config in kernel.h, to make the kernel buildable,

I mean: in kernel.h or in Makefile.

> you need to include trace_printk.h explicitly where it's actually used.
> IOW, apply my patch v4-7.
> 
> Then, developers who use trace_printk() on their development machine,
> will be really frustrated when their debugging code will break client
> build just because CONFIG_TRACE_PRINTK_DEBUGGING is disabled there.
> They will spend a day, at best, communicating with remote managers,
> and end up with adding #include <linux/trace_printk.h> in the files
> they touch. Is that your plan?
> 
> If I was one of those developers, the solution would be simple for me:
> don't use trace_printk() at all.
> 
> Thanks,
> Yury

