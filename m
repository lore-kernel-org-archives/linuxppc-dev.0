Return-Path: <linuxppc-dev+bounces-22857-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9E4FCDB46B
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Jun 2026 13:08:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gjs8p6HQVz2xQD;
	Sun, 21 Jun 2026 23:08:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1129"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782047322;
	cv=none; b=AuU039CPBiB4RH2ZCTgMcADVpxnXMxWdzOH5Hi4zjFGIHWR2nMmCKgPsjL4Hv/uthNA8xfxiDLc29dV7oa3/ACFrl9cYNWWVpGy0ULW4kSqoN4sQwFT+iuc/Av1WOCafSkDo+zwZoJptK8i/QEgSh1lsKas3FABGckNf18AIf4yk0Dq2Sy/ZUT9iSnmS+zWASXrP1YoW4OpFG/2bhaZ3pQCtS1lmXoC0j/XNzQk89K4HKoaYushKVzII06MSAYBKatkMVk+tQFaT19lz7eJwtW6dVGrD7g/1ZhM/wWZIa0Qk5WyRpbYCGw/I5cYQfs3NgNu8ybxa4+JVShoXKfvrbA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782047322; c=relaxed/relaxed;
	bh=JelQF+PgdiILboeOL52+qm2l/XNW/EjjD3ktKV3cKe4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AkN7gZ9mG4iOKZ+Ps34lSkYQVB8TlO8ET3phr56LyhAWGmmxw58yu0rXIOt0CMZZcVdTkhr35W8otGppJsX52EVlEq2+XcB4w1NLlg6krvhoPXqDM4WWpfzQUpD2YaUHqliBo39SAM3t786injuapUgXcomy83uBN54f98yGhHPtTZehqrGvHlbrzbORbFC/yPwjvvAhC8qIFHvGo5wt6XO9vhH7BVAUM1K3xVSYzga7JEDnp3HCxk0bnc7/cqVUOjcvpf/+8GqPrVRLQ05JWqXh48I94B/F6+jdtatnbxfMgP+7f2MU8BGw8BzrB92xX5w/MLJYQ8MCXtxsveUhgA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qUrMqR6L; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1129; helo=mail-yw1-x1129.google.com; envelope-from=yury.norov@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qUrMqR6L;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1129; helo=mail-yw1-x1129.google.com; envelope-from=yury.norov@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gjs8n2n5jz2xPb
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Jun 2026 23:08:40 +1000 (AEST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-8000e21f014so34813727b3.2
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Jun 2026 06:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782047318; x=1782652118; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JelQF+PgdiILboeOL52+qm2l/XNW/EjjD3ktKV3cKe4=;
        b=qUrMqR6L4iC4MTvTwEaIumKNQnbKujZ+sa8IK9AKBSicJaZaAO7A7lcrbyby3smlLJ
         0VrWKOyn1bBSIJJjur0ASuvn27JlSElO2/V41Uor+SIoiNQ+8ltjV1eDJVz82EISaGVd
         3BOSe1DytHW/9rmHqB+0YxmOwWAuCvQNZ2dbVef5ZHqZABkz1/hmanTVhUro4ZRkFSU3
         LGAW4jNdlC8YKa+vh1KIhE2x/9SnSoQrOC9+pEmmXDJLYoWAnVcnCjMbFYc98GUzyZw5
         LlaWPyvH8hFpLi6giZjxU3ctJ/W7Cpv+RcQwzCcYFKIWmCbX6mbEq9w2luA0jkyV2wjM
         YOQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782047318; x=1782652118;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JelQF+PgdiILboeOL52+qm2l/XNW/EjjD3ktKV3cKe4=;
        b=hUjod0Dzsd1TUGScPPfnFdQ7HD/F+oEgooPIo571smjXVURSy08m8Bx7d+nELyn+kQ
         25Z33BkIDEjljb11DukaoB7eI1I2X0Q8C2AEfwDIuCbEgDQQZ/8smqYV+rBagp8cEl/+
         n//GKfFx4z1jnm3Qew8Pi0P0IS2Rb/0cOOj4LST7GnnMSJHNxciq2x5Fbmsrr2IOAtDK
         OD1bt8ir2qxBO5IRHL4aR4bACQhqKpP65x6BqM6pDDs2gQtZKPvMTpQ2TsA3pb3/8Wfv
         IX289CWe1+ofoGWCfAjHDYRBQVtoFWn5vSFi5nRXa5c3qmzf5IIkFhOd10eRp/rSQbnZ
         A8bw==
X-Forwarded-Encrypted: i=1; AHgh+RrsPumwdHYbVv68DrP/JmXTgY8AnT044I8LKJHK2Q7MHMs/vqEe58N6dt6w1kbe8xZiPM1EtjvK1GfWwVI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yzx5HAOu1/5dEpOHPNsVUepRUCmrPIfnFrOfVBgXI/khciTsb3C
	Mk22+1MuIXRM2jqpdilPoV1gQhs9pxaXmY70rvSiqOigmGD7fWqqew+e
X-Gm-Gg: AfdE7cmu+uBKHOvhdISzbKEdIySNIJkWREzHf2Sxv2iyICYxdTvfeHcRCVTcpnS9pa0
	nijqocFcZ+yP+e5P1163q9VlWqKmgoyTVRoLLjhr3x2LcNftbrxQk49VPmO6jtqVLFHp83sdTXo
	EPfLdVJXBXwgvE7qRTUtnVITGzTcrNaV3LJW2l1nkxKE00xaIcxF27ptK349ApkBTEz+iL4BJXe
	J/ulAWmMj5PuzLPv/KygaIIbn6g8JMe1s2NFLsPKLaZ2Qw20sOSdupBBiIeaVZo1qY3+mwgAUyx
	q6+Cb/DK2O8aKZeME7LjGm7fuI8patxISJCPtcyofHQULTnkvzZCK7K/XHTz3KDtiBgEyFJykyx
	KEoVv9VQwcSgVwvzbdiADe3ZCk3lI2bvy28vX/vElwy9qgeY8aWDCIRwVwvLtJxvVflV+r7aKAb
	15koOexzxYbBL3SGT7edRARYg23oFCMMTLTuo=
X-Received: by 2002:a05:690c:6881:b0:7fd:5297:28da with SMTP id 00721157ae682-80139103c73mr119142517b3.49.1782047317965;
        Sun, 21 Jun 2026 06:08:37 -0700 (PDT)
Received: from localhost (user-24-214-85-55.knology.net. [24.214.85.55])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8025cf693f8sm20544597b3.15.2026.06.21.06.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 06:08:37 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
X-Google-Original-From: Yury Norov <ynorov@nvidia.com>
Date: Sun, 21 Jun 2026 09:08:37 -0400
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
	Peter Zijlstra <peterz@infradead.org>,
	Julia Lawall <julia.lawall@inria.fr>,
	Yury Norov <yury.norov@gmail.com>, linux-doc@vger.kernel.org,
	linux-kbuild@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	dri-devel@lists.freedesktop.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-rdma@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-nfs@vger.kernel.org, kvm@vger.kernel.org,
	intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH 1/2] tracing: Move non-trace_printk prototypes back to
 kernel.h
