Subject: i8259 and unhandled interrupt
To: linuxppc-embedded@lists.linuxppc.org
From: "Philippe Villet" <philippe.villet@acterna.com>
Date: Fri, 22 Nov 2002 17:42:44 +0100
Message-ID: <OF9F693509.7B2D00DF-ONC1256C79.0057DC5A@eng.eni.wago.de>
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


We have a custom board with a 405GP connected to a PIIX4 southbridge. The
PIIX4 contains 2 cascaded 8259 interrupt controllers (16 irqs).
2 IDE buses where connected to IRQ14 and IRQ15 with success(Hard Disk,
CD-RW work fine). IRQ5 is connected to an SMSC37C78 floppy controller.
During the floppy.o module insertion (with appropriate IRQ and DMA ), i've
got 3 PIIX4 interrupts (2 correct IRQ5 and an unhandled IRQ0 (PIIX4
internal timer)).
If i have a look with a logical analyser, the 3rd IRQ seems also generated
by the Floppy controller(IRQ5) but was read as an IRQ0 and (the 3rd)IRQ5 is
never acknowledge.
Does anyone met this pb ?
The insmod command doesn't seem to fail but the mount /dev/fd0 /mnt/floppy
command fail because no more IRQ5 are genereted.
Any idea ?

Thanks - Philippe.

Note : I'am running MVL PE (2.4.17) with hollis patch for the i8259.c (
http://lists.linuxppc.org/linuxppc-dev/200112/msg00043.html )


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
