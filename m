Return-Path: <linuxppc-dev+bounces-19926-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C86A6F94CCA
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Apr 2026 05:57:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g0pQY0NmWz2yZN;
	Wed, 22 Apr 2026 15:57:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a0a:51c0:0:12e:550::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776837428;
	cv=none; b=lNmydvglF2q6is7dWOCJu83r+DjBP6GhhpvNImwtuAbzC0P9qxq3d9uxgOEEtWG3zle9M/QeVJc/0XRqXvYLsKVkX3mWyTld4gTvQEHCyIHcgpqxreZSSjqswuYAR0Q3Aivyi3QjPqVMWUF2AcuGDtfzMke8LhXyrLGOcraohVPepsV/tk9rD/22teopUxuebPE2foQxcXpF/93TRCK0kplSOXxmwYAsFb5HWDae+b6fv6j6ZdBS9j0JUW5oxagoRv6yLnHXBzo3aKMEFj4OkA0cJUmajmeG/PaoBgiNHsxL+z/OA5y6dqWGsbYRJesp4CqTYp8btnceb9Z1N5T1IA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776837428; c=relaxed/relaxed;
	bh=9ovs0MfObWMEAYCItMLX9P88HtOnHXJzwGjgwUQTUPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GgbkflKlDKboQ6lKoNrCzoyGr0zfA0GJ/vlf7I4OvtMWnWOytHr6BSTsQAXNp3ko1225huwkqj1jPkeGk+tCzV47/MhxrChbT/AmBRE217UkUZJnKnVrTeI2xwdKC6caWmy0P+k1vdWB83ptmYBcbX3Y/ZyS0n+Hb9qylsgJZCOdXzfgbiyqJZvC2uzbobCa7zy5lYT7EaJMaUa46k7hen64FgwGbfiqrU6CR7GSS/YRutUSbx3iD5/+Ec4YRh/S0o0/MmT7P3rDlAAiv5f/uUQcppy+5vDVEwsXM2I5YXNCLkK7vTq1zTHHJ3vry9OZoRGHDoKYqR/+qf0PfSz7LQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=z5IC0+ha; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=+vmzERty; dkim-atps=neutral; spf=pass (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=z5IC0+ha;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=+vmzERty;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g0pQW1M6lz2xSN
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2026 15:57:07 +1000 (AEST)
Date: Wed, 22 Apr 2026 07:56:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1776837422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9ovs0MfObWMEAYCItMLX9P88HtOnHXJzwGjgwUQTUPk=;
	b=z5IC0+haCM0qWEllygNCw1PQuTkzu27LqFvjZSvHBj4ZXX8x69qmRyLlv/UBe1hpavFlNM
	xWrYnJLe9NMEmiLbh/SuuT+WgMn4eXdsYUjWVKGKJMbVU7Bc80LB363PKX0p8lcu6Itoyq
	KUPRIvrKxB1ksVBwG5SWbrvbXoswGpYDpDt8rSHNugjBVSNo94gQHIA8T+gvRNoU710V6r
	0Hvlo41aHnxIHrv3R+lnIqBv70/1roeTC55p1mEzqOqMRFV/nYCzH6SAhAfCBAgcxj6l1h
	vdi1lFJmHN8sZvA3EG+GgJKDUNY1luwR7gzMXi18/KzGqpVkO1Xc6fZZh9zoJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1776837422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9ovs0MfObWMEAYCItMLX9P88HtOnHXJzwGjgwUQTUPk=;
	b=+vmzERtyQwX568xh6yyuX1pXFpi4zySDDVo3wqpZxoaQv0bY7b4/qQbeMQimiVFIVKtEUr
	xm9FtjQQ5+pTkNAQ==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: linux-arm-kernel@lists.infradead.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: New warning in linus/master
Message-ID: <20260422071541-9a295128-d913-418f-a21c-1386fca30290@linutronix.de>
References: <CANiDSCsOy0P1if-gJZqOM5pTJ0RDcwVfru1B7KFbTOEMqjPKJw@mail.gmail.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiDSCsOy0P1if-gJZqOM5pTJ0RDcwVfru1B7KFbTOEMqjPKJw@mail.gmail.com>

Hi Ricardo,

On Wed, Apr 22, 2026 at 11:51:45AM +0800, Ricardo Ribalda wrote:
> Media-CI has found a couple of new warnings in the latest kernel
> version for aarch64 and powerpc. They get fixed with this patch and
> before moving I wanted to know if this was under your radar.

Thanks for the report. I was not aware of these so far.

> diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
> index 7dec05dd33b7..65914842fae0 100644
> --- a/arch/arm64/kernel/vdso/Makefile
> +++ b/arch/arm64/kernel/vdso/Makefile
> @@ -50,7 +50,7 @@ CFLAGS_vgettimeofday.o = $(CC_FLAGS_ADD_VDSO)
>  CFLAGS_vgetrandom.o = $(CC_FLAGS_ADD_VDSO)
> 
>  ifneq ($(c-gettimeofday-y),)
> -  CFLAGS_vgettimeofday.o += -include $(c-gettimeofday-y)
> +  CFLAGS_vgettimeofday.o += -include $(c-gettimeofday-y)
> -Wno-maybe-uninitialized
>  endif

(...)

I'd like to know exactly what is going on before suppressing the warning.
It is a non-standard warning, only enabled by *some* of the vDSO builds
for some reason.

> https://gitlab.freedesktop.org/linux-media/users/ribalda/-/pipelines/1649144/test_report?job_name=cross-gcc

While I was able to download a configuration from this job and also use the
same container image, I can not reproduce the issue. Is the configuration the
full one or only the template?

Could you provide full reproduction steps?

> CONFIG_CC_VERSION_TEXT="aarch64-linux-gnu-gcc (Debian 15.2.0-16) 15.2.0"

The linked test log shows GCC 14.2, not 15.2.
Not that I could reproduce it with either one...

>   SYNC    include/config/auto.conf
>   CC      arch/arm64/kernel/vdso/vgettimeofday.o
> In file included from <command-line>:
> In function ‘vdso_set_timespec’,
>     inlined from ‘do_aux’ at /workdir/lib/vdso/gettimeofday.c:266:2,
>     inlined from ‘__cvdso_clock_gettime_common’ at
> /workdir/lib/vdso/gettimeofday.c:293:10,
>     inlined from ‘__cvdso_clock_gettime_data.constprop’ at
> /workdir/lib/vdso/gettimeofday.c:306:7:
> /workdir/lib/vdso/gettimeofday.c:104:26: warning: ‘sec’ may be used
> uninitialized [-Wmaybe-uninitialized]
>   104 |         ts->tv_sec = sec + __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
>       |                      ~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /workdir/lib/vdso/gettimeofday.c: In function
> ‘__cvdso_clock_gettime_data.constprop’:
> /workdir/lib/vdso/gettimeofday.c:242:13: note: ‘sec’ was declared here
>   242 |         u64 sec, ns;
>       |             ^~~

The same pattern is used in some other do_ handlers, which do not generate this
warning. I also can't immediately see what is wrong.

(...)


Thomas