Message-ID: <ajfiVTlCIVlqW3sh@yury>
References: <20260621093430.264983361@kernel.org>
 <20260621093811.007634476@kernel.org>
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
In-Reply-To: <20260621093811.007634476@kernel.org>

On Sun, Jun 21, 2026 at 05:34:31AM -0400, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> In order to remove the include to trace_printk.h from kernel.h the tracing
> control prototypes need to be moved back into kernel.h. That's because

Please don't. Instead, you can split them out to trace_control.h, and
include where needed. I actually have a prototype for it, FYI:

https://github.com/norov/linux/tree/trace_pritk3

> they are used in other common header files like rcu.h. There's no point in
> removing trace_printk.h from kernel.h if it just gets added back to other
> common headers.
> 
> Prototypes are very cheap for the compiler and should not be an issue.

It's not about cost, it's about mess. kernel.h is included everywhere.
Is that API needed everywhere? No, it's needed in literally 10 files.
So, no place in kernel.h.
 
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> ---
>  include/linux/kernel.h       | 18 ++++++++++++++++++
>  include/linux/trace_printk.h | 17 -----------------
>  2 files changed, 18 insertions(+), 17 deletions(-)
> 
> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> index e5570a16cbb1..c3c68128827c 100644
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -194,4 +194,22 @@ extern enum system_states system_state;
>  # define REBUILD_DUE_TO_DYNAMIC_FTRACE
>  #endif
>  
> +#ifdef CONFIG_TRACING
> +void tracing_on(void);
> +void tracing_off(void);
> +int tracing_is_on(void);
> +void tracing_snapshot(void);
> +void tracing_snapshot_alloc(void);
> +void tracing_start(void);
> +void tracing_stop(void);
> +#else
> +static inline void tracing_start(void) { }
> +static inline void tracing_stop(void) { }
> +static inline void tracing_on(void) { }
> +static inline void tracing_off(void) { }
> +static inline int tracing_is_on(void) { return 0; }
> +static inline void tracing_snapshot(void) { }
> +static inline void tracing_snapshot_alloc(void) { }
> +#endif
> +
>  #endif
> diff --git a/include/linux/trace_printk.h b/include/linux/trace_printk.h
> index 3d54f440dccf..879fed0805fd 100644
> --- a/include/linux/trace_printk.h
> +++ b/include/linux/trace_printk.h
> @@ -35,15 +35,6 @@ enum ftrace_dump_mode {
>  };
>  
>  #ifdef CONFIG_TRACING
> -void tracing_on(void);
> -void tracing_off(void);
> -int tracing_is_on(void);
> -void tracing_snapshot(void);
> -void tracing_snapshot_alloc(void);
> -
> -extern void tracing_start(void);
> -extern void tracing_stop(void);
> -
>  static inline __printf(1, 2)
>  void ____trace_printk_check_format(const char *fmt, ...)
>  {
> @@ -176,16 +167,8 @@ __ftrace_vprintk(unsigned long ip, const char *fmt, va_list ap);
>  
>  extern void ftrace_dump(enum ftrace_dump_mode oops_dump_mode);
>  #else
> -static inline void tracing_start(void) { }
> -static inline void tracing_stop(void) { }
>  static inline void trace_dump_stack(int skip) { }
>  
> -static inline void tracing_on(void) { }
> -static inline void tracing_off(void) { }
> -static inline int tracing_is_on(void) { return 0; }
> -static inline void tracing_snapshot(void) { }
> -static inline void tracing_snapshot_alloc(void) { }
> -
>  static inline __printf(1, 2)
>  int trace_printk(const char *fmt, ...)
>  {
> -- 
> 2.53.0
> 

