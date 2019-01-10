Return-Path: <SRS0=xr3w=PS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 079BEC43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 17:13:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 737C720874
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 17:13:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 737C720874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43bCJN16ZQzDqM3
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 04:13:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.160.193; helo=mail-qt1-f193.google.com;
 envelope-from=arndbergmann@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arndb.de
Received: from mail-qt1-f193.google.com (mail-qt1-f193.google.com
 [209.85.160.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43bCGV4QTnzDq5g
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jan 2019 04:12:02 +1100 (AEDT)
Received: by mail-qt1-f193.google.com with SMTP id u47so14039180qtj.6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jan 2019 09:12:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=h9Ub2IW9cySGL3QZFJM+qSZvbyYHJpNB32B/Hx6OxIg=;
 b=ZSc0t6qBghWuaehwQAMI34NA5q021lfCTPBKVquBZ4uoWp4U7Y3Rm6wRW6PQ17NEDd
 XMuayC7URl7S7CRqBy8pskBSiKQ/blHaMcRKEVB0dl+OCjkrfnv6HJfJrmKsbCOBYwNn
 32+QrYVqMdOjUyato58SKyMWljsQ7IPde5HrBumG85sgiT2ovW4lmbAivlVudrONOlHH
 owqE1qLBfBwSsizZsGfNLoZTG6gbUnJWmadLGz8u9tDbQyJ6omeRCjkl1YmNtTFK/Z1N
 3vpkdz08JI+de7rHcs/dzokkC76hmDJtnwIseP90Gl2QM671ClLxvIq6PuiLktG9os+S
 uzpA==
X-Gm-Message-State: AJcUukcHgmAFg6flGHandQ/X3K8Va4FrTqrS5m/odTaSBcE7y+JcS2Rg
 tVMs9ZgxLYV4ll2Sv1y3xHJlbtVgOpOyQ87TPxs=
X-Google-Smtp-Source: ALg8bN4Gur1wD3h0ELBSl0ybGvD7wc1qcQeOBkYMXly/Z0pb/J89D40WVoT3xz1IidS9G8IG/oXogEOscyYpZb29+TE=
X-Received: by 2002:a0c:d992:: with SMTP id y18mr10912612qvj.161.1547140320327; 
 Thu, 10 Jan 2019 09:12:00 -0800 (PST)
MIME-Version: 1.0
References: <20190110162435.309262-1-arnd@arndb.de>
 <20190110162435.309262-7-arnd@arndb.de>
 <20190110163220.GB31683@fuggles.cambridge.arm.com>
In-Reply-To: <20190110163220.GB31683@fuggles.cambridge.arm.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 10 Jan 2019 18:11:44 +0100
Message-ID: <CAK8P3a0TyDTTG7Eoz9dZF1J0SH-=OYQvQ6=YVThTkDfX-mnfWg@mail.gmail.com>
Subject: Re: [PATCH 06/15] ARM: add migrate_pages() system call
To: Will Deacon <will.deacon@arm.com>
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
Cc: Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org,
 Linux-sh list <linux-sh@vger.kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Dominik Brodowski <linux@dominikbrodowski.net>, linux-mips@vger.kernel.org,
 Max Filippov <jcmvbkbc@gmail.com>, Deepa Dinamani <deepa.kernel@gmail.com>,
 "H. Peter Anvin" <hpa@zytor.com>, sparclinux <sparclinux@vger.kernel.org>,
 linux-s390 <linux-s390@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
 y2038 Mailman List <y2038@lists.linaro.org>, Helge Deller <deller@gmx.de>,
 the arch/x86 maintainers <x86@kernel.org>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Firoz Khan <firoz.khan@linaro.org>, Matt Turner <mattst88@gmail.com>,
 Fenghua Yu <fenghua.yu@intel.com>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Michal Simek <monstr@monstr.eu>, Tony Luck <tony.luck@intel.com>,
 Parisc List <linux-parisc@vger.kernel.org>,
 Linux API <linux-api@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Paul Burton <paul.burton@mips.com>,
 "Eric W . Biederman" <ebiederm@xmission.com>,
 alpha <linux-alpha@vger.kernel.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 David Miller <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Jan 10, 2019 at 5:32 PM Will Deacon <will.deacon@arm.com> wrote:

> > diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
> > index 04ee190b90fe..355fe2bc035b 100644
> > --- a/arch/arm64/include/asm/unistd32.h
> > +++ b/arch/arm64/include/asm/unistd32.h
> > @@ -821,6 +821,8 @@ __SYSCALL(__NR_statx, sys_statx)
> >  __SYSCALL(__NR_rseq, sys_rseq)
> >  #define __NR_io_pgetevents 399
> >  __SYSCALL(__NR_io_pgetevents, compat_sys_io_pgetevents)
> > +#define __NR_migrate_pages 400
> > +__SYSCALL(__NR_migrate_pages, sys_migrate_pages)
>
> Should be compat_sys_migrate_pages instead?

Yes, good catch! Fixed now.

Thanks,

        Arnd
