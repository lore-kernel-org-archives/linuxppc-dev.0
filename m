Return-Path: <linuxppc-dev+bounces-28928-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 808D3CA5FCE
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Oct 2026 11:22:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hyxn740Ytz2yD8;
	Mon, 05 Oct 2026 22:22:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791199339;
	cv=none; b=BEhvJSVqNuOacU0A5i06zW7H1IJLd6jg/CLnuRTjB6/gYvdBEON6PpRHzcgnDtE/S8p/8ND6fnN59bRydohONh1bWoeJFdV/mSYOa5TfEOh/6tuszA/9YCbPR7DoBvLjJOVlmztsZji5N3NvAYxVr8XWMaFWMHDiRAVP72Yc601LD2zp6yyUTd0ZrGZGakCZSee6mBMFJx11Swd7AeO5+zFtCMeANXBKJLGvjPln/6ee5v/AmVTvS8BvWk5HXcHHOtXr5gxjSptfH0yMT7TBxz71V8Btif952pc4ru0jvq7vG/olxZlNnyUKqOUKMMNDb+q9odu4O3pcOfqRS4JIzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791199339; c=relaxed/relaxed;
	bh=+Ur16o5EMFLYs3ii15Ilcb6PLqZ5R/+UrvQP8v8yGf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hJili6UOE+40ih7izw13IaJV887kIuWnze7Brld8Tvi70oGL4WvHPBCHpR96pNeWr+nMnF/xyVHEaAkV9XC6UUQPSv9fCQpD+DzDeA36ihdlonjPWYGIVD1D2gQQv5qF4THzylloxrq4cvNf7bsQWiXmqVIJM0ARtMdIceNoSpo5sckLzjkxsp/R7U3N0iCZB7wx5dCpXypyuUT4VP6JXiVGG8y7GHS40/yuDF8v2CNb8zY+1OOI6Q3kQmxDX5jBi8/2s9ELR7Md5c7LRwPEuXQZ+Hm0X/zuQs1OoStzgQxYoA50q2vLfn2i3bcCHcXcUluq+nsQsF+8Z5gwN/vLOA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HuZWN5Us; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kees@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HuZWN5Us;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kees@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hyxn60W7Jz2y7p
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Oct 2026 22:22:17 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 90DB640B0A;
	Mon,  5 Oct 2026 11:22:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A8451F000FF;
	Mon,  5 Oct 2026 11:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791199335;
	bh=+Ur16o5EMFLYs3ii15Ilcb6PLqZ5R/+UrvQP8v8yGf8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HuZWN5Us1odcgFzPDx1TIFTAMYvOaGXTqYoEoTbeWe2Om0hHL+qOzldtkgSBWUYZh
	 QCUUJkrhwU+0MTe4I7ItSH1rv/dlyns16z4yuAikMzmF68O3Z9KaxB/LMd5tOBcu4u
	 gL00QF+vSno8AlPdZNroFRYsvR7cqfamI3Yv5UdenzxyytF2m6YmcTY4A6049w3BH3
	 NRQNtQI4WVy+e7ywsjNosabc+4bm9TynYJW0RG579Sf/+2uH2UmUVqWC0Lz3gre1A4
	 KOFyx3X6NZxA7USIyXaeyKqNwwFJO6dhpM1FgdABIWZ0w+42yWAAM7DXAKkAr/h03P
	 WlA/xczcpYn6Q==
Date: Mon, 5 Oct 2026 04:22:15 -0700
From: Kees Cook <kees@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bill Wendling <morbo@google.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Gow <david@davidgow.net>, Petr Mladek <pmladek@suse.com>,
	Shuvam Pandey <shuvampandey1@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jiri Kosina <jikos@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Shivaprasad G Bhat <sbhat@linux.ibm.com>,
	Thorsten Blum <blum@kernel.org>,
	Alison Schofield <alison.schofield@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Ira Weiny <iweiny@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	nvdimm@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v4 05/11] seq_buf: Add seq_buf_strlen()
Message-ID: <20261005112209.1e47fa-kees@kernel.org>
References: <20261003035906.too.263-kees@kernel.org>
 <20261003035921.1918874-5-kees@kernel.org>
 <asEhEe0Urb5Wx7yi@ashevche-desk.local>
 <202610040023.A3865A6@keescook>
 <asIPlnb0noMd33rr@ashevche-desk.local>
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
In-Reply-To: <asIPlnb0noMd33rr@ashevche-desk.local>

On Sun, Oct 04, 2026 at 11:34:30AM +0300, Andy Shevchenko wrote:
> On Sun, Oct 04, 2026 at 12:26:39AM -0700, Kees Cook wrote:
> > I'd rather not make all 0-len strings return the .data segment's const
> > "" string...
>
> Good point. Perhaps then to add a short note to the kernel doc,
> so we won't see patches based on the suggestion like I gave?

Yeah, reasonable. :) For v5 I've added this to seq_buf_str()'s kernel-doc:

 * A zero-sized seq_buf has nowhere to put a NUL, so the empty string
 * is returned instead of writing to @s->buffer. Any other seq_buf
 * returns @s->buffer, even when it holds an empty string, so callers
 * always get their own buffer back.

-Kees

-- 
Kees Cook

