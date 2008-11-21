Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.124]) by ozlabs.org (Postfix) with ESMTP id 918E2DDED9
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Nov 2008 00:31:17 +1100 (EST)
Date: Fri, 21 Nov 2008 08:31:14 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ftrace: mcountrecord.pl for arm
In-Reply-To: <20081121131109.GA12241@flint.arm.linux.org.uk>
Message-ID: <alpine.DEB.1.10.0811210823460.6447@gandalf.stny.rr.com>
References: <20081120203415.251344054@goodmis.org>
	<20081120220406.GA2159@blackbean.org>
	<20081120221149.GA2470@blackbean.org>
	<20081121131109.GA12241@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Abhishek Sagar <sagar.abhishek@gmail.com>, Matt Fleming <mjf@gentoo.org>,
	Jim Radford <radford@galvanix.net>, LKML <linux-kernel@vger.kernel.org>,
	linux-arm-kernel@lists.arm.linux.org.uk, linuxppc-dev@ozlabs.org,
	Paul Mundt <lethal@linux-sh.org>, Ingo Molnar <mingo@elte.hu>,
	Sam Ravnborg <sam@ravnborg.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, 21 Nov 2008, Russell King - ARM Linux wrote:

> On Thu, Nov 20, 2008 at 02:11:49PM -0800, Jim Radford wrote:
> > Ingo and Steven,
> > 
> > Here's an updated version of the arch/arm changes for dynamic ftrace
> > based on top of your latest tip/master.
> 
> Excuse me if I'm rather confused, but...
> 
> When ftrace for ARM was originally merged, neither linux-arm-kernel
> nor myself were copied with the patches.  Now, I'm being sent updates
> to code that I've no understanding of and haven't seen before.
> 
> I mean, yes, it's nice to be copied with patches which are relevent.
> It would've been even nicer to have been copied with the patches adding
> ftrace in the first place, so people knew something about it and were
> aware of the changes.
> 
> It seems to me like there's been a total breakdown of communication
> when ftrace was initially merged...

Yes I totally agree that in the beginning there was a breakdown of
communication. I myself just learned of the ARM port.

> 
> So, questions: has ftrace actually been tested on ARM at all?  Has it
> been reviewed?  Which ARM platforms has it been tried on?  How stable
> is it?  How has it been implemented on ARM?  Does it rely on any CPU
> specific behaviour?
> 
> Looking at the git history, ftrace was merged via Ingo, so I assume
> that Ingo has some understanding of this code.  So, for the time being
> if these are urgent updates, I suggest that updates go through Ingo's
> tree rather than mine.

I would suggest that they at least get an ACK from you. The original
code should have too.

> 
> And looking at arch/arm/kernel/ftrace.c, it's incompatible with Thumb2
> which we've been working towards supporting.  What about SMP?  ARM is
> a SMP capable architecture now, and I see no locking in there - what
> I do see is static data with pointers to it being returned to other
> code... Yuck.

Some of this code will be redesigned in 29. But as for the locking, this 
code is run under kstop_machine. Which means that even on SMP 
architectures, this acts like a UP box.  Some of the code can be run 
outside of kstop_machine, but it is protected by locks in the module code.
I'll take a look at the ftrace.c arm code and see if there's any problems 
with it. I wrote the x86 version as well as the coming PowerPC port.

Thanks,

-- Steve
