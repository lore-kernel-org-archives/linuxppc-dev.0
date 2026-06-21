Return-Path: <linuxppc-dev+bounces-22858-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94FB7CD98F2
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Jun 2026 13:39:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gjsrB6DHcz2xPb;
	Sun, 21 Jun 2026 23:39:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::112e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782049162;
	cv=none; b=b9QBl9lo7ZEYbD4wuAqad5BSIBUAioQZvgEIQG9H9sEQa24KyqaNY8eM54id0lwn5w4cOcAMXfBuXJCf3h4r2rPWpMstLaMNPgzZ1+m8hO9e4C+evk34qX1au/i0DyhHbYVs8/lvVsXbf2Oy4Gxzu+Pvqz02SqkqA+JTT1nE0ZUJiCKFDPBCU9pwveX7rbUb1Sa8YoX3RVsMLalT+g2auH4C5IDc3Q6pfsykwb/GIvC2eMQLo3/dYmA/lB5bh7/BWnCgzaHTmv0o6FRN7T51lMqVdsP+O25ochwbruHDjfYywBMgcfVffi9q48kSF+lKlNqsN5/+Fi7hulhpFO/Kfg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782049162; c=relaxed/relaxed;
	bh=YUsaj7vv5ecLJDUQ0RmLhOH3YlF5lnncSJLJl2FpGbU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nobvbriKOUbJywynQO0ASuL68ojCqfd0gPIcD0AG8onx//YEjmbazMuP5kOfgwSxKiLyO1C/gSrXoUM10gtC8IlQ1ajD6BARMIbh7J29/BLLUl6RUEzC7AD3iF3462ubcpAL7iQCiqQdv6nnboB4zeQa9JgHHz2gBX6LDvCMJcs1i5NUesn+dIk5OMIIf4gAJJoWyVzzm9Sfr2WXTAxzA9Fs5qQfpV0dsGiwqqT4UoXv/bA3grzhxZr71+4SE/wC+YgcLCVj8BHh49MsE1YIDYv0b8lrfHI3ex/rMRVTLAn8TwwnUT2cP5rX78oq5oCpprR3U2VkM1bAFk9KWJ4Nzg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aReCMhd1; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::112e; helo=mail-yw1-x112e.google.com; envelope-from=yury.norov@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aReCMhd1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::112e; helo=mail-yw1-x112e.google.com; envelope-from=yury.norov@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gjsr95KcTz2xPL
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Jun 2026 23:39:20 +1000 (AEST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-7ff05e5d009so33580377b3.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Jun 2026 06:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782049158; x=1782653958; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YUsaj7vv5ecLJDUQ0RmLhOH3YlF5lnncSJLJl2FpGbU=;
        b=aReCMhd1oI0y9iuhOdPWcsp9D/fU3WUt24mNgHqtc/+98CCPl6w3nZnu72HPl4GVgo
         KcLn5laGUBQZs3XVfYfaXAsGFTjSUKgfmM5r2YwXpItFP8syN/qEt1ukLN7iC239CXak
         BJHc7xX+O4buPBwKW8rJpE+8SS+FlwFqVcXUlVKhRyBxs2IVbfb7/Vqk/um5U3362ZEx
         52Fw4UL0eH3yMRbYUhIzKJaNmtSnTObGSCZx2LUofGi9ZZSakAgNmw+V+2cG21T2zyma
         nkoqnGqaEccPUAZ7tYdrniMI/cvgr+eRJspM3QoUxqmXRV+9GSdyiW6CV+5fTltB7kI3
         1HIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782049158; x=1782653958;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YUsaj7vv5ecLJDUQ0RmLhOH3YlF5lnncSJLJl2FpGbU=;
        b=T3qOVY84FGC8WrUx0B5ZI79b0eazJQ3WU1TGH3gWjy7oBoPMTF4PE1r1rvukEVK1/j
         eJzBIQc1Ck9S6RO7C+TJ13avLeh+F0O8am/YuaZVpwmmr9OUtp/MaTEdo7oiiLViDCBk
         3OHYgmJsLsicWUlgN8wNkkJJBlL5Bl1aXs8mzdteJYCPJwzG+OPMCXDxr899R+xdWpON
         jlIb7Zs+fq3ZcyggpCKYY4nlVQIym53l1gm/QUfSQQ4OCvI/E2z1gd6t3i6itnUKUn1U
         IJaV1uLFlI9PDta2mNLhbV1APrJEJLY+eiquDP9om+sYK63sLllM0xcOV430kIlv8eLq
         Xxeg==
X-Forwarded-Encrypted: i=1; AHgh+RoD0DgC1apJU5cHf3uV9SNNMj8yvQjVGzjzbs6Oeqqp9YA0GtBrJg27s/RReTd8BoiCWVfbgeyLmUcqkss=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzIYYTBEPpkeNgUxftHR57Zp1+ZnBBzD39kVZA6TBTW7MPPh2y9
	EOM0jxDR0/3fTSUZTMJ4RwbDwW2IPqyPpd6Dv5yy4eizsoiUFBBO67i1
X-Gm-Gg: AfdE7cl3BrpFfUGRTH3nj8+7BtcbnLZOFlH3NMq31Pzbm1LLZ53Oy6wfU/Dt9mjqMbu
	Bmxj1DXwU5TFIb5NXdi7m51sifs4CSqaLGtHILKYNj6v/BAE+H6ZVz+6RSe8ol1J6WpQYQn9sDo
	zaFkt8smfTE1C/EyQqTjbZ6Zr55U77MK29t+EkwLwQjbJa5jgNY0tKGoDgfvpiDaY/x80GCOOQY
	ZgpRjmzKCM5jHiyBYfsWSvfY9AMMh4lGVoozijbqCS/1KDusCveu/OoKk5jPvG4CLOL4okDk7HV
	HJTjOI/JlBAik1ftZAidff2ZfhqmaRVbRFjEqB8PaimMschFEgIN5sZT5lTF24s2/6FpmU8vBkn
	yrkHQUz7wduNHZwd/65Yv74473BMuYvvR2KI94z0nWqRTXzQ1YobHxCJvFvmQmpnu1/ZgisSpud
	8vWTbD4iAHsT5bcFYYG1XUvVSZflwlIPdOuJo=
X-Received: by 2002:a05:690c:e347:b0:7db:ccda:a409 with SMTP id 00721157ae682-801759e5070mr88778787b3.9.1782049157948;
        Sun, 21 Jun 2026 06:39:17 -0700 (PDT)
Received: from localhost (user-24-214-85-55.knology.net. [24.214.85.55])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8025f8dde30sm20893067b3.27.2026.06.21.06.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 06:39:17 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
X-Google-Original-From: Yury Norov <ynorov@nvidia.com>
Date: Sun, 21 Jun 2026 09:39:17 -0400
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	Thomas Gleixner <tglx@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Julia Lawall <julia.lawall@inria.fr>,
	Yury Norov <yury.norov@gmail.com>, linux-doc@vger.kernel.org,
	linux-kbuild@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	dri-devel@lists.freedesktop.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-rdma@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-nfs@vger.kernel.org, kvm@vger.kernel.org,
	intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH 2/2] tracing: Add CONFIG_TRACE_PRINTK_DEBUGGING to clean
 up kernel.h
