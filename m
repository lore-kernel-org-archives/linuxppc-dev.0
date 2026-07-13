Return-Path: <linuxppc-dev+bounces-24094-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3DD8C43458
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Jul 2026 05:21:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gz9l914DHz2xqM;
	Mon, 13 Jul 2026 15:21:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1034"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783920069;
	cv=none; b=Pg+A6Jh61wIoRjI70jrBfs3yAL3GOoYieMD4nXdUsU20+xTiw2aDjISi9Qkzzc0OGQjgOCoshtr6PJKz4Etl6FW9wMJdpWIVLrcs8wXulb/GPyTV6krcnSiSb/n6WewwRS0K8lmDNOOCiVbbNHr8VWdoZrBrihgRC7/ufa0k6pxnXBuhTiNC4ItAe1T6NeQpRHzqSkXnodbff3YWm7WltriH0LeX9aioIJVAb0YR/nkOOZIgdffSDmUdPhlp81nHwbPCE3I3x09FqVYx864l4kx+y4X0buqdbzk8dgCs6cy7kdQgFmiQVQteOTleouBEFFF7O8hdfNvhbx/JoIcI+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783920069; c=relaxed/relaxed;
	bh=NgrUijC43NZjO9+tarpgdkIMgwBwcs7VglIntyvaAbA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=gjlEN/BksZbQZQu8PaZGliOWEsb8T/bAuWmZZE2O8ztZuJod5BoZ8+AF6z28Gf3BEmWUgyOcmJ+vqcitwgoPXOa+A9WL6ihgixdWHyr6rL3SoAw2PLSSx13COo7i7sVPfXUUxmMjz6MtT0xiJHpbALfEkKSzk5Ac8CjkhcZM67mx68HynlfgR19v8o5Yuwc/j8iLfVyLGnRR3WBQCBBhvzU/yrAH5tELRyIsRz+3CRV5EK0WxIkqfmOfD3DridhdLWZG4KK82paXKe4AHDtRjANK+FHTCmftqz94RBvw2jj2c6thPxYARRhWGcqr8OncB/JdESEGUhdP892jZ7sfNQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=beXzKs/d; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=beXzKs/d;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gz9l82RyRz2xlv
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2026 15:21:07 +1000 (AEST)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-3847e8b0f3aso2280975a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Jul 2026 22:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783920065; x=1784524865; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=NgrUijC43NZjO9+tarpgdkIMgwBwcs7VglIntyvaAbA=;
        b=beXzKs/d1Bi0ujpDn3gUZpVWDbY+J5EBVQcMhTPSBY0gR11bfTvc0ezWz8VtbDCCUg
         6Mr75Aow38Is/EigI1RQlBFxlDY42s3HZ0FiCw03kC1DE29PJF/pb9CPdh6aGAmeYwqG
         tgqTIx6I+l4XdlOWPeUCgAgYVdVjMp0WwNPwrLh0YgBuLx4sEEgQqQ4JmMXpDidXi90k
         jUi+zYWv7XcNTslL3QvmkmwOOBMgxQuLSF++hMLZ87EO1Qjls8+Wel+co3N74rd3HbGB
         GrEGqDZXd9X7/oBKcbYtXbFUNbg7PF3cPd8zvej8RIOuhnFpEV4XbcQRGip18NVL7bK2
         lr4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783920065; x=1784524865;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NgrUijC43NZjO9+tarpgdkIMgwBwcs7VglIntyvaAbA=;
        b=M0w3ef47Z703ESDS2ZNuToMz4mZC/jVnZwCOuAGuJ8PErs2tE2zKBRyAR0epgV7S/F
         nvhHJmfU5/QMrCVu1Mgn9BMFkD8hid/RyTg58RzZZH6nGDFBEF0l4BIM56MVMqhgGnES
         oU+EpTn2gXqPFduagRM1L45QLm/SQOFUeI9CEsyn3tmrXDNYF3KHeoK78f5QQk1b0xcb
         psCgnbnu+k0tE6s8hxM07SEMVZInWWP6RcfJRCyfeJb9uu/vSmFnOgdMI63zFhNQEOar
         f0yJyq+osokiMbVYKTNJ/PCpwxF3ZIZvX/tJB85ISkZvSfQ1p4OsznwWmwuRGUcrTaEI
         s/sQ==
X-Forwarded-Encrypted: i=1; AHgh+RqKUJUL1XIeN/CS+XuIPiMQygRAXXNCuAWeBZatxW/IsaeRYWdJpW/CZTyZuGryjpkLBhldFCYaf7wr4mU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxzO+9HAVaRQJClhKs1kQGzDaHnG0iHFxH/CJTXRYMm0o3jT0pM
	KipIoYLkjpwtxG8GMa38JAGLTaxrowLzSp2X8FeseATy3mGFbbpgYtsU
X-Gm-Gg: AfdE7clkq8gtGcEXHggyGZ/dwyOb6NJSF490X5hjkWqG32v17Ebqn+hfOZIqp8XLuSY
	DeVpAheaGRqB6UTLA1bMKBYRY8WK0GTECxZYD1HE7t7UNDaXsfTDwTxD47LpeN/Dwo6vsymJD3f
	DbOrXWOuv663Micy75artdpyPd7q4ZYDR8iLyFgJXaXqsdbEybKfdqvJfApT+mLZSPWdv56hub5
	y8pRnJ9zG4kOUpdovY/mXwqVhJaMRomJiba90eObHsBXHBjeHdulF+HaPHbBDU7MBfwmjfm38wZ
	AD4dnPU5Nzlaejj9dwZAN2bLhKz6VNzZy26tn9+2+QPxpZN+b/KK52VIg73Qb/2iyx17VIvxqqW
	0YRiqTmS/HDldxrFr5tn6LwPgtcxdVt3TsfWHhGT8n30e+lB+6cJVyVQIDHit4giGATiZy2Z2g8
	WOuNr+LmtzCss=
