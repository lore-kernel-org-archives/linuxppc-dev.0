Return-Path: <SRS0=gbiG=P5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE967C31684
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Jan 2019 17:10:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 100B820989
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Jan 2019 17:10:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 100B820989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43jyjQ4xGFzDqQb
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jan 2019 04:10:18 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 43jygW6L2rzDqK9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jan 2019 04:08:39 +1100 (AEDT)
Received: by mail-qt1-f193.google.com with SMTP id i7so24278417qtj.10
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Jan 2019 09:08:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=A3BFzNbMjDWWnmVRt1tolWRl8m0peBLC2YUEivt95tQ=;
 b=Ea3Vd0qZuPVXXM9e6aXKBLcQ3Uzo2YBOGVq2yH0OvJvCoh63QXj/+kg2Y5GGIUMHo9
 kF7GM0+/4Khx24o5+kC2QZbsDUzP0eNCZyP4XHeUIieQo4NAZTXubLVoD/8C0Wnxr0Tv
 aAYTpndVpMjNvTUd4CcrxKWPmT7oZ7EBUsKmu5cP12zNArAM5b/DAuPCOAL4cuSwzaZe
 tYDSls8w8thL0C9cgWd942msIqVBfamqDyY74lukkxvFFQXqLYNjpY8h5C+IznisK7CT
 tXOUOT4mHWAt9QuWWi8AS2aWVkDrLROWuoCDmTazOfDcukhOWrwp3affSsaolxnePtkK
 KUqA==
X-Gm-Message-State: AJcUukdn6sabfqmkd0Z1n7T1XNiCU0oLsLfNgQ5pr3UizWo/bCkrLyDA
 kSZtEHuzRDat53X4vlWmB6fAiSePUUQnSoBnxIo=
X-Google-Smtp-Source: ALg8bN7/DN0rP0JOEiYkuJ24jXW/SvkEYHpGox4RlM5iK+eeluX/kG/Kn+zKF5Ngogsr1NCH9MXedHfaxCnYfxa1vgY=
X-Received: by 2002:ac8:1d12:: with SMTP id d18mr27232408qtl.343.1548090517294; 
 Mon, 21 Jan 2019 09:08:37 -0800 (PST)
MIME-Version: 1.0
References: <20190118161835.2259170-1-arnd@arndb.de>
 <20190118161835.2259170-30-arnd@arndb.de>
 <CALCETrXqM5mhvwreN5y-9K99h1j9rs9MAVK-cNLC54s1fdHA6w@mail.gmail.com>
 <CAK8P3a0V+xboaGAF2nqrYtpjXXA7y0LcvCKi4ngLTus1D_XZBA@mail.gmail.com>
 <CALCETrWPj6dHEyo=AELoVjXGsiwuSpRp17x3CEWBHvp7i3cy+Q@mail.gmail.com>
 <20190119142852.cntdihah4mpa3lgx@e5254000004ec.dyn.armlinux.org.uk>
 <CAMuHMdXzQNEEDjWrmTph8Krovj1g2WhnBUaM=FvKB+J2fZqctA@mail.gmail.com>
In-Reply-To: <CAMuHMdXzQNEEDjWrmTph8Krovj1g2WhnBUaM=FvKB+J2fZqctA@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 21 Jan 2019 18:08:20 +0100
Message-ID: <CAK8P3a04UC2dHVqx1gHXJQzsDw446h1ghLEuRe0xmUyJgrOktw@mail.gmail.com>
Subject: Re: [PATCH v2 29/29] y2038: add 64-bit time_t syscalls to all 32-bit
 architectures
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
 Heiko Carstens <heiko.carstens@de.ibm.com>, linux-mips@vger.kernel.org,
 Max Filippov <jcmvbkbc@gmail.com>,
 Network Development <netdev@vger.kernel.org>,
 Deepa Dinamani <deepa.kernel@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>,
 sparclinux <sparclinux@vger.kernel.org>,
 linux-arch <linux-arch@vger.kernel.org>,
 linux-s390 <linux-s390@vger.kernel.org>,
 y2038 Mailman List <y2038@lists.linaro.org>, Helge Deller <deller@gmx.de>,
 X86 ML <x86@kernel.org>,
 Russell King - ARM Linux admin <linux@armlinux.org.uk>,
 Ingo Molnar <mingo@redhat.com>, Firoz Khan <firoz.khan@linaro.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Matt Turner <mattst88@gmail.com>,
 Fenghua Yu <fenghua.yu@intel.com>, Will Deacon <will.deacon@arm.com>,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Michal Simek <monstr@monstr.eu>, Tony Luck <tony.luck@intel.com>,
 Parisc List <linux-parisc@vger.kernel.org>,
 Linux API <linux-api@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
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

On Mon, Jan 21, 2019 at 9:19 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Sat, Jan 19, 2019 at 3:29 PM Russell King - ARM Linux admin
> <linux@armlinux.org.uk> wrote:
> > On Fri, Jan 18, 2019 at 11:53:25AM -0800, Andy Lutomirski wrote:
> > > On Fri, Jan 18, 2019 at 11:33 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > > > On Fri, Jan 18, 2019 at 7:50 PM Andy Lutomirski <luto@kernel.org> wrote:
> > >
> > > Can we perhaps just start the consistent numbers above 547 or maybe
> > > block out 512..547 in the new regime?
> >
> > I don't think you gain much with that kind of scheme - it won't take
> > very long before an architecture misses having a syscall added, and
> > then someone else adds their own.  Been there with ARM - I was keeping
> > the syscall table in the same order as x86 for new syscalls, but now
>
> Same for m68k, and probably other architectures.
>
> > that others have been adding syscalls to the table since I converted
> > ARM to the tabular form, that's now gone out the window.
> >
> > So, I think it's completely pointless to do what you're suggesting.
> > We'll just end up with a big hole in the middle of the syscall table
> > and then revert back to random numbering of syscalls thereafter again.
>
> I believe the plan is to add future syscalls for all architectures in a
> single commit, to keep everything in sync.

Yes, that is the idea. This was not realistic before, since each one
of the old architectures had its own way of describing the system call
tables, and many needed a different set of quirks.

Since (almost) everything is now converted to the syscall.tbl format,
we have removed all obsolete architectures, and a lot of the quirks
(x32, spu, s390-31) won't matter as much in the future, I think it is
now possible to do it.

We could even extend scripts/checksyscalls.sh to warn if a new
syscall above 423 is not added to all 16 tables at the same time.

> Regardless, I'm wondering what to do with the holes marked "room for
> arch specific calls".
> When is a syscall really arch-specific, and can it be added there, and
> when does it turn out (later) that it isn't, breaking the
> synchronization again?

We've had a bit of that already, with cacheflush(), which exists on
a couple of architectures, including some that use the first
'arch specific' slot (244) of the asm-generic table. I think this
will be rare enough that we can figure out a solution when we
get there.

> The pkey syscalls may be a bad example, as AFAIU they can be implemented
> on some architectures, but not on some others.  Still, I had skipped them
> when adding new syscalls to m68k.
>
> Perhaps we should get rid of the notion of "arch-specific syscalls", and
> reserve a slot everywhere anyway?

I don't mind calling the hole something else if that helps. Out of
principle I would already assume that anything we add for x86
or the generic table should be added everywhere, but we can
make it broader than that.

      Arnd
