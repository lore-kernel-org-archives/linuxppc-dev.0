Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s5c4k5NNQzDqQq
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Aug 2016 05:17:09 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Luis R. Rodriguez" <mcgrof@kernel.org>, linux-next@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Fengguang Wu <fengguang.wu@intel.com>,
 Guenter Roeck <linux@roeck-us.net>
Subject: Re: powerpc allyesconfig / allmodconfig linux-next next-20160729 -
 next-20160729 build failures
Date: Fri, 05 Aug 2016 21:16:00 +0200
Message-ID: <29606723.2uK9PgjbC3@wuerfel>
In-Reply-To: <20160806021642.5b53b4bf@roar.ozlabs.ibm.com>
References: <CAB=NE6U18jv89pxqAeZY8eTj44mq90kyXGaQO-108+ZMTyxQiQ@mail.gmail.com>
 <2852406.SOgyPXcJfO@wuerfel> <20160806021642.5b53b4bf@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Saturday, August 6, 2016 2:16:42 AM CEST Nicholas Piggin wrote:
> > 
> > diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> > index 0ec807d69f18..7a3ad269fa23 100644
> > --- a/include/asm-generic/vmlinux.lds.h
> > +++ b/include/asm-generic/vmlinux.lds.h
> > @@ -433,7 +433,7 @@
> >   * during second ld run in second ld pass when generating System.map */
> >  #define TEXT_TEXT                                                    \
> >               ALIGN_FUNCTION();                                       \
> > -             *(.text.hot .text .text.fixup .text.unlikely)           \
> > +             *(.text.hot .text .text.* .text.fixup .text.unlikely)   \
> >               *(.ref.text)                                            \
> >       MEM_KEEP(init.text)                                             \
> >       MEM_KEEP(exit.text)                                             \
> > 
> > 
> > It also got much faster again, the link time for an allyesconfig
> > kernel is now 18 minutes instead of 10 hours, but it's still
> > much worse than the 2 minutes I had earlier or the four minutes
> > with the previous patch.
> 
> Are you using the patches I just sent?

Not yet, I was still busy with the older version, and trying to
figure out exactly what went wrong in ld.bfd. FWIW, I first tried
to see if the hash tables were just too small, but as it turned
out that was not the problem. When I tried to change the default
hash table sizes, making them bigger only made things slower.

I also found the --hash-size=xxx option, which has a significant
impact on runtime speed. Interestingly again, using sizes less
than the default made things faster in practice. If we can
work out the optimum size for the kernel build, that might
shave a few minutes off the total build time.

> Either way, you also need
> to do the same for data and bss sections as you are using
> -fdata-sections too.

Right.

> I've found virtually no build time regression on powerpc or x86
> when those are taken care of properly (x86 numbers I sent are typo,
> it's not 5m20, it's 5m02).

Interesting. I wonder if it's got something to do with the
generation of the branch trampolines on ARM, as we have a lot
of them on an allyesconfig.

Is the 5m20 the total build time for the kernel, the time for
rebuilding after a trivial change, or the time to call 'ld.bfd'
once?

Are you using ld.bfd on x86 or ld.gold? For me ld.gold either
works and is really fast, or it crashes, depending on the
configuration. I also don't think it supports big-endian ARM
(which is what allyesconfig ends up using).

	Arnd