X-Received: by 2002:a17:90b:2f0f:b0:38d:f710:63f0 with SMTP id 98e67ed59e1d1-38df7106443mr2705726a91.43.1783920065185;
        Sun, 12 Jul 2026 22:21:05 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3117d847e17sm65148262eec.18.2026.07.12.22.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 22:21:04 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au
Cc: npiggin@gmail.com, chleroy@kernel.org, shivangu@linux.ibm.com, hbathini@linux.ibm.com, mahesh@linux.ibm.com, adityag@linux.ibm.com, venkat88@linux.ibm.com, stable@vger.kernel.org, Sourabh Jain <sourabhjain@linux.ibm.com>, Mahesh Kumar G <mahe657@linux.ibm.com>
Subject: Re: [PATCH v2 3/3] powerpc/crash: stop watchdogs before booting kdump kernel
In-Reply-To: <20260713035954.1559605-4-sourabhjain@linux.ibm.com>
Date: Mon, 13 Jul 2026 10:40:06 +0530
Message-ID: <o6gbv5jl.ritesh.list@gmail.com>
References: <20260713035954.1559605-1-sourabhjain@linux.ibm.com> <20260713035954.1559605-4-sourabhjain@linux.ibm.com>
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

Sourabh Jain <sourabhjain@linux.ibm.com> writes:

> On pseries LPAR systems, watchdog timers configured from userspace can
> remain active after a kernel panic. When a panic triggers kdump, the
> crashing kernel jumps directly to the kdump kernel without stopping
> active watchdogs. As a result, the watchdogs remain active after the
> kdump kernel starts.
>
> If dump capture takes longer than the watchdog timeout, PHYP resets the
> LPAR before the dump is fully captured, causing dump capture to fail.
>
> Fix this by issuing the `H_WATCHDOG` hcall during the crash shutdown
> sequence to stop all active watchdogs before booting the kdump kernel.
>
> Fixes: 69472ffa6575 ("watchdog/pseries-wdt: initial support for H_WATCHDOG-based watchdog timers")
> Reported-by: Mahesh Kumar G <mahe657@linux.ibm.com>
> Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> ---
>  arch/powerpc/include/asm/papr-watchdog.h |  2 ++
>  arch/powerpc/platforms/pseries/setup.c   | 18 ++++++++++++++++++
>  2 files changed, 20 insertions(+)
>
> diff --git a/arch/powerpc/include/asm/papr-watchdog.h b/arch/powerpc/include/asm/papr-watchdog.h
> index fb3a511aa861..84bbe1ddd56f 100644
> --- a/arch/powerpc/include/asm/papr-watchdog.h
> +++ b/arch/powerpc/include/asm/papr-watchdog.h
> @@ -55,4 +55,6 @@
>  #define PSERIES_WDTQ_MIN_TIMEOUT(cap)	(((cap) >> 48) & 0xffff)
>  #define PSERIES_WDTQ_MAX_NUMBER(cap)	(((cap) >> 32) & 0xffff)
>  
> +#define PSERIES_WDT_NUM_ALL	((unsigned long)-1)
> +

minor nit:

This should be defined at the end of the H_WATCHDOG Input section.
/*
 * H_WATCHDOG Input
 *

<...>

Something like this maybe?

/*
 * R5: "watchdogNumber":
 *       PAPR says use -1 (all ones) to stop all watchdogs.
 */
#define PSERIES_WDT_NUM_ALL	((unsigned long)-1)

/*
 * H_WATCHDOG Output
 *
 * R3: Return code
 *
 <...> 

>  #endif /* _ASM_POWERPC_CRASHDUMP_PPC64_H */
> diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
> index bbb2813f8ede..2e40a9dba637 100644
> --- a/arch/powerpc/platforms/pseries/setup.c
> +++ b/arch/powerpc/platforms/pseries/setup.c
> @@ -77,6 +77,7 @@
>  #include <asm/dtl.h>
>  #include <asm/hvconsole.h>
>  #include <asm/setup.h>
> +#include <asm/papr-watchdog.h>
>  
>  #include "pseries.h"
>  
> @@ -185,6 +186,18 @@ static void __init fwnmi_init(void)
>  #endif
>  }
>  
> +#ifdef CONFIG_CRASH_DUMP
> +static void pseries_crash_stop_watchdogs(void)
> +{
> +	long rc;
> +
> +	rc = plpar_hcall_norets_notrace(H_WATCHDOG, PSERIES_WDTF_OP_STOP,
> +					PSERIES_WDT_NUM_ALL);
> +	if (rc != H_SUCCESS && rc != H_NOOP)
> +		pr_warn("Could not stop watchdogs before kdump rc=%ld\n", rc);
> +}
> +#endif /* CONFIG_CRASH_DUMP */
> +
>  /*
>   * Affix a device for the first timer to the platform bus if
>   * we have firmware support for the H_WATCHDOG hypercall.
> @@ -203,6 +216,11 @@ static __init int pseries_wdt_init(void)
>  		return PTR_ERR(pseries_wdt_dev);
>  	}
>  
> +#ifdef CONFIG_CRASH_DUMP
> +	if (crash_shutdown_register(pseries_crash_stop_watchdogs))
> +		pr_warn("Could not register watchdog crash shutdown handler\n");
> +#endif
> +

minor nit:
I don't think we need any of the #ifdef. All definitions used inside
pseries_crash_stop_watchdogs are already available and
crash_shutdown_register() already exists for !CONFIG_CRASH_DUMP, so we
may as well drop all of the ifdefs.


Otherwise LGTM, so feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


