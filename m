Return-Path: <chuckmeade@mindspring.com>
Received: from elasmtp-banded.atl.sa.earthlink.net
	(elasmtp-banded.atl.sa.earthlink.net [209.86.89.70])
	by ozlabs.org (Postfix) with ESMTP id DA4CDDE121
	for <linuxppc-dev@ozlabs.org>; Sat, 23 May 2009 22:13:14 +1000 (EST)
Message-ID: <4A17E7FD.1070905@mindspring.com>
Date: Sat, 23 May 2009 08:11:41 -0400
From: Chuck Meade <chuckmeade@mindspring.com>
MIME-Version: 1.0
To: Hunter Cobbs <hunter.cobbs@gmail.com>
Subject: Re: PPC405EX based irq flooding with USB-OTG and usbserial device
References: <ad84a70a0905222048i4e7ae5ddp66418f96d531f5f3@mail.gmail.com>
In-Reply-To: <ad84a70a0905222048i4e7ae5ddp66418f96d531f5f3@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hunter Cobbs wrote:
> Hello everyone,
> 
> This is my first post to the PPC dev list as my company has just started
> developing a new project based on Linux.  The good news is, this post is
> not debug-related as much as it is an introduction and query while I
> download the latest DENX kernel(only place I know that has the DWC_OTG
> driver).
> 
> I've been working with a Kilauea dev board and have had lots of trouble
> when I plug in a sierra-wireless modem dev kit on the USB.  It goes fine
> untill I actually try to communicate(pppd or minicom) with the little
> bugger and then my IRQs go through the roof.  And they only calm back
> down after I shut down my communicaiton channel.
> 
> I've solved this issue with our board, and was wondering if it has since
> been fixed (I'm running 2.6.25-DENX).  I don't want to waste the board's
> time with a patch that is no longer necesarry.
> 
> -- 
> Hunter Cobbs

Hello Hunter,

It would absolutely *not* be a waste of anyone's time.  I for one would like
to see how you solved this.  I am dealing with the same problem, with the same
setup.

The underlying cause for this problem is the PPC405EX CPU's erratum USBO_9.
The USB 2.0 PING protocol is supposed to handle a PING transaction in
the hardware -- note that in USB 2.0, a PING is the method used by the sender to
determine if it can send.  If I remember correctly, erratum USBO_9 is caused when
a NAK response from the PING transaction is handled not in hardware, but instead
as an interrupt in software, and that NAK leads to a lot of processing.  In the
2.6.25 Denx Linux tree that I used, that processing ends up trying to restart the
channel, restart the send, which leads to yet another PING/NAK sequence, yet another
interrupt...

The end result is that you get over 100,000 interrupts (with significant interrupt
handling logic) per second, and the target can't do anything else.  I was able
to get this interrupt count by looking at /proc/interrupts, then causing this problem
for 20 seconds, then pulling out the USB modem physically (mine is on a Express card)
to stop the interrupt storm, then checking /proc/interrupts again.  Averaged over
100,000 ints/sec.

In contact with AMCC, they told us they are not respinning the CPU (at least not
at this time) to fix this erratum.

I have tried to solve the problem as suggested by the erratum, by not allowing the
NAK interrupt handling to *directly* cause a retry of the send, but rather to wait
until the next SOF interrupt (start of microframe, which happens 8,000 times per sec)
to restart it.  "Breaking the chain" like this does allow the board to proceed, but
I think it is suboptimal, or at least unfortunate.

One painful side effect of this workaround is that you cannot disable the 8,000 SOF
interrupts/second, or at least some of them, since they are being used now for another
purpose -- recovery from the erratum.

The 8000 SOF ints being handled per second do cause a measurable drain on the
CPU.  In some cursory testing we see a 10% slowdown of certain transactions in
lmbench.

So please send me your patch for the dwc_otg driver.  I am very interested in what
you did, and if it perhaps is a better solution for the problem we both are seeing
than what I implemented.

Thanks in advance,
Chuck
