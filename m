Subject: Re: RFC: 405LP sleep
From: Hollis Blanchard <hollis@austin.ibm.com>
To: Todd Poynor <tpoynor@mvista.com>
Cc: devel list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <3E023BD8.8050107@mvista.com>
References: <1040330490.29647.340.camel@granite.austin.ibm.com>
	<3E023BD8.8050107@mvista.com>
Content-Type: text/plain
Date: 20 Dec 2002 17:31:14 -0600
Message-Id: <1040427074.1095.23.camel@granite.austin.ibm.com>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 2002-12-19 at 15:36, Todd Poynor wrote:
>
> Suggest more unique names for these globals.

Well, how about making them static? :)

> +       jiffies += rtc_secs_elapsed * HZ;
>
> If jiffies is jumped forward then can kernel events (such as those
> waiting on a kernel timer) be missed?

I certainly *hope* the check is >= rather than == ... :)

> Whether or not timer queues et al
> are processed on wakeup, not sure if it's harmful to update the "kernel
> time" when the kernel has done nothing during the sleep interval, maybe
> causing various timeouts.  Has this been tried with applications like X
> running and verified not to kill apps on wakeup?

I have not run anything interesting like X, no.

> Matt Locke and I have been discussing whether it's best to update wall
> clock time but leave jiffies alone, since "kernel time" did not advance
> during the sleep interval.  It's a little worrisome: the kernel advances
> time by 10ms for its own operations, but wallclock time (xtime and RTC)
> jumps forward 10 minutes.  We've tried this a little bit on a TI OMAP
> and haven't seen anything die so far, but I imagine there'll be some
> application that isn't happy about the situation no matter what choice
> is made.

Before posting I had tried commenting out the jiffies update and it
seemed to run ok both ways. I decided to leave it in though to preserve
the reality of time passing as much as possible.
arch/arm/mach-sa1100/pm.c seems to only update xtime.tv_sec. I'm hoping
Someone Who Knows will comment one way or the other here...

The updated patch, with many cleanups and one important bugfix, has been
posted to http://penguinppc.org/~hollis/405LP-sleep.diff. Aside from the
remaining get_pteptr problem, I think the code is ready to be checked
in. If anyone disagrees please let me know. :)

-Hollis
--
PowerPC Linux
IBM Linux Technology Center


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
