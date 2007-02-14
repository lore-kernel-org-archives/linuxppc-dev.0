Return-Path: <pavel@ucw.cz>
Received: from amd.ucw.cz (gprs189-60.eurotel.cz [160.218.189.60])
	by ozlabs.org (Postfix) with ESMTP id 89864DDE32
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 01:46:07 +1100 (EST)
Date: Wed, 14 Feb 2007 15:45:56 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [linux-pm] [PATCH 02/12] powermac: support G5 CPU hotplug
Message-ID: <20070214144556.GC25910@elf.ucw.cz>
References: <20070207124536.963531000@sipsolutions.net>
	<20070207124610.392302000@sipsolutions.net>
	<1170940494.4385.51.camel@johannes.berg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1170940494.4385.51.camel@johannes.berg>
Cc: linuxppc-dev@ozlabs.org, linux-pm@lists.osdl.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi!

> > Except for the in-irq count hack I'm happy with this. I still haven't found
> > where the in-hard-irq count is set to 1 in the down path during suspend or
> > resume and other platforms do similar things so I'm inclined to leave this.
> 
> Um, ok, so the hack breaks platforms that don't have paca, e.g. chrp32.
> 
> Also, I finally figured out how the in-hard-irq count happens. The thing
> is that when I try to turn off the CPU it actually doesn't really turn
> off of course, so it ends up doing NAP and taking timer interrupts...
> which goes irq_enter() and we happen to kill it afterwards.
> 
> I have two ways of fixing this:
>  - just ignore it as we do now
>  - insert a "if (cpu_dead) return" into the timer interrupt function
> 
> I prefer the latter because then we're guaranteed that whatever the
> timer interrupt does we don't modify any state for/by the CPU that isn't
> supposed to exist.

Can you disable timer interrupt on the interrupt controller, instead?
Provides same functionality, and needs no runtime overhead...
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
