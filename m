Return-Path: <SRS0=xr3w=PS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB63FC43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 17:08:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EAA320685
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 17:08:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EAA320685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43bC9z2h1bzDqsM
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 04:08:07 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 43bC845gMxzDq5g
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jan 2019 04:06:28 +1100 (AEDT)
Received: by mail-qt1-f193.google.com with SMTP id t33so13998886qtt.4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jan 2019 09:06:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ppZcVQ/6kEa1+6j6RgrBmmjrAAts0gpmQru81oI2DjY=;
 b=NitfHHghEDulNF5d3KwAhV9BSwyP3E/ztBoqCMkU+FppbHiQh2eh6Qi6fYMXkja7tk
 XCtmwG8l9gCrXkuUNGAvNDHS5sp1u8zQWLmTpI3cajgvy7KHP90Cr1Pn+0ihvVpjG5X/
 ocsiUFXK0uVpgq0v96N1pawfbjbGQnmeEPLvTeq4rRXcRsv/C8pPFAMWPa9e8/04WC9g
 ddSVmY6SfVZpTh2e+Qu6QrdbX/ZMwmFtI+PVbQjGkWJ3kzECpW2JqbojAvGZ73tMFFAV
 jR4NImAebgX+7G9QdUlIkYWdoEmc9nfAJ3EWwDYm1NCLoM364YwNw8FoPDN0sLMb1bHZ
 tn5A==
X-Gm-Message-State: AJcUukca67SevbtuiiWgZdHKmixMTYViC930t67hpO5O60+Z9uRAv8hS
 9p0FKoIrVqkek/gon4aDLGna0kWdUm/mTRNR1ak=
X-Google-Smtp-Source: ALg8bN6AYimQvL2fk3CyhFYbTwHueixsV0cppMAFEDILJ7f9F0R4jNkQXt8J3yrK7O3RY2Kukmp6QEA1Mn21OLb0A00=
X-Received: by 2002:a0c:e202:: with SMTP id q2mr10276671qvl.180.1547139986093; 
 Thu, 10 Jan 2019 09:06:26 -0800 (PST)
MIME-Version: 1.0
References: <20190110162435.309262-1-arnd@arndb.de>
 <CAMuHMdXYP3=TRHYqddVRfbRRaj_Ou=wfoX6ohKM7XNAx-c2RXw@mail.gmail.com>
In-Reply-To: <CAMuHMdXYP3=TRHYqddVRfbRRaj_Ou=wfoX6ohKM7XNAx-c2RXw@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 10 Jan 2019 18:06:09 +0100
Message-ID: <CAK8P3a0kmr2ju+sZE+f-+=-2t5Eu+t-DS-+r6OKrPVTAxHwf8w@mail.gmail.com>
Subject: Re: [PATCH 00/15] arch: synchronize syscall tables in preparation for
 y2038
To: Geert Uytterhoeven <geert@linux-m68k.org>
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
Cc: Rich Felker <dalias@libc.org>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 Linux-sh list <linux-sh@vger.kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Dominik Brodowski <linux@dominikbrodowski.net>, linux-mips@vger.kernel.org,
 Max Filippov <jcmvbkbc@gmail.com>, Deepa Dinamani <deepa.kernel@gmail.com>,
 "H. Peter Anvin" <hpa@zytor.com>, sparclinux <sparclinux@vger.kernel.org>,
 linux-s390 <linux-s390@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
 y2038 Mailman List <y2038@lists.linaro.org>, Helge Deller <deller@gmx.de>,
 the arch/x86 maintainers <x86@kernel.org>,
 Russell King <linux@armlinux.org.uk>, Ingo Molnar <mingo@redhat.com>,
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
 "Eric W. Biederman" <ebiederm@xmission.com>,
 alpha <linux-alpha@vger.kernel.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Jan 10, 2019 at 5:59 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Arnd,
>
> On Thu, Jan 10, 2019 at 5:26 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > The system call tables have diverged a bit over the years, and a number
> > of the recent additions never made it into all architectures, for one
> > reason or another.
> >
> > This is an attempt to clean it up as far as we can without breaking
> > compatibility, doing a number of steps:
>
> Thanks a lot!
>
> > - Add system calls that have not yet been integrated into all
> >   architectures but that we definitely want there.
>
> It looks like you missed wiring up io_pgetevents() on m68k.
> Is that intentional?

Yes, I thought I had described that somewhere but maybe I
forgot: semtimedop() and io_pgetevents() get replaced with
time64 versions in the follow-up, so I only added them in
64-bit architectures. If you think we should have both
io_pgetevents() and io_pgetevents_time32() on all 32-bit
architectures, I can add that as well.

      Arnd
