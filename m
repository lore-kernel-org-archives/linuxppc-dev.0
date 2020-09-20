Return-Path: <SRS0=1NAR=C5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 955A0C43465
	for <linuxppc-dev@archiver.kernel.org>; Sun, 20 Sep 2020 17:02:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8686720EDD
	for <linuxppc-dev@archiver.kernel.org>; Sun, 20 Sep 2020 17:02:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJKTktW4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8686720EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BvYm64kZczDqdP
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Sep 2020 03:02:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=luto@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=default header.b=gJKTktW4; dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BvYhn3MB7zDqZ3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2020 02:59:53 +1000 (AEST)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2B77E23600
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 Sep 2020 16:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600621190;
 bh=x0CbGoy7QDKeuRiDyZ0r+bpumnscmCVOPI/85NlktW8=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=gJKTktW4SZM9Nk5DOVt1OrRoD5xvcMTHGvsORGcnvvYrrRwkT7FctEN7F9OgfkMkf
 go8qh4j37RWcESJvMJRLehEaF3oKhwPYJJdJDts/+toGi7k1LIglAiuuVrdC6I4+Xp
 /LzZmxNyVgp/8l8nI8i/3m9FhkW6jCz/eC4EQY4Q=
Received: by mail-wm1-f44.google.com with SMTP id z9so10231124wmk.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 Sep 2020 09:59:50 -0700 (PDT)
X-Gm-Message-State: AOAM53194jGSbFK7FSvWSG0jBw2cGlwXjv4B86YIzUY6y081OzE88nvl
 khBBSQx6cq9eQawDYGY0LliXHhbwR/JEgaMiVzpNqQ==
X-Google-Smtp-Source: ABdhPJwqhOCovrDdCcRZECZNQYs8Sx/d9wwPnQKSY4d4VjHeXmP8XzKxWrTfmcwJ7rQVtp7oa0fbaMUpJAjukisl/1Y=
X-Received: by 2002:a1c:7e15:: with SMTP id z21mr25730921wmc.21.1600621188572; 
 Sun, 20 Sep 2020 09:59:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200919224122.GJ3421308@ZenIV.linux.org.uk>
 <36CF3DE7-7B4B-41FD-9818-FDF8A5B440FB@amacapital.net>
 <20200919232411.GK3421308@ZenIV.linux.org.uk>
 <CALCETrViwOdFia_aX4p4riE8aqop1zoOqVfiQtSAZEzheC+Ozg@mail.gmail.com>
 <20200920025745.GL3421308@ZenIV.linux.org.uk>
In-Reply-To: <20200920025745.GL3421308@ZenIV.linux.org.uk>
From: Andy Lutomirski <luto@kernel.org>
Date: Sun, 20 Sep 2020 09:59:36 -0700
X-Gmail-Original-Message-ID: <CALCETrWj1i-oyfA1rCXsNqdJddK6Vwm=W31YEf=k-OMBTC0vHw@mail.gmail.com>
Message-ID: <CALCETrWj1i-oyfA1rCXsNqdJddK6Vwm=W31YEf=k-OMBTC0vHw@mail.gmail.com>
Subject: Re: [PATCH 1/9] kernel: add a PF_FORCE_COMPAT flag
To: Al Viro <viro@zeniv.linux.org.uk>
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
Cc: linux-aio <linux-aio@kvack.org>,
 "open list:MIPS" <linux-mips@vger.kernel.org>,
 David Howells <dhowells@redhat.com>, Linux-MM <linux-mm@kvack.org>,
 keyrings@vger.kernel.org, sparclinux <sparclinux@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>, linux-arch <linux-arch@vger.kernel.org>,
 linux-s390 <linux-s390@vger.kernel.org>,
 Linux SCSI List <linux-scsi@vger.kernel.org>, X86 ML <x86@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, linux-block <linux-block@vger.kernel.org>,
 Andy Lutomirski <luto@kernel.org>, io-uring@vger.kernel.org,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Jens Axboe <axboe@kernel.dk>, Parisc List <linux-parisc@vger.kernel.org>,
 Network Development <netdev@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 LSM List <linux-security-module@vger.kernel.org>,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, Sep 19, 2020 at 7:57 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Sat, Sep 19, 2020 at 05:14:41PM -0700, Andy Lutomirski wrote:
>
> > > 2) have you counted the syscalls that do and do not need that?
> >
> > No.
>
> Might be illuminating...
>
> > > 3) how many of those realistically *can* be unified with their
> > > compat counterparts?  [hint: ioctl(2) cannot]
> >
> > There would be no requirement to unify anything.  The idea is that
> > we'd get rid of all the global state flags.
>
> _What_ global state flags?  When you have separate SYSCALL_DEFINE3(ioctl...)
> and COMPAT_SYSCALL_DEFINE3(ioctl...), there's no flags at all, global or
> local.  They only come into the play when you try to share the same function
> for both, right on the top level.

...

>
> > For ioctl, we'd have a new file_operation:
> >
> > long ioctl(struct file *, unsigned int, unsigned long, enum syscall_arch);
> >
> > I'm not saying this is easy, but I think it's possible and the result
> > would be more obviously correct than what we have now.
>
> No, it would not.  Seriously, from time to time a bit of RTFS before grand
> proposals turns out to be useful.

As one example, look at __sys_setsockopt().  It's called for the
native and compat versions, and it contains an in_compat_syscall()
check.  (This particularly check looks dubious to me, but that's
another story.)  If this were to be done with equivalent semantics
without a separate COMPAT_DEFINE_SYSCALL and without
in_compat_syscall(), there would need to be some indication as to
whether this is compat or native setsockopt.  There are other
setsockopt implementations in the net stack with more
legitimate-seeming uses of in_compat_syscall() that would need some
other mechanism if in_compat_syscall() were to go away.

setsockopt is (I hope!) out of scope for io_uring, but the situation
isn't fundamentally different from read and write.
