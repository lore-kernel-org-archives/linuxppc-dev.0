Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id BC9902C0211
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Aug 2013 07:01:10 +1000 (EST)
Message-ID: <1376514060.4255.73.camel@pasglop>
Subject: Re: Pull request: scottwood/linux.git next
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Date: Thu, 15 Aug 2013 07:01:00 +1000
In-Reply-To: <1376499759.31636.15.camel@snotra.buserror.net>
References: <20130808224501.GA8925@home.buserror.net>
 <1376453881.4255.57.camel@pasglop>
 <1376499759.31636.15.camel@snotra.buserror.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-08-14 at 12:02 -0500, Scott Wood wrote:
> On Wed, 2013-08-14 at 14:18 +1000, Benjamin Herrenschmidt wrote:
> > On Thu, 2013-08-08 at 17:45 -0500, Scott Wood wrote:
> > >       powerpc/e500: Update compilation flags with core specific
> > > options
> > 
> > This breaks the build for my FSL test configs. For some reason gcc 4.7.3
> > doesn't know about -mcpu=e5500
> 
> Ugh.  I guess that's what I get for using toolchains provided internally
> rather than building them myself

:-)

I recommend you use one of tony's on kernel.org, that way you have
something that matches what other people use :-)

>  -- though it doesn't help that the GCC
> people love finding new ways to break building GCC without libc (why
> doesn't --without-headers automatically disable any component that
> requires libc headers?)

Hehe, yeah.

> , and usually respond to bug reports with "go run
> crosstool and leave us alone".  It looks like e5500 support is in 4.8.1,
> but I can't actually get it to build (libdecnumber wants to
> #include_next <stdlib.h> and can't be disabled -- arm64 toolchain built
> fine with the similar configure options).  I don't know about earlier
> versions.

In any case, there are mechanisms in Kbuild to check if the option
exist, so that should be used here. Look at the other ones.

> > Additionally, on 64-bit, that means one can no longer make a kernel that
> > does both A2 and e5500...
> 
> Other than the toolchain issue, I'm not sure how this is worse than it
> was before, when such a kernel would have had -Wa,-me500 forced.

Probably similarly bad though it did work ... but if you are touching
it, may as well do it right...

> What -mcpu value should be used in such a combined kernel?

Good question. We lack a generic booke option. What about powerpc64 ?

A default like that is fine as long as tricky asm uses the macros for
that and the *optional* -mcpu=<xxx> option is available (and you can put
it in defconfig).

It might be worth asking gcc to add something like -march=<arch version>
or something like that though.

> > I'm reverting that crap patch, please make such optimizations CONFIG_*
> > options like power5...7
> 
> Speaking of crap patches, those config options don't limit themselves to
> book3s and thus we're now getting CONFIG_GENERIC_CPU (and thus
> -mtune=power7) on e5500 builds.

Indeed, another crap patch ... I didn't spot it because it didn't break
the build :-)

Feel free to submit a fix !

Cheers,
Ben.
