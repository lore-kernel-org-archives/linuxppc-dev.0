Return-Path: <SRS0=nZGU=SK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77AD9C10F13
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Apr 2019 14:24:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D14A821473
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Apr 2019 14:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="d0dni/9x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D14A821473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44dCNC3rS1zDqDf
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 00:24:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=axtens.net
 (client-ip=2607:f8b0:4864:20::642; helo=mail-pl1-x642.google.com;
 envelope-from=dja@axtens.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=axtens.net header.i=@axtens.net header.b="d0dni/9x"; 
 dkim-atps=neutral
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44dCLN4h9fzDqDf
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Apr 2019 00:22:35 +1000 (AEST)
Received: by mail-pl1-x642.google.com with SMTP id d1so7431233plj.8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Apr 2019 07:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axtens.net; s=google;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=+l3tw15+EBOjVrpujq4+kow5Gen869VXHMC7WM5YNlI=;
 b=d0dni/9xh0/ycqgdH4XHTOqZknSl0L0jrT6J2nLqkf8KWQR1i1mszt/uaEH9bOGuAS
 MCVsAyfW8cgMslswlrem5e0pyBU8Q9EI5Tuw7ha3xpS6E0oTUUCRj6fAQgthAfjrE7GD
 O/6uSUrfZEMwnFdf0F86NAycNpeyFecg7FE+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=+l3tw15+EBOjVrpujq4+kow5Gen869VXHMC7WM5YNlI=;
 b=uhJJjg30MnmTNvES/eeaSZZlGnFsdIa+BFYDk9OlJf8+rLWoX+3y/kDw750rV5ZRdd
 28aBSBBZrSh4k9IqSMTP+82dToNMNfJx6+VJ2DU8+9bIE82NIxUQhHbXIFFYVltnH6xK
 of1GwKHCV/ll+NOkAACff52DIC8H9Spm3OoH9VagZbhsSze542bGMpTLR5Bvy7/wH6ID
 0VH3aFnTMSmV7uqc7HByuu9ORJlUi16GZw8NwVmiaIMSdwcDTAnDFGxOz0tFfoqX2IGo
 TVk4j48catFNDCqJ0V/5ZSV0nnnzT/K5rjSjIOiMWYYVKGMKALbqEgvUoD5YPgROHSw/
 05QQ==
X-Gm-Message-State: APjAAAVFSEXwF+djxH4/gtTyGh5r+qhMt72truuybMk7BcXICZ3lTSCB
 DA7Zal8/fzFabUHD443WrMpTvQ==
X-Google-Smtp-Source: APXvYqwb6KlLXvhT1MCCSFEuR27y/E0V+U1Q0OgRJWc6VDoxG0sWz5zQkSd54/etDQ54yYftc/fsdQ==
X-Received: by 2002:a17:902:5a45:: with SMTP id
 f5mr16751845plm.23.1554733351919; 
 Mon, 08 Apr 2019 07:22:31 -0700 (PDT)
Received: from localhost (124-171-136-51.dyn.iinet.net.au. [124.171.136.51])
 by smtp.gmail.com with ESMTPSA id x24sm40802225pfn.128.2019.04.08.07.22.28
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 08 Apr 2019 07:22:29 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: Abhishek Goel <huntbag@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 2/2] cpuidle : Add auto-promotion flag to cpuidle flags
In-Reply-To: <20190405091647.4169-3-huntbag@linux.vnet.ibm.com>
References: <20190405091647.4169-1-huntbag@linux.vnet.ibm.com>
 <20190405091647.4169-3-huntbag@linux.vnet.ibm.com>
Date: Tue, 09 Apr 2019 00:22:26 +1000
Message-ID: <87o95gwp99.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: Abhishek Goel <huntbag@linux.vnet.ibm.com>, daniel.lezcano@linaro.org,
 rjw@rjwysocki.net, ego@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Abhishek Goel <huntbag@linux.vnet.ibm.com> writes:

