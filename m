Message-ID: <3E023BD8.8050107@mvista.com>
Date: Thu, 19 Dec 2002 13:36:24 -0800
From: Todd Poynor <tpoynor@mvista.com>
MIME-Version: 1.0
To: Hollis Blanchard <hollis@austin.ibm.com>
Cc: devel list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: RFC: 405LP sleep
References: <1040330490.29647.340.camel@granite.austin.ibm.com>
In-Reply-To: <1040330490.29647.340.camel@granite.austin.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


+int alarm_secs;
+int cdiv;
+char mode[16] = "standby";     /* "clock-suspend", "power-down",
"standby" */
+int attempts;  /* debugging */

Suggest more unique names for these globals.

+       jiffies += rtc_secs_elapsed * HZ;

If jiffies is jumped forward then can kernel events (such as those
waiting on a kernel timer) be missed?  Whether or not timer queues et al
are processed on wakeup, not sure if it's harmful to update the "kernel
time" when the kernel has done nothing during the sleep interval, maybe
causing various timeouts.  Has this been tried with applications like X
running and verified not to kill apps on wakeup?

Matt Locke and I have been discussing whether it's best to update wall
clock time but leave jiffies alone, since "kernel time" did not advance
during the sleep interval.  It's a little worrisome: the kernel advances
time by 10ms for its own operations, but wallclock time (xtime and RTC)
jumps forward 10 minutes.  We've tried this a little bit on a TI OMAP
and haven't seen anything die so far, but I imagine there'll be some
application that isn't happy about the situation no matter what choice
is made.


--
Todd


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
