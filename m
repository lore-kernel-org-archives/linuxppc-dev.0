Message-Id: <200108231638.MAA10774@orchid.cspi.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Brian Waite <bwaite@cspi.com>
Reply-To: bwaite@cspi.com
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: SCSI PMC card
Date: Thu, 23 Aug 2001 12:31:12 -0400
References: <85256AB1.005815DF.00@pine.cspi.com>
In-Reply-To: <85256AB1.005815DF.00@pine.cspi.com>
MIME-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Ok here is the information you asked for. I am using 2.4.3 from kernel.org. I
was using 2.4.3-pre3 forever from the linuxppc_2_4 stable tree and I had the
same mappings. I recently grabbed the 2.4.3 tarball from kernel.org and
updated my bk tree with it. I did check every change I committed to make sure
nothing looked bad. I had to do this under the gun so please excuse the cross
breeding of bk and kernel.org.

The SPAN card is the PMC SPAN from motorola that gives you 2 extra PMC slots.

Here is the output of my 2400 boot WITHOUT the SCSI card and WITHOUT the
SPAN. I have enabled DEBUG in drivers/pci/pci.c and arch/ppc/kernel/pci.c
along with adding my own own debugs (ignore the BJW: lines )

OpenPIC timer frequency is 12.500098 MHz
reqest_irq() for irq 16 !
reqest_irq() for irq 2 !
time_init: decrementer frequency = 24.999999 MHz
Calibrating delay loop... 699.59 BogoMIPS
Memory: 124848k available (1048k kernel code, 664k data, 88k init, 0k highmem)
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 8192 (order: 3, 32768 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
BJW: Bus 0
Scanning bus 00
Found 00:00 [1057/4803] 000600 00
Fixup mem res, dev: 0.0, res_start: 3c000000->fc000000
Found 00:58 [10ad/0565] 000601 00
Found 00:59 [10ad/0105] 000101 00
Found 00:68 [10e3/0000] 000680 00
Fixup mem res, dev: 0.d, res_start: 2ff7f000->eff7f000
Found 00:70 [1011/0019] 000200 00
Fixup mem res, dev: 0.e, res_start: 2ff7ec00->eff7ec00
Fixup mem res, dev: 0.e, res_start: fffc0000->bffc0000
Found 00:88 [14c1/8043] 000000 00
Fixup mem res, dev: 0.11, res_start: 2e000000->ee000000
Fixup mem res, dev: 0.11, res_start: fff80000->bff80000
Fixups for bus 00
Bus scan for 00 returning with max=00
BJW: setup mem_resource flags 0
BJW: setup mem_resource flags 0
BJW: setup mem_resource flags 0
BJW: All busses probed
BJW: Fixingup
Setting PCI interrupts for a "MVME 2400"
Set winbond IDE to native mode
BJW: Done
BJW: Allocate
        1
PCI:0:0:0: Resource fc000000-fc03ffff (f=200)
PCI:0:b:1: Resource 0ff7fff8-0ff7ffff (f=109)
PCI:0:b:1: Resource 0ff7fff4-0ff7fff7 (f=105)
PCI:0:b:1: Resource 0ff7ffe8-0ff7ffef (f=109)
PCI:0:b:1: Resource 0ff7ffe4-0ff7ffe7 (f=105)
PCI:0:b:1: Resource 0ff7ffd0-0ff7ffdf (f=101)
PCI:0:b:1: Resource 0ff7ffc0-0ff7ffcf (f=101)
PCI:0:d:0: Resource eff7f000-eff7ffff (f=200)
PCI:0:d:0: Resource 0ff7e000-0ff7efff (f=101)
PCI:0:e:0: Resource eff7ec00-eff7efff (f=200)
PCI:0:11:0: Resource ee000000-eeffffff (f=120c)
        2
        3
BJW: Done
Linux NET4.0 for Linux 2.4
.
.


Thanks
Brian


On Thursday 23 August 2001 12:02 pm, you wrote:
> On Thu, Aug 23, 2001 at 10:24:56AM -0400, Brian Waite wrote:
> > I am trying to put a Cyclone SCSI PMC (symbios 53c895 chipset) card on my
> > Motorola MVME2400 and I see some wierd stuff. If I put the SCSI card on a
> > SPAN card, the kernel comes up and see the card, but when I place the
>
> SCSI
>
> > card on either of the 2 PMC slots on the base, I hang while probing PCI
> > hardware. It gets part way through the PCI fixup resources section and
>
> just
>
> > hangs. Here is my boot
>
> <snip>
>
> > PCI: Probing PCI hardware
> > Fixup mem res, dev: 0.0, res_start: 3c000000->fc000000
> > Fixup mem res, dev: 0.d, res_start: 2ff7f000->eff7f000
> > Fixup mem res, dev: 0.e, res_start: 2ff7ec00->eff7ec00
> > Fixup mem res, dev: 0.e, res_start: fffc0000->bffc0000
>
> You are in resource hell.
>
> In a PReP map, 0xfffc0000 isn't a legal PCI base address since
> it lies in PCI's system memory space (0x80000000-0xffffffff).
> I seem to remember a bug in the ppc resource pci_mem_offset
> handling that applied pci_mem_offset twice in some cases.
> It is fixed at least in the 2_4_devel tree.  You can confirm
> this by reading the contents of the BAR corresponding to that
> last fixup directly.  I'll bet that it is 0x3ffc0000, PPCBUG's
> autoconfiguration code is real good so I highly doubt that it
> assigned 0xfffc0000 to a memory BAR.
>
> #define DEBUG in drivers/pci/pci.c and arch/ppc/kernel/pci.c and
> repost your results.
>
> > A thing to note is that I do not have and SCSI support built into this
> > kernel. I built scsi_mod, sd_md, and sym53c8xx and load them as modules.
> > I am using the 2.4.3 kernel and I have tried building the sym module into
>
> the
>
> > driver, but the hangs occurs before the driver ever loads! Any idea what
>
> has
>
> > gone wrong while tring to probe this card? It is strage that it works
>
> fine on
>
> > a SPAN card. Too bad that is not a solution for us. PS this worked under
>
> 2.2
>
> > so I know the card is OK.
>
> By SPAN card do you mean a PMCSPAN?  Which 2.4.3 are you using?
> kernel.org,
> linuxppc_2_4, linuxppc_2_4_devel?
>
> Regards,

--
Brian Waite

Looking for a TeraFLOP in a closet
www.fastcluster.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
