Return-Path: <SRS0=xHiI=PX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF25C43387
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 15:21:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BECD620989
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 15:21:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BECD620989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43fDZt5y8nzDqch
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 02:21:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.222.193; helo=mail-qk1-f193.google.com;
 envelope-from=arndbergmann@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arndb.de
Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com
 [209.85.222.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43fDWt65NCzDqN9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jan 2019 02:19:06 +1100 (AEDT)
Received: by mail-qk1-f193.google.com with SMTP id c21so1733155qkl.6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jan 2019 07:19:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OFGD7PXuhpa61ZNV+Dxzw50BERwu8kM4CC/gfLY4p9U=;
 b=MHtmMAG71IUGedUOrYPUfgfZh4nAvF++arD6pY1TT6CjU6d+aJE0sncWgaO+5376Il
 cVKRlzrhHQPMi6dJV3zDbnjUfVUynsMQ3PStWKzv3PFUHQ9X1RDjhLWLf/4wMF0Yz7JZ
 rMPVATmNt5hs8cDHerdIDNulEEUp8ZNYJ85zKuZYsG+dFJuUmTwHqHYJiW5QpU/BC2ZC
 keFjAEgwUzUUhnjQaSRDEA0+ec6X1P/xLRJB0g2C2HNMGBOaDJYEJVcjvB+Z4OC95aFW
 TbR/SUYbqyDAGYaapUYM40INatdmEL00QDEHaxvTfYOpYaVqKG6SZyYvANsHBaoSYDKe
 2jHQ==
X-Gm-Message-State: AJcUukd+CZqwN3nMApKR3flyhfqvXuAsVpO3vMlN3DD/VWNMlBCmIjAf
 rY9FG1P+O6MJymeH24cmSRPXRFnW7uBI0HTNiec=
X-Google-Smtp-Source: ALg8bN5li7wBTklauFcVKrMtYE7+j8exj0sCThMZxxkRVYqsdAVuAfN8FZb6/7OCIQd/h7bJ0hMXGi+Oq4K6cLzGY0s=
X-Received: by 2002:ae9:d8c2:: with SMTP id u185mr2951683qkf.107.1547565544568; 
 Tue, 15 Jan 2019 07:19:04 -0800 (PST)
MIME-Version: 1.0
References: <20190110162435.309262-1-arnd@arndb.de>
 <20190110162435.309262-15-arnd@arndb.de>
 <87pnsz28k2.fsf@concordia.ellerman.id.au>
 <CAK8P3a0uas76i2W1yjFvxHT-2=A8_egUZeAUM-Vya6386+87Xg@mail.gmail.com>
In-Reply-To: <CAK8P3a0uas76i2W1yjFvxHT-2=A8_egUZeAUM-Vya6386+87Xg@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 15 Jan 2019 16:18:48 +0100
Message-ID: <CAK8P3a3eUzGDrJtV2ySpgHwjKHwZYr+1xHp6tChCt1gWi=mJ+g@mail.gmail.com>
Subject: Re: [PATCH 14/15] arch: add split IPC system calls where needed
To: Michael Ellerman <mpe@ellerman.id.au>
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
 Fenghua Yu <fenghua.yu@intel.com>, Will Deacon <will.deacon@arm.com>,
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

On Tue, Jan 15, 2019 at 4:01 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Jan 14, 2019 at 4:59 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
> > Arnd Bergmann <arnd@arndb.de> writes:
> > >  arch/m68k/kernel/syscalls/syscall.tbl     | 11 +++++++++++
> > >  arch/mips/kernel/syscalls/syscall_o32.tbl | 11 +++++++++++
> > >  arch/powerpc/kernel/syscalls/syscall.tbl  | 12 ++++++++++++
> >
> > I have some changes I'd like to make to our syscall table that will
> > clash with this.
> >
> > I'll try and send them today.
>
> Ok. Are those for 5.0 or 5.1? If they are intended for 5.0, it would be
> nice for me to have a branch based on 5.0-rc1 that I can put
> the other patches on top of.

There is also another change that I considered:

At the end of my series, we have a lot of entries like

245     32      clock_settime                   sys_clock_settime32
245     64      clock_settime                   sys_clock_settime
245     spu     clock_settime                   sys_clock_settime

which could be folded into

245     32      clock_settime                   sys_clock_settime32
245     spu64 clock_settime                   sys_clock_settime

if we just add another option to the ABI field. Any thoughts on
that?

      Arnd
