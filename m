Return-Path: <linuxppc-dev+bounces-19430-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9010FEEF24
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Apr 2026 11:29:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fqkWT1cPgz2yZ3;
	Tue, 07 Apr 2026 21:29:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775561397;
	cv=none; b=BHv0XGtKQWXIoLv+XNpBFvZ0lux8x95MgdyW3NEzYWyy2TBNt4HXReNu0Hav3cTZew3DxedOXVEgenR+4rrTB0/J7MSpfpbOHXToVmRW/iMcY87qRaaHKlGhv0YcsvMm/R5BJlyKq/WwjGOLe5I7AtuR/G/Z3mDqoNZZ+GnQtVIelo34HVYliKOKP7aV/XfKpM59P0Bifh9KsVuiKK6hsmmT2E/UTFqzYZmS67byIAx5SyHmBiYYMOI0+LYBZm+NV2KLMkKt1jfZqCEWwuLVLf1XLaVgYRziKL9kweAREsZFRMH37Wu4Ilqr1aI8VsQyp22hdhEc4UZmGxumWTCEsg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775561397; c=relaxed/relaxed;
	bh=YPMzMSu2UcaUr3+SNKjnG4539dTdukUCZBYScBAzSWs=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=dLreIsRuLUtABJ/WbyaU4Ef0nCw/YbG0HAg7oYrmC/0nHzVWNT1XSp07avUtf5QZPdzn1+kXq63OU2JM1gaEJVZze9ihb2+yU6cNSmPfGMxqmXLfaTIEa11ngtfPiB6jO4CvSuuLybJyPVYtOU6cXETJUCwaORWeK/nQBPesnkEpjWaAAiuY4Myjphlto97o/AuuYdLhqpfa1PM6xh/gKQ3oNC2gSVsFOvcRYRgLbD4ZtTEMbAPgZp/kqLBhFmzHM+NIKNh7QNCO/KYgIa/XDUAYiSDEmVq8IsfTwJ8IxAi8vCHHl5HicGbJvj3jKRZgf0aJfBTrQQajnz32Dr8K3g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Cz0mzciM; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52e; helo=mail-pg1-x52e.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Cz0mzciM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52e; helo=mail-pg1-x52e.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fqkWS140fz2ySS
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Apr 2026 21:29:55 +1000 (AEST)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-c76b87931b8so3409765a12.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Apr 2026 04:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775561392; x=1776166192; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YPMzMSu2UcaUr3+SNKjnG4539dTdukUCZBYScBAzSWs=;
        b=Cz0mzciMgDfUJbT90sji+BVobtIaXRGApWaDGlrOWJSq1Yr6SKJU6y+XEXWhrKFw4Q
         JyWAf2oJPdkTuY1sWNYkXojKrpdaPnjETqW5p0lf3+rZVV5cYihZv0s0me15m/2OlXYs
         tkHgK9WRO1H6TIKuf2UbgF2s+ojsmj6Vd6dfUGfZgzoYj1ezyU8B6zUN1ODSE22HnHdx
         bALS004N9g2zcNxxu5j94kebjyeN+V6N3uRHzw4IX8jGmYTvDSN/3HxhsuT6jJL9OHwP
         B+pSdmUSHMMfy/O7RhOLIC2QqHGQb4r3lgkHGYn6ehq+essuxQ352kxnruFpX6hgk776
         wXfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775561392; x=1776166192;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YPMzMSu2UcaUr3+SNKjnG4539dTdukUCZBYScBAzSWs=;
        b=fXLASht14GeymCGzMceLtvU2bf2eNuf+TgiMvEVOW6w0uFVLyFhZhrjLDfZaWsM8Px
         TRhiOUtcMMvmryX2366/NPM2KLPx/Vzmwxy4pQ43f4gJC8oD+DMJVKkKerwYUxMTRoFE
         +QBRP1EsvSGmBYdYkYRm8O866imgDbjNOQbvv/t2aTZ3zGBTi9etYMkbQTGY4UZoQuUZ
         AFtEwwjtKifJZWMaRyW+tHTMOH8bTcOFfo6cn5w5s9H3vw+auj4fvRKkSQqVAYlR5EoP
         2o/tkM/sgf0dbpqb7GgVspr6v0GR5tfDIJJw5Q5x3iqMxs2XLtv3OR32vDnJ61xeAP5E
         PyWA==
X-Forwarded-Encrypted: i=1; AJvYcCVCQ6eu6xgDoLOC24mhGBEhEKdZ6FtszNz88NIe5pZBR5NEtah4fpmOYrcYqqmc9hyNggVgzYkkumlFtwk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwmKKq9yt9Oco4Hjv6NWM/TqABMma9jDY171F9Fr8zqmYBgboR6
	WBGZz5yQuetQZDIOnXYNXmN+8lq6mFnquCw7E/jL+LAS3EDj6Jvf90eO
