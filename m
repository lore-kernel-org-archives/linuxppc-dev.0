Date: Mon, 8 May 2000 11:44:47 +0200 (MET DST)
From: Henning Loeser <Henning.Loeser@Physik.Uni-Marburg.DE>
To: linuxppc-dev@lists.linuxppc.org
Subject: AEC6260M PCI-IDE-Card
Message-ID: <Pine.OSF.4.02.10005081054570.11165-100000@ax1305.physik.uni-marburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi I hope someone here can help me with this:
I got myself a Acard Pci-IDE card for my Powermac 7500 and found myself
with the problem that the linux 2.2.15  driver suppied by Andre Hedrick
with his 2.2.15-ide patch doesn't work under LinuxPPC in contrast to the
x86 machines. :-(
The problem is, that the card keeps losing its interrupt. The card is
detected during boot and finds the drive :

>AEC6260R: IDE controller on PCI bus 00 dev 78
>AEC6260R: not 100% native mode: will probe irqs later
>AEC6260R: ROM enabled at 0x80800000
>AEC6260: reg49h=0x00 ATA-66 Cable Port0
>     ide2: BM-DMA at 0x0800-0x0807, BIOS settings: hde:pio, hdf:pio
>hde: IBM-DJNA-352030, ATA DISK drive
>ide2 at 0x840-0x847,0x000 on irq 25
>hde: IBM-DJNA-352030, 19470MB w/1966kB Cache, CHS=39560/16/63, UDMA(66)

but when doing the partition check I get:
kernel: hde: lost interrupt
kernel: ide_dmaproc: chipset supported ide_dma_lostirq func only: 11
kernel: hde: lost interrupt
kernel:  hde1ide_dmaproc: chipset supported ide_dma_lostirq func only: 11
kernel: hde: lost interrupt
kernel:  hde2 hde3ide_dmaproc: chipset supported ide_dma_lostirq func
	only: 11

and so on for every partition.
I compiled the kernel with sharing PCI IDE interrupt support, Generic PCI
busmaster support the AEC6260 driver AND Builtin PowerMac IDE support with
PowerMac IDE DMA support. If I let the buitin Ide support out, the kernel
wont even boot. If I let the sharing interrupt support out, I could not
use the keyboard ....

Can anyone help with this? I'm in contact with Andre but he can't check
anything on a PowerPC. I'm a complete greenhorn but I'd be willing to
learn if someone helps. I don't even know where and how to start looking
what is really going wrong. Is it the PIO stuff ????
I have tried to compile a 2.3.99pre5 kernel and inculde the card there,
but that kernel wouldnt even compile. Thats wy I went back to the stable
kernel sources with the ide.2.2.15.20000504.patch with no real succes so
far either I admit :-)

Cheers Henning

--------------------------------------------------------------------------
Henning Loeser					      Fachbereich Physik
email: henning.loeser@physik.uni-marburg.de	      AG Oberflaechen
						      Philipps-Uni Marburg


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
