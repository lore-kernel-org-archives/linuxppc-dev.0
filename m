Date: Mon, 20 Mar 2000 11:11:09 +0100 (CET)
From: Geir Frode Raanes <geirfrs@invalid.ed.ntnu.no>
To: Richard Hendricks <ra6353@email.sps.mot.com>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: What is the catch with IDMA on MPC860?
In-Reply-To: <38D29EF5.F20EDF32@email.sps.mot.com>
Message-ID: <Pine.BSF.4.10.10003200951040.10686-100000@invalid.ed.ntnu.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, 17 Mar 2000, Richard Hendricks wrote:

> Geir Frode Raanes wrote:
> >
> > Possibely. But where does the manual say that the
> > performance stinks? It should be documented somewhere.
>
> Of course!  It's documented in the Serial Communications
> Performance chapter.  Something like 3-4 pages at the very
> end.  At 25 MHz (the values scale linearly with frequency,
> more or less), and with no other loading on the CPM,
> Memory to Memory burst IDMA transactions top out at 10.4 MB/sec,
> or, at a more reasonable speed like 66 MHz, 27.45 MB/sec.


Ah. RTFM. The paper version - Appendix B - that is.
Can still not find it in the PDF version. Funny.
Thank you anyway. Those where the timing diagrams I
were looking for. I am just moving up from the world
of microcontrollers and FPGA to microprocessors.
Can't say I am all that thrilled about IF-THEN-ELSE
soft timing datasheets. But I'll manage.

And 27.45 MBytes per sec gives me a reasonable headroom
from the 20 MBytes per second requirement of the grabber,
and still allow me to leave interrupts enabeled.
And yes, it is in fact a CCD camera grabber without
much local buffering.


What I was really asking was what the "inefficient"
label on IDMA was all about. More specifically, if that
meant that IDMA wasted bus clock cycles - i.e. hogging
the bus while setting up the transfer or requiring
wait states irrespectible of the source/target speed.
Considering the timing diagrams in Appendix B and given
the Motorola "will then perform a fast back-to-back
transfer" statement this does not seem to be the case.

I can live with the fact that IDMA can not utilize the
bus 100% of the time as long as it __relinquish the bus__
at all times it does not perform __full speed__ data
movements. Actually I prefer it does just that.

The other use of these IDMA channels is for soft
PCI interface. There is specified a limit of 8 PCI
clocks on target latency. That rules out any interrupt
based interface handling. But IDMA to configuration
space and memory space respectively in combination
with an interrupt migth do the trick.

> > Now, the question is - what controls the /TA line?
>
> Er, you're doing DMA to/from a memory.  The timing of that
> memory controls /TA.  If you're using your DRAM with one
> of the UPMs, and you're targeting that DRAM with IDMA, it
> uses the UPM to control the DRAM. (For a flyby-mode transaction).

I am aware of that. What I was really asking was what is the
upper boundary on the timing. Like for instance the timing
of the TMP68303 microcontroller from Toshiba wich stated that
the _slower_ of the internally generated /DTACK and externally
applied is used for DMA transfers.

--
  ******************************************************
  Never ever underestimate the power of human stupidity.
  -Robert Anson Heinlein

		GeirFRS@invalid.and.so.forth
  ******************************************************


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
