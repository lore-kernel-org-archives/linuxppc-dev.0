Date: Thu, 30 Mar 2000 22:59:08 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Michel Dänzer <michdaen@iiic.ethz.ch>, Gabriel Paubert <paubert@iram.es>,
        Benjamin Herrenschmidt <bh40@calva.net>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: LongTrail PCI resource assignment
In-Reply-To: <Pine.LNX.4.05.10003292157410.28211-100000@callisto.of.borg>
Message-ID: <Pine.LNX.4.10.10003301038370.19296-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> The example considers PCI memory space only. PCI I/O space is left as an
> exercise for the reader :-)

I played a bit with PCI resource remapping in 2.2.15pre9 and I've got a
few questions, one of them dealing with PCI I/O space:

- OF reports two base addresses for the Mach64, one of which is the I/O
region (according to the PCI BAR values) at 0xc00. OF reports its address
as 0x80881000 or some such. Does this mean the I/O registers are
accessible at 0x80881000, or did OF probing get some bogus values there?

- I can successfully remap the MMIO range of the chip to some area outside
the VRAM range. XFree86 no longer barfs on the mem resource conflict
(though it still reports the I/O resource conflict with the DVD decoder),
reports the new mapping of the MMIO range, and starts up nicely. lspci -vv,
however, still reports the old range. Where's that one stored
(assuming /proc/pci somewhere), and wouldn't it make more sense to have
the PCI bus rescanned on reading /proc/pci entries?

- I picked a range to remap MMIO to more or less at random. How can I find
out what ranges are believed to be unassigned from OF data?

Too lazy to read all of the source,

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
