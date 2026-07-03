Return-Path: <linuxppc-dev+bounces-23503-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EB66C43458
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Jul 2026 12:46:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gsD5V3WsSz2xdb;
	Fri, 03 Jul 2026 22:46:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::436"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783082782;
	cv=none; b=cLLfkors3mwEIeitiWjDEL/xYQqNg96a25S9RLO/O/ehIIKq/NHlKoFZRK1nXGLslaZx7T1AWeC9xCWHsYeC9djbK1uiY+eTFbVz3KHDxMKysNZ+9fRdgiQ1g2hibjOhf5Roqp8RUaGjmWMc0fe4E/Baaf9RdN4xpZb5KR7GG8mk2jqF2Tw+9rks5XMC3WkRkg58VEAGIZSoDx0whHIvonDJS6xnad2dFXfKc1J8ivJ9nLU9ErdpCV7Y72iJbGvG/i+yRIL3lKzgIkwsBfnYaOfvBzSiygj+jUNlphjupm/P4rMIqGz2Y8KovuBU2HyiimNatYnRXwAjaRM8etq2Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783082782; c=relaxed/relaxed;
	bh=EsBLm+/j8lRVOopPYicPuZIR3XyWb+EmA3UL37jV8mE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NdoM1edDs/id8SS321O5LxlNIjWGaap0PgOI8i8Qwy4SkHRLI8xE8rVVRvM1UbbDgX10I7cXO45rVStAj+UGNkXEEX4nGhcamHo7LJBvGm3SycCEujskN61NcjP4lDYWcC/OcRZ1W3XTIZjuoZ/zSd0XV1Y6HkaEn9T+G41z5QwT+Iorq7mrT0aSGHeC5z+O5cgW/sHZ51ZnKBPwQsK+5ANFyHrI/MWnGaP4XxAFzi/GaiqP85F6st3N+5eppjjop0oEOvSPG3+hIiGeAYsw2wVo+Dof8zumGQQrKDzXVS0flreXzGsE689Cn6YXGFb8PLBSgM31OUT40g1Iq/40gw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=ERW+2bph; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::436; helo=mail-wr1-x436.google.com; envelope-from=pmladek@suse.com; receiver=lists.ozlabs.org) smtp.mailfrom=suse.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=ERW+2bph;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.com (client-ip=2a00:1450:4864:20::436; helo=mail-wr1-x436.google.com; envelope-from=pmladek@suse.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gsD5S5P0bz2xLq
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jul 2026 22:46:19 +1000 (AEST)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-475417f010dso353982f8f.2
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jul 2026 05:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783082775; x=1783687575; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EsBLm+/j8lRVOopPYicPuZIR3XyWb+EmA3UL37jV8mE=;
        b=ERW+2bphNOI7aJx10lkBuSNN3QPA1csZ4us9NeKrPLEif3y0k2uUqZbLVMeJxLpDfS
         ZqO/4mlvsq9b1OeC7yGi6o9xEa1fYvRNwY4GSq+eqmk32luF9BEE3yE+K5fJnIZIeR8E
         zOr2Q4/iBqlRwVSAzNcYtz5pnMmlOevtkTq4iwNHwZdEVTJqI1DZ/BLo+wtjVTFv61nO
         uotOyKMll1h0avtSy80IPFV1hdfPkYofSq9iOoeRL0hyq8azut1VqcRMJL1ZmjODCy65
         +VadD49RpMgztSsW0P9CKVQ8A6JMQpPMZk3yr/A1zqzJYX656CWsb7zrZLGCOerA0Y8w
         BxJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783082775; x=1783687575;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EsBLm+/j8lRVOopPYicPuZIR3XyWb+EmA3UL37jV8mE=;
        b=gDJ4Xb7DKQsiHcLwOK3lxRV6WYbfKAU0jw2GSfYzUTp9+FRVpipcLvNZwkP/VT1MB2
         060g4LuMXzI+eCUExbUeZuzYIWAocjtLP1fRGpS4Tg/IqdHyYxXQZ0mCOIzTecaxMObU
         P6CHYWYVGnMMYS7XJSqR4qI/fRJRo7RpO9GEzhc+rR4xZYgRV9jDYlyXtA84qYgu0Va9
         TcP0lUS5dp1lF/n5WNTuGYJpjQh5aQqGO0/gHrsua7PA6cKWSHapywvl9UVGS95qRb+O
         2LMFNl9fYOEs9PWh2VqpHapyrNTX6Lu5hGlCzmUwuND0cAXnR0WudSJKwlSjkrYJiWG7
         6lzg==
X-Forwarded-Encrypted: i=1; AFNElJ/iiIQQnsgnSb4e945ChjbM+wvy8q41TJyFPXfbzKYTtm7tmqEYT4BFcLDA5minN+6R6LEiUjMYvcCgrOE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YylrNiuKwCeIzKB4X5jwW/m3tpRYx+IoMtbTisHD3DHAdD7/uch
	Nw6PhVYxI50r6yNQ3iAC4GAAJ7pf/2HPtvrbpLJbsTz9o1oc9wL4SsNSBjOBXYPu/Cs=
X-Gm-Gg: AfdE7cnLIcf1uM/FohWctF/WCwASxyO4OUH4fADykCu4ug3KZYBUcNQ6ONs+UepSf4S
	R9d8DP6wxkF6BWUHGPuLLBdzI9gfZZMqPVGHr128OxODJ93R6Pj2Yv+0rxgIj3ynkJDBVh2KTqo
	y2DwXjs00xNuo2HgUtr6nSRQxfNwVel67dPQ4YFOIr+cohVYWtFic1hhtKKa47VaFyOHaBTCcfS
	m5w1V+Go+uSkXAhZyPhaw/7HtqQoB+Pz5omjWsVttlGbnAzlCyC/QZXFTqcF9Dk5FdLi38CxQfF
	Mw9BRgc6sK5TI9yMPB46pPbY0nCCDfif5HLfXo9rQiMYSH6q7C+YNXb9ntGOqLk6BvyqCqlsAqu
	WEoqgkC/6T9eyAlAmC3ki+XMjgGX1ul5zOmDa9XdVNYk9LC4ZFnGkUXlcgr+kLVNSoQ9NDBwJKa
	j7oBTFPzAgYuMC05U=
X-Received: by 2002:a05:600c:5805:b0:493:b163:42e8 with SMTP id 5b1f17b1804b1-493c2b7f204mr94148515e9.21.1783082774690;
        Fri, 03 Jul 2026 05:46:14 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493ccdb62d3sm54494835e9.8.2026.07.03.05.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 05:46:14 -0700 (PDT)
Date: Fri, 3 Jul 2026 14:46:12 +0200
From: Petr Mladek <pmladek@suse.com>
To: Bradley Morgan <include@grrlz.net>
Cc: Feng Tang <feng.tang@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Douglas Anderson <dianders@chromium.org>,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 4/4] panic: use sys_info_with_filter() to avoid
 duplicate backtraces
