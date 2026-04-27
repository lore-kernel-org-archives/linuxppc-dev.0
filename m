Return-Path: <linuxppc-dev+bounces-20158-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C923FF885E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Apr 2026 12:24:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g42nT5GFWz2y7r;
	Mon, 27 Apr 2026 22:24:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::72f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777292685;
	cv=none; b=H74D/N4MgYTip5bz9vDpqJLnOHwffOhXZvmIR+vhNO2pxKuM+u/AcGAnCkk9lVU3eBadRSojeFMbWo667Gr9Mf/FKR1ROYVYz864YsPiq0mkC2dPUxlBQd09TJt3RaPgXbCMJAlitZxmLurUoVzOEoHcIsptepNYW0PvPmAUqtxlfPXBXvlfYFzkFg1HqPrds+E3JtDppFw/KpIr/0DcQXapn6aEhmh1sS4h+bjQtm9vLxIUn0MD/Ivr/rcuStMY9oK2EEq/1eti9bepA4M2fQabk5LGvkdqm8XrZl6w074x765op7G/LBGdVSjC0INh6FHcmqqq4Qvd+Nm389ViyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777292685; c=relaxed/relaxed;
	bh=fsTJa+uRyVdowu5zbQNaZb0MC5lMT7s0/CuhRGRoz/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JOCpcFS9vvVVWJ8KF8TOz0oVtS2k8tVUO0i3+3pxBbWr5Eq9UVg/1jMCQg2l8QB2OsjGeGOD4/rTjAyvJ+m1gm9r7B6H1UVJV3ScgXX+0rNNbd2VwkRcQqioaChaFGcWoqRsAAHdu4VHGQi0Jk/j5OiqaEIgyMmdvfxCckUkr+amobhG1iJ9laUawRsfsukkvle1r3KLZyptuFooKSy1BRHwS+tHEue5wtZ19ZphsbqqGkQcPqIIOzin1Av2gfZCO0hAfvq3FINyMr9zOoHlh/1YtOrSv6WuaOaR7K3+yXTnKD3xBVEL0y525u70JyX0uNyuR8IYfAvXr2s6lysGZA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=C/hrGizm; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::72f; helo=mail-qk1-x72f.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=C/hrGizm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::72f; helo=mail-qk1-x72f.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g42nS0m7Bz2xcD
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2026 22:24:42 +1000 (AEST)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-8ee9ec26edaso705703585a.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2026 05:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777292679; x=1777897479; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fsTJa+uRyVdowu5zbQNaZb0MC5lMT7s0/CuhRGRoz/c=;
        b=C/hrGizmagl0vPkZbTk5TbIkB70SIAe7k9QaDrHX6xEkSwTtWpSimTaZnAOkpNSwVo
         JDnR+e+9HnoqiFWUMSHKwokqwYpaSX9zcgvY4bF5j/PHxaZGevRJjbad93oZfkELqP7X
         kKPaIebPPvJYGwDYPwe1qwmQLG8FbL4aom99mVdQBULw+JoQmiCjH/0bQK1GPZCcdorl
         zBMl5D+kKtbc+jq9d/SCsyjcLKZZeeAzQPz9d978OOMLVN52LWdHNVoonL4DKO6NdRun
         el4ZQGiVxT/zjY8kkTP65uMNxHHBITRtakNsTMDw2d47nPwTiVpvjerwFXfte/0Xiv2I
         tOFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777292679; x=1777897479;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fsTJa+uRyVdowu5zbQNaZb0MC5lMT7s0/CuhRGRoz/c=;
        b=X0x3S76p9IM1s2chc2lIuvuKfB9dyp7q8aCGSmsPW1Y5mcvDSebsBQO0AHwNSRFmD2
         fdO2V9buS0GB6znExXBuO+vGgLg/tyfjAoFJXaKSJIeKO9hWUoSWEJH1Uot+MVc1q5SN
         fllioRXxx2n35nDIkHU4omkW8CNo3u9D2w16yN5OlKbubpW/nlvIZ6L/iTsAI2pvHNzJ
         udpBTnF+QaJ5sE+4o09Jno63aK6ykb8yZoU2wJOp9JaR2MhCqC5vhRn2kcx1AC140Adc
         Cy0Vru/zrWfiqqQZ6GLq3UDfyCHOeu9lWMqP8aCRFShEbG9wrNcuQSnT2Z22jXFSFl5u
         mUxQ==
X-Forwarded-Encrypted: i=1; AFNElJ/k/aZ1V9xqOXq0w+ZJY9S1cTrG7L5S6WeoRtqgRQY75zECvDGoRtSkhmXM7+nHHmODPAZM3R2hguUgL8s=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxkXb91kZ1Zq8M/iQOUD36az4GGCdvPH92PmhHzZKHX16HDuK92
	DmtNxj31GHnVRaTNFzC4kAK27xc/2cPvjBH6VLQiIWDydfekokzCX/uA