Message-ID: <ajfphe4Z8BrfYoUX@yury>
References: <20260621093430.264983361@kernel.org>
 <20260621093811.168514984@kernel.org>
 <20260621054721.7cde38f0@fedora>
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
In-Reply-To: <20260621054721.7cde38f0@fedora>

On Sun, Jun 21, 2026 at 05:47:21AM -0400, Steven Rostedt wrote:
> On Sun, 21 Jun 2026 05:34:32 -0400
> Steven Rostedt <rostedt@kernel.org> wrote:
> 
> > Instead of having trace_printk.h included in kernel.h, create a config
> > TRACE_PRINTK_DEBUGGING that when set will update the CFLAGS in the
> > Makefile to allow developers to add trace_printk() without the need to add
> > the include for it. Having it included in the Makefile keeps it from being
> > in the dependency chain and it will not waste extra CPU cycles for those
> > building the kernel without using trace_printk.
> 
> Bah, I only tested with the config option enabled, and missed some
> dependencies with it disabled.

Yes you did.
 
> For instance, rcu.h also uses ftrace_dump() so that too needs to go
> into kernel.h.

No, it shouldn't.

> I also need to add a few more includes to trace_printk.h.

> OK, I need to run this through all my tests to find where else I missed
> adding the includes. But the idea should hopefully satisfy everyone.

If you include it under config in kernel.h, to make the kernel buildable,
you need to include trace_printk.h explicitly where it's actually used.
IOW, apply my patch v4-7.

Then, developers who use trace_printk() on their development machine,
will be really frustrated when their debugging code will break client
build just because CONFIG_TRACE_PRINTK_DEBUGGING is disabled there.
They will spend a day, at best, communicating with remote managers,
and end up with adding #include <linux/trace_printk.h> in the files
they touch. Is that your plan?

If I was one of those developers, the solution would be simple for me:
don't use trace_printk() at all.

Thanks,
Yury

