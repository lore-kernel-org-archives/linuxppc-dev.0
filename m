Return-Path: <SRS0=/GF9=P6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D4F3C433EF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Nov 2021 08:55:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8FD561212
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Nov 2021 08:55:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B8FD561212
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HqbBv4Bp4z3c6j
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Nov 2021 19:55:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20210112 header.b=hKMluJXv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::32e;
 helo=mail-wm1-x32e.google.com; envelope-from=elver@google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20210112 header.b=hKMluJXv; dkim-atps=neutral
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HqbB62gHjz2xB1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Nov 2021 19:54:20 +1100 (AEDT)
Received: by mail-wm1-x32e.google.com with SMTP id
 67-20020a1c1946000000b0030d4c90fa87so3889749wmz.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Nov 2021 00:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=C2pRx3VrkRvZzvTAGodY7FBYbqa7VwcKa7WgFhF9R6k=;
 b=hKMluJXv3cyn/6Ynmj9veQdzGcfSmCSFG579re0rSO1tRqLHpBWJu9Fwffh1MImSiV
 9lVDbZ+PTmFa5VLZtW+4dmbkNJhCiV6Mn31mAn/sv9C2ywUe+5Zi9nw1sKPf3D79mJuH
 Xu78Qr/gH0FY/7l8aYSagKd3qmz9gYzLZ62FAXcMZVNkqPtXOBh3x22yTvvJpgfPc81T
 ek0wMLCyit/12eBl70fjor1e4lUxm8HvOdo/uiRyMJ+z0uM+jdn8tMtRpiqnoCejQ6s1
 9Mxz0cBVuYZN6jSzMhjTX2uPJYFwb+XZ+JH+qIGcAEGf2NQ1Qs5ojQHmD9vsEWdGVZcM
 GY/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=C2pRx3VrkRvZzvTAGodY7FBYbqa7VwcKa7WgFhF9R6k=;
 b=HZNiHt50XT7QI4GBbn2EeAIJBsp5tGB14SBYRuDcb1A83JHr+PLPtY5WAdnD6zm+gu
 aLNP2r/2s+ivu+CFD+Ee/hvI7KkUMhM8wADNRSgyqZS+sUUwbRzq3stR5FLMk9isl4h2
 xaLk7/lwWResp5OJsXJQUfDUiu2PXlekZNHZ7NtNVM2IAm5KgC7L8rTl4VQVzaJnvfML
 p1YesrW9UX/GYK6qQxvvPCdGIpxttYxl4H41eGzOeJTOFAZzWvQrcYV5kJ2z/lbvI+lG
 tlXD4XGwmoetcINVmtPRbDsMBr94FI/JFcbvSmIFFCUopCKj7XM90iaBN3eMghwW4Znt
 HlmA==
X-Gm-Message-State: AOAM5338sCrUdy04r6CrzlWWwIet8hqSzK7yZdCk3c8VDbUk4oNvrWme
 FcN3z3mfjPwi7JGzpb3R7TP8iQ==
X-Google-Smtp-Source: ABdhPJxEBRNPec/bxvLCqnLUS7WDbPiOxrRwFfQ0JkP8imwe8zHRLQn9sFwrFH2xKqmya9LJVZJJMA==
X-Received: by 2002:a05:600c:4f8a:: with SMTP id
 n10mr6436687wmq.54.1636620852405; 
 Thu, 11 Nov 2021 00:54:12 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:fd21:69cc:1f2b:9812])
 by smtp.gmail.com with ESMTPSA id l2sm8637092wmq.42.2021.11.11.00.54.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Nov 2021 00:54:11 -0800 (PST)
Date: Thu, 11 Nov 2021 09:54:05 +0100
From: Marco Elver <elver@google.com>
To: Valentin Schneider <valentin.schneider@arm.com>
Subject: Re: [PATCH v2 2/5] preempt/dynamic: Introduce preempt mode accessors
Message-ID: <YYzaLTtf1tFbqDSn@elver.google.com>
References: <20211110202448.4054153-1-valentin.schneider@arm.com>
 <20211110202448.4054153-3-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211110202448.4054153-3-valentin.schneider@arm.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Michal Marek <michal.lkml@markovi.net>, linux-kbuild@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>,
 Frederic Weisbecker <frederic@kernel.org>, Mike Galbraith <efault@gmx.de>,
 Nick Desaulniers <ndesaulniers@google.com>, linux-kernel@vger.kernel.org,
 kasan-dev@googlegroups.com, Paul Mackerras <paulus@samba.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masahiro Yamada <masahiroy@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@kernel.org>,
 Dmitry Vyukov <dvyukov@google.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Nov 10, 2021 at 08:24PM +0000, Valentin Schneider wrote:
[...]
> +#ifdef CONFIG_PREEMPT_DYNAMIC
> +
> +extern bool is_preempt_none(void);
> +extern bool is_preempt_voluntary(void);
> +extern bool is_preempt_full(void);
> +
> +#else
> +
> +#define is_preempt_none() IS_ENABLED(CONFIG_PREEMPT_NONE)
> +#define is_preempt_voluntary() IS_ENABLED(CONFIG_PREEMPT_VOLUNTARY)
> +#define is_preempt_full() IS_ENABLED(CONFIG_PREEMPT)
> +
> +#endif
> +
> +#define is_preempt_rt() IS_ENABLED(CONFIG_PREEMPT_RT)
> +

Can these callables be real functions in all configs, making the
!DYNAMIC ones just static inline bool ones? That'd catch invalid use in
#if etc. in all configs.

>  /*
>   * Does a critical section need to be broken due to another
>   * task waiting?: (technically does not depend on CONFIG_PREEMPTION,
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 97047aa7b6c2..9db7f77e53c3 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6638,6 +6638,17 @@ static void __init preempt_dynamic_init(void)
>  	}
>  }
>  
> +#define PREEMPT_MODE_ACCESSOR(mode) \
> +	bool is_preempt_##mode(void)						 \
> +	{									 \
> +		WARN_ON_ONCE(preempt_dynamic_mode == preempt_dynamic_undefined); \
> +		return preempt_dynamic_mode == preempt_dynamic_##mode;		 \
> +	}

This needs an EXPORT_SYMBOL, so it's usable from modules like the
kcsan_test module.
