Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao06.cox.net (fed1rmmtao06.cox.net [68.230.241.33])
	by ozlabs.org (Postfix) with ESMTP id 88CCB2BDA1
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  8 Oct 2004 04:48:42 +1000 (EST)
Date: Thu, 7 Oct 2004 11:48:40 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Message-ID: <20041007184840.GN14773@smtp.west.cox.net>
References: <1096517265.27208.18.camel@localhost.localdomain>
	<20041007154029.GE14773@smtp.west.cox.net>
	<Pine.LNX.4.60.0410071158320.5191@dell.enoriver.com>
	<20041007173023.GK14773@smtp.west.cox.net>
	<Pine.LNX.4.60.0410071354340.6526@dell.enoriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.60.0410071354340.6526@dell.enoriver.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] remove obsolete arch/ppc/8xx_io/uart.c
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Oct 07, 2004 at 02:09:05PM -0400, Robert P. J. Day wrote:

> On Thu, 7 Oct 2004, Tom Rini wrote:
> 
> >Since these changes can go right into a linux-2.6 tree and out to 
> >Linus, I should be able to get BitKeeper to happily merge these 
> >changes and your changes.
> 
> since i already went to the trouble to figure out what it would take 
> to do this, i'll just post it in case any of it is helpful.
> 
> first, i assume that anything related to UARTs in arch/ppc/8xx_io/ can 
> be deleted (the newer stuff being in drivers/serial/cpm_uart/).  this 
> would include uart.c, and any references to UARTs in both Kconfig and 
> Makefile.  so that stuff is pretty easily deletable.

Right.

> regarding Kconfig, that currently defines the following config 
> variables related to UARTs (all of the latter ones dependent on the 
> first, so if you delete the first, all the rest pretty well have to 
> vanish as well):
> 
>   CONFIG_8xx_UART
>   CONFIG_SMC2_UART
>   CONFIG_ALTSMC2
>   CONFIG_CONS_SMC2
>   CONFIG_USE_SCC_IO

Not all of these options exist in linux-2.6.

> if you get rid of that chunk of Kconfig, then you better make sure 
> there's nothing in the rest of the kernel source that refers to any of 
> those config variables in any meaningful way.  other than uart.c, some 
> of these variables are listed in arch/ppc/configs/*, so you'd probably 
> want to clean up any of those defconfig files while you're at it.

Leaving them in the defconfigs is fine.  In fact, unless you're going to
properly convert them to the CPM_UART versions, it's best to leave them.

[snip]
>   apparently, according to this menu, i can walk through and select 
> every single serial port possibility: SMC[12] and SCC[1234].  but even 
> after you do that, you can apparently still go to the "MPC8xx" menu 
> and select to put ethernet on, say, SCC1.  i'm pretty sure you 
> shouldn't be able to select that SCC1 is for both UART and ethernet 
> simultaneously.  just need to add more dependencies to some Kconfig 
> files, i suspect.

I think this had been discussed before, but perhaps not.  What should
happen at some point is something more like "Do you hae SMC1 ? What is
it? Do you have SMC2 ? What is it? Do youhave SCC1? What is it?" and so
on.  For now, I wouldn't worry about it.

-- 
Tom Rini
http://gate.crashing.org/~trini/
