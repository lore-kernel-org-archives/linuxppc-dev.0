Message-ID: <3856B837.CAC7CCE9@email.sps.mot.com>
Date: Tue, 14 Dec 1999 15:35:51 -0600
From: "Richard Hendricks" <ra6353@email.sps.mot.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: fads823 ethernet interface does (seams) not send data
References: <OF18F33680.CFE448E8-ON00256843.003AAE59@flaga.is> <38515AF9.3F756E5E@netx4.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The problem may lie with the multiplexing of the pins for the (not
availible) softmodem.  The short story is to look at page 6 of 9 of the
MPC823FADSDB schematics. That 74LCX257 does some routing control of
various signals, and may be causing some confusion and pain.  The MPC823
FADS User's Manual should also have a picture on page 4-7 and a
discussion on page 4-6 about this "feature".  The important thing is the
picture, it shows how all the signals are REALLY connected between the
daugthercard and motherboard.

In your case, you'll notice that the PA7/ETHTCK from the motherboard is
really connected to PA5/ETHTCK on the daughtercard.  I have seen
Ethernet working on the MPC823FADS board, so I know it CAN be done.

Dan Malek wrote:
> 
> kd@flaga.is wrote:
> 
> > Is it possible that this has something to do with the microcode patch
> > presented in 2.213?
> 
> No, it has nothing to do with that.  It is only skeleton code
> that someday may perform a patch.  The drivers are not yet
> updated to handle it.  The microcode patches either work
> correctly or not at all, there is no in between.
> 
> I have never used an SCC Ethernet on the FADS, but there must
> be control register bits or other 8xx general purpose I/O
> pins that are required to be set correctly for the Ethernet PHY
> to operate correctly.  You have to also make sure all of the
> SCC clock and I/O pins are properly configured for the hardware
> design.  I can guarantee some of this may not be correct for
> the 823 FADS, as all boards seem to use something different.
> 
> The 8xx SCC Ethernet driver will only run on half duplex mode.
> There is no auto sensing like is provided on (some) FEC 10/100
> Ethernet PHYs.  The SCC (and FEC) has to be configured differently
> for half or full duplex operation.
> 
>         -- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
