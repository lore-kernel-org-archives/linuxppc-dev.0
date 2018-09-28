Return-Path: <SRS0=psBJ=MK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E22C43382
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 14:36:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6CE720652
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 14:36:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="ZJ093PMh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6CE720652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42MDkr73fPzDrp4
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Sep 2018 00:36:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=axtens.net header.i=@axtens.net header.b="ZJ093PMh";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=axtens.net
 (client-ip=2607:f8b0:4864:20::444; helo=mail-pf1-x444.google.com;
 envelope-from=dja@axtens.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=axtens.net header.i=@axtens.net header.b="ZJ093PMh"; 
 dkim-atps=neutral
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42MDc95mkQzF3FS
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Sep 2018 00:30:33 +1000 (AEST)
Received: by mail-pf1-x444.google.com with SMTP id k21-v6so4441361pff.11
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Sep 2018 07:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axtens.net; s=google;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=C10pPrxQZsgncFbuhvA3QlXsQ7xIxnM2i3AG0UKHjnA=;
 b=ZJ093PMhczJgVstKIEkKO/fZJAgF3AIjw1T0H3tQg+KADEhZV2gALhxtKkTQk4Dkjg
 HD+Z4JV4C3le8dnfEshLuHsTWJzrJGeuZ6tHU+sVX7kG5InWk5EXZaZAdFABKCgh8aT+
 97C23F0CAzTpA3X4Lg3Qjvw9H/xOqb0ZCbsIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=C10pPrxQZsgncFbuhvA3QlXsQ7xIxnM2i3AG0UKHjnA=;
 b=VR3fedZQSM8q7ZIPIPoq1FkabIUK0h9/gMx2E79zPFcbvp8whvGM1VKLoz/yNyuZYh
 6dWtqscfqqm/j0v5ct8XC+FC+hP+JqxesGURjMmVQx/p3Zp+muDEzC/5qDBuIHYCG30z
 yKDYZWFND8W6xj5mbPeeo+i7nKgugffiWCMvxis84DnIT9r8657PRtivjNStzQazEvPo
 mAFEMvX1Y3XWQytrFjtqGVFtmjxYui4jQ9jImEYJ5HREO292GmQ5rkwUzwUnEs1GlrUu
 L6MCZCsrqwO56LwjEuPSgPSJI22luGzKxAG23Ny+s2LGx0xarohti8FX4iSm6laQn5Nv
 TNjg==
X-Gm-Message-State: ABuFfohoSZCulK5m/6nQw2RTRhTtd9laZ0AOCgMpoh/HClRHJ9/LhCkw
 nh2xlyUwiWJmTDvigduGAGzb+w==
X-Google-Smtp-Source: ACcGV62zTdlgnIqln5jxrt3XWK8+vMeRjoLUK5e1jYyBNb1rCoUdgcLEFqlCp4ytx8kgDlbTEacXgw==
X-Received: by 2002:a63:2703:: with SMTP id
 n3-v6mr15630860pgn.113.1538145031002; 
 Fri, 28 Sep 2018 07:30:31 -0700 (PDT)
Received: from localhost ([2001:67c:1562:8007::aac:4356])
 by smtp.gmail.com with ESMTPSA id 25-v6sm8595113pfm.36.2018.09.28.07.30.28
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 28 Sep 2018 07:30:29 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2] powerpc: wire up memtest
In-Reply-To: <5ccbb0b1ce0a86ef7a77e7b8dbb85c3637bf4628.1538087238.git.christophe.leroy@c-s.fr>
References: <5ccbb0b1ce0a86ef7a77e7b8dbb85c3637bf4628.1538087238.git.christophe.leroy@c-s.fr>
Date: Sat, 29 Sep 2018 00:30:22 +1000
Message-ID: <874le9k83l.fsf@linkitivity.dja.id.au>
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Christophe,

> Add call to early_memtest() so that kernel compiled with
> CONFIG_MEMTEST really perform memtest at startup when requested
> via 'memtest' boot parameter.
>
This works for me on an e6500.

Tested-by: Daniel Axtens <dja@axtens.net>

However, you should also change Documentation/admin-guide/kernel-parameters.txt
to reflect that memtest is supported natively on ppc with your patch.

Regards,
Daniel

> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  v2: moved the test after initmem_init() as PPC64 sets max_low_pfn later than PPC32.
>
>  arch/powerpc/kernel/setup-common.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
> index 93fa0c99681e..9ca9db707bcb 100644
> --- a/arch/powerpc/kernel/setup-common.c
> +++ b/arch/powerpc/kernel/setup-common.c
> @@ -33,6 +33,7 @@
>  #include <linux/serial_8250.h>
>  #include <linux/percpu.h>
>  #include <linux/memblock.h>
> +#include <linux/bootmem.h>
>  #include <linux/of_platform.h>
>  #include <linux/hugetlb.h>
>  #include <asm/debugfs.h>
> @@ -966,6 +967,8 @@ void __init setup_arch(char **cmdline_p)
>  
>  	initmem_init();
>  
> +	early_memtest(min_low_pfn << PAGE_SHIFT, max_low_pfn << PAGE_SHIFT);
> +
>  #ifdef CONFIG_DUMMY_CONSOLE
>  	conswitchp = &dummy_con;
>  #endif
> -- 
> 2.13.3
