Message-Id: <200005082113.XAA00798@piglet.grunz.lu>
Date: Mon, 8 May 2000 23:13:35 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: AEC6260M PCI-IDE-Card
To: Henning.Loeser@Physik.Uni-Marburg.DE
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.OSF.4.02.10005081054570.11165-100000@ax1305.physik.uni-marburg.de>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi there,

On   8 May, this message from Henning Loeser echoed through cyberspace:
>
> Hi I hope someone here can help me with this:
> I got myself a Acard Pci-IDE card for my Powermac 7500 and found myself
> with the problem that the linux 2.2.15  driver suppied by Andre Hedrick
> with his 2.2.15-ide patch doesn't work under LinuxPPC in contrast to the
> x86 machines. :-(
> The problem is, that the card keeps losing its interrupt. The card is
> detected during boot and finds the drive :
>
>>AEC6260R: IDE controller on PCI bus 00 dev 78
>>AEC6260R: not 100% native mode: will probe irqs later
>>AEC6260R: ROM enabled at 0x80800000
>>AEC6260: reg49h=0x00 ATA-66 Cable Port0
>>     ide2: BM-DMA at 0x0800-0x0807, BIOS settings: hde:pio, hdf:pio
                       ^^^^^^^^^^^^^
These port addresses are interesting... Are you sure your driver does
access the disks? These port addresses are not supposed to work with
stock kernels AFAIK....

>>hde: IBM-DJNA-352030, ATA DISK drive
>>ide2 at 0x840-0x847,0x000 on irq 25
                               ^^^^^^
This sounds reasonable. To be sure, can you send an lspci -vv and
lspci -bvv along?

>>hde: IBM-DJNA-352030, 19470MB w/1966kB Cache, CHS=39560/16/63, UDMA(66)

Disk found. I guess if it gets through here, it is at least able to read
id info from the drive...

> but when doing the partition check I get:
> kernel: hde: lost interrupt
> kernel: ide_dmaproc: chipset supported ide_dma_lostirq func only: 11
> kernel: hde: lost interrupt
> kernel:  hde1ide_dmaproc: chipset supported ide_dma_lostirq func only: 11
> kernel: hde: lost interrupt
> kernel:  hde2 hde3ide_dmaproc: chipset supported ide_dma_lostirq func
> 	only: 11

Hm, might this be a problem with doing DMA?

> and so on for every partition.
> I compiled the kernel with sharing PCI IDE interrupt support, Generic PCI
> busmaster support the AEC6260 driver AND Builtin PowerMac IDE support with
> PowerMac IDE DMA support. If I let the buitin Ide support out, the kernel
> wont even boot.

Yeah, PowerMac IDE support is still somewhat broken in the sense that
compile options are not clear, and generic IDE functionality depends on
machine-specific stuff configured-in that might not even be relevant to
your machine...

> Thats wy I went back to the stable
> kernel sources with the ide.2.2.15.20000504.patch with no real succes so
> far either I admit :-)

I have a Promise U/66 IDE controller in my 7600, so I need Andre's
patches as well in the 2.2 kernels. I have not yet tried 2.2.15,
however... nor have I adapted the other patches that I need for PCI
stuff (like the port addresses mentioned above) to 2.2.15. Some day
soon...

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
