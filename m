Message-Id: <4.3.2.20010206140052.00baff00@falcon.si.com>
Date: Tue, 06 Feb 2001 14:14:17 -0500
To: linuxppc-embedded@lists.linuxppc.org
From: Jerry Van Baren <vanbaren_gerald@si.com>
Subject: Re: 60 second CPU load spike
In-Reply-To: <200102061833.f16IXbT21311@lara.pathlink.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Did you check the file system synchronizing?  Traditionally, it happens
every 30 seconds, but it may be 60 seconds in your system.  Even if you
are running on a RAM disk, the system quite likely is doing a bdflush()
periodically.

man update(8), bdflush(2)

gvb


At 10:33 AM 2/6/01 -0800, bkuschak@yahoo.com wrote:

>Hello,
>
>I was hoping someone might be able to provide a few hints or insights
>regarding
>a problem I am trying to track down.  I've noticed that something in
>our system
>is spiking the CPU load exactly every 60 seconds.  When the system is
>heavily
>loaded by packet processing, this spike causes the CPU to go to about
>100% (from
>80%) for approximately 2-3 seconds.  This causes packet drops at
>either the
>hardware or the netif_rx() backlog queue.  Here is some more information:
>
>- no other processes running except init, getty, sh, kswapd, kupdate,
>kflushd,
>wdt (watchdog)
>- kernel instrumentation shows one 60-second timer (wdt), but it is not
>coincident with the spike
>- happens with ethernet IP-forwarding
>- profiling data inconclusive
>- using MontaVista's 2.4 kernel on PowerPC405
>
>I noticed 60 second periodic tasks such as route-related garbage
>collection,
>etc, and changed these periods in /proc, without any effect.  I would
>like to
>find out what is causing these spikes and eliminate the problem.  Any
>comments
>would be appreciated.
>
>Thanks,
>Brian


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
