Date: Mon, 17 Apr 2000 10:19:19 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: David Monro <davidm@amberdata.demon.co.uk>
cc: Linux/ppc Dev List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: prep interrupt routing
In-Reply-To: <38F77A99.7A233BC8@amberdata.demon.co.uk>
Message-ID: <Pine.HPX.4.10.10004170952310.6016-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 14 Apr 2000, David Monro wrote:

> I've had my suspicions for a little while that all is not quite right
> with the kernel interrupt routing for the IBM 850, caused by the
> behaviour of my SCSI controller (the ncr53c8xx driver ended up in a loop
> which looked exactly like what happens on an intel PC when the interrupt
> routing is wrong). Looks like I'm right. Dumping the residual data on my
> 850 shows that all PCI interrupts are mapped to IRQ 15:
>
> Integrated PCI device DevFunc 0x58 interrupt line(s)  routed to 8259
> line(s) 8259
> Integrated PCI device DevFunc 0x60 interrupt line(s) A routed to 8259
> line(s) 15(L)
> Integrated PCI device DevFunc 0x70 interrupt line(s) A routed to 8259
> line(s) 15(L)
> Integrated PCI device DevFunc 0x80 interrupt line(s) A routed to 8259
> line(s) 15(L)
> PCI Slot 1 DevFunc 0xb0 interrupt line(s) A/B/C/D routed to 8259 line(s)
> 15(L)/15(L)/15(L)/15(L)
> PCI Slot 2 DevFunc 0x90 interrupt line(s) A/B/C/D routed to 8259 line(s)
> 15(L)/15(L)/15(L)/15(L)

It looks like the output of my residual data dump code :-), and the first
line shows a bug in my code (harmless, but then I had never found residual
data which specifies that a device has no interrupt lines).

>
> DevFunc 0x58 is dev 0xb0, the Fire Coral ISA bridge, with no interrupts.
> DevFunc 0x60 is dev 0xc0, the onboard ethernet.
> DevFunc 0x70 is dev 0xe0, the onboard video.
> DevFunc 0x80 is dev 0x10, which I don't have but would be onboard SCSI
> on a 7248.
> DevFunc 0xb0 is def 0x16, which is an ncr53c825 SCSI card.
> DevFunc 0x90 is dev 0x12, which is currently a GXT-150P graphics board.
>
> Forcing the interrupt line to be 15 for all PCI devices (by hacking
> prep_pci.c) means that my SCSI host adapter is now detected and
> initialized correctly.

Good...

>
> Of course putting all of the devices on irq 15 doesn't seem like a
> particularly good idea. Does anybody know a) which chip is responsible
> for the mapping and b) how to reprogram it?

The chip is often the PCI<->ISA bridge which has registers to route PCI
interrupts to specific 8259 inputs. But I dno't know have the spec of your
PCI/ISA bridge at hand. For example a WinBond 83c553F has 4 inputs for PCI
interrupts which are routed to specific 8259 inputs by a 16 bit
configuration space register in which each hex nibble determines the
routing of one of the PCI interrupt inputs.

Intel chipsets often have a 32 bit register with one byte for each
interrupt line (but the high order nibble is stuck at zero).

It is still possible that your ISA bridge has only one input pin for PCI
interrupts and that its routing hardwired to IRQ 15. Actually I suspect
that this is the case. Just try lspci -xxxsb.0:

[root@vlab1 linux-test]# lspci -xxxsb.0
00:0b.0 ISA bridge: Symphony Labs W83C553 (rev 04)
[snipped]
40: 24 04 00 00 ef ab 78 00 f1 00 00 00 00 33 04 00
                ^^^^^
Or 0xabef in right byte order: meaning routing to IRQs 10/11/14/15,
although I don't use these any more since the board has an OpenPIC (but
PPCBUUG disagnostics would be very upset if I changed it).

	Regards,
	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
