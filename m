MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: 8266 PCI on 2.6.x
Date: Fri, 11 Jun 2004 16:27:16 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B06DAFE@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi

I have a problem...
I have a (local) port of the PCI driver for 8266 from kernel 2.4 running
on 2.6.5 without problems.

I am trying to get it to work on 2.6.6 and 2.6.7rc3 (both mainstream and
linuxppc-2.5), but
the workaround for PCI errata 9 hangs on anything newer that 2.6.5...

Below is the function (uses IDMA to read PCI config registers)
This function gets called when a readb, readw or readl is issued.

On 2.6.6 & 7 it hangs on the line
	while(bd->flags & IDMA_BD_V);

Problem is that this function works when the kernel is scanning the PCI
bus, and initializing the IDE controller.
It only hangs right before starting init.

What changed between 2.6.5 and 2.6.6? I am doing diffs, and trying to
see what changed that coud affect this, but have no clue what I'm
looking for.


/* Use the IDMA controller to transfer data from I/O memory to local
RAM.
 * The src address must be a physical address suitable for use by the
DMA
 * controller with no translation.  The dst address must be a kernel
virtual
 * address.  The dst address is translated to a physical address via
 * virt_to_phys().
 * The sinc argument specifies whether or not the source address is
incremented
 * by the DMA controller.  The source address is incremented if and only
if sinc
 * is non-zero.  The destination address is always incremented since the

 * destination is always host RAM.
 */
static void
idma_pci9_read(u8 *dst, u8 *src, int bytes, int unit_size, int sinc)
{
	unsigned long flags;
	volatile idma_t *pram = &idma_dpram->pram;
	volatile idma_bd_t *bd = &idma_dpram->bd;
	volatile immap_t *immap = (immap_t *)IMAP_ADDR;

	local_irq_save(flags);

	/* initialize IDMA parameter RAM for this transfer */
	if (sinc)
		pram->dcm = IDMA_DCM_DMA_WRAP_64 | IDMA_DCM_SINC
			  | IDMA_DCM_DINC | IDMA_DCM_SD_MEM2MEM;
	else
		pram->dcm = IDMA_DCM_DMA_WRAP_64 | IDMA_DCM_DINC
			  | IDMA_DCM_SD_MEM2MEM;
	pram->ibdptr = pram->ibase;
	pram->sts = unit_size;
	pram->istate = 0;

	/* initialize the buffer descriptor */
	bd->dst = virt_to_phys(dst);
	bd->src = (uint) src;
	bd->len = bytes;
	bd->flags = IDMA_BD_V | IDMA_BD_W | IDMA_BD_I | IDMA_BD_L |
IDMA_BD_DGBL
		  | IDMA_BD_DBO_BE | IDMA_BD_SBO_BE | IDMA_BD_SDTB;

	/* issue the START_IDMA command to the CP */
	while (immap->im_cpm.cp_cpcr & CPM_CR_FLG);
	immap->im_cpm.cp_cpcr = mk_cr_cmd(IDMA_PAGE, IDMA_SBLOCK, 0,
					 CPM_CR_START_IDMA) |
CPM_CR_FLG;
	while (immap->im_cpm.cp_cpcr & CPM_CR_FLG);

	/* wait for transfer to complete */
	while(bd->flags & IDMA_BD_V);

	local_irq_restore(flags);

	return;
}



Linux version 2.6.6 (runet@ernie.innovsys.com) (gcc version 3.2.2
20030217 (Yellow Dog Linux 3.0 3.2.2-2a_1)) #7 Fri Jun 11 16:12:24
Innovative Systems LLC AP2 port
Using IDMA4 for MPC8260 device erratum PCI 9 workaround
On node 0 totalpages: 65536
  DMA zone: 65536 pages, LIFO batch:16
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
Built 1 zonelists
Kernel command line: console=ttyS0,115200 root=/dev/hda3 rw
ip=172.23.11.125:172.23.14.39:172.23.8.150:255.255.248.0:gold4_cpu1:ethe
PID hash table entries: 2048 (order 11: 16384 bytes)
Warning: real time clock seems stuck!
Memory: 257280k available (1664k kernel code, 436k data, 248k init, 0k
highmem)
Calibrating delay loop... 192.00 BogoMIPS
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
PCI: Probing PCI hardware
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
SiI680: IDE controller at PCI slot 0000:00:11.0
SiI680: chipset revision 2
SiI680: BASE CLOCK == 133
SiI680: 100% native mode on irq 69
    ide0: MMIO-DMA , BIOS settings: hda:pio, hdb:pio
    ide1: MMIO-DMA , BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: Maxtor 5A250J0, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0xd1000f80-0xd1000f87,0xd1000f8a on irq 69
Probing IDE interface ide1...
hda: max request size: 64KiB
hda: 490234752 sectors (251000 MB) w/2048KiB Cache, CHS=30515/255/63,
UDMA(133)
 hda: hda1 hda2 hda3 hda4
CPM UART driver version 0.02
ttyS0 on SMC1 at 0x0000, BRG7
ttyS1 on SCC1 at 0x0040, BRG8
eth0: FCC ENET Version 0.3, 00:30:d7:00:01:09
eth1: FCC ENET Version 0.3, 00:30:d7:00:01:0a
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET: Registered protocol family 1
NET: Registered protocol family 17
IP-Config: Complete:
      device=eth1, addr=172.23.11.125, mask=255.255.248.0,
gw=172.23.8.150,
     host=gold4_cpu1, domain=, nis-domain=(none),
     bootserver=172.23.14.39, rootserver=172.23.14.39, rootpath=
Rune Torgersen
System Developer
Innovative Systems LLC
1000 Innovative Drive
Mitchell, SD 57301
Ph: 605-995-6120
www.innovsys.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
