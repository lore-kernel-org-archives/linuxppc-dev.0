Date: Tue, 26 Nov 2002 16:29:32 -0600
From: Nicholas Riley <njriley@uiuc.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: Promise 20267 can't recognize IDE device or freezes
Message-ID: <20021126222932.GA2805891@uiuc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I have an ATAPI Seagate (Conner) Travan tape drive which I recently
removed from my Power Mac G4 running OS X.  It worked fine with
Retrospect on the internal ATA bus and through a FireWire bridge.

I want to use the drive for backups on my Power Mac 9500 running
Linux.  I bought a Promise Ultra100 card as it appeared to be
supported under PowerPC Linux, and installed the card and tape drive
into the machine.  For obvious reasons (no driver support) I can't
test whether it works under Mac OS.

I was using kernel 2.4.18-ben0 compiled in March, with IDE as a module
I compiled yesterday.  According to what I read either ide-scsi or
ide-tape should work, but I couldn't get the device to show up.

The output I saw was exactly as this message discusses:

<http://lists.linuxppc.org/linuxppc-dev/200105/msg00130.html>

Here is the dmesg output:

Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PDC20267: IDE controller on PCI bus 00 dev 70
PCI: Enabling device 00:0e.0 (0004 -> 0007)
PDC20267: chipset revision 2
PDC20267: not 100% native mode: will probe irqs later
PDC20267: ROM enabled at 0x80820000
PDC20267: (U)DMA Burst Bit DISABLED Primary PCI Mode Secondary PCI Mode.
    ide2: BM-DMA at 0x0400-0x0407, BIOS settings: hde:pio, hdf:DMA
    ide3: BM-DMA at 0x0408-0x040f, BIOS settings: hdg:pio, hdh:pio

In the following thread:

<http://lists.linuxppc.org/linuxppc-user/199907/msg01838.html>

when someone had the same problem in a 2.2 kernel, they were able to
fix it by building with ide-pmac even though internal IDE is not used.

I updated to the latest 2.4.20-rc3-ben0 from yesterday and tried
compiling with ide-pmac and the other options recommended by Andre
Hedrick in his message in that thread (CONFIG_BLK_DEV_OFFBOARD).  Now
I get the following on boot:

Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PDC20267: IDE controller on PCI bus 00 dev 70
PDC20267: chipset revision 2
PDC20267: not 100% native mode: will probe irqs later
PDC20267: ROM enabled at 0x80820000
PDC20267: (U)DMA Burst Bit DISABLED Primary PCI Mode Secondary PCI Mode.
	ide0: BM-DMA at 0x0400-0x0407, BIOS settings: hda:pio, hdb:DMA
	ide1: BM-DMA at 0x0408-0x040f, BIOS settings: hdc:pio, pdd:pio
Probing IDE interface ide0...
disabling irq 24 defensively
hdb: CONNER CTT8000-A, ATAPI TAPE drive
Probing IDE interface ide1...
[freeze]

If I disable IDE completely, then the 2.4.20-pre3-ben0 kernel usually
boots correctly (sporadically it doesn't, but much earlier than the
IDE kernel dies, so I don't think it's related).

The kernel configuration that works for me is here:

<http://web.sabi.net/promise/config-no-ide-boots.txt>

and the configuration which failed here:

<http://web.sabi.net/promise/config-ide.txt>

Any suggestions on how to troubleshoot (or fix) this problem would be
much appreciated.  Do I need another kernel, different options,
another IDE driver?

Thanks,

--
=Nicholas Riley <njriley@uiuc.edu> | <http://www.uiuc.edu/ph/www/njriley>
        Pablo Research Group, Department of Computer Science and
  Medical Scholars Program, University of Illinois at Urbana-Champaign

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
