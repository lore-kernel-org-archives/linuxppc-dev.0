Message-ID: <B25E2E5A003CD311B61E00902778AF2A0204438E@SERVER1>
From: Brian Kuschak <brian.kuschak@skystream.com>
To: "'Jerry Van Baren '" <vanbaren_gerald@si.com>,
        "'linuxppc-embedded@lists.linuxppc.org '"
	 <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: 60 second CPU load spike
Date: Tue, 6 Feb 2001 11:35:59 -0800 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Jerry,

Yes, I put printk's in the kupdate and kbdflush loops.  Seems like kupdate
was called every 5 seconds and bdflush was less often (I don't recall the
exact period, but it didn't seem to coincide with my load spike).

-Brian


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
>hardware or the netif_rx() backlog queue.  Here is some more
information:
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
