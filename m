Message-ID: <38515AF9.3F756E5E@netx4.com>
Date: Fri, 10 Dec 1999 14:56:41 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: kd@flaga.is
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: fads823 ethernet interface does (seams) not send data
References: <OF18F33680.CFE448E8-ON00256843.003AAE59@flaga.is>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


kd@flaga.is wrote:


> Is it possible that this has something to do with the microcode patch
> presented in 2.213?


No, it has nothing to do with that.  It is only skeleton code
that someday may perform a patch.  The drivers are not yet
updated to handle it.  The microcode patches either work
correctly or not at all, there is no in between.

I have never used an SCC Ethernet on the FADS, but there must
be control register bits or other 8xx general purpose I/O
pins that are required to be set correctly for the Ethernet PHY
to operate correctly.  You have to also make sure all of the
SCC clock and I/O pins are properly configured for the hardware
design.  I can guarantee some of this may not be correct for
the 823 FADS, as all boards seem to use something different.

The 8xx SCC Ethernet driver will only run on half duplex mode.
There is no auto sensing like is provided on (some) FEC 10/100
Ethernet PHYs.  The SCC (and FEC) has to be configured differently
for half or full duplex operation.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
