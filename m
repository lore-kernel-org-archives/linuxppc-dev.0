Return-Path: <linuxppc-dev+bounces-23014-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BD3BCD4F26
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Jun 2026 10:23:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gmsGM5dyXz2yYf;
	Fri, 26 Jun 2026 20:23:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::430"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782469435;
	cv=none; b=h9ncsdOUcUfcnPeu1JitgTyEqisg1Eb2NY7JbNkqMQoYBsE9bbI8sqrqE9Y/dFp7jlf//jjt3fdq8vLiDdwcqFCEpjoCZR5rqHnfnKndi9RJvoISmbyxY+16HdjdUwMm6G1so/79DEswQUZnICa809Df6t0wTEYqvROwu29JhJfVYteUpnthdxix3qDgVt4eyRE/1Nmqrb/xo8VVkJcZteeXJPliEud6v6kjQmcruRGLfJhAWVV4oik3IGvXOdVhlVG6w9FZ+FxTL0DRZ07PQQNTor4PH+WYEPNUCtpbvkK42hMsoIN5ksn4VNdafJzZr0Jz+dHNAvNM4+Ou7pSr5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782469435; c=relaxed/relaxed;
	bh=eLFZTGPtRiE8UPhqU4UMjkuV0PbJHe/HCNgoSE+benw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TdpqA+Wn/eLP4MCss6Y/iVOPFnnVF9zCYyfUc681YLN7jMJ65gbUDqT/zcSDg1TxEaLldXgyEi10mRATShzWopfPwZhTgWArf1JBYM8ub6X5WN0ujIWyWzmLR8kqnj0UX0Yqiassq5uzPfnByKNXGROsQRa7fEhn2SUdn9zUNbRSV7OjH/WD2dL0FulXGyhPm8yRpwWAWcXxl1jDI+Vx9j/EshOSrizqA9B+HVpKefG01MHBiInxuV7vpbDWmQQCKGTwpJZWVeqB16brc8lT02me9JmUCSmazGoqmjJDqsbqGZP03VcSCmJTGLvYC17fK211OczuZWTRIAVJ11QhXg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=REE13fGZ; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::430; helo=mail-wr1-x430.google.com; envelope-from=pmladek@suse.com; receiver=lists.ozlabs.org) smtp.mailfrom=suse.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=REE13fGZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.com (client-ip=2a00:1450:4864:20::430; helo=mail-wr1-x430.google.com; envelope-from=pmladek@suse.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gmsGL1ytRz2yYd
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jun 2026 20:23:53 +1000 (AEST)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-461edb387ddso776007f8f.3
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jun 2026 03:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1782469430; x=1783074230; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eLFZTGPtRiE8UPhqU4UMjkuV0PbJHe/HCNgoSE+benw=;
        b=REE13fGZOBy5KGqEytR+78rU0U8jVkShIx8+P3AhhpVPVZoY/vm/HKG3a4uwre9khe
         E+4DJW0Eg0F+9G0vcwLc6KpVkSnJLRYYXDenGNYkyrUZtFFBKWKBuImm6o05tBkAtmIj
         RAIHU0BDoxCr8hTsqaN3KnlQk0uERdu0WK07wApdhFUgyjc6uRAnju5HjFsBkvYlTpM6
         PVvhReVvrsN5F6oRz2xfiNKuyl3h3cjCV45npzeFTPCupHIsC2lhnMw6Z3cWvCkEffuf
         yRhHTthdRn1gHGCo+ys6ekibYVQru8sAmwrlrG5xjmIzDX3tMfFcQsxfFuVXu+3LvStp
         d3dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782469430; x=1783074230;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eLFZTGPtRiE8UPhqU4UMjkuV0PbJHe/HCNgoSE+benw=;
        b=UfFICo4koUwI6I9IzbANhdAekMhnNNCcgaWRzQV46CrdmHSBlqax60JHDfofkx1xRj
         C1k0y5y8rpE9c9gZgZUC4D0o18qpJv6GJWIjM5VshjAFeyNbjSzh5RwM00VPmTJkXEvC
         gYCHHBYAweGvspQTNP/4UZgAJ3dLuipD789YXZ6wXRYIPxXnKfFFcY4TgigJZsQ8SS62
         PF9/31wajdiyA5L6ZfROvzs5Wj62twV+8nG82Egiscx+lF7/w7wbGyTzigrbSwD4Nhbk
         fCvFnIo4tb5NvIYOXX+KZs0SajDdNoyL8mZmUWYH73QxFGOBctZ8tpEuVp0EqeMdJ7jE
         pBDw==
X-Forwarded-Encrypted: i=1; AHgh+RrThiPsZlq5HLKDJqGHWwFbKXUvpa/NBFaHNWCPxuib8M+UOei6GiMS/7sDQyDPqsYhzvaf1Iw8N4urFu8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yzv+ibjUXBJOeO9NLyBUncvoy3YZhXeHeHNRHRYHY66otdtXKwD
	01kfYOYGXWO+8xStyZFjKtVfM0Y1MsgHL0uYP36NTVUF5jFb03Rk5s8kKq/jqIJ6L1M=
X-Gm-Gg: AfdE7cnsY2EuVOHZ34MUM5acl2y4Tn3IQC3Kb2p3+IXjE4hHeQaf+l0wDUE3ny9DxLY
	RKkVde8N9nLs2JI8DsusbrOLyqsw5KZW48T+vXXn17eg0aAJb55toG+we4ka816pmYzkryngUNx
	8O13wOO1bHT9qL4JBlJ7NFG3i+uNHaRPjEMpDYIK/XadD0Z6rFzDbrGJB+TnpyAjQZaKxjiaByq
	LjhSFX1uSrqzZrBH63yoXHkMz4fsQhicnyD9WTTOqUDhSULLZMhDGnrwFH4aPphAcUKRMAAxK0k
	4b88if55ZVYBsVDW/l7NJgzF/ccDpJIEmHUwdwYHRNXxtWc0uhzhzlWvR6kb9qZ4eDzjg1Tk/7w
	uEa+9pUtP6G8FZNZQxr1ERzN/1aNnmlnjULixFO2VGr2Md6MTadkyXIfTAtWmQlTvyFdU3ZNt+p
	colezPqwhUCbyuFGY=
X-Received: by 2002:a05:6000:4204:b0:460:30bd:4dca with SMTP id ffacd0b85a97d-46dc12e056fmr9792387f8f.30.1782469430521;
        Fri, 26 Jun 2026 03:23:50 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46dcbac0c9dsm13650525f8f.19.2026.06.26.03.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 03:23:50 -0700 (PDT)
Date: Fri, 26 Jun 2026 12:23:48 +0200
From: Petr Mladek <pmladek@suse.com>
To: Bradley Morgan <include@grrlz.net>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Douglas Anderson <dianders@chromium.org>,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 4/4] panic: use sys_info_with_filter() to avoid
 duplicate backtraces
