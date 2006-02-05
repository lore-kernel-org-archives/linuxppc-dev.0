Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "sabrina.ovro.caltech.edu",
	Issuer "sabrina.ovro.caltech.edu" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 4A23768A5A
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  5 Feb 2006 15:39:36 +1100 (EST)
Received: from ovro.ovro.caltech.edu
	(IDENT:U2FsdGVkX18kt5tAPx1kAdCDiGITsyw8gwf5c+Wb6Pw@ovro.ovro.caltech.edu
	[192.100.16.2])
	by ovro.ovro.caltech.edu (8.13.1/8.13.1) with SMTP id k154dXR0008250
	for <linuxppc-embedded@ozlabs.org>; Sat, 4 Feb 2006 20:39:33 -0800
Message-ID: <43E58202.8020000@ovro.caltech.edu>
Date: Sat, 04 Feb 2006 20:41:38 -0800
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Yosemite/440EP PLB4 vs PLB3 DMA to PCI issue
References: <35786B99AB3FDC45A8215724617919736D921C@gbrwgceumf01.eu.xerox.net>	<20060202094641.GB12810@gate.ebshome.net>	<20060202073700.B27740@cox.net>	<20060202174504.GE12810@gate.ebshome.net>
	<20060202111603.B28536@cox.net>
In-Reply-To: <20060202111603.B28536@cox.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi all,

I've been testing the PLB4 and PLB3 DMA controllers
for memory-to-memory transfers between the Yosemite
board SDRAM and a PCI board.

The PCI board contains a PLX PCI-9054 PCI controller
(PCI-to-local bus bridge), and the board contains
SDRAM at the addresses I was testing DMA.

So, the test is basically:

Yosemite SDRAM <-> 440EP bridge <-> PLX-9054 bridge <-> SDRAM

Here's the problem/issue:

PLB4 burst DMA reads are performed as blocks of 32-bytes
(8 transfers of 4-bytes), with the PCI command code
toggling between memory-read-multiple (MRM) and
then memory-read-line (MRL). The change in PCI command
code causes the PLX-9054 controller to consider each
32-byte burst to be a new transaction, and hence
it flushes its internal read FIFO and disconnects from
the local bus for each burst.

The PLB3 DMA controller does not do this, it always
bursts using a memory-read-line (MRL) PCI command code.
Hence the PLX-9054 can determine that the next 32-byte
burst follows on from the previous, and it can deliver
data from its internal FIFOs.

The performance results for transfers between the
Yosemite SDRAM and a device on the 33MHz/32-bit PCI bus were;

   DMA controller    Read          Write
   --------------    ----          -----

      PLB4           19.9MB/s     46.5MB/s

      PLB3           46.0MB/s     46.7MB/s

For the curious, here is the section from my test doc
containing logic analyzer traces;

http://www.ovro.caltech.edu/~dwh/yosemite_440ep_dma.pdf

The performance is below that of the maximum 132MB/s
achievable on the PCI bus. But since the DMA controllers
on the 440EP have to first read and then write,
I don't expect the DMA to do much better than 60MB/s.
So, the ~50MB/s I observed for the majority of tests
seems pretty reasonable.

I haven't had a chance to look at the 440EP PCI bridge
configuration registers that might lead to the use of the
MRM/MRL commands. I'll do that next. I just figured I'd
post these results now, so that others reading this
list might comment (Stefan from Denx comes to mind :))

Cheers
Dave
