From: bkuschak@yahoo.com
Date: Tue, 6 Feb 2001 10:33:37 -0800 (PST)
Message-Id: <200102061833.f16IXbT21311@lara.pathlink.com>
Subject: 60 second CPU load spike
To: linuxppc-embedded@lists.linuxppc.org
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I was hoping someone might be able to provide a few hints or insights regarding
a problem I am trying to track down.  I've noticed that something in our system
is spiking the CPU load exactly every 60 seconds.  When the system is heavily
loaded by packet processing, this spike causes the CPU to go to about 100% (from
80%) for approximately 2-3 seconds.  This causes packet drops at either the
hardware or the netif_rx() backlog queue.  Here is some more information:

- no other processes running except init, getty, sh, kswapd, kupdate, kflushd,
wdt (watchdog)
- kernel instrumentation shows one 60-second timer (wdt), but it is not
coincident with the spike
- happens with ethernet IP-forwarding
- profiling data inconclusive
- using MontaVista's 2.4 kernel on PowerPC405

I noticed 60 second periodic tasks such as route-related garbage collection,
etc, and changed these periods in /proc, without any effect.  I would like to
find out what is causing these spikes and eliminate the problem.  Any comments
would be appreciated.

Thanks,
Brian


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
