Return-Path: <linuxppc-dev+bounces-19932-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE523F94CDB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Apr 2026 07:32:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g0rXK37Fpz2yZN;
	Wed, 22 Apr 2026 17:32:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776843137;
	cv=none; b=oFyMRt5vIm0t6Gz60YkrvJjTxtUc7KVRRKQnRuxThNyBUCYVUBSMQVSWLwOX7eQtpitETDy5lzSn3vUMUL931MVQhDJW/y87jmLF9jXEWfukP2YyIESbI1Toy9AJQBLahJtbbnnDi0qsK8W7H7jRcY7Y8f8WPcgT3bGTsh09YnuY59gfsEcNzBuqz7+Z+pMTM0/4euJOx5Nel+O6WFT/vgbD24FDS6Xt9kB17jPgRbAxcZK4dxIjOEpsYrnHGvoskZ7yoX7UirqxXUxA9MoFaEWdiIjLydMbLfAZXzp8+aqLphsSSewbvncrMovhKmXcvFDXWrazYTj+I51Pf1cNYA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776843137; c=relaxed/relaxed;
	bh=nqWPSH9orhqk1QAO9hwmlkYDMAf9Dazei8dWQ2yLik0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hQ87/y3AMXPvb4PQY59rVsuVyeLIaD0BmC46pq1H6xdPunEiLI7AF7yULSIIbVRdEAjel4wOR8hGR939j+OoP7Rj8OGobeSL+/9oTUqeHxQsZiTSGOHEbEBA6w2v6adYEU29dQGUunq0F0zI/3ZCxAHYgrFnBGkDBOMC9iNawGhCPPca9J0QBL9SmxpLwg5nZXrJfT2Kys/D1+fkpQk+iqjvb7l1nWo9m2Sp8oPLgtWBMFXSV0GnBEsyWPbdvnbGOwlq7WEBuAMwqou4yDDAfZzFQxYJ2BQ6IIf6UFqZph269Ll2/4YL4zoF+7BvW/+kC4dqtNx/4GVQlTe48oCa4g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=HGuqX591; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=vA6bVzJf; dkim-atps=neutral; spf=pass (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=HGuqX591;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=vA6bVzJf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g0rXJ3wjbz2xSN
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2026 17:32:16 +1000 (AEST)
Date: Wed, 22 Apr 2026 09:32:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1776843131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nqWPSH9orhqk1QAO9hwmlkYDMAf9Dazei8dWQ2yLik0=;
	b=HGuqX591fOx4yUoKbPFM3AFnEj4TNUtdJlqS+09QNrk+lg6EdJ54hu0hlVKN9TC//Dlb/B
	z9yH4pYM6L62+z/gkWjipQflovPh3Oa/xEF1N+j+y2xTjOTqMOEPbWaxmniMSiLlXtsfX/
	HZuudN0IQpcRD+DnLrzVQ/ZoSoDVwstsv8/LLrZFEsO+A7ZdG2/HtljUDkAgkwcdW9jHa6
	bLRPitpEl2B+or7HlfZHV2Xh6UWQFOLA264zEm+aoj1RtROfTLHu9eZ/4HIK09RNlygdDp
	E4sAlAMH/7rgRYiKYn9gW2QvyiRzgJxilh7GS8AVmz0tkai8d7+IuH3xssRiMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1776843131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nqWPSH9orhqk1QAO9hwmlkYDMAf9Dazei8dWQ2yLik0=;
	b=vA6bVzJf/I9G8QEzLBWv5aZcIXcu70EFV/3tqET1xHv2nKF+Jj51HQlj7efTfkGBhadOmY
	b/J/+85f8+H7QcDA==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: linux-arm-kernel@lists.infradead.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: New warning in linus/master
Message-ID: <20260422092713-4021a1a5-3a54-4260-878a-aec1bef3f8c7@linutronix.de>
References: <CANiDSCsOy0P1if-gJZqOM5pTJ0RDcwVfru1B7KFbTOEMqjPKJw@mail.gmail.com>
 <20260422071541-9a295128-d913-418f-a21c-1386fca30290@linutronix.de>
 <CANiDSCviww1L1p2+MvF59Biqb6hc7WdL1J37kBjFd1NXz-Yt8A@mail.gmail.com>
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
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiDSCviww1L1p2+MvF59Biqb6hc7WdL1J37kBjFd1NXz-Yt8A@mail.gmail.com>

On Wed, Apr 22, 2026 at 03:00:11PM +0800, Ricardo Ribalda wrote:
> On Wed, 22 Apr 2026 at 13:57, Thomas Weißschuh
> <thomas.weissschuh@linutronix.de> wrote:
> > On Wed, Apr 22, 2026 at 11:51:45AM +0800, Ricardo Ribalda wrote:
> > > Media-CI has found a couple of new warnings in the latest kernel
> > > version for aarch64 and powerpc. They get fixed with this patch and
> > > before moving I wanted to know if this was under your radar.
> >
> > Thanks for the report. I was not aware of these so far.
> >
> > > diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
> > > index 7dec05dd33b7..65914842fae0 100644
> > > --- a/arch/arm64/kernel/vdso/Makefile
> > > +++ b/arch/arm64/kernel/vdso/Makefile
> > > @@ -50,7 +50,7 @@ CFLAGS_vgettimeofday.o = $(CC_FLAGS_ADD_VDSO)
> > >  CFLAGS_vgetrandom.o = $(CC_FLAGS_ADD_VDSO)
> > >
> > >  ifneq ($(c-gettimeofday-y),)
> > > -  CFLAGS_vgettimeofday.o += -include $(c-gettimeofday-y)
> > > +  CFLAGS_vgettimeofday.o += -include $(c-gettimeofday-y)
> > > -Wno-maybe-uninitialized
> > >  endif
> >
> > (...)
> >
> > I'd like to know exactly what is going on before suppressing the warning.
> > It is a non-standard warning, only enabled by *some* of the vDSO builds
> > for some reason.
> >
> > > https://gitlab.freedesktop.org/linux-media/users/ribalda/-/pipelines/1649144/test_report?job_name=cross-gcc
> >
> > While I was able to download a configuration from this job and also use the
> > same container image, I can not reproduce the issue. Is the configuration the
> > full one or only the template?
> >
> > Could you provide full reproduction steps?
> 
> You can try repro with:
> 
> work/linux $ podman run -v .:/workdir/ --rm -it
> registry.freedesktop.org/linux-media/media-ci/build:latest
> $ cd /workdir
> $ CROSS_COMPILE=aarch64-linux-gnu- ARCH=arm64 make allyesconfig
> $ CROSS_COMPILE=aarch64-linux-gnu- ARCH=arm64 make
> arch/arm64/kernel/vdso/vgettimeofday.o
> 
> The gcc version discrepancy is because I the error was due to old gcc
> version and I was playing around with that... but it fails in both
> gcc14 and gcc15

Ack.

> You can try with debian testing with
> work/linux$ podman run -v .:/workdir/ --rm -it debian:testing
> $ apt-get update
> $ apt-get install gcc-aarch64-linux-gnu build-essential flex bison libssl-dev bc
> $ cd /workdir
> $ CROSS_COMPILE=aarch64-linux-gnu- ARCH=arm64 make allyesconfig
> $ CROSS_COMPILE=aarch64-linux-gnu- ARCH=arm64 make
> arch/arm64/kernel/vdso/vgettimeofday.o

Both reproducers do *not* reproduce the issue for me.
(It is more or less exactly what I tried before)

Please note that this line does not work in general:
$ CROSS_COMPILE=aarch64-linux-gnu- ARCH=arm64 make arch/arm64/kernel/vdso/vgettimeofday.o

The vDSO object files can not be built in this way like regular kernel object
files and will produce a compiler error, but not the one under discussion.
Instead the vDSO on arm64 is built during the 'make prepare' phase.
(Other architectures work differently, of course...)

(...)


Thomas

