Return-Path: <nbarendt@vxitech.com>
Received: from vxitech.com (mail.atiba.com [216.153.79.104])
	by ozlabs.org (Postfix) with ESMTP id 7502467A6B
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Mar 2005 11:50:37 +1100 (EST)
Message-Id: <5.2.1.1.0.20050310185814.02b26630@mail.atiba.com>
Date: Thu, 10 Mar 2005 19:27:25 -0500
To: linuxppc-dev@ozlabs.org
From: Nick Barendt <nbarendt@vxitech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Subject: MPC5200 PCI TX/RX FIFO
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



         Has anyone had luck getting the MPC5200 PCI RX or TX FIFOs 
working, either directly or with Bestcomm DMA support?  I've been trying to 
do so for a few weeks, on and off, with little luck.  I'm probably missing 
something obvious.
         I'm using Wolfgang's kernel tree, on a board similar to the IceCube.
         I'd like to use the PCI RX FIFO to speed up moving data from a PCI 
device - it looks like the RX FIFO is the most straight-forward mechanism 
for bursting.  I've had some luck getting the RX FIFO to pull data back 
from a PCI device, and can get a peripheral interrupt from the RX FIFO, but 
no matter what I do (read data from FIFO to DDR, clear status bits, etc.), 
I can't seem to acknowledge the interrupt at the peripheral end, so it 
continues to fire.  I can't find anything in the MPC5200 user manual about 
acknowledging the interrupt in the PCI controller, unlike the FEC, say, 
which has documentation on how to ack FEC interrupts.
         I then went the Bestcomm route, using the Bestcomm API, but I'm 
clearly missing something there, because the DMA engine indicates a TEA 
after a very long timeout.  That problem might be related to my PCI RX FIFO 
interrupt problem, or might be completely different.  Might it be that the 
Alarm signal to the DMA engine is the same as the interrupt signal to the core?
         In the end, I'd like to go the DMA route.  It is likely that using 
the RX FIFO would be a significant improvement over what I have right now, 
though, and it is (hopefully) easier to get up and running.
         Does anyone have any wisdom (or, better yet, sample code :-) they 
can share on this?



Nick Barendt
VXI Technology, Inc.
Cleveland Instruments Division
5425 Warner Road, Suite 13
Valley View, OH 44125
PH:  216-447-4059
FAX: 216-447-8951
nbarendt@vxitech.com
