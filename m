Return-Path: <linuxppc-dev+bounces-22868-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EE0FCDB471
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Jun 2026 08:34:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gkM2M3wr8z2yVd;
	Mon, 22 Jun 2026 18:34:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:8b0:10b:1236::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782117291;
	cv=none; b=fucBDJM2w1fNLoaDpDkipUhwqZO+DIxD7AHiD2QftAkI1Q+fdW8NTw6aqehx9aey1uOZBrHgr0oqqFNX8SdLz0wXmMB+P/dUkmH5yxFhMxyX/Ze5YZ9ada4P9M2PUhQoBPWnpI2Rd1f5gGniMex+0pnQFRttdGSc/w7FolWquZhzNigUYirqDV5I0M3YKDkBfWZp2MxAPmg9X1b8tjhDkLMvYHIhoQkfqmDrXevWIlM9g9InORssKxvicfhpk874Wj+hMa60rH9hVP7kwSlHxO4sWPxXLGFp+BxNxq/fAv1gyZf6SOpQq3RZzkOVk1PLlDugfns/W7JLW+FqaLnb0g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782117291; c=relaxed/relaxed;
	bh=y2+mOP/j6lYd9qVyAamBJsy1djQW4CKGJJUDwRnuyXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RyPu37s/Adu99+JFw1h+juhHryTLMut5ZlOQ8NrIVOj7kcXlpmwsNHmm9qIW6A7Efs3/MUxq6uWeEZRtibrI07JEfP6lJ4fIqMuyx6Cx2AthRjbBK6IueuWN/IHVZ8Q0ZgBla5rWc17zD3j7Pibv+gyyRbKm48q8WSiSckY9kFX3z0ZyCfvomv3yRl+FV6+MSkG7MhDn9bDas6+WA3UyZHbOj6K0EjlhriljYf3Bn/Bns0Z6orrc8VtlwBgpBBvtFFUFCKyxE5u4KDDUJE/NGzT68bDTE5ZPL9d1NtmVAjKQ85s7cByZcVs07P/2eSqIaGum7SqDh67lMFnICxhqCA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=TuPlTRCU; dkim-atps=neutral; spf=pass (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=peterz@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=TuPlTRCU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=infradead.org (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=peterz@infradead.org; receiver=lists.ozlabs.org)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gkM2K2B5Jz2yVZ
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jun 2026 18:34:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=y2+mOP/j6lYd9qVyAamBJsy1djQW4CKGJJUDwRnuyXs=; b=TuPlTRCUatJuuJgUUAwvzHwMKv
	dWwVfsTqUjTJh9SX5fPBCQGdiQcrZu7Ws4gSZKgN7rA0kNKxui7b5LEtKWEEQDe4V7j5A8N0jYuRY
	uas/iKoJjFjR3gKpo0uOWWxjsbSNbU4N4b8MGJpMvU190ZELYDlzfAoftHa96t+aSCVqbpoMUbpfL
	uOWtb+WeGCTtTYOdcuf3kQ/LcfWhZsQK+C/ri3C/zOHCtiyE1n8uDvDi3TDA+Xy225DqvitJuIeN0
	RneapmfngTU0PhOUCG9gkRpGwiGc3BAbq6jkG1ZvAJCnP1chuakPaLn4PyoFg+CyhHRv/kOJ0Ywl3
	cXoCNRYg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wba77-00000003u7U-1iUV;
	Mon, 22 Jun 2026 08:34:42 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 52395300B5F; Mon, 22 Jun 2026 10:34:40 +0200 (CEST)
Date: Mon, 22 Jun 2026 10:34:40 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	Thomas Gleixner <tglx@kernel.org>,
	Julia Lawall <julia.lawall@inria.fr>,
	Yury Norov <yury.norov@gmail.com>, linux-doc@vger.kernel.org,
	linux-kbuild@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	dri-devel@lists.freedesktop.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-rdma@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-nfs@vger.kernel.org, kvm@vger.kernel.org,
	intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH 0/2] tracing: Move trace_printk.h out of kernel.h
Message-ID: <20260622083440.GX49951@noisy.programming.kicks-ass.net>
References: <20260621093430.264983361@kernel.org>
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
In-Reply-To: <20260621093430.264983361@kernel.org>

On Sun, Jun 21, 2026 at 05:34:30AM -0400, Steven Rostedt wrote:
> There's been complaints about trace_printk() being defined in kernel.h as it
> can increase the compilation time. As it is only used by some developers for
> debugging purposes, it should not be in kernel.h causing lots of wasted CPU
> cycles for those that do not ever care about it.
> 
> Instead, add a CONFIG_TRACE_PRINTK_DEBUGGING option that developers that do
> use it can set and not have to always remember to add #include <linux/trace_printk.h>
> to the files they add trace_printk() while debugging. It also means that
> those that do not have that config set will not have to worry about wasted
> CPU cycles as it is only include in the CFLAGS when the option is set, and
> its completely ignored otherwise.

Did you forget your C 101 class? If you use a function, you gotta
include the relevant header.

You don't see userspace saying: 'Hey, you know what, perhaps we should
add stdio.h to every other header, just in case someone wants to
printf()' either.

I really don't understand your argument. Yes, maybe someone will forget
and then either their editor (if they have a halfway modern setup with
LSP enabled) or their build will complain, but so what? This is all
trivial stuff, surely we have more pressing matters to concern outselves
with?

