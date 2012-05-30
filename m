Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by ozlabs.org (Postfix) with SMTP id 0EC1DB704F
 for <linuxppc-dev@ozlabs.org>; Thu, 31 May 2012 01:18:48 +1000 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 14761-03 for <linuxppc-dev@ozlabs.org>;
 Wed, 30 May 2012 16:11:23 +0100 (BST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: MPC8315 PCI express lockup
Date: Wed, 30 May 2012 16:10:37 +0100
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6026B6F33@saturn3.aculab.com>
From: "David Laight" <David.Laight@ACULAB.COM>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

(I apologise for this not having much to do with linux...)

We have a system with an MPC8315 ppc running linux 2.6.32
that uses the PCI express interface in RC mode to interface
to an Altera FPGA.
This uses both PIO and the PEX DMA interfaces (locally
written dma driver).
Under normal circumstances this all works fine.

However under some circumstances (eg DMA reads from
addresses that don't have actual slaves on the fpga [1])
the dma transfer requests don't complete.
There are no obvious error bits set in the hisr or csmisr
registers and the csb_status shows 'dma in progress'.
The dma transfer itself can be cancelled (by setting the
SUS bit in the dma_ctrl register), and the relevant
status bit are set to show the transfer has been aborted.

Once in this state all further PCI express transfers fail.
DMA requests timeout (driver gives up waiting for completion)
and PIO requests fault (Oops: Machine check, sig 7 [#1])
locking the kernel solid.

This looks very much like the MPC8315's errata PEX7
except that I don't see the CSMISR[RST] bit set.
I'm not at all sure the recovery for that errata is
actually writable! I'm certainly not going to write it
just to find out if it would help.
In any case it is quite likely that the driver's ISR will
try to do a PIO read while a dma transfer is timing out.

We can look at the fpga side and possibly find out
what it is doing, but it would be useful to know more
about the status on the ppc side.

I presume there is a way of doing a 'probe' type memory
cycle that won't panic on a fault?
Although that may not help me keep linux running as the
ISR needs to to a PCIe write to remove the level-sensitive
interrupt.

Any thought on ways to progress?

	David

[1] PIO reads are ok and just return 0xffffffff.
