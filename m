Return-Path: <SRS0=xr3w=PS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA08C43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 17:17:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7944120874
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 17:17:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7944120874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43bCNB4vV2zDqM3
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 04:16:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.160.194; helo=mail-qt1-f194.google.com;
 envelope-from=arndbergmann@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arndb.de
Received: from mail-qt1-f194.google.com (mail-qt1-f194.google.com
 [209.85.160.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43bCL44WvZzDq5g
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jan 2019 04:15:08 +1100 (AEDT)
Received: by mail-qt1-f194.google.com with SMTP id p17so14062411qtl.5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jan 2019 09:15:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Vi+SvwsycUKtGhpMC3QEpN/Bk6bKq1AfTBDWYF1k7VQ=;
 b=ijy9UaJb9pJGJoCAkKy5VEiPxL1AqJhfHM8cIxPiPq8MQWBO4LNaPTGYuLOArDQ/Ox
 ALl2idsVfgnVUp30CWSctAimRcg3aajoX6lXZGV+ZKBPmSmUwFXN5dxBsTWE495JvVcw
 zE1jp9dVJNM2u+/exch3fuF4cjBv16NFUvV3V+yc3KggxAuXzbdDcbx9FlJLcBMAbs4i
 VKF1nhaJ+NveHiCh2IT9BrOf27GjVp4YGzRTeuwo3U0uxLa26VDesrvW6UVWKXY0A0gM
 H1smH8siqQFORKTHjqp/5P04OulN347F+SLqKFrFIJ1Q0SAS4siFWHpTP7SIeQWwR6Nw
 WOKQ==
X-Gm-Message-State: AJcUukcEZiG0SQ+epWjcQd0pZLO8R7vvOOpUwSTfbPtkZXkV+Ml3cx94
 23SeuYEbIN1LULdek/cNO83kMaq+xTFRU6ixGv8=
X-Google-Smtp-Source: ALg8bN4AdylggnguSr7egu7xIPGdOjTe436nAOiytiob3A7SfzgpinZUkBcCe85tXDNMw1nvzwC1nAoiCh7sWU6vHE4=
X-Received: by 2002:ac8:1d12:: with SMTP id d18mr10355152qtl.343.1547140506273; 
 Thu, 10 Jan 2019 09:15:06 -0800 (PST)
MIME-Version: 1.0
References: <20190110162435.309262-1-arnd@arndb.de>
 <20190110162435.309262-8-arnd@arndb.de>
 <20190110163908.GC31683@fuggles.cambridge.arm.com>
In-Reply-To: <20190110163908.GC31683@fuggles.cambridge.arm.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 10 Jan 2019 18:14:50 +0100
Message-ID: <CAK8P3a27hYDL+yjO+DFe8n_C_dyjGNKcKOcWz-p3Pc1LwcxKjw@mail.gmail.com>
Subject: Re: [PATCH 07/15] ARM: add kexec_file_load system call number
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

On Thu, Jan 10, 2019 at 5:39 PM Will Deacon <will.deacon@arm.com> wrote:
>
> > diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
> > index 355fe2bc035b..19f3f58b6146 100644
> > --- a/arch/arm64/include/asm/unistd32.h
> > +++ b/arch/arm64/include/asm/unistd32.h
> > @@ -823,6 +823,8 @@ __SYSCALL(__NR_rseq, sys_rseq)
> >  __SYSCALL(__NR_io_pgetevents, compat_sys_io_pgetevents)
> >  #define __NR_migrate_pages 400
> >  __SYSCALL(__NR_migrate_pages, sys_migrate_pages)
> > +#define __NR_kexec_file_load 401
> > +__SYSCALL(__NR_kexec_file_load, sys_kexec_file_load)
>
> Hmm, I wonder if we need a compat wrapper for this, or are we assuming
> that the early entry code has already zero-extended the long and pointer
> arguments?

Yes, that is generally the assumption for compat syscalls.

s390 needs some extra magic to do a 31-to-64 extension on pointer
arguments, and I think sometimes we need a special wrapper to
do sign-extension of 32-bit arguments into 64-bit, but the arguments
here should not need that.

     Arnd
