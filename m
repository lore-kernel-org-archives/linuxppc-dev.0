Return-Path: <SRS0=aKpC=P3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C9BC61CE4
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Jan 2019 14:31:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08BDE2086D
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Jan 2019 14:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="NR2Et1dr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08BDE2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43hgHS1KNJzDr19
	for <linuxppc-dev@archiver.kernel.org>; Sun, 20 Jan 2019 01:31:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=armlinux.org.uk
 (client-ip=2001:4d48:ad52:3201:214:fdff:fe10:1be6;
 helo=pandora.armlinux.org.uk;
 envelope-from=linux+linuxppc-dev=lists.ozlabs.org@armlinux.org.uk;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none)
 header.from=armlinux.org.uk
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=armlinux.org.uk header.i=@armlinux.org.uk
 header.b="NR2Et1dr"; dkim-atps=neutral
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk
 [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43hgFj0KMqzDql0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 Jan 2019 01:30:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=d63QEDmnrldHslsD9mf7nQ3yGthqTGS5pzxH/xWmhF0=; b=NR2Et1druix8/4pNwnuT+RILu
 9d1Rxv6XWz1TN+9FqQ/p/P7acLs7c7trws/Jg8fG3MPHsJWvYLs9TlllAhF873aPPG/2SMtV0ge2K
 NorzWF9puUKyS/b5Aid7zX6nzfqByLov3FnZBmN2/p8vSFlBK8+rFnheOM8d1SGvO/EXM=;
Received: from e5254000004ec.dyn.armlinux.org.uk
 ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:35354 helo=shell.armlinux.org.uk)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1gkrcD-0006gO-Mk; Sat, 19 Jan 2019 14:28:53 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
 (envelope-from <linux@shell.armlinux.org.uk>)
 id 1gkrcC-0002s2-N7; Sat, 19 Jan 2019 14:28:52 +0000
Date: Sat, 19 Jan 2019 14:28:52 +0000
From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
To: Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v2 29/29] y2038: add 64-bit time_t syscalls to all 32-bit
 architectures
Message-ID: <20190119142852.cntdihah4mpa3lgx@e5254000004ec.dyn.armlinux.org.uk>
References: <20190118161835.2259170-1-arnd@arndb.de>
 <20190118161835.2259170-30-arnd@arndb.de>
 <CALCETrXqM5mhvwreN5y-9K99h1j9rs9MAVK-cNLC54s1fdHA6w@mail.gmail.com>
 <CAK8P3a0V+xboaGAF2nqrYtpjXXA7y0LcvCKi4ngLTus1D_XZBA@mail.gmail.com>
 <CALCETrWPj6dHEyo=AELoVjXGsiwuSpRp17x3CEWBHvp7i3cy+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrWPj6dHEyo=AELoVjXGsiwuSpRp17x3CEWBHvp7i3cy+Q@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
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
 Linux-sh list <linux-sh@vger.kernel.org>, Will Deacon <will.deacon@arm.com>,
 linux-mips@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>,
 Network Development <netdev@vger.kernel.org>,
 Deepa Dinamani <deepa.kernel@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>,
 sparclinux <sparclinux@vger.kernel.org>,
 linux-arch <linux-arch@vger.kernel.org>,
 linux-s390 <linux-s390@vger.kernel.org>,
 y2038 Mailman List <y2038@lists.linaro.org>, Helge Deller <deller@gmx.de>,
 X86 ML <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Firoz Khan <firoz.khan@linaro.org>,
 Matt Turner <mattst88@gmail.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <heiko.carstens@de.ibm.com>,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 Thomas Gleixner <tglx@linutronix.de>,
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

On Fri, Jan 18, 2019 at 11:53:25AM -0800, Andy Lutomirski wrote:
> On Fri, Jan 18, 2019 at 11:33 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Fri, Jan 18, 2019 at 7:50 PM Andy Lutomirski <luto@kernel.org> wrote:
> > > On Fri, Jan 18, 2019 at 8:25 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > > > - Once we get to 512, we clash with the x32 numbers (unless
> > > >   we remove x32 support first), and probably have to skip
> > > >   a few more. I also considered using the 512..547 space
> > > >   for 32-bit-only calls (which never clash with x32), but
> > > >   that also seems to add a bit of complexity.
> > >
> > > I have a patch that I'll send soon to make x32 use its own table.  As
> > > far as I'm concerned, 547 is *it*.  548 is just a normal number and is
> > > not special.  But let's please not reuse 512..547 for other purposes
> > > on x86 variants -- that way lies even more confusion, IMO.
> >
> > Fair enough, the space for those numbers is cheap enough here.
> > I take it you mean we also should not reuse that number space if
> > we were to decide to remove x32 soon, but you are not worried
> > about clashing with arch/alpha when everything else uses consistent
> > numbers?
> >
> 
> I think we have two issues if we reuse those numbers for new syscalls.
> First, I'd really like to see new syscalls be numbered consistently
> everywhere, or at least on all x86 variants, and we can't on x32
> because they mean something else.  Perhaps more importantly, due to
> what is arguably a rather severe bug, issuing a native x86_64 syscall
> (x32 bit clear) with nr in the range 512..547 does *not* return
> -ENOSYS on a kernel with x32 enabled.  Instead it does something that
> is somewhat arbitrary.  With my patch applied, it will return -ENOSYS,
> but old kernels will still exist, and this will break syscall probing.
> 
> Can we perhaps just start the consistent numbers above 547 or maybe
> block out 512..547 in the new regime?

I don't think you gain much with that kind of scheme - it won't take
very long before an architecture misses having a syscall added, and
then someone else adds their own.  Been there with ARM - I was keeping
the syscall table in the same order as x86 for new syscalls, but now
that others have been adding syscalls to the table since I converted
ARM to the tabular form, that's now gone out the window.

So, I think it's completely pointless to do what you're suggesting.
We'll just end up with a big hole in the middle of the syscall table
and then revert back to random numbering of syscalls thereafter again.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
