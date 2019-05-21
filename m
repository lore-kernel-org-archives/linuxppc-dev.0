Return-Path: <SRS0=oIc7=TV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C0FC072B5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 May 2019 20:32:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A40902173E
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 May 2019 20:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="E9cuWHFC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A40902173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 457nVz6z9KzDqQK
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 May 2019 06:32:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linuxfoundation.org
 (client-ip=2a00:1450:4864:20::243; helo=mail-lj1-x243.google.com;
 envelope-from=torvalds@linuxfoundation.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org
 header.b="E9cuWHFC"; dkim-atps=neutral
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com
 [IPv6:2a00:1450:4864:20::243])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 457nTQ6JpKzDqLL
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 May 2019 06:30:50 +1000 (AEST)
Received: by mail-lj1-x243.google.com with SMTP id e13so17060645ljl.11
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 May 2019 13:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mwA8SKkNo0NB1BSSFbQlGkhBkIi6dkzdh19hX1ggqqc=;
 b=E9cuWHFCD4Bgx1lOv97Ctr9bLKO3EjHQDpiZyM5FZUFuOxpsSHENK8V3oPkAEWY2CT
 4OwJ0l1afyS0KlYgZEStFftLyE7H7JbMd/BnYgfS8lVdq73pcYKuqkBJcrl7o7GLJZCx
 7466NcnIhfaDTvK1H+iwihEveSzhyKGC/2Zgk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mwA8SKkNo0NB1BSSFbQlGkhBkIi6dkzdh19hX1ggqqc=;
 b=Y9Os4FTZcffym7SADxtBKayJkDlamSgf5lOT7ACMjhPrmaD9MmiUABMDUk6d8aH0IR
 nX+q18tsowuUx04ryu96Zq0bJjFsCnFk4Em1MH+39BhmjHorWqJEyX67otMHemQBpNlk
 2FeSxpFZPVjZLsmGfTTMFbXDU49skO83ye0Pn8r/XHtq95Z7+xrEKA5NdkwN9a6f5C02
 c6J3FwKyclaL7UeloNSNBJxB7gKzLt1KJ0equpPJRIXNtCJtjhzWPa3yY5R5LgP4iBOB
 7HsENFtFR6YT5HfHf6E+kpktHne7dXkm/6kyb66q4tFRpyKRj9XQkIAaMIJFuUR7LJd6
 O2Ww==
X-Gm-Message-State: APjAAAXobTyZXw+4K0QB9Kqbp1mdujvvedPlUm1oAxVIMj47xiIsCGi1
 OIWjZ+FJ8wxYxS14y5Ctht8jTSsr1Ug=
X-Google-Smtp-Source: APXvYqxpVkGjz7NiXqT8vQOhZF0x28xHlV2+cld5zP5zi4VcQMblwY0xddU0k7txd2c+aeVrmO5xqw==
X-Received: by 2002:a2e:86c2:: with SMTP id n2mr9809040ljj.23.1558470645524;
 Tue, 21 May 2019 13:30:45 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com.
 [209.85.208.177])
 by smtp.gmail.com with ESMTPSA id c189sm4902887lfd.10.2019.05.21.13.30.45
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 21 May 2019 13:30:45 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id z5so17076822lji.10
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 May 2019 13:30:45 -0700 (PDT)
X-Received: by 2002:a2e:2f03:: with SMTP id v3mr4725518ljv.6.1558470208997;
 Tue, 21 May 2019 13:23:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190521150006.GJ17978@ZenIV.linux.org.uk>
 <20190521113448.20654-1-christian@brauner.io>
 <28114.1558456227@warthog.procyon.org.uk>
 <20190521164141.rbehqnghiej3gfua@brauner.io>
In-Reply-To: <20190521164141.rbehqnghiej3gfua@brauner.io>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 21 May 2019 13:23:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgtHm4t71oKbykE=awiVv2H2wCy8yH0L_FsyhHQ5OSO+Q@mail.gmail.com>
Message-ID: <CAHk-=wgtHm4t71oKbykE=awiVv2H2wCy8yH0L_FsyhHQ5OSO+Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] open: add close_range()
To: Christian Brauner <christian@brauner.io>
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
Cc: linux-ia64@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>,
 Oleg Nesterov <oleg@redhat.com>, David Howells <dhowells@redhat.com>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 sparclinux@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 linux-arch <linux-arch@vger.kernel.org>,
 linux-s390 <linux-s390@vger.kernel.org>, Miklos Szeredi <miklos@szeredi.hu>,
 the arch/x86 maintainers <x86@kernel.org>, linux-mips@vger.kernel.org,
 linux-xtensa@linux-xtensa.org, tkjos@android.com,
 Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 Al Viro <viro@zeniv.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>,
 "Dmitry V. Levin" <ldv@altlinux.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Florian Weimer <fweimer@redhat.com>, linux-parisc@vger.kernel.org,
 Linux API <linux-api@vger.kernel.org>,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 alpha <linux-alpha@vger.kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, May 21, 2019 at 9:41 AM Christian Brauner <christian@brauner.io> wrote:
>
> Yeah, you mentioned this before. I do like being able to specify an
> upper bound to have the ability to place fds strategically after said
> upper bound.

I suspect that's the case.

And if somebody really wants to just close everything and uses a large
upper bound, we can - if we really want to - just compare the upper
bound to the file table size, and do an optimized case for that. We do
that upper bound comparison anyway to limit the size of the walk, so
*if* it's a big deal, that case could then do the whole "shrink
fdtable" case too.

But I don't believe it's worth optimizing for unless somebody really
has a load where that is shown to be a big deal.   Just do the silly
and simple loop, and add a cond_resched() in the loop, like
close_files() does for the "we have a _lot_ of files open" case.

                   Linus