> This patch sets up flags for the state which needs to be auto-promoted. On
> POWERNV system, only lite states need to be autopromoted. We identify lite
> states by those which do not lose user context. That information has been
> used to set the flag for lite states.
>
> Signed-off-by: Abhishek Goel <huntbag@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/opal-api.h |  1 +
>  drivers/cpuidle/Kconfig             |  4 ++++
>  drivers/cpuidle/cpuidle-powernv.c   | 13 +++++++++++--
>  3 files changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
> index 870fb7b23..735dec731 100644
> --- a/arch/powerpc/include/asm/opal-api.h
> +++ b/arch/powerpc/include/asm/opal-api.h
> @@ -226,6 +226,7 @@
>   */
>  
>  #define OPAL_PM_TIMEBASE_STOP		0x00000002
> +#define OPAL_PM_LOSE_USER_CONTEXT	0x00001000

Is the important thing that you don't lose user context, or that the
state prevents thread folding? From your description, it seems from a
power managment point of view that the important thing is that the state
prevents thread folding, and it seems almost coincidental that it
preserves user context.

If this is mirrored from the way hardware or opal describes it (which
looking at the other flags it looks like it might be), it would be worth
adding a comment that explains why we want to leave such a state.

>  #define OPAL_PM_LOSE_HYP_CONTEXT	0x00002000
>  #define OPAL_PM_LOSE_FULL_CONTEXT	0x00004000
>  #define OPAL_PM_NAP_ENABLED		0x00010000
> diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
> index 8caccbbd7..9b8e9b96a 100644
> --- a/drivers/cpuidle/Kconfig
> +++ b/drivers/cpuidle/Kconfig
> @@ -35,6 +35,10 @@ config CPU_IDLE_GOV_TEO
>  config DT_IDLE_STATES
>  	bool
>  
> +config CPU_IDLE_AUTO_PROMOTION
> +	bool
> +	default y if PPC_POWERNV
> +
As I mentioned in the previous patch, this is used in the previous
patch. It's also not used here.


Regards,
Daniel

>  menu "ARM CPU Idle Drivers"
>  depends on ARM || ARM64
>  source "drivers/cpuidle/Kconfig.arm"
> diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
> index 84b1ebe21..0dd767270 100644
> --- a/drivers/cpuidle/cpuidle-powernv.c
> +++ b/drivers/cpuidle/cpuidle-powernv.c
> @@ -299,6 +299,7 @@ static int powernv_add_idle_states(void)
>  	for (i = 0; i < dt_idle_states; i++) {
>  		unsigned int exit_latency, target_residency;
>  		bool stops_timebase = false;
> +		bool lose_user_context = false;
>  		struct pnv_idle_states_t *state = &pnv_idle_states[i];
>  
>  		/*
> @@ -324,6 +325,9 @@ static int powernv_add_idle_states(void)
>  		if (has_stop_states && !(state->valid))
>  				continue;
>  
> +		if (state->flags & OPAL_PM_LOSE_USER_CONTEXT)
> +			lose_user_context = true;
> +
>  		if (state->flags & OPAL_PM_TIMEBASE_STOP)
>  			stops_timebase = true;
>  
> @@ -332,12 +336,17 @@ static int powernv_add_idle_states(void)
>  			add_powernv_state(nr_idle_states, "Nap",
>  					  CPUIDLE_FLAG_NONE, nap_loop,
>  					  target_residency, exit_latency, 0, 0);
> +		} else if (has_stop_states && !lose_user_context) {
> +			add_powernv_state(nr_idle_states, state->name,
> +					  CPUIDLE_FLAG_AUTO_PROMOTION,
> +					  stop_loop, target_residency,
> +					  exit_latency, state->psscr_val,
> +					  state->psscr_mask);
>  		} else if (has_stop_states && !stops_timebase) {
>  			add_powernv_state(nr_idle_states, state->name,
>  					  CPUIDLE_FLAG_NONE, stop_loop,
>  					  target_residency, exit_latency,
> -					  state->psscr_val,
> -					  state->psscr_mask);
> +					  state->psscr_val, state->psscr_mask);
>  		}
>  
>  		/*
> -- 
> 2.17.1
