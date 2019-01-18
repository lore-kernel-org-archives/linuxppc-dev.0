Return-Path: <SRS0=AYvg=P2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A65C07EBF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 19:55:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39D772086D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 19:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oXZuN8bp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39D772086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43hBW9257ZzDrF0
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Jan 2019 06:55:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=luto@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="oXZuN8bp"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43hBTL4XCDzDq6N
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Jan 2019 06:53:42 +1100 (AEDT)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4B2DD21871
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jan 2019 19:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547841220;
 bh=Y+Mkku2hpjHuuxfJcSbx0NCmyP047W00KgMfbKQs2v4=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=oXZuN8bpl7JO1HHlyJ0rBP27+NxU97vc4K2YMPp9tpjDP7ZyAS4VPhg0sKzkGrhGL
 gl4esmhhdnMv2qRY42CYbfQHSvoACOAC08eP/XECCjAIzpA5m4vNdJ+SUeYIQSuS11
 xyOSBpsZ78Xd0zbQ1oayf1Vw47DpmCpYwWsy1J9k=
Received: by mail-wr1-f43.google.com with SMTP id 96so16538492wrb.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jan 2019 11:53:40 -0800 (PST)
X-Gm-Message-State: AJcUukfgN6ZYH1ea0H92PI39D4dEBjz3/hSfjILEZbl4JrHg26G75Ein
 kVyu+kBGm5fbGYOR9G3rZ1+MgtceAYO2lgSAslMHSw==
X-Google-Smtp-Source: ALg8bN53XBFm0k52gttkiOitsF79fQNn3QWHfyq1eUU45COG9ndt1TzlVHWhAbvhM0sXfa6/3VThsSvvBz3zraeomxM=
X-Received: by 2002:a5d:550f:: with SMTP id b15mr18669734wrv.330.1547841216670; 
 Fri, 18 Jan 2019 11:53:36 -0800 (PST)
MIME-Version: 1.0
References: <20190118161835.2259170-1-arnd@arndb.de>
 <20190118161835.2259170-30-arnd@arndb.de>
 <CALCETrXqM5mhvwreN5y-9K99h1j9rs9MAVK-cNLC54s1fdHA6w@mail.gmail.com>
 <CAK8P3a0V+xboaGAF2nqrYtpjXXA7y0LcvCKi4ngLTus1D_XZBA@mail.gmail.com>
In-Reply-To: <CAK8P3a0V+xboaGAF2nqrYtpjXXA7y0LcvCKi4ngLTus1D_XZBA@mail.gmail.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Fri, 18 Jan 2019 11:53:25 -0800
X-Gmail-Original-Message-ID: <CALCETrWPj6dHEyo=AELoVjXGsiwuSpRp17x3CEWBHvp7i3cy+Q@mail.gmail.com>
Message-ID: <CALCETrWPj6dHEyo=AELoVjXGsiwuSpRp17x3CEWBHvp7i3cy+Q@mail.gmail.com>
Subject: Re: [PATCH v2 29/29] y2038: add 64-bit time_t syscalls to all 32-bit
 architectures
To: Arnd Bergmann <arnd@arndb.de>
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
 Heiko Carstens <heiko.carstens@de.ibm.com>, linux-mips@vger.kernel.org,
 Max Filippov <jcmvbkbc@gmail.com>,
 Network Development <netdev@vger.kernel.org>,
 Deepa Dinamani <deepa.kernel@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>,
 sparclinux <sparclinux@vger.kernel.org>,
 linux-arch <linux-arch@vger.kernel.org>,
 linux-s390 <linux-s390@vger.kernel.org>,
 y2038 Mailman List <y2038@lists.linaro.org>, Helge Deller <deller@gmx.de>,
 X86 ML <x86@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Firoz Khan <firoz.khan@linaro.org>,
 Matt Turner <mattst88@gmail.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Will Deacon <will.deacon@arm.com>,
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

On Fri, Jan 18, 2019 at 11:33 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, Jan 18, 2019 at 7:50 PM Andy Lutomirski <luto@kernel.org> wrote:
> > On Fri, Jan 18, 2019 at 8:25 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > > - Once we get to 512, we clash with the x32 numbers (unless
> > >   we remove x32 support first), and probably have to skip
> > >   a few more. I also considered using the 512..547 space
> > >   for 32-bit-only calls (which never clash with x32), but
> > >   that also seems to add a bit of complexity.
> >
> > I have a patch that I'll send soon to make x32 use its own table.  As
> > far as I'm concerned, 547 is *it*.  548 is just a normal number and is
> > not special.  But let's please not reuse 512..547 for other purposes
> > on x86 variants -- that way lies even more confusion, IMO.
>
> Fair enough, the space for those numbers is cheap enough here.
> I take it you mean we also should not reuse that number space if
> we were to decide to remove x32 soon, but you are not worried
> about clashing with arch/alpha when everything else uses consistent
> numbers?
>

I think we have two issues if we reuse those numbers for new syscalls.
First, I'd really like to see new syscalls be numbered consistently
everywhere, or at least on all x86 variants, and we can't on x32
because they mean something else.  Perhaps more importantly, due to
what is arguably a rather severe bug, issuing a native x86_64 syscall
(x32 bit clear) with nr in the range 512..547 does *not* return
-ENOSYS on a kernel with x32 enabled.  Instead it does something that
is somewhat arbitrary.  With my patch applied, it will return -ENOSYS,
but old kernels will still exist, and this will break syscall probing.

Can we perhaps just start the consistent numbers above 547 or maybe
block out 512..547 in the new regime?

--Andy
