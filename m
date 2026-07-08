Return-Path: <linuxppc-dev+bounces-23762-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56F93C43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2026 05:34:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gw6HH6Lf3z2yQL;
	Wed, 08 Jul 2026 15:34:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::431"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783488891;
	cv=none; b=IztDPeoKo1eoF2nduMUkjAXP4p6c5PNkNAX48gPfWxvddFjl3kkirC2NnxNbe+X5rd2UnSlagw68hMLqnq45FyQ69h2vw7xTQAHPCoN4In/9u1dR6N+FFdjnqNvRSezzghiwHdOGserG2zgxri4uZzolLzJMGEvRGXh12cfErHD6DOxPr6LUIX+1Mq9wFd58UWnrLw++SHPy9f0Ev4I5qeHtBtjNj97WCrEbpeCEEM8hROVxU3yCHKsG4b7QJ8d9XwALFMK1swE5cSbLsWMPSfIAsRiYVOkD+s36Bvh/O6BQbXvyUyhUgPqzltvPOKTWQxlFyC89om631mpD10wE0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783488891; c=relaxed/relaxed;
	bh=KCoAZ3oKeEmfTRfzWJr2UxLwWnUEP8ZX9pC688Pm86A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fwOvS6T9VvS16apRh3mZ0MBs2wuLX7vjYrp+D2U0pFqspW1NxxbC6TMbsKhOu+2XVZiSdxPSkwECsk/PbCuwhugt5vXSJWsej2u/hgb2TMVixUSLhDp/Qlz0e5imLR3rYy4aosqeXV6RBb2xQeMN5ZmF0wwOczn0FBYVWE6fqZ35MSpDrewFAnpyAeaChAeZF6VsvpZ6YDmObzN8Hq980NiRRuxKtAqjDIZP0IDsB1dQg3cFX1YiJzdfB1SJAISqsUtk8+E1qSD+gp7BbBtwlENMheXSTCVxeh92EyDgNFXIdNrFZfcViF1wOn3b0wbp4ByfjGvmqCtFPzYMyaa0aQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Y6A8iqux; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::431; helo=mail-pf1-x431.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Y6A8iqux;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::431; helo=mail-pf1-x431.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gw6HF53FLz2xKh
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 15:34:48 +1000 (AEST)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-84536ecfc5bso308918b3a.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Jul 2026 22:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783488885; x=1784093685; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KCoAZ3oKeEmfTRfzWJr2UxLwWnUEP8ZX9pC688Pm86A=;
        b=Y6A8iqux6U8t7DROyEExuSB+fT4UYjC74XD4r23ZUwZiYsuCK+ws8n1EtIEjaWN41R
         Wv696c3xtXLiUDzoTe9rooIJDvnkeZULQx89sBq8BZgMLQk/ZX6awF0vPtfFnnrDueJn
         ibsuXrPop7Tfv63nIErmk9qkFONU98p9c24ihUoHpqsHRCIr8DGdBQCGZ0YYgjGoCzi8
         mOjVWlw/OfGjGqWYP6GYyXzH2ohjMUDG1G0E6OjF59+NTPpR+8JeAweA0KaPh0Fs1uHI
         JU2ni/QAqITA1mBEDvP8QzPerGw24mdV4uRh+E8r95cqGibGJTHxSp8XwoSqArG32sZm
         sOpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783488885; x=1784093685;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KCoAZ3oKeEmfTRfzWJr2UxLwWnUEP8ZX9pC688Pm86A=;
        b=jZGlYHS06DkjllwrfcM1XxKsmLo11ppG8xBO1M8UzyqdLWBcTU7tdQQcY7ItQ3QxE7
         8WI3TQyGi0mGbgztugrvZV2JkOJbZ5/IwJcDY15rpGN1tP3/ZyIbLY/EaFkMwj5BoQoM
         789TG5UFlzZqwlx2U0pImD/KryaRHPOH8RnqHgrPqt3WdqUikPvhxt+BQkESCx/LBuJz
         9afAxcwy6pmODgrJY2ldGNeU9jVTw0Ud8/L5i2ziI+RB/y4LwFsRL2ZMa1Evm6K0a9HD
         T+4lKj597iht1GHnAzA+GVPzLQwLH0JLac+8QQRm8Iiu/qsTd5yqRytjnFYLocHrv+Lo
         T9Zg==
X-Forwarded-Encrypted: i=1; AHgh+RoF63NSR7LKT9u637qEHsPQ4SB/MqxujeNuUrU5LaOGQPZr0Q7e/lrN4ACZW3dEcsHnL8WLDBsTM+EaEyQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwMSNHIcjyd/YeMznGl5zgmG4w/GzJA45/qTkWwcNnWES2L2dp0
	YFCJgz9E767vT7PGiweja83+y4N4q7QDM6R/zyIEkwDi5zd/rjD0JJAW
