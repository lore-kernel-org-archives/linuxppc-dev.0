Message-ID: <3B678DB5.B84E8751@airways.com>
Date: Tue, 31 Jul 2001 22:03:49 -0700
From: "D. Lance Robinson" <lancer@airways.com>
Reply-To: lancer@airways.com
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: All PCI Interrupts are at (1)
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

Somewhere between 2.4.5 and 2.4.7 the PCI interrupts are being set to
(or being left at) IRQ 1 and things ain't working. Everything else in
the PCI configuration data seems correct, just the IRQ is screwy.

This issue may not be PPC related, but my environment is a modified PREP
using the Windbond PCI bridge and PPC 750. Below is /proc/pci
information.

I notice in the diffs between 2.4.5 and 2.4.7 that the file
linux/drivers/pci/syscall.c that had pci_fixup_irqs() was removed. There
have also been changes in the /arch/ppc/kernel/pci* code.

Any ideas?

Thanks.
<>< Lance.


bash-2.03# cat /proc/pci

PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Motorola MPC106 [Grackle] (rev 64).
  Bus  0, device  11, function  0:
    ISA bridge: Symphony Labs W83C553 (rev 16).
  Bus  0, device  11, function  1:
    IDE interface: Symphony Labs SL82c105 (rev 5).
      IRQ 14.
      Master Capable.  No bursts.  Min Gnt=2.Max Lat=40.
      I/O at 0x1f0 [0x1f7].
      I/O at 0x3f4 [0x3f7].
      I/O at 0x170 [0x177].
      I/O at 0x374 [0x377].
      I/O at 0x1000 [0x100f].
      I/O at 0x1010 [0x101f].
  Bus  0, device  12, function  0:
    Ethernet controller: Digital Equipment Corporation DECchip 21142/43
(rev 65).
      IRQ 1.
      Master Capable.  Latency=32.  Min Gnt=20.Max Lat=40.
      I/O at 0x8000 [0x807f].
      Non-prefetchable 32 bit memory at 0x80880000 [0x808803ff].
  Bus  0, device  13, function  0:
    Ethernet controller: Digital Equipment Corporation DECchip 21142/43
(#2) (rev 65).
      IRQ 1.
      Master Capable.  Latency=32.  Min Gnt=20.Max Lat=40.
      I/O at 0x8080 [0x80ff].
      Non-prefetchable 32 bit memory at 0x80881000 [0x808813ff].
  Bus  0, device  14, function  0:
    SCSI storage controller: Symbios Logic Inc. (formerly NCR) 53c896
(rev 5).
      IRQ 1.
      Master Capable.  Latency=32.  Min Gnt=17.Max Lat=64.
      I/O at 0x8400 [0x84ff].
      Non-prefetchable 64 bit memory at 0x80882000 [0x808823ff].
      Non-prefetchable 64 bit memory at 0x80884000 [0x80885fff].
  Bus  0, device  14, function  1:
    SCSI storage controller: Symbios Logic Inc. (formerly NCR) 53c896
(#2) (rev 5).
      IRQ 1.
      Master Capable.  Latency=32.  Min Gnt=17.Max Lat=64.
      I/O at 0x8800 [0x88ff].
      Non-prefetchable 64 bit memory at 0x80886000 [0x808863ff].
      Non-prefetchable 64 bit memory at 0x80888000 [0x80889fff].
  Bus  0, device  18, function  0:
    SCSI storage controller: Q Logic ISP2100 (rev 4).
      IRQ 1.
      Master Capable.  Latency=32.
      I/O at 0x8c00 [0x8cff].
      Non-prefetchable 32 bit memory at 0x8088a000 [0x8088afff].

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
