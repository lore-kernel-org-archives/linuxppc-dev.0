Message-ID: <38D29EF5.F20EDF32@email.sps.mot.com>
Date: Fri, 17 Mar 2000 15:09:09 -0600
From: "Richard Hendricks" <ra6353@email.sps.mot.com>
MIME-Version: 1.0
To: Geir Frode Raanes <geirfrs@invalid.ed.ntnu.no>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: What is the catch with IDMA on MPC860?
References: <Pine.BSF.4.10.10003171722430.93013-100000@invalid.ed.ntnu.no>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Geir Frode Raanes wrote:
>
> On Fri, 17 Mar 2000, Richard Hendricks wrote:
>
> >
> >
> > Geir Frode Raanes wrote:
> > >
> > > Revision C or later of the '860 will even perform
> > > a single-address _burst_ transfer on IDMA channel 1.
> > > This I would love to do from our in-house designed
> > > frame grabber to main memory. Then I could avoid
> > > disabling all interrupts while bursting. Meaning
> > > I could still catch run-away situations on a
> > > time-out basis. Today things simply lock up...
>
> > The biggest complaint I hear is the performance stinks.
> > Which it does, since it is really a software based DMA
> > algorithm running on the CPM.
>
> Possibely. But where does the manual say that the
> performance stinks? It should be documented somewhere.

Of course!  It's documented in the Serial Communications
Performance chapter.  Something like 3-4 pages at the very
end.  At 25 MHz (the values scale linearly with frequency,
more or less), and with no other loading on the CPM,
Memory to Memory burst IDMA transactions top out at 10.4 MB/sec,
or, at a more reasonable speed like 66 MHz, 27.45 MB/sec.

YMMV, btw. :)

> > I *think* you mean Single-buffer burst flyby mode.
>
> That is correct. I just quoted the subtitle of figure 20-15.
> But the chapter is named Single-buffer burst flyby mode.
> The following figure numbers are collected from the current
> version of the MPC860UM user manual in PDF form @ motorola.
>
> Figure 14-5:  Single-Beat Cycle Basic Timing Zero Wait States
>               Two clock cycles per bus cycle.
>
> Figure 14-12: Burst-Read Cycle with Zero Wait state.
>               Five clock cycles per four words burst cycle.
>
> Figure 20-15: Single Buffer/Address IDMA1 Burst Timing.
>               /TA alternating resulting in one waitstate per
>               word and thus nine clock cycles per four words
>               burst cycle.
>
> Figure 14-14: Burst-Read Cycle with Wait States between Beats.
>               Would have been identical to figure 20-15
>               with identical /TA pattern.
>
> Now, the question is - what controls the /TA line?

Er, you're doing DMA to/from a memory.  The timing of that
memory controls /TA.  If you're using your DRAM with one
of the UPMs, and you're targeting that DRAM with IDMA, it
uses the UPM to control the DRAM. (For a flyby-mode transaction).

> Will I get full speed if actively driving the /TA line low for
> the duration of the IDMA1 burst cycle? Or for that matter in the
> Single-address/Single-cycle Fly-by transfer of figure 20-10?
> The subtitles states that /TA is externally generated. What then
> stops me from running the IDMA bus cycle with normal PIO mode
> timing as per figure 14-5?

You're limited to however fast you can interface to the
memory.  If your peripheral needs extra cycles inserted in,
it could use UPWAITx to do so.

> Figure 20-10: /SDACK timing diagram
>               Single-Address Peripheral write
>               __EXTERNALLY GENERATED /TA__
>
> --
>   ******************************************************
>   Never ever underestimate the power of human stupidity.
>   -Robert Anson Heinlein
>
>                 GeirFRS@invalid.and.so.forth
>   ******************************************************
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