Message-ID: <aj5TNB8cRtMNTtIT@pathway.suse.cz>
References: <20260625152558.7450-1-include@grrlz.net>
 <20260625152558.7450-5-include@grrlz.net>
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
In-Reply-To: <20260625152558.7450-5-include@grrlz.net>

On Thu 2026-06-25 15:25:58, Bradley Morgan wrote:
> panic_other_cpus_shutdown() handles SYS_INFO_ALL_BT before stopping the
> other CPUs. Do not ask sys_info() to handle that bit again later in the
> panic path.
> 
> Use sys_info_with_filter() so panic_print=all_bt does not request more
> output after the CPUs are stopped.
> 
> Fixes: a9af76a78760 ("watchdog: add sys_info sysctls to dump sys info on system lockup")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bradley Morgan <include@grrlz.net>
> ---
>  kernel/panic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/panic.c b/kernel/panic.c
> index 213725b612aa..eb842823df61 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -680,7 +680,7 @@ void vpanic(const char *fmt, va_list args)
>  	 */
>  	atomic_notifier_call_chain(&panic_notifier_list, 0, buf);
>  
> -	sys_info(panic_print);
> +	sys_info_with_filter(panic_print, SYS_INFO_ALL_BT);

Hmm, this prevents printing backtraces from all CPUs completely.
But what if they were not printed?

They might be printed by:

static void panic_other_cpus_shutdown(bool crash_kexec)
{
	if (panic_print & SYS_INFO_ALL_BT)
		panic_trigger_all_cpu_backtrace();

[...]
}

But it checks only "panic_print" variable. It won't do anything
when (panic_print == 0).

In this case, we might still want to print the backraces when
SYS_INFO_ALL_BT is set in kernel_si_info.

>  	kmsg_dump_desc(KMSG_DUMP_PANIC, buf);

Of course, we might fix panic_other_cpus_shutdown() to check also
kernel_si_info.

But it all becomes very hairy. We have several levels:

   + watchdog-all_bt-specific option, e.g. sysctl_hardlockup_all_cpu_backtrace

   + watchdog-specific si_info preferences, e.g. hardlockup_si_mask

   + panic-specific si_info: panic_print

   + universal fallback for any layer: kernel_si_info

Now, we try to check all these variables back and forth to
trigger all backtraces or to avoid triggering them.
And it clearly does not work well and the code is more and more
hairy.

I think about another approach. The word "waterfall" comes to my mind.
Instead of checking all the settings back and forth, let's process
each setting one by one and just remember what has been done and
skip this in the next level.

All the si_info actions seems to dump a global system state.
So, it would make sense to remember the state in a global variable
even when it might be modified by more CPUs in parallel.

I am going to think more about it.

Please, do not send v4 until the discussion settles!

Best Regards,
Petr

