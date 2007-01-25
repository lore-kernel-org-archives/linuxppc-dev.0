Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net
	[151.189.21.42])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 849A0DE18D
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 11:57:43 +1100 (EST)
In-Reply-To: <20070125001843.GI16486@localdomain>
References: <20070125001843.GI16486@localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <5FE26120-8464-4431-8F0D-EEBB4B896419@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/2] move pSeries nvram code to neutral location
Date: Thu, 25 Jan 2007 01:57:27 +0100
To: Nathan Lynch <ntl@pobox.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Move arch/powerpc/platforms/pseries/nvram.c to
> arch/powerpc/sysdev/rtas_nvram.c so other platforms with RTAS support
> for manipulating nvram can use it.
>
> Add a RTAS_NVRAM Kconfig option which triggers the build of
> arch/powerpc/sysdev/rtas_nvram.o.
>
> Select RTAS_NVRAM for pSeries and Maple platforms.

The patch seems to select it for pSeries and iSeries, instead?

> Signed-off-by: Nathan Lynch <ntl@pobox.com>

> +config RTAS_NVRAM
> +	bool
> +	default n

No need for "default n", all defaults are "n" by default ;-)

> --- a/arch/powerpc/platforms/pseries/nvram.c
> +++ /dev/null

> --- /dev/null
> +++ b/arch/powerpc/sysdev/rtas_nvram.c

You can do a "git diff -M" -- that way, we can see that you're
not trying to sneak in any changes ;-) (and it makes you patch
much more legible and smaller, too).


Looks good otherwise, thanks!


Segher
