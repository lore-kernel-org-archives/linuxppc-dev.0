Message-ID: <38DA9F5E.57D49502@email.sps.mot.com>
Date: Thu, 23 Mar 2000 16:49:02 -0600
From: "Richard Hendricks" <ra6353@email.sps.mot.com>
MIME-Version: 1.0
To: Noah Misch <nmisch@erols.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: What is the catch with IDMA on MPC860?
References: <Pine.BSF.4.10.10003200951040.10686-100000@invalid.ed.ntnu.no> <v04011702b4fefea1120a@[216.164.128.206]>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Noah,
  Everyone else pointed you to documents, but I'll give you a
nickel explaination.

CPM = Communications processor module.  It's the second CPU on the
MPC8xx family that handles communication (so, say, the PowerPC CPU
doesn't need to worry about handling each byte of an ethernet packet).
It is based off the MPC68360 CPM.  It has been modifed by adding
a MAC unit to do DSP, and changing the hardware DMA to software
(running on the CPM).  Kinda makes the MPC8xx family "dual core", but
that may be strecthing it a bit.  Programming of the CPM is restricted
to Motorola and a few key customers.

UART = Universal Asynchronous Receiver/Transmitter.  A serial port,
where data is transmitted one bit at a time.  Used mostly in PCs as
RS-232.

DMA/IDMA = Direct Memory Access/ Independant DMA.  DMA allows memory
transactions to go on without CPU intervention.  Say you have a digital
camera with a CCD.  You would want the CCD's information constantly
copied to main memory.  With DMA, you can do that without the CPU
having to transfer every byte itself.  IDMA is just how DMA is
implemented in the MPC8xx by the CPM.  Independant means
independant from the serial channels, I guess.  You could also
use DMA, say, to feed an audio chip data when it requests it.

UPM = User Programmable Machine.  A special state machine within
the Memory Controller for handling complex memories like DRAM and
custom user interfaces.  It allows you to control the waveforms of
the various memory signals.  Sorta like a microcode for a memory
controller.

SCC = Serial Communications Controller.  Many serial protocols are
similar enough that a general "serial engine" can handle them.  The SCC
is powerful enough to do everything from RS-232 up to Ethernet.  There's
also a FCC, or Fast CC, and an SMC.  An SMC is a Serial Management
Controller, which is designed for very simple serial protocols. As far
as actual nuts & bolts, the SCC can handle more bandwidth since much
of its functionality is hardware-based, while most of the SMC
functionality is controlled by software.  This is why the SMC
can't handle the same amount of data bandwidth the SCC can.

Noah Misch wrote:
>
> Would you mind telling me briefly what CPM, UART, DMA/IDMA, UPM, and SCC
> are, or pointing me to a document that explains them?  I see these terms
> used a lot, but I don't know what they stand for and have only a general
> idea of what they are.  I apologize for wasting your time with a worthless
> question.
>
> <snip>
>
> >Just be sure you don't overtax your CPM.  20/27.45 = 73%,
> >but if you start adding in UARTs, etc, you might be getting
> >close to the edge.
>
> <snip>
>
> >> I can live with the fact that IDMA can not utilize the
> >> bus 100% of the time as long as it __relinquish the bus__
> >> at all times it does not perform __full speed__ data
> >> movements. Actually I prefer it does just that.
>
> <snip
>
> >> > Er, you're doing DMA to/from a memory.  The timing of that
> >> > memory controls /TA.  If you're using your DRAM with one
> >> > of the UPMs, and you're targeting that DRAM with IDMA, it
> >> > uses the UPM to control the DRAM. (For a flyby-mode transaction).
>
> <snip>
> Noah Misch
> nmisch@erols.com
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