X-Gm-Gg: AeBDietwjXU42jhGPYR6/Cy3jOh92D7qjiaMhrfihYyHnes8E1K1U1TU/ZF0ZQbBlp9
	E7+iI5EI7AQDgHL8Q1PYxD7VabNhiQMvdVO4APgmhiTXKCBj+lEFIjmUSYAyGAvr71K659P/xZY
	+e1fDxU6e54nWs9A47L3qlrvLeUcAYypkmrmv1ssE0wkmmjXSm0lCe56KgzcPQ5TvFFGgvzkOwN
	yR/SBFIGbymuRgBfi1xkyBFnZmkdYVm6ZV1FW6bVK/MquxLIdSMCv16OQ3L2/BtCURR8zplV2IB
	xyctTGcrXEjB5b9TFAvYEICr4Z1Grm0en4yWMyxT5bciZodT5VZPNebrvFK6JkSDtNc+4SXISKE
	wFZsoKqJsJxZ2DQsLYOLUxDJBVoqJrd1ftrhfWS3xd5dYNvJ9lM02BeV3dlsjkbRz3EkAgQc48+
	bBdGUQLm2QSPSD2x08DBOPzw==
X-Received: by 2002:a05:6a20:7354:b0:39b:e321:784f with SMTP id adf61e73a8af0-39f2f05041dmr17711179637.40.1775561392149;
        Tue, 07 Apr 2026 04:29:52 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c657dfb7sm14891242a12.24.2026.04.07.04.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 04:29:51 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Haren Myneni <haren@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, brauner@kernel.org, hbabu@us.ibm.com, haren@linux.ibm.com
Subject: Re: [PATCH] powerpc/pseries: Fix UAF reference for src_info after list_add
In-Reply-To: <20260317040444.2785741-1-haren@linux.ibm.com>
Date: Tue, 07 Apr 2026 15:48:04 +0530
Message-ID: <v7e3krab.ritesh.list@gmail.com>
References: <20260317040444.2785741-1-haren@linux.ibm.com>
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

Haren Myneni <haren@linux.ibm.com> writes:

> Getting the following kernel panic in papr_hvpipe_dev_create_handle()
> when trying to add src_info to the list.
>  Kernel attempted to write user page (0) - exploit attempt? (uid: 0)
>  BUG: Kernel NULL pointer dereference on write at 0x00000000
>  Faulting instruction address: 0xc0000000001b44a0
>  Oops: Kernel access of bad area, sig: 11 [#1]
>  ...
>  Call Trace:
>  papr_hvpipe_dev_ioctl+0x1f4/0x48c (unreliable)
>  sys_ioctl+0x528/0x1064
>  system_call_exception+0x128/0x360
>  system_call_vectored_common+0x15c/0x2ec
>
> The current code adds src_info to the list after UAF for src_info.
> So move the retain_and_null_ptr(src_info) after this list add.
>

Sorry for the delay in getting back on this.

> Fixes: 6d3789d347a7 ("papr-hvpipe: convert papr_hvpipe_dev_create_handle() to FD_PREPARE()")
> Signed-off-by: Haren Myneni <haren@linux.ibm.com>
> ---
>  arch/powerpc/platforms/pseries/papr-hvpipe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/platforms/pseries/papr-hvpipe.c b/arch/powerpc/platforms/pseries/papr-hvpipe.c
> index 14ae480d060a..5121c87d1fad 100644
> --- a/arch/powerpc/platforms/pseries/papr-hvpipe.c
> +++ b/arch/powerpc/platforms/pseries/papr-hvpipe.c
> @@ -509,7 +509,6 @@ static int papr_hvpipe_dev_create_handle(u32 srcID)
>  	if (fdf.err)
>  		return fdf.err;
>  
> -	retain_and_null_ptr(src_info);
>  	spin_lock(&hvpipe_src_list_lock);
>  	/*
>  	 * If two processes are executing ioctl() for the same
> @@ -522,6 +521,7 @@ static int papr_hvpipe_dev_create_handle(u32 srcID)
>  	}
>  	list_add(&src_info->list, &hvpipe_src_list);
>  	spin_unlock(&hvpipe_src_list_lock);
> +	retain_and_null_ptr(src_info);
>  	return fd_publish(fdf);
>  }

Looking at the destructor routine...

static inline void class_fd_prepare_destructor(const struct fd_prepare *fdf)
{
	if (unlikely(fdf->__fd >= 0))
		put_unused_fd(fdf->__fd);
	if (unlikely(!IS_ERR_OR_NULL(fdf->__file)))
		fput(fdf->__file);
}


...I think this approach might still have issues. i.e. if we don't make
src_info as null like how it was done before, then when we return an
error from here, it can cause double free issue:

	if (hvpipe_find_source(srcID)) {
		spin_unlock(&hvpipe_src_list_lock);
		return -EALREADY;
	}

Because, an auto cleanup / kfree(src_info) will get called.  And since
the FD_PREPARE() step was done successfully, it will also call the
file->f_op()->release() function on fput(). Now since we have not even
added the src_info into the global list so this can cause list
corruption as well.

static int papr_hvpipe_handle_release(struct inode *inode,
				struct file *file)
...
	src_info = file->private_data;
	list_del(&src_info->list);
...

So looks like, this approach has list corruption + double free issue.
Maybe you can even try to reproduce this when you call the IOCTL twice
with the same srcID.


@Haren,
While looking at the papr-hvpipe code, I think I may have found couple
of more issues. So, I am preparing a set of fixes for the same. I will
need your help in the review and testing of those please, as I am not
much familiar with this code :)

-ritesh


