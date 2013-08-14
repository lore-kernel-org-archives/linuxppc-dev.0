Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe003.messaging.microsoft.com [207.46.163.26])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3AD992C0135
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Aug 2013 03:02:57 +1000 (EST)
Message-ID: <1376499759.31636.15.camel@snotra.buserror.net>
Subject: Re: Pull request: scottwood/linux.git next
From: Scott Wood <scottwood@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 14 Aug 2013 12:02:39 -0500
In-Reply-To: <1376453881.4255.57.camel@pasglop>
References: <20130808224501.GA8925@home.buserror.net>
 <1376453881.4255.57.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-08-14 at 14:18 +1000, Benjamin Herrenschmidt wrote:
> On Thu, 2013-08-08 at 17:45 -0500, Scott Wood wrote:
> >       powerpc/e500: Update compilation flags with core specific
> > options
> 
> This breaks the build for my FSL test configs. For some reason gcc 4.7.3
> doesn't know about -mcpu=e5500

Ugh.  I guess that's what I get for using toolchains provided internally
rather than building them myself -- though it doesn't help that the GCC
people love finding new ways to break building GCC without libc (why
doesn't --without-headers automatically disable any component that
requires libc headers?), and usually respond to bug reports with "go run
crosstool and leave us alone".  It looks like e5500 support is in 4.8.1,
but I can't actually get it to build (libdecnumber wants to
#include_next <stdlib.h> and can't be disabled -- arm64 toolchain built
fine with the similar configure options).  I don't know about earlier
versions.

> Additionally, on 64-bit, that means one can no longer make a kernel that
> does both A2 and e5500...

Other than the toolchain issue, I'm not sure how this is worse than it
was before, when such a kernel would have had -Wa,-me500 forced.

What -mcpu value should be used in such a combined kernel?

> I'm reverting that crap patch, please make such optimizations CONFIG_*
> options like power5...7

Speaking of crap patches, those config options don't limit themselves to
book3s and thus we're now getting CONFIG_GENERIC_CPU (and thus
-mtune=power7) on e5500 builds.

-Scott
