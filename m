Date: Fri, 10 Mar 2000 13:38:58 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: David Monro <davidm@amberdata.demon.co.uk>
cc: Hollis R Blanchard <hollis+@andrew.cmu.edu>,
        Linux/ppc Workstation List <linuxppc-workstation@lists.linuxppc.org>,
        Linux/ppc Dev List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.3 on 850
In-Reply-To: <38C82F79.2094DDEF@amberdata.demon.co.uk>
Message-ID: <Pine.HPX.4.10.10003101128250.22162-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Thu, 9 Mar 2000, David Monro wrote:

> Well I've had a little look at this today, and something is a bit
> twisted. I've compiled it up with no vga console or framebuffer built
> in, just the serial console. I get some interesting output:
>
> loaded at:     00480410 00495230
> relocated to:  00800000 00814E20
> board data at: 00121FE0 001289EC
> relocated to:  0080E314 00814D20
> zimage at:     0048B410 0053054E
> relocated to:  00815000 008BA13E
> avail ram:     00400000 00800000
>
> Linux/PPC load: console=ttyS0,9600 hdc=swapdata hda=3079,64,32
> root=/dev/hda5 -b
> Uncompressing
> Linux...done.
> Now booting the kernel
> PReP architecture
> Total memory = 160MB; using 1024kB for hash table (at c0300000)
> Linux version 2.3.50 (davidm@fuzzbox) (gcc version 2.95.2 19991024
> (release)) #2 Thu Mar 9 22:37:05 GMT 2000
> kmem_alloc: NULL ptr (name=unknown)
> Boot arguments:
> kmem_alloc: NULL ptr (name=unknown)
> kmem_alloc: NULL ptr (name=unknown)
> kmem_alloc: NULL ptr (name=unknown)
> kmem_alloc: NULL ptr (name=unknown)
> kmem_alloc: NULL ptr (name=unknown)
> kmem_alloc: NULL ptr (name=unknown)
> On node 0 totalpages: 40960
> zone(0): 40960 pages.
> zone(1): 0 pages.
> zone(2): 0 pages.
>
> What happened to my boot arguments?????

Don't know, perhaps problems with this bootinfo thing...


> Further down:
> Setting PCI interrupts for a "IBM 8xx (Carolina)"
> Relocating PCI address 20000000 -> 1000000
> PCI: Address space collision on region 0 of device Symbios Logic Inc.
> (formerly NCR) 53c825
> PCI: Address space collision on region 0 of device Weitek P9100
> PCI: Address space collision on region 6 of device Weitek P9100
>
> This is sort of OK. What has happened here is that the '825 has an I/O
> region at 0x01000000, and the P9100 has a memory region as 0x01000000.

Is it an I/O or a memory region ? Anyway the remapping in the kernel
is dangerous and something is wrong as soon as you get this kind of
message (except for the ROM). I solved the problem in my bootloader
by reallocating all PCI resources from scratch, making sure there would
never be any conflict.

> Is this legal or not? The collision on address space 6 is almost
> certainly the bios at 0xc0000 clashing with the one for the onboard S3
> 864. Since the P9100 doesn't actually have a bios in the rom socket I'm
> not too worried about this :-)

Even then, it means that 2 slaves might respond to an acess at ISA memory
space at 0xc0000 if both ROMs are enabled, and cause conflicts on the bus.
The other one is definitely serious. what do /proc/ioports /proc/iomem and
/proc/pci (or lspci -vvxxx) report ?

FYI that's what I get on my boards:
[root@vcorr1 linux-test]# cat /proc/ioports
00000000-0000001f : dma1
00000020-0000003f : pic1
00000040-0000005f : timer
00000074-00000077 : PreP NVRAM
00000080-0000008f : dma page reg
000000a0-000000bf : pic2
000000c0-000000df : dma2
00000170-00000177 : Symphony Labs SL82c105
000001f0-000001f7 : Symphony Labs SL82c105
000002f8-000002ff : serial(auto)
00000376-00000376 : Symphony Labs SL82c105
000003c0-000003df : vga+
000003f6-000003f6 : Symphony Labs SL82c105
000003f8-000003ff : serial(auto)
00010000-000100ff : Symbios Logic Inc. (formerly NCR) 53c825
  00010000-0001007f : ncr53c8xx
00010100-0001017f : Digital Equipment Corporation DECchip 21140 [FasterNet]
  00010100-0001017f : DC21140 (eth0)
00010180-0001018f : Symphony Labs SL82c105
00010190-0001019f : Symphony Labs SL82c105

[root@vcorr1 linux-test]# cat /proc/iomem
fc6b0000-fc6bffff : S3 Inc. 86c764/765 [Trio32/64/64V+]
fc6c0000-fc6fffff : Digital Equipment Corporation DECchip 21140 [FasterNet]
fc7aee80-fc7aeeff : Digital Equipment Corporation DECchip 21140 [FasterNet]
fc7aef00-fc7aefff : Symbios Logic Inc. (formerly NCR) 53c825
fc7af000-fc7affff : Symbios Logic Inc. (formerly NCR) 53c825
fc7b0000-fc7bffff : Tundra Semiconductor Corp. CA91C042 [Universe]
fc7c0000-fc7fffff : Motorola Raven
fc800000-fcffffff : S3 Inc. 86c764/765 [Trio32/64/64V+]

(the first 2 are ROMs although there is no actual ROM on the Ethernet chip)

[root@vcorr1 linux-test]# cat /proc/pci
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Motorola Raven (rev 1).
      I/O at 0x0 [0xffff].
      Non-prefetchable 32 bit memory at 0xfc7c0000 [0xfc7fffff].
  Bus  0, device  11, function  0:
    ISA bridge: Symphony Labs W83C553 (rev 4).
  Bus  0, device  11, function  1:
    IDE interface: Symphony Labs SL82c105 (rev 5).
      Master Capable.  No bursts.  Min Gnt=2.Max Lat=40.
      I/O at 0x1f0 [0x1f7].
      I/O at 0x3f6 [0x3f6].
      I/O at 0x170 [0x177].
      I/O at 0x376 [0x376].
      I/O at 0x10190 [0x1019f].
      I/O at 0x10180 [0x1018f].
  Bus  0, device  12, function  0:
    SCSI storage controller: Symbios Logic Inc. (formerly NCR) 53c825 (rev 19).
      IRQ 19.
      Master Capable.  Latency=128.  Min Gnt=17.Max Lat=64.
      I/O at 0x10000 [0x100ff].
      Non-prefetchable 32 bit memory at 0xfc7aef00 [0xfc7aefff].
      Non-prefetchable 32 bit memory at 0xfc7af000 [0xfc7affff].
  Bus  0, device  13, function  0:
    Bridge: Tundra Semiconductor Corp. CA91C042 [Universe] (rev 0).
      IRQ 21.
      Master Capable.  No bursts.  Min Gnt=3.
      Non-prefetchable 32 bit memory at 0xfc7b0000 [0xfc7bffff].
  Bus  0, device  14, function  0:
    Ethernet controller: Digital Equipment Corporation DECchip 21140 [FasterNet] (rev 32).
      IRQ 18.
      Master Capable.  Latency=96.  Min Gnt=20.Max Lat=40.
      I/O at 0x10100 [0x1017f].
      Non-prefetchable 32 bit memory at 0xfc7aee80 [0xfc7aeeff].
  Bus  0, device  16, function  0:
    VGA compatible controller: S3 Inc. 86c764/765 [Trio32/64/64V+] (rev 0).
      IRQ 25.
      Non-prefetchable 32 bit memory at 0xfc800000 [0xfcffffff].


	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
