Message-ID: <20030305183324.96783.qmail@web40908.mail.yahoo.com>
Date: Wed, 5 Mar 2003 10:33:24 -0800 (PST)
From: Brian Kuschak <bkuschak@yahoo.com>
Subject: RE: Network performance loss when migrating to 2.4.18 on Walnut 4 05GP
To: jperri@viadux.com
Cc: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>> I applied a patch (from Andrea A. I think?) that
>> backed out the ksoftirq addition.
>
> Do you have any more specifics concerning the patch
> to remove ksoftirqd? I browsed all of Andrea's
> 2.4/2.5 patches on kernel.org and found a few
> relating to ksoftirqd, but none that removed it
> entirely. A google search didn't turn up anything
> either.  Could the patch have come from someone
> other than Andrea?

You're right.  Andrea and Ingo Molnar both posted
numerous ksoftirq-related patches.  I think the one I
was referring to is here, by Ingo:
http://people.redhat.com/mingo/irqrate-patches/irqrate-2.4.17-A1

>> With other tricks I was able to hit 35K+ pps...
>
> If you're willing to share, I'd like to hear about
> these other "tricks" :-)
>

If you do some profiling, you'll notice that the
interrupts from the ethernet interfaces constitute a
large amount of CPU time.  A common technique to
reduce this is interrupt mitigation.  If you keep
track of the rx/tx packet rate and reduce or limit the
interrupt rate when it exceeds a threshold, you can
improve performance significantly.  There are several
techniques you can use.  I chose an interrupt-based
polling mode.  The ethernet driver switches to polling
mode when packet rate is high and back to interrupt
mode when packet rate drops.  (The PPC FIT timer (at
1500Hz) makes a good polling interrupt).

By adjusting the length of your DMA rings you can also
put a hard limit on the number of packets/sec that the
system will process.  This will help you to limit or
avoid packet-flood D.O.S. attacks.

Combine the ksoftirq backout, the ethernet interrupt
mitigation, and enable CONFIG_FASTROUTE (and implement
fastroute for the 405 ethernet driver), and you will
forward 50K+ packets/sec on a 200Mhz 405GP.

-Brian


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
