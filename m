Return-Path: <cbouatmailru@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.169])
	by ozlabs.org (Postfix) with ESMTP id 09C55DDEEB
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Apr 2008 07:33:55 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id q7so686196uge.0
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Apr 2008 14:33:53 -0700 (PDT)
Date: Tue, 22 Apr 2008 01:33:49 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 4/5] [POWERPC] QE: implement support for the GPIO LIB API
Message-ID: <20080421213349.GA3833@zarina>
References: <20080418190632.GA32204@polina.dev.rtsoft.ru>
	<fa686aa40804210758r70a5906eqb090cd3d8b797317@mail.gmail.com>
	<20080421164128.GA28561@polina.dev.rtsoft.ru>
	<200804211301.13026.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <200804211301.13026.david-b@pacbell.net>
Cc: linuxppc-dev@ozlabs.org
Reply-To: cbouatmailru@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Apr 21, 2008 at 01:01:12PM -0700, David Brownell wrote:
> On Monday 21 April 2008, Anton Vorontsov wrote:
> >  From: J. Random Hacker
> >  Subject: [POWERPC] cleanup board initialization code
> > 
> >  This patch removes vast amount of machine_arch_initcall()s that were
> >  used to solely initialize some hardware, like this:
> > 
> >  qe_add_gpio_chips();
> >  fsl_gtm_init();
> >  fsl_spi_init();
> >  ...
> > 
> >  So, instead of calling this stuff from the board files, we implement
> >  own arch_initcalls for these functions.
> 
> The way other platforms do this is to hav SOC-specific
> init code, and have board-specific initcalls call the
> relevant SOC-specific setup.

I don't know about other platforms other than PowerPC and some ARM,
of course. For example, PXA boards don't call any SOC specific code.
Instead, looking into reworked PXA code, I can see that there are
separate arch_initcalls() for the pxa25x, pxa27x, and pxa3xx SOCs.
The same for s3cxxxx. So, at least not every platform out there doing
this.

Yes, I can see AVR32. But there are only two boards, and when you'll
have more, probably later you'd want to eliminate some repetitive
code, if possible.

Here, with OF, it's quite simple because we have methods of "probing" SOC
devices instead of placing init code into board files (think arch/ppc/).

> Among other things that facilitates kernels that handle
> multiple SOCs (if they're closely-enough related).  That
> may not be used by many distros (handhelds.org being at
> least a partial exception), but it certainly helps cut
> the number of configurations that need build-testing.

Is this about QE_GPIO being user-selectable? Yes, verbose Konfig option
have its own drawbacks. Though, I don't actually have any objections
for making it silent.

And well, I'm not objecting for placing qe gpio code under arch/, too.
I'll resend this patch once again reverting its placement to arch/.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
