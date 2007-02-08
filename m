Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E100FDDEC6
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Feb 2007 09:24:31 +1100 (EST)
Subject: Re: [PATCH 02/12] powermac: support G5 CPU hotplug
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <1170940494.4385.51.camel@johannes.berg>
References: <20070207124536.963531000@sipsolutions.net>
	<20070207124610.392302000@sipsolutions.net>
	<1170940494.4385.51.camel@johannes.berg>
Content-Type: text/plain
Date: Fri, 09 Feb 2007 09:24:23 +1100
Message-Id: <1170973463.2620.373.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-pm@lists.osdl.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-02-08 at 14:14 +0100, Johannes Berg wrote:
> On Wed, 2007-02-07 at 13:45 +0100, Johannes Berg wrote:
> 
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

Or we can just mark interrupts as soft-disabled ?

Ben.
