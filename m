Return-Path: <SRS0=gbiG=P5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B10C282DB
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Jan 2019 08:52:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39F0C2084A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Jan 2019 08:52:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39F0C2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43jlfj0GgDzDqWy
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Jan 2019 19:52:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.217.65; helo=mail-vs1-f65.google.com;
 envelope-from=geert.uytterhoeven@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux-m68k.org
Received: from mail-vs1-f65.google.com (mail-vs1-f65.google.com
 [209.85.217.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43jkws2FW1zDqD8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Jan 2019 19:19:25 +1100 (AEDT)
Received: by mail-vs1-f65.google.com with SMTP id n13so12131335vsk.4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Jan 2019 00:19:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eNwdIYQYJT6Pc3PhNslPpG4rGotSgFNPjN+8uubEzLc=;
 b=iZTGoGDnA72iItJgFIySlFB5yOzJWpL8tcskDaOgMRpbIMrkMTDSXnwuJRbG8jFwXi
 1Do8SYyVH8GJeamHRdweR7YoXbuRZZUs1VpD8bSUnNHMwDe+jjFimOENrXVnrq/ZYdJ6
 KfOMgck08ILvFQoWS9Mx3WtB1muvH7IQ1n/kN4pcuoqRRHWpyEvQWT83dbKXYaJB6hdC
 Me3s8NF9GV7cR48KdlU/azxwRU+X7I39ClBpx5So2pmEZGZB+ZW8ofj9P5Ikt1xEq5Id
 XceiM55oGu5hw28aWfGD45G1bAcYDzqvGX/1B9WxC3Q+AIxE1507bbYsRHvu8PL5jdCe
 sUFg==
X-Gm-Message-State: AJcUukdKRu7YI9gBY7c5urXNbw6WIeG7KdKni6tIBGw/YKw1ZDBZJDC+
 tqgIsakxkGcjzMSpOnn/qVX4VExTqdnQndWvtpk=
X-Google-Smtp-Source: ALg8bN7Na9+3XJsTlxP4CnU3flevzSwRj2I8fvGc/mex1gzD8KE0G4LYkLwzBJ2YcDmVU42ivUABTg84S/YKw2y1uBc=
X-Received: by 2002:a67:3885:: with SMTP id n5mr10324892vsi.96.1548058763095; 
 Mon, 21 Jan 2019 00:19:23 -0800 (PST)
MIME-Version: 1.0
References: <20190118161835.2259170-1-arnd@arndb.de>
 <20190118161835.2259170-30-arnd@arndb.de>
 <CALCETrXqM5mhvwreN5y-9K99h1j9rs9MAVK-cNLC54s1fdHA6w@mail.gmail.com>
 <CAK8P3a0V+xboaGAF2nqrYtpjXXA7y0LcvCKi4ngLTus1D_XZBA@mail.gmail.com>
 <CALCETrWPj6dHEyo=AELoVjXGsiwuSpRp17x3CEWBHvp7i3cy+Q@mail.gmail.com>
 <20190119142852.cntdihah4mpa3lgx@e5254000004ec.dyn.armlinux.org.uk>
In-Reply-To: <20190119142852.cntdihah4mpa3lgx@e5254000004ec.dyn.armlinux.org.uk>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 21 Jan 2019 09:19:11 +0100
Message-ID: <CAMuHMdXzQNEEDjWrmTph8Krovj1g2WhnBUaM=FvKB+J2fZqctA@mail.gmail.com>
Subject: Re: [PATCH v2 29/29] y2038: add 64-bit time_t syscalls to all 32-bit
 architectures
To: Russell King - ARM Linux admin <linux@armlinux.org.uk>
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
 Linux-sh list <linux-sh@vger.kernel.org>, Will Deacon <will.deacon@arm.com>,
 linux-mips@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>,
 Network Development <netdev@vger.kernel.org>,
 Deepa Dinamani <deepa.kernel@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>,
 sparclinux <sparclinux@vger.kernel.org>,
 linux-arch <linux-arch@vger.kernel.org>,
 linux-s390 <linux-s390@vger.kernel.org>,
 y2038 Mailman List <y2038@lists.linaro.org>, Helge Deller <deller@gmx.de>,
 X86 ML <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Firoz Khan <firoz.khan@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Matt Turner <mattst88@gmail.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <heiko.carstens@de.ibm.com>,
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

Hi Russell,

On Sat, Jan 19, 2019 at 3:29 PM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
> On Fri, Jan 18, 2019 at 11:53:25AM -0800, Andy Lutomirski wrote:
> > On Fri, Jan 18, 2019 at 11:33 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Fri, Jan 18, 2019 at 7:50 PM Andy Lutomirski <luto@kernel.org> wrote:
> > > > On Fri, Jan 18, 2019 at 8:25 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > > > > - Once we get to 512, we clash with the x32 numbers (unless
> > > > >   we remove x32 support first), and probably have to skip
> > > > >   a few more. I also considered using the 512..547 space
> > > > >   for 32-bit-only calls (which never clash with x32), but
> > > > >   that also seems to add a bit of complexity.
> > > >
> > > > I have a patch that I'll send soon to make x32 use its own table.  As
> > > > far as I'm concerned, 547 is *it*.  548 is just a normal number and is
> > > > not special.  But let's please not reuse 512..547 for other purposes
> > > > on x86 variants -- that way lies even more confusion, IMO.
> > >
> > > Fair enough, the space for those numbers is cheap enough here.
> > > I take it you mean we also should not reuse that number space if
> > > we were to decide to remove x32 soon, but you are not worried
> > > about clashing with arch/alpha when everything else uses consistent
> > > numbers?
> > >
> >
> > I think we have two issues if we reuse those numbers for new syscalls.
> > First, I'd really like to see new syscalls be numbered consistently
> > everywhere, or at least on all x86 variants, and we can't on x32
> > because they mean something else.  Perhaps more importantly, due to
> > what is arguably a rather severe bug, issuing a native x86_64 syscall
> > (x32 bit clear) with nr in the range 512..547 does *not* return
> > -ENOSYS on a kernel with x32 enabled.  Instead it does something that
> > is somewhat arbitrary.  With my patch applied, it will return -ENOSYS,
> > but old kernels will still exist, and this will break syscall probing.
> >
> > Can we perhaps just start the consistent numbers above 547 or maybe
> > block out 512..547 in the new regime?
>
> I don't think you gain much with that kind of scheme - it won't take
> very long before an architecture misses having a syscall added, and
> then someone else adds their own.  Been there with ARM - I was keeping
> the syscall table in the same order as x86 for new syscalls, but now

Same for m68k, and probably other architectures.

> that others have been adding syscalls to the table since I converted
> ARM to the tabular form, that's now gone out the window.
>
> So, I think it's completely pointless to do what you're suggesting.
> We'll just end up with a big hole in the middle of the syscall table
> and then revert back to random numbering of syscalls thereafter again.

I believe the plan is to add future syscalls for all architectures in a
single commit, to keep everything in sync.

Regardless, I'm wondering what to do with the holes marked "room for
arch specific calls".
When is a syscall really arch-specific, and can it be added there, and
when does it turn out (later) that it isn't, breaking the
synchronization again?

The pkey syscalls may be a bad example, as AFAIU they can be implemented
on some architectures, but not on some others.  Still, I had skipped them
when adding new syscalls to m68k.

Perhaps we should get rid of the notion of "arch-specific syscalls", and
reserve a slot everywhere anyway?

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