X-Gm-Gg: AfdE7cnSaYgISev5xVN1iwu8MXWgLx9pM0hjy/RKztwsSSReu/djaLW1mrVkGAqG18D
	AVgXn4JyXW82TixGrz7QKvyszSSZldwNp7/Kcj4HXx5TZMQxiTeMmpJltUXM4ePOgMw9t5bhsw+
	ID/HHaXyBKASlgzDnAt8rs39SfV59A709yNFyEby/ZZ7wgVhnNGd2Y97dWBCz+27fjDynOQjxwA
	2yJv6mLepbmhZ9YSImyuwtdoM+SCZzoj+yYMyM6TrXB98Vm8eGd74NAkmYYTekyNRoc58sKgErZ
	fOipCg6zhrpuVq+55CkVfZSy+RY/48n7RdTZNMHSmX8dvi9NGXaxwrqtqtNqMygwP9Taj6A9AT2
	nggPMG992NhgiUofICsBgGLhuqpTF0W1bksVNWVWdana0bgSmgpd/BFTvwFkLfWi8nvg51e0v7X
	YNcR6k+PHdtxmOrRoOZz1BAhnQ62RryE2lZHbjTmU+DTTq7QTZ6MA2DF/R+ZBw
X-Received: by 2002:a05:6a00:71cb:b0:848:44c5:f801 with SMTP id d2e1a72fcca58-84844c5fab3mr988421b3a.33.1783488885348;
        Tue, 07 Jul 2026 22:34:45 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6dddf8bsm6458652b3a.61.2026.07.07.22.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 22:34:45 -0700 (PDT)
Date: Wed, 8 Jul 2026 11:04:39 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, mchauras@linux.ibm.com, ruanjinjie@huawei.com, thuth@redhat.com, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] powerpc/970: fix nap return address corruption on async
 interrupt exit
Message-ID: <ak3gTv4Ub63TRLme@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260707172430.790040-1-mkchauras@gmail.com>
 <880eba74-6427-4fa3-941d-b67bbf98f3a4@linux.ibm.com>
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
In-Reply-To: <880eba74-6427-4fa3-941d-b67bbf98f3a4@linux.ibm.com>

On Wed, Jul 08, 2026 at 09:57:44AM +0530, Shrikanth Hegde wrote:
> Hi Mukesh.
> 
> On 7/7/26 10:54 PM, Mukesh Kumar Chaurasiya (IBM) wrote:
<... snip ...>

> >   		/* Can avoid a test-and-clear because NMIs do not call this */
> >   		clear_thread_local_flags(_TLF_NAPPING);
> > @@ -286,14 +293,6 @@ static inline void arch_interrupt_async_enter_prepare(struct pt_regs *regs)
> >   static inline void arch_interrupt_async_exit_prepare(struct pt_regs *regs)
> >   {
> > -	/*
> > -	 * Adjust at exit so the main handler sees the true NIA. This must
> > -	 * come before irq_exit() because irq_exit can enable interrupts, and
> > -	 * if another interrupt is taken before nap_adjust_return has run
> > -	 * here, then that interrupt would return directly to idle nap return.
> > -	 */
> > -	nap_adjust_return(regs);
> > -
> >   	arch_interrupt_exit_prepare(regs);
> >   }
> 
> This makes arch_interrupt_async_exit_prepare same as arch_interrupt_exit_prepare.
> Maybe remove arch_interrupt_async_exit_prepare?
> 
Hey,

`arch_interrupt_async_exit_prepare` and `arch_interrupt_exit_prepare`,
both are marked static inline. So the generated assembly will have no
impact. I kept it this way coz it was consistent with how we implemented
other macros like `DEFINE_INTERRUPT_HANDLER`.

Regards,
Mukesh

> > diff --git a/arch/powerpc/include/asm/interrupt.h b/arch/powerpc/include/asm/interrupt.h
> > index fb42a664ae54..1b45a49e9bed 100644
> > --- a/arch/powerpc/include/asm/interrupt.h
> > +++ b/arch/powerpc/include/asm/interrupt.h
> > @@ -246,6 +246,7 @@ interrupt_handler void func(struct pt_regs *regs)			\
> >   	instrumentation_begin();					\
> >   	irq_enter_rcu();						\
> >   	____##func (regs);						\
> > +	nap_adjust_return(regs);					\
> >   	irq_exit_rcu();							\
> >   	instrumentation_end();						\
> >   	arch_interrupt_async_exit_prepare(regs);			\
> 

