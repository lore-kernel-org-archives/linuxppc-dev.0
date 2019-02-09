Return-Path: <SRS0=dqXl=QQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFF8C169C4
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 Feb 2019 00:12:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E27120869
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 Feb 2019 00:12:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LbLALWqm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E27120869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43xCCx3FPBzDqZb
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 Feb 2019 11:12:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linuxfoundation.org
 (client-ip=2a00:1450:4864:20::241; helo=mail-lj1-x241.google.com;
 envelope-from=torvalds@linuxfoundation.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org
 header.b="LbLALWqm"; dkim-atps=neutral
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com
 [IPv6:2a00:1450:4864:20::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43xCB92LG0zDqZQ
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Feb 2019 11:10:40 +1100 (AEDT)
Received: by mail-lj1-x241.google.com with SMTP id f21-v6so3005622ljj.8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 08 Feb 2019 16:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=esUN0eAUy4YWkP+bozuSr/XyV8kG31d8rYJRedvgykU=;
 b=LbLALWqmuur3vFRa25JFyrgBoAdC34KiufM5BZY6FVjl/WYfmGblutfsjwJLgcnL2s
 7WfLx0BMAxPDJUxhk3YWwQvooGaab1y8eWCVbR4BtrKqYJ8QmykyrhzkiPDRsWkCWKX2
 tpgX9WKhMrvACLp3JH8Bq642be3K34aaxe+NA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=esUN0eAUy4YWkP+bozuSr/XyV8kG31d8rYJRedvgykU=;
 b=GQEITc8/FGrV/zzen/gDFmwlnQuHO4RhZ6m1FPBCl4AhhuqPwXTFZ7zbpGtnU87ogj
 UFnfo93SSYHnsyGyKgxQc0wy3JUejhFecFU2hP9xpc5Pi3CGCJLyUnLZM6CN0QDfwi4U
 LJG2J1SynAGwdDc2SV4gjvAGaLiQX9w68cYnNA1dk1mJfaw6sCy4huirDtqA8IGwPIAq
 +GfiCtPCmJ2elGlB1wuKdaf8lz8Yogqq3hIcWw6q/9TsGiVKQjU1zWxSOStLFM2a9FEK
 rik8j3PRRzZMWBbJK4waCW4f89XBqJZ48FLuiP5sEedletnS3JuQH4unfO48od+CIJl9
 hHmA==
X-Gm-Message-State: AHQUAuYAmHYUYYXTBFbm+W/JY51j7vXM4W62PGHr6+gH3r1mdJl7msci
 BLqIK6mK96XVWZU1bwKCKXi+2wQK9/k=
X-Google-Smtp-Source: AHgI3IZUkby5SJ/j7wiFcQFnd17HK5mGJ6innG9DLytZJDZ+KrPj/cLe49ZGVbpJB/kVn6EMxOr2dg==
X-Received: by 2002:a2e:8808:: with SMTP id
 x8-v6mr14903117ljh.190.1549671036336; 
 Fri, 08 Feb 2019 16:10:36 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com.
 [209.85.167.47])
 by smtp.gmail.com with ESMTPSA id f16-v6sm702833lji.88.2019.02.08.16.10.35
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 08 Feb 2019 16:10:36 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id f5so3789315lfc.13
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 08 Feb 2019 16:10:35 -0800 (PST)
X-Received: by 2002:ac2:4191:: with SMTP id z17mr14867539lfh.117.1549670639775; 
 Fri, 08 Feb 2019 16:03:59 -0800 (PST)
MIME-Version: 1.0
References: <1549566446-27967-1-git-send-email-longman@redhat.com>
 <CAHk-=wjfyrFBjifzmgMVrkrvEePEPaBTDq7D=f2i5kD2E=SqRQ@mail.gmail.com>
 <d7476dfb-1653-747b-b865-5597ba5fc1c1@redhat.com>
In-Reply-To: <d7476dfb-1653-747b-b865-5597ba5fc1c1@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 8 Feb 2019 16:03:43 -0800
X-Gmail-Original-Message-ID: <CAHk-=whzAGRJQE43NHaC8sCECLr-QnpHYst+TJq-qhfp9eK-Qw@mail.gmail.com>
Message-ID: <CAHk-=whzAGRJQE43NHaC8sCECLr-QnpHYst+TJq-qhfp9eK-Qw@mail.gmail.com>
Subject: Re: [PATCH-tip 00/22] locking/rwsem: Rework rwsem-xadd & enable new
 rwsem features
To: Waiman Long <longman@redhat.com>
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
Cc: linux-arch <linux-arch@vger.kernel.org>, linux-xtensa@linux-xtensa.org,
 Davidlohr Bueso <dave@stgolabs.net>, linux-ia64@vger.kernel.org,
 Tim Chen <tim.c.chen@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>,
 Linux-sh list <linux-sh@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, linux-hexagon@vger.kernel.org,
 the arch/x86 maintainers <x86@kernel.org>, Will Deacon <will.deacon@arm.com>,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 "H. Peter Anvin" <hpa@zytor.com>, linux-alpha@vger.kernel.org,
 sparclinux@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Feb 8, 2019 at 12:31 PM Waiman Long <longman@redhat.com> wrote:
>
> >  (b) what's the new fastpath case
>
> The only change in the fastpath is the use of cmpxchg for writer lock.

.. since a big deal here was about using the generic atomic accessor
functions, I really was looking forward to seeing the *actual* fast
path code generation.

In other words, right now I have very little visibility in how it
actually affects the code. Looking at the patches themselves doesn't
make it obvious. I was hoping for the overview to really explain the
whole "before and after" situation, and it didn't. Not at the high
level, and not at a low level. And no performance numbers in the
overview either.

And yes, I see the numbers in the patches, but what I really hoped for
was some real load numbers. In particular, I would have loved to see
numbers from th ekernel test robot "will-it-scale.per_thread_ops"
case, which is the one that had a 65% regression due to the lack of
reader spinning.

So I was kind of hoping to hear whether that regression is basically
entirely gone with this patch series, or if we still have a regression
due to the extra downgrade, or what?

                 Linus