Message-ID: <akevFNCaXnt0kRVC@pathway.suse.cz>
References: <20260625152558.7450-1-include@grrlz.net>
 <20260625152558.7450-5-include@grrlz.net>
 <aj5TNB8cRtMNTtIT@pathway.suse.cz>
 <aj5tFiwhRqPkAkqU@pathway.suse.cz>
 <akJZxCTlLcwubqi2@U-2FWC9VHC-2323.local>
 <E482A23D-4E1C-42C0-9D07-83C6CDFD1546@grrlz.net>
 <akYq1YaCpZ0b4SBS@pathway.suse.cz>
 <EC1E5A79-524A-45C2-9FE8-964EB0E18D76@grrlz.net>
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
In-Reply-To: <EC1E5A79-524A-45C2-9FE8-964EB0E18D76@grrlz.net>

On Thu 2026-07-02 19:13:26, Bradley Morgan wrote:
> On July 2, 2026 10:09:41 AM GMT+01:00, Petr Mladek <pmladek@suse.com>
> wrote:
> >On Mon 2026-06-29 13:54:18, Bradley Morgan wrote:
> >> On 29 June 2026 12:40:52 BST, Feng Tang <feng.tang@linux.alibaba.com>
> >> wrote:
> >> >On Fri, Jun 26, 2026 at 02:14:14PM +0200, Petr Mladek wrote:
> >> >> On Fri 2026-06-26 12:23:50, Petr Mladek wrote:
> >> >> > On Thu 2026-06-25 15:25:58, Bradley Morgan wrote:
> >> >> In watchdog, panic, and hung task detection scenarios, sys_info() can
> >> >> be called multiple times or alongside direct backtrace triggers like
> >> >> trigger_allbutcpu_cpu_backtrace(). This results in identical
> >backtraces
> >> >> being dumped repeatedly from all CPUs, cluttering the kernel log and
> >> >> delaying or obscuring critical debug details.
> >> 
> >> im feeling a new file to do all the force panic jazz, but putting tape
> >> on sys_info.c isn't bd either.
> >
> >I wonder how to move forward with this.
> >
> >Honestly, I am not sure what exactly you mean by creating another
> >API for tracking the reports so I could not judge it. Feel free
> >to sent some POC.
> 
> sup petr, here's my poc
> 
> This should make my entire thing make sense
> 
> >From eb587ed749ff5993c517f29799b369185c5ee7d8 Mon Sep 17 00:00:00 2001
> From: Bradley Morgan <include@grrlz.net>
> Date: Thu, 2 Jul 2026 18:09:23 +0000
> Subject: [POC] sys_info: Introduce incident state-tracking to prevent
>  duplicate diagnostics
> 
> In watchdog, panic, and hung task detection scenarios, sys_info()
> can be called multiple times or alongside direct debug output
> functions (like trigger_allbutcpu_cpu_backtrace(), print_modules(),
> print_irqtrace_events(), and dump_stack()). This leads to identical
> diagnostics and stack traces being dumped repeatedly, cluttering the
> kernel log and delaying critical panics.
> 
> Introduce a state tracking bitmask and helpers in a new file,
> lib/sys_info_filter.c:

