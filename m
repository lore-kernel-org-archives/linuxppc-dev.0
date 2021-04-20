Return-Path: <SRS0=xixs=JR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16DCFC433ED
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Apr 2021 02:36:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 667B86100B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Apr 2021 02:36:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 667B86100B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FPSVt5DbBz30BN
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Apr 2021 12:36:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=JIZquBA3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::d29;
 helo=mail-io1-xd29.google.com; envelope-from=sxwjean@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=JIZquBA3; dkim-atps=neutral
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FPSVR0n8Zz2xZW
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Apr 2021 12:36:12 +1000 (AEST)
Received: by mail-io1-xd29.google.com with SMTP id b9so7230470iod.13
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Apr 2021 19:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=oQD9yitLmdBKSzetJdXBaqRYGMIda2O8rBTT+Bg5aJo=;
 b=JIZquBA3UWr6slVXG8UdQTuLK+Vu4tsVfvoQiI20BS0aMxuQIxDTIl5zBl9+Lsllbn
 +HwU7ss36jWi2fTPkhEXvhl8fbHBOPGVvzm/3VjCro0L1K75L+qARASWYmwP4EFKe+E9
 0gwOOMA1na34aJyt2pcWqy8ANawz0r7T5NWXa1n89I0YKhVr6hPoO9hvZwyEvVFSsETO
 dyokVDPB2lXUhWuutu8X4sIBgnlzPPaekrxSN601V03tTGu6LKNhhTepjNs1wRQH1J5R
 RxoeFIymRyfYpifBGuaNt9vPGGktnZVsfAVrgZjufFr9wuBYnrAA0jWd+PocuiG6Ji4b
 r9JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oQD9yitLmdBKSzetJdXBaqRYGMIda2O8rBTT+Bg5aJo=;
 b=L6tGCacMlkKeV/jvZJCZgae/AQBr6jXXXNgucLEWb2bU7F1zAXHrsuM50M4kEggQbM
 Ik5oBhPHhb2YzZFWBIlYYlPthqMB21qF8130pglIXicd9rJ23N42XqhLMoaq8KmxZAxP
 jXRxZpSCHhCoZfughM5n/tQHnxl78EwqcxULShEX7Kqv2KHFPeXMIK6KmtgGXeYAO9W+
 fSjMMH84326wI5/NlquPoQiqRisXIK3lIz2QnIhejp/2q2wJnQDzzpEdXcb5QMrSowUT
 dYelj/ltkBpFnW1FenrjJshX+Qtf7MPy0Xg7yDB7yqpp4LUenbU/I0f6aHBwRfQRZg1A
 c2Iw==
X-Gm-Message-State: AOAM530p94V2xU3cAQiFrFtllDbGrpsqK8mj/R/1q/Xa/X0LS9npfufq
 AHzS36NZoP4r9liFsz6wwKcMreh9NFszS8EO64w=
X-Google-Smtp-Source: ABdhPJzBw3I3f+kIQB52gcP4DQxj2nPSIzECf0Z1qC/V+UYEOOexb6cuOGXU2VZL4JI8/GZvo5Gz10QZaH7r+GOoPJI=
X-Received: by 2002:a5e:8e0d:: with SMTP id a13mr2275186ion.23.1618886169062; 
 Mon, 19 Apr 2021 19:36:09 -0700 (PDT)
MIME-Version: 1.0
References: <e1147287bf6f2fb0693048fe8db0298c7870e419.1618847273.git.christophe.leroy@csgroup.eu>
In-Reply-To: <e1147287bf6f2fb0693048fe8db0298c7870e419.1618847273.git.christophe.leroy@csgroup.eu>
From: Xiongwei Song <sxwjean@gmail.com>
Date: Tue, 20 Apr 2021 10:35:42 +0800
Message-ID: <CAEVVKH-0XRY1auCigxXQd5Q2o71Mi6jduh=7BHELQ7K=1j_kLw@mail.gmail.com>
Subject: Re: [PATCH 1/3] powerpc/8xx: Enhance readability of trap types
To: Christophe Leroy <christophe.leroy@csgroup.eu>
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
Cc: PowerPC <linuxppc-dev@lists.ozlabs.org>, Paul Mackerras <paulus@samba.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Apr 19, 2021 at 11:48 PM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
> This patch makes use of trap types in head_8xx.S
>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/include/asm/interrupt.h | 29 ++++++++++++----
>  arch/powerpc/kernel/head_8xx.S       | 49 ++++++++++++++--------------
>  2 files changed, 47 insertions(+), 31 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/interrupt.h b/arch/powerpc/include/asm/interrupt.h
> index ed2c4042c3d1..cf2c5c3ae716 100644
> --- a/arch/powerpc/include/asm/interrupt.h
> +++ b/arch/powerpc/include/asm/interrupt.h
> @@ -2,13 +2,6 @@
>  #ifndef _ASM_POWERPC_INTERRUPT_H
>  #define _ASM_POWERPC_INTERRUPT_H
>
> -#include <linux/context_tracking.h>
> -#include <linux/hardirq.h>
> -#include <asm/cputime.h>
> -#include <asm/ftrace.h>
> -#include <asm/kprobes.h>
> -#include <asm/runlatch.h>
> -
>  /* BookE/4xx */
>  #define INTERRUPT_CRITICAL_INPUT  0x100
>
> @@ -39,9 +32,11 @@
>  /* BookE/BookS/4xx/8xx */
>  #define INTERRUPT_DATA_STORAGE    0x300
>  #define INTERRUPT_INST_STORAGE    0x400
> +#define INTERRUPT_EXTERNAL             0x500
>  #define INTERRUPT_ALIGNMENT       0x600
>  #define INTERRUPT_PROGRAM         0x700
>  #define INTERRUPT_SYSCALL         0xc00
> +#define INTERRUPT_TRACE                        0xd00

The INTERRUPT_TRACE macro is defined in BookS section.
In BookE, 0xd00 stands for debug interrupt, so I defined it as
INTERRUPT_DEBUG.  I understand they are similar things,
but the terminologies are different in reference manuals.

Regards,
Xiongwei
