Date: Wed, 11 Aug 2004 02:14:44 +0200 (MEST)
Message-Id: <200408110014.i7B0Eit6017963@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: linux-ide@vger.kernel.org, linuxppc-dev@lists.linuxppc.org
Subject: PDC20269 problems on PowerMac with 2.4.27 kernel
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have a PowerMac G3 (beige) upgraded with a 1GHz G4 processor
and a PDC20269 (Promise Ultra 133 TX2) IDE PCI controller,
which works reliably with the 2.6.8-rc kernels. The controller,
disk, and cable also work in an x86 box with both 2.6 and 2.4 kernels.

However, with 2.4.27 on the PowerMac I frequently get DMA timeouts
while doing heavy I/O operations like a cp -ax from my scsi root
to a partition on the PDC20269's disk:

hde: dma_timer_expiry: dma status == 0x20
hde: timeout waiting for DMA
PDC202XX: Primary channel reset.
hde: timeout waiting for DMA
hde: (__ide_dma_test_irq) called while not waiting
hde: status error: status=0x58 { DriveReady SeekComplete DataRequest }

hde: drive not ready for command

Occasionally I instead get EXT3 meta-data errors, which I suspect
are caused by data corruption.

I've compared lspci -vvx on 2.4 and 2.6, but the only difference
is a ParErr setting on the 53c875 SCSI controller.

There are some differences in /proc/ide/ide2/hde/settings between
2.4 and 2.6, for multicount and wcache, but I don't know if they're
relevant. (Manually setting multicount on 2.4 to zero like 2.6 reports
it leads to immediate data corruption. Weird.)

I've disabled IDEDMA_AUTO and manually lowered the transfer mode to
udma3 or even udma2, but that doesn't help at all. It does udma4 w/o
problems in 2.6 kernels.

Strangely enough, the card worked better earlier when the box still
had its original 300MHz CPU. It did throw _one_ error at kernel
boot-up, but never anything afterwards. Disabling IDEDMA_AUTO
silenced that error.

Any ideas on what might be causing this? At this point I'm beginning
to suspect big-endian or timing bugs in pdc202xx_new.c, or a general
problem with IDE/DMA/PCI in the 2.4.27 kernel on ppc32/pmac.

/Mikael

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