New file suggests that it would implement an API using
sys_info_filter() prefix.

> - sys_info_filter_and_set(mask): Atomically tests which bits in a mask
>   have not yet been printed during the current incident, marks them as
>   printed, and returns that subset.

The name of the funtion is a kind of puzzle. I think that we
could do a better job.

> - sys_info_reset(): Clears the printed mask state.

This function has sys_info* prefix. It would expect it in sys_info.c

> Add SYS_INFO_MODULES, SYS_INFO_IRQTRACE, and SYS_INFO_STACK flags to
> include/linux/sys_info.h, and handle them inside sys_info's diagnostic
> dispatch.

I though about adding an information that we printed backtrace for this
CPU as well. But it not trivial. Different API shows different extra
info, like modules, IRQ backtrace, registers, code. I would leave
this complexity aside for now.

> Update the watchdogs, hung task detector, and panic core to call
> sys_info_filter_and_set() to deduplicate their diagnostic printouts, and
> sys_info_reset() when a warning incident concludes (e.g., when a stuck
> CPU recovers, or a new hung task check round begins).
> 
> This ensures each piece of system diagnostic is printed at most once per
> lockup/panic event, preventing console log spam.
> 
> Assisted-by: Gemini:gemini-3.5-flash
> Signed-off-by: Bradley Morgan <include@grrlz.net>

> --- /dev/null
> +++ b/lib/sys_info_filter.c
> @@ -0,0 +1,120 @@
> +static unsigned long sys_info_printed;
> +
> +unsigned long sys_info_filter_and_set(unsigned long si_mask)
> +{
> +	unsigned long old, new;
> +
> +	if (!si_mask)
> +		return 0;
> +
> +	do {
> +		old = READ_ONCE(sys_info_printed);
> +		if (!(si_mask & ~old))
> +			return 0;
> +		new = old | si_mask;
> +	} while (cmpxchg(&sys_info_printed, old, new) != old);

It is a good question whether to update the info using atomic
operations. One problem is that the mask is "unsigned long".
I am not sure if it natively atomic on all architectures.
32-bit architecures use extra locking when implementing
atomic operations with 64-bit values. And we should rather
avoid any locking in this code.

Well, long seems to be 32-bit on 32-bit x86 so it might be
safe after all.

> +void sys_info_reset(void)
> +static void __sys_info(unsigned long si_mask)
> +void sys_info(unsigned long si_mask)

I wonder why this sys_info*() API implementation has been moved
from sys_info.c to sys_info_filter.c.

I am sorry but I do not see any advantage in adding the new file
sys_info_filter.c

> NOTE!!: This is AI generated!! This **MAY** not be the finished product,
> this is ONLY the model!

IMHO, Gemini did pretty bad job in this case. Please, try to review
the AI generated before you send it. And send it only when you think
that it is reasonable enough. :-)

It is even fine to send "crap" but you should start the mail
with a warning that you send it just give us an idea what you
had it mind. And you should explain why you actually do not like.

Best Regards,
Petr

