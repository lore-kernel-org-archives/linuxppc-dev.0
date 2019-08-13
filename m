Return-Path: <SRS0=6DYt=WJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93673C433FF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Aug 2019 17:19:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13F4320679
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Aug 2019 17:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sIc3iW+t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13F4320679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 467KFq1lT5zDqWW
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Aug 2019 03:19:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::344; helo=mail-ot1-x344.google.com;
 envelope-from=ego.lkml@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="sIc3iW+t"; 
 dkim-atps=neutral
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com
 [IPv6:2607:f8b0:4864:20::344])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 467KCv1P5QzDqRr
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Aug 2019 03:17:43 +1000 (AEST)
Received: by mail-ot1-x344.google.com with SMTP id c7so2851463otp.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Aug 2019 10:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=vZVcs4LHWSa+CEuk1zbpzCTPed7jzRYVuPmUvA2+gSk=;
 b=sIc3iW+tmhYDoGxx1nUWYOl/My+eo8QCd6W7f75P9O8+xNb6w1xx/J2FeLVSZQItaT
 s89wgJncLyIr4huP39snAcYX/TXDkpiQZHX9sT0A7TaUWcr2FA2xUsyeJC0FBbKEFlMl
 7PMjuvwowZDNkq0uM7SJqYfjmrQUPnFaNJy7gcnj1EliAze7ADJSxzLdbckZXHaGNGSQ
 IrM244XPw4Db+YJlvT7hKVSkc69Mmppv9Nzwj1JGlWEV7ipdAh+P/SKXL4c5vtZ4yLh0
 dK2IovDyh+slkdGetZX9lWWm3OfLIFpQwSmh20L2l09gkeCozse9M8XQNNk2a8jnO9T4
 Qvzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=vZVcs4LHWSa+CEuk1zbpzCTPed7jzRYVuPmUvA2+gSk=;
 b=pFVS8J+AtLS4K4Oa7FmRkbbPGAPsm0gkbD72PHptGYN/A3WZJjS7A5darFUXlAV2Uh
 lWXv/bGzL9uhGJPLBBKMHs43Q+sKy/6MVMK4QLyd4pkrkF+dZk++/cKU1m/JJwzOl0u2
 rBGmr97igQR8YBYVwa0nJo6yZVeB7DbhsWjvA5kHeYW1yHwVQ4yzsPFfeThNBOs1iLLN
 6izSaoInkZi6PCX8143bLVe97GThFZ7LpcpGzrKh8KszTe9sKTs7kZhAaUQM/cebSAV3
 IiIueOVKwL8vdx6I5ImBM3axe+hyLSadq+q0t3y0Y1iKTE6InNyGK03VogQ3Y4iVDdIR
 BpGA==
X-Gm-Message-State: APjAAAU9F4/C9ogqMXwfzuEvnBaxS18QgHuYpHM3xAAhkSqzTmZ3rfjN
 QnKnDrOmK7VaKe68h2WWA2KJ75n/hul8W7YvXzA=
X-Google-Smtp-Source: APXvYqypVHoS+VruXXHa+ev9bTPrqyqoEK6OZXXgicYuuu/y9xrMdNpCirxF8H45J+IFM+ir20yL5xnK8PLNzGHheA8=
X-Received: by 2002:aca:3a0a:: with SMTP id h10mr2323371oia.52.1565716661861; 
 Tue, 13 Aug 2019 10:17:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190802192926.19277-1-nathanl@linux.ibm.com>
 <20190802192926.19277-3-nathanl@linux.ibm.com>
In-Reply-To: <20190802192926.19277-3-nathanl@linux.ibm.com>
From: Gautham R Shenoy <ego.lkml@gmail.com>
Date: Tue, 13 Aug 2019 22:47:30 +0530
Message-ID: <CAHZ_5WyBjss+C2rY_zhr_BDFHEDNOq7-3T6um38uVj-Tj6jHtA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] powerpc/rtas: allow rescheduling while changing
 cpu states
To: Nathan Lynch <nathanl@linux.ibm.com>
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
Cc: ego@linux.vnet.ibm.com, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, Aug 3, 2019 at 1:03 AM Nathan Lynch <nathanl@linux.ibm.com> wrote:
>
> rtas_cpu_state_change_mask() potentially operates on scores of cpus,
> so explicitly allow rescheduling in the loop body.
>

Are we seeing softlockups/rcu stalls while running this ?

> Signed-off-by: Nathan Lynch <nathanl@linux.ibm.com>

Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>

> ---
>  arch/powerpc/kernel/rtas.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
> index 05824eb4323b..b7ca2fde68a9 100644
> --- a/arch/powerpc/kernel/rtas.c
> +++ b/arch/powerpc/kernel/rtas.c
> @@ -16,6 +16,7 @@
>  #include <linux/capability.h>
>  #include <linux/delay.h>
>  #include <linux/cpu.h>
> +#include <linux/sched.h>
>  #include <linux/smp.h>
>  #include <linux/completion.h>
>  #include <linux/cpumask.h>
> @@ -898,6 +899,7 @@ static int rtas_cpu_state_change_mask(enum rtas_cpu_state state,
>                                 cpumask_clear_cpu(cpu, cpus);
>                         }
>                 }
> +               cond_resched();
>         }
>
>         return ret;
> --
> 2.20.1
>


-- 
Thanks and Regards
gautham.
