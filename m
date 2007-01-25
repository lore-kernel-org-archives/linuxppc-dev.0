Return-Path: <ntl@pobox.com>
Received: from rune.pobox.com (rune.pobox.com [208.210.124.79])
	by ozlabs.org (Postfix) with ESMTP id ECF4DDE1C4
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 12:04:58 +1100 (EST)
Date: Wed, 24 Jan 2007 19:04:53 -0600
From: Nathan Lynch <ntl@pobox.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/2] move pSeries nvram code to neutral location
Message-ID: <20070125010453.GN16486@localdomain>
References: <20070125001843.GI16486@localdomain>
	<5FE26120-8464-4431-8F0D-EEBB4B896419@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5FE26120-8464-4431-8F0D-EEBB4B896419@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool wrote:
> >Move arch/powerpc/platforms/pseries/nvram.c to
> >arch/powerpc/sysdev/rtas_nvram.c so other platforms with RTAS support
> >for manipulating nvram can use it.
> >
> >Add a RTAS_NVRAM Kconfig option which triggers the build of
> >arch/powerpc/sysdev/rtas_nvram.o.
> >
> >Select RTAS_NVRAM for pSeries and Maple platforms.
> 
> The patch seems to select it for pSeries and iSeries, instead?

Aw crap, evidently damage introduced when rebasing (Kconfig files seem
so fragile in this regard).

> >+config RTAS_NVRAM
> >+	bool
> >+	default n
> 
> No need for "default n", all defaults are "n" by default ;-)

Duh, will fix.


> >--- a/arch/powerpc/platforms/pseries/nvram.c
> >+++ /dev/null
> 
> >--- /dev/null
> >+++ b/arch/powerpc/sysdev/rtas_nvram.c
> 
> You can do a "git diff -M" -- that way, we can see that you're
> not trying to sneak in any changes ;-) (and it makes you patch
> much more legible and smaller, too).

Thanks for the tip, I'll try it that way.
