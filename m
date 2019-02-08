Return-Path: <SRS0=r06i=QP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55FDCC169C4
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 19:52:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C64B220855
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 19:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OyX0wzEF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C64B220855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43x5SL5wkxzDqZq
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 Feb 2019 06:52:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linuxfoundation.org
 (client-ip=2a00:1450:4864:20::142; helo=mail-lf1-x142.google.com;
 envelope-from=torvalds@linuxfoundation.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org
 header.b="OyX0wzEF"; dkim-atps=neutral
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com
 [IPv6:2a00:1450:4864:20::142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43x5Qf6KPvzDqT7
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Feb 2019 06:51:02 +1100 (AEDT)
Received: by mail-lf1-x142.google.com with SMTP id q11so3445649lfd.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 08 Feb 2019 11:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qOYQNrLIv4ghYg9cJs/kFayOVviMNWKea8x1M/btUwQ=;
 b=OyX0wzEFwz/6B3oUovySoSdj87UyroJwU08G3xNJoOnjsbu6Dq0hCgkf1L42WN6nW1
 jwoJPZp5H1TptNE7ujv4YSzeQ1S9iqAxD7F1/8fIrL0nE3FasZpSYcLqdNGwta+XmVQT
 r5DkKnmqomQZhOV3nS7bhb+cUUVEYNQaa28wc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qOYQNrLIv4ghYg9cJs/kFayOVviMNWKea8x1M/btUwQ=;
 b=NTotMvLgBnmmHSE7Uw/VNgGcYc5Y3A7HSNz3VxavswSYPLTDkCv7HYpK9eSk+ooDQx
 W2Km+rxSZTtPi3u5rQycsTyY7VtVZvDNteZPGpQH+anM8c9fr9PUcaILFor5c7AjuV36
 Vehfq8eiPv952OVX9Ajbhpv3gcWSV9UJnDuJBaox3m+jSgjwwCnqBlHP4366CR3wFlHU
 IE4hdjE0AVKNORYDrzh7Ydwsx6d6sg+ED3rq366Z03jB09Eet820kfcWGyoD4dNXehC3
 4KhvNi0+5/GEut+xncSxZVpwCCzMByKsRLDvXOPRc1BsRiE8IVkEQsXwH8gpF94gf84K
 4Zlw==
X-Gm-Message-State: AHQUAuaeQX/RfTEjF05tgOZ8IwSWh26f97V74ogA97jwnnej8RAF8Epk
 GgBEow14jCR0jm1L+f3QkBwqZjFA2SsJTA==
X-Google-Smtp-Source: AHgI3IZjLABqPUunxUCa2j27I36HJblO45jaXJdD77JygagQiBqrHphhM+fqSkUKtKZHt96SK8c0jQ==
X-Received: by 2002:ac2:41cf:: with SMTP id d15mr14367374lfi.14.1549655458515; 
 Fri, 08 Feb 2019 11:50:58 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com.
 [209.85.167.48])
 by smtp.gmail.com with ESMTPSA id m10-v6sm579835ljj.34.2019.02.08.11.50.56
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 08 Feb 2019 11:50:57 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id b20so3400210lfa.12
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 08 Feb 2019 11:50:56 -0800 (PST)
X-Received: by 2002:ac2:4191:: with SMTP id z17mr14335535lfh.117.1549655456495; 
 Fri, 08 Feb 2019 11:50:56 -0800 (PST)
MIME-Version: 1.0
References: <1549566446-27967-1-git-send-email-longman@redhat.com>
In-Reply-To: <1549566446-27967-1-git-send-email-longman@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 8 Feb 2019 11:50:40 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjfyrFBjifzmgMVrkrvEePEPaBTDq7D=f2i5kD2E=SqRQ@mail.gmail.com>
Message-ID: <CAHk-=wjfyrFBjifzmgMVrkrvEePEPaBTDq7D=f2i5kD2E=SqRQ@mail.gmail.com>
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

On Thu, Feb 7, 2019 at 11:08 AM Waiman Long <longman@redhat.com> wrote:
>
> This patchset revamps the current rwsem-xadd implementation to make
> it saner and easier to work with. This patchset removes all the
> architecture specific assembly code and uses generic C code for all
> architectures. This eases maintenance and enables us to enhance the
> code more easily.
>
> This patchset also implements the following 3 new features:
>
>  1) Waiter lock handoff
>  2) Reader optimistic spinning
>  3) Store write-lock owner in the atomic count (x86-64 only)

The patches are kind of hard to read, with most of them just doing
prep-work that doesn't necessarily matter to the big picture.

What I'd really like to see is

 (a) an overview of the new locking logic

 (b) what's the new fastpath case

 (c) some performance numbers

to explain the changes from a "this is the point of the whole
exercise" standpoint.

And yes, I realize that the lock handoff and optimistic spinning is a
big deal, since I've seen the same regression numbers that presumably
caused this effort to be resurrected. So it's not that I don't find
this intriguing and worthwhile, it's literally that I'd like a summary
not so much of the individual patches, but of the new model.

Please?

             Linus
