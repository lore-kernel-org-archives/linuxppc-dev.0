Return-Path: <tim.martin@viasat.com>
Received: from annex.viasat.com (eagle.viasat.com [199.106.52.54])
	by ozlabs.org (Postfix) with ESMTP id 95098679F7
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 14 May 2005 08:26:43 +1000 (EST)
Message-ID: <846BA3AF7C8A2048937F1801FD3129C902DB5942@messenger.viasat.com>
From: "Martin, Tim" <tim.martin@viasat.com>
To: "'linuxppc-embedded@ozlabs.org'" <linuxppc-embedded@ozlabs.org>
Date: Fri, 13 May 2005 15:11:29 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: MPC860 CP / CPM Misbehaving
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Not so much a linux question, as a general MPC860 question, but maybe
someone out there can help.

I'm using a custom MPC860 based embedded board and having problems with SCC1
and SMC1 reception.  I have SCC1 setup in ethernet mode, and SMC1 setup in
UART mode.  The general problem manifests itself as getting receive buffer
descriptors (BDs) from the CPM with the OV bit set (bit 14 of the RxBD
status/control field, "Overrun. Set when a receiver overrun occurs during
reception").

For example, when receiving an ICMP ping over SCC1, I typically get the
first 40-64 bytes of the standard 78 byte ICMP message.

For another example, with no activity on SCC1, receive activity on SMC1 can
also result in receive RxBDs with the OV bit set.

There is also some weirdness where activity on SCC1 results in CPM
interrupts (and RxBDs filled) for SMC1.

I am testing my code by running from a BDM/JTAG debugger.  To throw a wrench
in things, the above weirdness does not occur if the core processor is
halted at a breakpoint (e.g. if the core is halted at a breakpoint, the CPM
continues to run and the entire 78 byte ICMP message shows up in an SCC1
RxBD).

This isn't a board hardware problem, the board runs fine with other software
(different operating system, etc).  It's most likely a configuration problem
on my end.

I have verified that:
* Clocks are setup for correct frequency and routing (SCC1 getting
CLK1/CLK2, SMC1 getting BRG1).
* Low power mode (MSR[POW] and PLPRCR[LPM]) is not being entered.
* I/O ports (PA, PB, PC, PD) configured correctly.
* I'm using the Motorola/Frescale microcode patch (MPC860MC05.zip) that
allows SMC1 and SCC3 to be used at the same time.  SMC1 dual port ram
parameter area is remapped correctly.  Not that this matters in this
configuration, since I'm not even enabling SCC3 for this test.  I've also
tried it without the microcode patch and get the same results.

My thoughts are that it's almost as if the CP (CPM RISC processor) or SDMA
is being occasionally frozen out while the core PowerPC MPC860 processor is
running.  The FIFO internal to the CPM between SCC1 and the CP is 32 bytes,
so the fact that I'm getting a little more than 32 bytes makes me think that
the CP is being kicked off, and someone gets slowed down/stopped, then the
FIFO overflows.  So I'm getting however many bytes the CP can process at the
start of a transmissions plus the 32 bytes in the FIFO before the overflow
occurs.  So if this is true, what could stop the CP from running?

Tim
