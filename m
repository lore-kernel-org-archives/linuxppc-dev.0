Message-ID: <38C95488.7DBC1DC6@amberdata.demon.co.uk>
Date: Fri, 10 Mar 2000 20:01:12 +0000
From: David Monro <davidm@amberdata.demon.co.uk>
MIME-Version: 1.0
To: Gabriel Paubert <paubert@iram.es>
CC: Linux/ppc Workstation List <linuxppc-workstation@lists.linuxppc.org>,
        Linux/ppc Dev List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.3 on 850
References: <Pine.HPX.4.10.10003101128250.22162-100000@gra-ux1.iram.es>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Gabriel Paubert wrote:
>
[..]
> > What happened to my boot arguments?????
>
> Don't know, perhaps problems with this bootinfo thing...
?? What's this?

>
> > Further down:
> > Setting PCI interrupts for a "IBM 8xx (Carolina)"
> > Relocating PCI address 20000000 -> 1000000
> > PCI: Address space collision on region 0 of device Symbios Logic Inc.
> > (formerly NCR) 53c825
> > PCI: Address space collision on region 0 of device Weitek P9100
> > PCI: Address space collision on region 6 of device Weitek P9100
> >
> > This is sort of OK. What has happened here is that the '825 has an I/O
> > region at 0x01000000, and the P9100 has a memory region as 0x01000000.
>
> Is it an I/O or a memory region ? Anyway the remapping in the kernel
> is dangerous and something is wrong as soon as you get this kind of
> message (except for the ROM). I solved the problem in my bootloader
> by reallocating all PCI resources from scratch, making sure there would
> never be any conflict.

Fair enough :-) I'll have to grab your bootloader code and have a
play...
>
> > Is this legal or not? The collision on address space 6 is almost
> > certainly the bios at 0xc0000 clashing with the one for the onboard S3
> > 864. Since the P9100 doesn't actually have a bios in the rom socket I'm
> > not too worried about this :-)
>
> Even then, it means that 2 slaves might respond to an acess at ISA memory
> space at 0xc0000 if both ROMs are enabled, and cause conflicts on the bus.
> The other one is definitely serious. what do /proc/ioports /proc/iomem and
> /proc/pci (or lspci -vvxxx) report ?

The rom area is marked disabled for both video devices in lspci.

Having finally managed to get a shell on this thing using a floppy for
the root fs:
/proc/ioports:
000001f0-000001f0 : ide0
000001f1-000001f1 : ide0
000001f2-000001f2 : ide0
000001f3-000001f3 : ide0
000001f4-000001f4 : ide0
000001f5-000001f5 : ide0
000001f6-000001f6 : ide0
000001f7-000001f7 : ide0
000002f8-000002ff : serial(auto)
000003f6-000003f6 : ide0
000003f8-000003ff : serial(auto)
00001000-00001007 : IBM Fire Coral
00009032-00009032 : ide0
01000200-0100021f : Advanced Micro Devices [AMD] 79c970 [PCnet LANCE]

/proc/iomem:
000c0000-000cffff : S3 Inc. 86c864 [Vision 864 DRAM] vers 1
013fff00-013fffff : Symbios Logic Inc. (formerly NCR) 53c825

/proc/pci (don't have lspci on floppy):
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Motorola MPC105 [Eagle] (rev 36).
  Bus  0, device  11, function  0:
    ISA bridge: IBM Fire Coral (rev 2).
      I/O at 0x1000 [0x1007].
  Bus  0, device  12, function  0:
    Ethernet controller: Advanced Micro Devices [AMD] 79c970 [PCnet
LANCE] (rev 22).
      IRQ 15.
      Master Capable.  Latency=211.  Min Gnt=6.Max Lat=255.
      I/O at 0x1000200 [0x100021f].
      Non-prefetchable 32 bit memory at 0x0 [0x1f].
  Bus  0, device  14, function  0:
    VGA compatible unclassified device: S3 Inc. 86c864 [Vision 864 DRAM]
vers 1 (rev 0).
      IRQ 10.
      Non-prefetchable 32 bit memory at 0x0 [0x7fffff].
  Bus  0, device  18, function  0:
    SCSI storage controller: Symbios Logic Inc. (formerly NCR) 53c825
(rev 2).
      IRQ 10.
      Master Capable.  Latency=128.
      I/O at 0x1000000 [0x200000ff].
      Non-prefetchable 32 bit memory at 0x13fff00 [0x13fffff].
  Bus  0, device  22, function  0:
    VGA compatible controller: Weitek P9100 (rev 0).
      IRQ 10.
      Non-prefetchable 32 bit memory at 0x1000000 [0x1ffffff].

As you can see, it's a bit of a mess! I've no idea what it thinks is in
the way of the second set of ide ports. The end address of the '825 I/O
regioin hasn't been remapped, so it clashes with the lance. The lance
and the S3 864 both have memory at 0x0? and the memory area for the 825
is right in the middle of the P9100 area. Yuck!

It looks a little bit different (and somewhat saner) under 2.2:
/proc/ioports:
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0074-007b : PReP NVRAM
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial(set)
0376-0376 : ide1
03f6-03f6 : ide0
03f8-03ff : serial(set)
1000200-100021f : PCnet/PCI II 79C970A


lspci -v
00:00.0 Host bridge: Motorola MPC105 [Eagle] (rev 24)
        Flags: bus master, fast devsel, latency 0

00:0b.0 ISA bridge: IBM Fire Coral (rev 02)
        Flags: bus master, slow devsel, latency 0
        I/O ports at 1000

00:0c.0 Ethernet controller: Advanced Micro Devices [AMD] 79c970 [PCnet
LANCE] (rev 16)
        Flags: bus master, medium devsel, latency 211, IRQ 15
        I/O ports at 1000200

00:0e.0 VGA compatible unclassified device: S3 Inc. 86c864 [Vision 864
DRAM] vers 1
        Flags: medium devsel, IRQ 10
        Expansion ROM at 000c0000 [disabled]

00:12.0 SCSI storage controller: Symbios Logic Inc. (formerly NCR)
53c825 (rev 02)
        Flags: medium devsel, IRQ 10
        I/O ports at 1000000 [disabled]
        Memory at 013fff00 (32-bit, non-prefetchable) [disabled]

00:16.0 VGA compatible controller: Weitek P9100 (prog-if 00 [VGA])
        Flags: stepping, medium devsel, IRQ 10
        Memory at 01000000 (32-bit, non-prefetchable)
        Expansion ROM at 000c0000 [disabled]

Cheers,

	David

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
