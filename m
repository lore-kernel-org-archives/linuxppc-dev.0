Return-Path: <SRS0=99u2=SG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B210C4360F
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 11:21:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B22F820855
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 11:21:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CRDLM1+x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B22F820855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44ZgWZ3MMnzDqL0
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 22:21:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::343; helo=mail-ot1-x343.google.com;
 envelope-from=ego.lkml@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="CRDLM1+x"; 
 dkim-atps=neutral
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com
 [IPv6:2607:f8b0:4864:20::343])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44ZgTZ6zSvzDqHW
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Apr 2019 22:20:02 +1100 (AEDT)
Received: by mail-ot1-x343.google.com with SMTP id j10so1995110otq.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Apr 2019 04:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=DzhjJoSnLxIhQ7soO3X1gaZNI2IHmC7vLUvM+M3gfuc=;
 b=CRDLM1+x+pp8lHeQjB5pzRO6JHCI9IaH9CUe6oQ7Nt6m4LjrIk0N+aySDso29KYvEW
 S1UJwg8Yu5WnRhcRlbfNbaS/RAW6N0beeJ6ydSbFc9ScWOmTmvfiX+h7G9He2bz9c0C+
 Oz+ykHUEwgMbiPPpob0Qwks94iCmnFhW+TA42N8GT/ZUb1COYlWwVESuR7jL+qz3rjQ7
 AIxXFPAHKWBEkICLGqYUQ5345qRbPJdmGyhWosfoU9HfuBPLgL80CRWXTzE7/XpbV+/T
 7iBcyowySHGXi9CwH1Nc7izIWTVtqlt2bPZR5PIWMpFrG7dgciF43THhA9IcZVFfbDS0
 MwZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=DzhjJoSnLxIhQ7soO3X1gaZNI2IHmC7vLUvM+M3gfuc=;
 b=oSZLOxR9IKDpSn+iVHq9dNbs5Ieb5B/KRJ/55HOM2n0iWeu58/N/zcc9Z7+LFL4WnW
 QWcYvZIDKem22ZpnJd+iJIJ2+gV6jzdWgAeN0VDUAL1nnt/XiyYnUCSXNcTP0SWWRuT8
 oixwgyv62bBry1PjzHcvpGjlFSwdXEu/hjgaT7otK1zx6Fupa25C06u8t5HrViVoG76r
 cCdGUfNlzTsC1HGvduPdRwdVwZbMZe9ub7yHIYWTIYqPfY/SeCfhuGHsutrXQMMAo2Km
 6LiABlYmMFN8p9ROKl4g6lUq7zvqKD5nMzpaYbwfI3Ut+ippeJyQ/ukX2oKuIL2rk1Jj
 8jOA==
X-Gm-Message-State: APjAAAX7Ut9fBS0wngvAanJLaB23dzMnUqph8TiBh5+nj7TO7jsBPn/k
 +IpiyQZZz9Aj3UiwvBLdkdfyCxRcfLW2SzmCt0s=
X-Google-Smtp-Source: APXvYqxlF/jPLcozu6bYMITuPbHs5shSHleQS3lMTCxKI8h3+2mD6FmvtsNzx0+wGRp4lZjGzuP2bUVEE8S51YnKV+A=
X-Received: by 2002:a9d:4804:: with SMTP id c4mr3837584otf.0.1554376799036;
 Thu, 04 Apr 2019 04:19:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190402112521.24888-1-npiggin@gmail.com>
In-Reply-To: <20190402112521.24888-1-npiggin@gmail.com>
From: Gautham R Shenoy <ego.lkml@gmail.com>
Date: Thu, 4 Apr 2019 16:49:47 +0530
Message-ID: <CAHZ_5WzckrKg=D+joA_JJU0riObA4bb7oQj-bfBNna5y22wQ+Q@mail.gmail.com>
Subject: Re: [PATCH] powerpc/watchdog: Use hrtimers for per-CPU heartbeat
To: Nicholas Piggin <npiggin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
Reply-To: ego@linux.vnet.ibm.com
Cc: Ravikumar Bangoria <ravi.bangoria@in.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hello Nicholas,

On Tue, Apr 2, 2019 at 4:57 PM Nicholas Piggin <npiggin@gmail.com> wrote:
>
> Using a jiffies timer creates a dependency on the tick_do_timer_cpu
> incrementing jiffies. If that CPU has locked up and jiffies is not
> incrementing, the watchdog heartbeat timer for all CPUs stops and
> creates false positives and confusing warnings on local CPUs, and
> also causes the SMP detector to stop, so the root cause is never
> detected.
>
> Fix this by using hrtimer based timers for the watchdog heartbeat,
> like the generic kernel hardlockup detector.
>
> Reported-by: Ravikumar Bangoria <ravi.bangoria@in.ibm.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

[..snip..]

> @@ -325,19 +325,21 @@ EXPORT_SYMBOL(arch_touch_nmi_watchdog);
>
>  static void start_watchdog_timer_on(unsigned int cpu)
>  {
> -       struct timer_list *t = per_cpu_ptr(&wd_timer, cpu);
> +       struct hrtimer *hrtimer = this_cpu_ptr(&wd_hrtimer);

This function can be called during the initialization via

watchdog_nmi_start -->
    for_each_online_cpu(cpu)
           start_wd_on_cpu(cpu) -->
                   start_watchdog_timer_on(cpu)

Thus, it is not guarateed that we are always calling
start_watchdog_timer_on() from the CPU where
we want to start the watchdog timer.

Thus, should we be calling this function from start_wd_on_cpu() via an
smp_call_function_single() ?


>
>         per_cpu(wd_timer_tb, cpu) = get_tb();
>
> -       timer_setup(t, wd_timer_fn, TIMER_PINNED);
> -       wd_timer_reset(cpu, t);
> +       hrtimer_init(hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> +       hrtimer->function = watchdog_timer_fn;
> +       hrtimer_start(hrtimer, ms_to_ktime(wd_timer_period_ms),
> +                     HRTIMER_MODE_REL_PINNED);
>  }
>
>  static void stop_watchdog_timer_on(unsigned int cpu)
>  {
> -       struct timer_list *t = per_cpu_ptr(&wd_timer, cpu);
> +       struct hrtimer *hrtimer = this_cpu_ptr(&wd_hrtimer);
>
> -       del_timer_sync(t);
> +       hrtimer_cancel(hrtimer);
>  }
>
>  static int start_wd_on_cpu(unsigned int cpu)
> --
> 2.20.1
>


-- 
Thanks and Regards
gautham.