X-Gm-Gg: AeBDiev2weNhqqeiGiZIzWXQ1Yxs3nqvhr9PBS8zk4OSttUckSaCOF2BF2MkJf6UGnS
	uKO0xmtE4wUKz2UGvfLvVtGfvTWO/dT1ZGnhX6ZepfWT1YU9zXZwn/BoaUGrDGKRTFSdfKhS3b5
	z5trnIqkY6rINGhIfV1gECcLaTXkiTm2yy8LMZa+7EcoxbdAghAJ+d2ME5ZQPhsz0B+fgypfgnV
	5c+yrTmROr03WS7msnRZUxs/C0tBoAIf2sun3cN38tJ32VLOLkesO/0Wt+yNzX6i3TgFATQmhrA
	/zoyEb+cnCjSuVn3o2tnnYsHv7FnAyrnrRbkkyZurqCnGpO9MWt64ZmDhvLZ5AHsvt3VTLghdgV
	fy9FYot+n5BF/cwOFHiQ/UQtU7tS8cpHHsvY8xewzTrsFvudC4F5uTVbrE5QM+s11g8fLlsUetO
	yK+B9Sse+vPdIMKu/Wkuaj9BMnihQG9VxjF5/Pv1M/4YRzNI1/04+4dVlOaM+xzNhM019yLeqBd
	KmYzw==
X-Received: by 2002:a05:620a:1720:b0:8ef:ba6:1a4e with SMTP id af79cd13be357-8ef0ba6262fmr3638609185a.31.1777292679227;
        Mon, 27 Apr 2026 05:24:39 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d8edb789sm2870868485a.31.2026.04.27.05.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 05:24:38 -0700 (PDT)
Date: Mon, 27 Apr 2026 17:54:33 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Shivani Nittor <shivani@linux.ibm.com>
Cc: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, 
	atrajeev@linux.ibm.com, hbathini@linux.vnet.ibm.com, Tejas.Manhas1@ibm.com
Subject: Re: [PATCH] powerpc/perf: Update check for PERF_SAMPLE_DATA_SRC
 marked events
Message-ID: <ae9VXVh8BMWoBqUX@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260421150628.96500-1-shivani@linux.ibm.com>
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
In-Reply-To: <20260421150628.96500-1-shivani@linux.ibm.com>

On Tue, Apr 21, 2026 at 08:36:28PM +0530, Shivani Nittor wrote:
> The core-book3s PMU sampling code validates the SIER TYPE field
> when PERF_SAMPLE_DATA_SRC is requested. The SIER TYPE field
> indicates the instruction type and is only valid for
> random sampling (marked events). To handle cases observed where
> SIER TYPE could be zero even for marked events,validation was
> added to drop such samples and increment event->lost_samples.
> 
> However, this validation was applied to all samples,
> including continuous sampling. In continuous sampling mode,
> the PMU does not set the SIER TYPE field, so it remains zero.
> As a result, valid continuous samples were incorrectly
> treated as invalid and dropped. Fixed this by gating the
> SIER TYPE validation with mark_event, so the check runs only
> for marked (random) events. Continuous samples now skip this
> check and are recorded normally in the final data recording path.
> 
> Fixes: 2ffb26afa642 ("arch/powerpc/perf: Check the instruction type before creating sample with perf_mem_data_src")
> Signed-off-by: Shivani Nittor <shivani@linux.ibm.com>
> ---
> 
>  arch/powerpc/perf/core-book3s.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
> index 8b0081441f85..2e6adf5b95c4 100644
> --- a/arch/powerpc/perf/core-book3s.c
> +++ b/arch/powerpc/perf/core-book3s.c
> @@ -2242,6 +2242,7 @@ static void record_and_restart(struct perf_event *event, unsigned long val,
>  	const u64 last_period = event->hw.last_period;
>  	s64 prev, delta, left;
>  	int record = 0;
> +	int mark_event = regs->dsisr & MMCRA_SAMPLE_ENABLE;
>  
>  	if (event->hw.state & PERF_HES_STOPPED) {
>  		write_pmc(event->hw.idx, 0);
> @@ -2304,9 +2305,9 @@ static void record_and_restart(struct perf_event *event, unsigned long val,
>  	 * In ISA v3.0 and before values "0" and "7" are considered reserved.
>  	 * In ISA v3.1, value "7" has been used to indicate "larx/stcx".
>  	 * Drop the sample if "type" has reserved values for this field with a
> -	 * ISA version check.
> +	 * ISA version check for marked events.
>  	 */
> -	if (event->attr.sample_type & PERF_SAMPLE_DATA_SRC &&
> +	if (mark_event && event->attr.sample_type & PERF_SAMPLE_DATA_SRC &&
>  			ppmu->get_mem_data_src) {
>  		val = (regs->dar & SIER_TYPE_MASK) >> SIER_TYPE_SHIFT;
>  		if (val == 0 || (val == 7 && !cpu_has_feature(CPU_FTR_ARCH_31))) {
> -- 
> 2.47.3
> 
> 
LGTM

Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>

