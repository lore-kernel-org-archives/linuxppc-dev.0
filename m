Message-Id: <200312300128.hBU1Sh3g057052@mail0.dreamwiz.com>
Date: Tue, 30 Dec 2003 10:28:43 +0900 (KST)
From: =?EUC-KR?B?wOXH/L/t?= <jazz0719@dreamwiz.com>
Subject: Re: DMA problem in Sil0680A - detail setting in my system 
To: chris@cryptoapps.com, linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Mr. Zimman,  Thank you for your kind and quick response first...
and Here are more detail configurations I set in my system...

- changed Level/Edge sensing, and polarity.
check for the externel interrupt setting in our system.

arch/ppc/platforms/sycamore.c

static u_char Sycamore_IRQ_initsenses[] __initdata = {
        (IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),      /* 0: Uart 0*/
        (IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),      /* 1: Uart 1*/
        (IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),      /* 2: IIC */
        (IRQ_SENSE_EDGE  | IRQ_POLARITY_POSITIVE),      /* 3: External Master */
        (IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),      /* 4: PCI ext cmd write*/
        (IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),      /* 5: DMA Chan 0 */
        (IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),      /* 6: DMA Chan 1 */
        (IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),      /* 7: DMA Chan 2 */
        (IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),      /* 8: DMA Chan 3 */
        (IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),      /* 9: Ethernet wakeup (WOL)*/
        (IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),      /* 10: Mal (SEER) */
        (IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),      /* 11: Mal TXEOB */
        (IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),      /* 12: Mal RXEOB */
        (IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),      /* 13: Mal TXDE*/
        (IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),      /* 14: Mal RXDE*/
        (IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),      /* 15: Ethernet */
        (IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),      /* 16: Ext PCI SERR */
        (IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),      /* 17: ECC */
        (IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),      /* 18: PCI PM*/
        (IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),      /* 19: Ext Int 7 */
        (IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),      /* 20: Ext Int 8 */
        (IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),      /* 21: Ext Int 9 */
        (IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),      /* 22: Ext Int 10 */
        (IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),      /* 23: Ext Int 11 */
        (IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),      /* 24: Ext Int 12 */
        (IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),      /* 25: Ext Int 0 - IDE */
        (IRQ_SENSE_EDGE  | IRQ_POLARITY_NEGATIVE),      /* 26: Ext Int 1 - Audio */
        (IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),      /* 27: Ext Int 2 - SCSI */
        (IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),      /* 28: Ext Int 3 - Serial-3 */
        (IRQ_SENSE_EDGE  | IRQ_POLARITY_NEGATIVE),      /* 29: Ext Int 4 - Encoder */
        (IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),      /* 30: Ext Int 5 */
        (IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),      /* 31: Ext Int 6 - Serial-4 */
};

- modified irq setting of PCI device. as you see, Sil0680 got a irq 25...
 (sorry for the misprint in the mail before. QLogic ISP1020 SCSI got a irq 27)
int __init
ppc405_map_irq(struct pci_dev *dev, unsigned char idsel, unsigned char pin)
{
        static char pci_irq_table[][4] =
            /*
             *      PCI IDSEL/INTPIN->INTLINE
             *      A       B       C       D
             */
        {
                /* modified by hwjang : see PPC405GP User's manual Table 10-1. UIC Interrupt Assignments */
                {-1, -1, -1, -1},       /* PCI slot 1 : PCI device 10ea:5252 (INTERG VGA) */
                {25, 25, 25, 25},       /* PCI slot 2 : PCI device 1095:0680 (CMD SII680) */
                {-1, -1, -1, -1},       /* PCI slot 3 : PCI device 104c:a106 (TI 6205 Decoder)*/
                {27, 27, 27, 27},       /* PCI slot 4 : PCI device 1077:1020 (QLogic ISP1020 SCSI) */
        };

        const long min_idsel = 1, max_idsel = 4, irqs_per_slot = 4;
        return PCI_IRQ_TABLE_LOOKUP;
};

- modified Timing setting for PIO, DMA, UDMA as my system works now...
  and set IDE clock freq to 100Mhz
drivers/ide/pci/siimage.c

#define __MY_CUSTOM_BOARD

static unsigned int setup_mmio_siimage (struct pci_dev *dev, const char *name)
{
printk("***** setup_mmio_siimage() started *****\n");
        unsigned long bar5      = pci_resource_start(dev, 5);
        unsigned long barsize   = pci_resource_len(dev, 5);
        u8 tmpbyte      = 0;
        unsigned long addr;
        void *ioaddr;

        /*
         *      Drop back to PIO if we can't map the mmio. Some
         *      systems seem to get terminally confused in the PCI
         *      spaces.
         */

        if(!request_mem_region(bar5, barsize, name))
        {
                printk(KERN_WARNING "siimage: IDE controller MMIO ports not available.\n");
                return 0;
        }

        ioaddr = ioremap(bar5, barsize);
        if (ioaddr == NULL)
        {
                release_mem_region(bar5, barsize);
                return 0;
        }

        pci_set_master(dev);
        pci_set_drvdata(dev, ioaddr);
        addr = (unsigned long) ioaddr;

printk("bar5 : %08x, ioaddr : %08x, addr : %08x\n", bar5, ioaddr, addr);

        if (pdev_is_sata(dev)) {
                writel(0, addr + 0x148);
                writel(0, addr + 0x1C8);
        }
/* modified by hwjang */
#ifndef __MY_CUSTOM_BOARD
        writeb(0, addr + 0xB4);
        writeb(0, addr + 0xF4);
#else /* ifdef __POSWATCH_PRO */
        writeb(0x33, addr + 0xB4);   /* IDE 0 - Ultra DMA Mode */
        writeb(0x33, addr + 0xF4);   /* IDE 1 - Ultra DMA Mode */
#endif /* __POSWATCH_PRO */

        tmpbyte = readb(addr + 0x4A);

/* modified by hwjang : set IDE clock freq to 100Mhz */
#ifndef __MY_CUSTOM_BOARD
        switch(tmpbyte & 0x30) {
                case 0x00:
                        /* In 100 MHz clocking, try and switch to 133 */
                        writeb(tmpbyte|0x10, addr + 0x4A);
                        break;
                case 0x10:
                        /* On 133Mhz clocking */
                        break;
                case 0x20:
                        /* On PCIx2 clocking */
                        break;
                case 0x30:
                        /* Clocking is disabled */
                        /* 133 clock attempt to force it on */
                        writeb(tmpbyte & ~0x20, addr + 0x4A);
                        break;
        }
#else /* ifdef __MY_CUSTOM_BOARD */
printk("setup_mmio_siimage() : IDE clck freq to 100Mhz...\n");
        switch(tmpbyte & 0x30) {
                case 0x00:
                        /* On 100 Mhz clocking */
                        break;
                case 0x30:
                        /* if clocking is disabled */
                        /* 100 clock attempt to force it on */
                        writeb(tmpbyte & ~0x30, addr + 0x4A);
                        break;
                case 0x10:
                        /* On 133 Mhz clocking */
                        /* 100 clock attempt to force it on */
                        writeb(tmpbyte & ~0x30, addr +  0x4A);
                        break;
                case 0x20:
                        /* BIOS set PCI x2 clocking */
                        /* 100 clock attempt to force it on */
                        writeb(tmpbyte & ~0x30, addr + 0x4A);
                        break;
        }
#endif

/* modified by hwjang : set for __MY_CUSTOM_BOARD. refer to config_Sil0680() in mqx */
#ifndef __MY_CUSTOM_BOARD
        writeb(      0x72, addr + 0xA1);
        writew(    0x328A, addr + 0xA2);
        writel(0x62DD62DD, addr + 0xA4);
        writel(0x43924392, addr + 0xA8);
        writel(0x40094009, addr + 0xAC);
        writeb(      0x72, addr + 0xE1);
        writew(    0x328A, addr + 0xE2);
        writel(0x62DD62DD, addr + 0xE4);
        writel(0x43924392, addr + 0xE8);
        writel(0x40094009, addr + 0xEC);
#else /* ifdef __MY_CUSTOM_BOARD */
printk("setup_mmio_siimage() : config_Sil068 for __MY_CUSTOM_BOARD\n");
        /* IDE 0 */
        writel(0x10C10200, addr + 0xA0);   /* TF-4 timing and IORDY monitored */
        writel(0x10C110C1, addr + 0xA4);   /* PIO-4 Timing */
        writel(0x10C110C1, addr + 0xA8);   /* DMA-2 Timing */
        writel(0x00010001, addr + 0xAC);   /* UDMA-5 Timing */

        /* IDE 1 */
        writel(0x10C10200, addr + 0xE0);   /* TF-4 timing and IORDY monitored */
        writel(0x10C110C1, addr + 0xE4);   /* PIO-4 Timing */
        writel(0x10C110C1, addr + 0xE8);   /* DMA-2 Timing */
        writel(0x00010001, addr + 0xEC);   /* UDMA-5 Timing */
#endif
        if (pdev_is_sata(dev)) {
                writel(0xFFFF0000, addr + 0x108);
                writel(0xFFFF0000, addr + 0x188);
                writel(0x00680000, addr + 0x148);
                writel(0x00680000, addr + 0x1C8);
        }

        tmpbyte = readb(addr + 0x4A);

        proc_reports_siimage(dev, (tmpbyte>>4), name);

	return 1;
}







- this is the messages shown including debugging information I added...


U-Boot 1.0.0 (Dec 16 2003 - 17:52:07)

CPU:   IBM PowerPC 405GPr Rev. B at 266.500 MHz (PLB=133, OPB=66, EBC=66 MHz)
       PCI sync clock at 33 MHz, internal PCI arbiter enabled
       16 kB I-Cache 16 kB D-Cache
Board: ### No HW ID - assuming WALNUT405
I2C:   ready
DRAM:  32 MB
NAND: val = 0000ec73
OK
*** Warning - bad CRC, using default environment

In:    serial
Out:   serial
Err:   serial
Hit any key to stop autoboot:  0
=> tftpboot 100000 /tftpboot/vmlinux.1
ENET Speed is 0 Mbps - FULL duplex connection
TFTP from server 192.168.1.210; our IP address is 192.168.1.200
Filename '/tftpboot/vmlinux.1'.
Load address: 0x100000
Loading: #################################################################
         #################################################################
         ##
done
Bytes transferred = 672804 (a4424 hex)
=> tftpboot 200000 /tftpboot/ramdisk
ENET Speed is 0 Mbps - FULL duplex connection
TFTP from server 192.168.1.210; our IP address is 192.168.1.200
Filename '/tftpboot/ramdisk'.
Load address: 0x200000
Loading: #################################################################
         #################################################################
         #################################################################
         #################################################################
         ###############################################
done
Bytes transferred = 1569863 (17f447 hex)
=> bootm 100000 200000
## Booting image at 00100000 ...
   Image Name:   Linux-2.4.23
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    672740 Bytes = 657 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Loading RAMDisk Image at 00200000 ...
   Image Name:   test
   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
   Data Size:    1569799 Bytes =  1.5 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Loading Ramdisk to 01e3c000, end 01fbb407 ... OK
id mach(): done
MMU:enter
MMU:hw init
MMU:mapin
MMU:mapin_ram done
MMU:setio
MMU:exit
setup_arch: enter
setup_arch: bootmem
arch: exit
Linux version 2.4.23 (root@hwjang) (gcc version 3.2.1 20020930 (MontaVista)) #1 Tue Dec 30 09:30:54 KST 2003
IBM Sycamore (IBM405GPr) Platform
Port by MontaVista Software, Inc. (source@mvista.com)
On node 0 totalpages: 8192
zone(0): 8192 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/hda1 ip=192.168.2.176:192.168.2.190:192.168.2.79:255.255.255.0
Calibrating delay loop... 266.24 BogoMIPS
Memory: 29244k available (1124k kernel code, 368k data, 84k init, 0k highmem)
Dentry cache hash table entries: 4096 (order: 3, 32768 bytes)
Inode cache hash table entries: 2048 (order: 2, 16384 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
PCI fixup irq -  dev->name:PCI device 1014:0156, pin:1, slot:0, irq:0
PCI fixup irq -  dev->name:PCI device 10ea:5202, pin:1, slot:1, irq:0
PCI fixup irq -  dev->name:PCI device 10ea:5252, pin:1, slot:1, irq:0
PCI fixup irq -  dev->name:PCI device 1095:0680, pin:1, slot:2, irq:25
PCI fixup irq -  dev->name:PCI device 104c:a106, pin:1, slot:3, irq:0
PCI fixup irq -  dev->name:PCI device 1077:1020, pin:1, slot:4, irq:27

Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0xef600300 (irq = 0) is a 16550A
ttyS01 at 0xef600400 (irq = 1) is a 16550A
Generic RTC Driver v1.07
IBM gpio driver version 07.25.02
GPIO #0 at 0xc3000700
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
emac: IBM OCP EMAC Ethernet driver, version 2.0
Maintained by Benjamin Herrenschmidt <benh@kernel.crashing.org>
mal0: Initialized, 2 tx channels, 1 rx channels
eth0: IBM emac, MAC 00:03:4e:00:00:16
eth0: Found Generic MII PHY (0x01)
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SiI680: IDE controller at PCI slot 00:02.0
SiI680: chipset revision 2
***** setup_mmio_siimage() started *****
bar5 : beffef00, ioaddr : c3009f00, addr : c3009f00
setup_mmio_siimage() : IDE clck freq to 100Mhz...
setup_mmio_siimage() : config_Sil068 for poswatch_pro
SiI680: BASE CLOCK == 100
******** PCI configuration register : setup_mmio_siimage  ********
0x48 : 00010000

0x04 : 00000000
0x0C : 00000000
0x10 : 00080000
0x18 : 00080000
0x20 : 00000000
0x24 : 00000000
0x28 : 00000000
0x2C : 00000000
0x80 : a157a157
0x84 : a157a157
0x88 : a157a157
0xA0 : 10c10201
0xA4 : 10c110c1
0xA8 : 10c110c1
0xAC : 00010001
0xB4 : 00000033
0xC0 : ff7fff7f
0xC4 : ff7fff7f
0xC8 : ff7fff7f
0xE0 : 10c10201
0xE4 : 10c110c1
0xE8 : 10c110c1
0xEC : 00010001
0xF4 : 00000033
SiI680: 100% native mode on irq 25
*** init_mmio_iops_siimage ***
base : c3009f80
ch : 0
    ide0: MMIO-DMA , BIOS settings: hda:pio, hdb:pio
***** ide_setup_dma() *****
dma_master   : c3009f10
dma_base     : c3009f10
dma_command  : c3009f10
dma_vendor1  : c3009f11
dma_status   : c3009f12
dma_vendor3  : c3009f13
dma_prdtable : c3009f04
dma_base2    : c3009f00
*********** 08H : 01018502
*** init_mmio_iops_siimage ***
base : c3009fc0
ch : 1
    ide1: MMIO-DMA , BIOS settings: hdc:pio, hdd:pio
***** ide_setup_dma() *****
dma_master   : c3009f10
dma_base     : c3009f18
dma_command  : c3009f18
dma_vendor1  : c3009f19
dma_status   : c3009f1a
dma_vendor3  : c3009f1b
dma_prdtable : c3009f0c
dma_base2    : c3009f08
Probing IDE interface ide0...
probing for hda: present=0, media=32, probetype=ATA
hda: IC35L090AVV207-0, ATA DISK drive
drive->name : hda, drive->id_read : 1, drive->media : 20, drive->present : 1
probing for hdb: present=0, media=32, probetype=ATA
eth0: Link is Up
eth0: Speed: 10, Half duplex.
probing for hdb: present=0, media=32, probetype=ATAPI
drive->name : hdb, drive->id_read : 0, drive->media : 20, drive->present : 0
blk: queue c0184878, I/O limit 4095Mb (mask 0xffffffff)
Probing IDE interface ide1...
probing for hdc: present=0, media=32, probetype=ATA
probing for hdc: present=0, media=32, probetype=ATAPI
drive->name : hdc, drive->id_read : 0, drive->media : 20, drive->present : 0
probing for hdd: present=0, media=32, probetype=ATA
probing for hdd: present=0, media=32, probetype=ATAPI
drive->name : hdd, drive->id_read : 0, drive->media : 20, drive->present : 0
ide0 at 0xc3009f80-0xc3009f87,0xc3009f8a on irq 25
hda: attached ide-disk driver.
ide_execute_command() started... cmd : 00000091
ide_execute_command() started... cmd : 00000010
ide_execute_command() started... cmd : 000000f8
hda: host protected area => 1
ide_execute_command() started... cmd : 00000027
hda: 160836480 sectors (82348 MB) w/1821KiB Cache, CHS=10011/255/63, UDMA(100)
ide_execute_command() started... cmd : 000000c6
ide_execute_command() started... cmd : 000000ef
Partition check:
 hda: unknown partition table
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 2048 bind 4096)
eth0: Speed: 10, Half duplex.
IP-Config: Complete:
      device=eth0, addr=192.168.2.176, mask=255.255.255.0, gw=192.168.2.79,
     host=192.168.2.176, domain=, nis-domain=(none),
     bootserver=192.168.2.190, rootserver=192.168.2.190, rootpath=
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 1533k freed
VFS: Mounted root (ext2 filesystem).
serial console detected.  Disabling virtual terminals.
init started:  BusyBox v0.60.2 (2002.12.19-10:50+0000) multi-call binary

Welcome to MontaVista Linux Preview Kit

Starting system...
mounting /proc: done.
Mounting '/' read-write: done.
brining up loopback interface: done.
Mounting /tmp: done.
Starting syslogd: done.



/* after booting */


$ cat /proc/interrupts  		/* SCSI device is not conected... */
           CPU0
  0:        249  IBM UIC Level     serial
  9:          0  IBM UIC Level     OCP EMAC Wakeup
 10:          0  IBM UIC Level     MAL SERR
 11:          0  IBM UIC Level     MAL TX EOB
 12:          0  IBM UIC Level     MAL RX EOB
 13:          0  IBM UIC Level     MAL TX DE
 14:          0  IBM UIC Level     MAL RX DE
 15:          0  IBM UIC Level     OCP EMAC MAC
 25:          7  IBM UIC Level     ide0
BAD:          1

$ cat /proc/pci
PCI devices found:
  Bus  0, device   0, function  1:
    Class 0600: PCI device 1014:0156 (rev 33).
  Bus  0, device   1, function  0:
    Class 0300: PCI device 10ea:5202 (rev 2).
      Master Capable.  Latency=128.
      Non-prefetchable 32 bit memory at 0xbf000000 [0xbfffffff].
  Bus  0, device   1, function  1:
    Class 0401: PCI device 10ea:5252 (rev 2).
      Master Capable.  Latency=128.
      Non-prefetchable 32 bit memory at 0xbefff000 [0xbeffffff].
      I/O at 0xff00 [0xffff].
  Bus  0, device   2, function  0:
    Class 0101: PCI device 1095:0680 (rev 2).
      IRQ 25.
      Master Capable.  Latency=128.
      I/O at 0xfef8 [0xfeff].
      I/O at 0xfef4 [0xfef7].
      I/O at 0xfee8 [0xfeef].
      I/O at 0xfee4 [0xfee7].
      I/O at 0xfed0 [0xfedf].
      Non-prefetchable 32 bit memory at 0xbeffef00 [0xbeffefff].
  Bus  0, device   3, function  0:
    Class 0000: PCI device 104c:a106 (rev 1).
      Master Capable.  Latency=128.
      Prefetchable 32 bit memory at 0xbe800000 [0xbebfffff].
      Non-prefetchable 32 bit memory at 0xbe000000 [0xbe7fffff].
      I/O at 0xfec0 [0xfecf].
  Bus  0, device   4, function  0:
    Class 0100: PCI device 1077:1020 (rev 6).
      IRQ 27.
      Master Capable.  Latency=128.
      I/O at 0xfd00 [0xfdff].
      Non-prefetchable 32 bit memory at 0xbdfff000 [0xbdffffff].
$ /sbin/hdparm -t /dev/hda

/dev/hda:
 Timing bufferedhwif->dma_command : c3009f10
 disk reads:  hwif->dma_status : c3009f12
******** PCI configuration register : __ide_dma_read(), before ide_execure_command()********
0x00 : 00200008
0x04 : 01e0d000
0x0C : 00000000
0x10 : 00280008
0x18 : 00080000
0x20 : 00000000
0x24 : 00000000
0x28 : 00000000
0x2C : 00000000
0x80 : a157a157
0x84 : a157a157
0x88 : a157a157
0xA0 : 10c10201
0xA4 : 10c110c1
0xA8 : 10c110c1
0xAC : 00010001
0xB4 : 00000033
ide_execute_command() started... cmd : 00000025
******** PCI configuration register : __ide_dma_read(), after ide_execure_command()********
0x00 : 00200008
0x04 : 01e0d000
0x0C : 00000000
0x10 : 00280008
0x18 : 00080000
0x20 : 00000000
0x24 : 00000000
0x28 : 00000000
0x2C : 00000000
0x80 : 00000000
0x84 : 00000000
0x88 : 00000000
0xA0 : 10c10201
0xA4 : 10c110c1
0xA8 : 10c110c1
0xAC : 00010001
0xB4 : 00000033
***** __ide_dma_begin() called....
dma_cmd before start DMA : 08
dma_cmd after start DMA : 09
ide_dma_count : 0
***** __ide_dma_begin() called....
dma_cmd before start DMA : 09
dma_cmd after start DMA : 09
Jan  1 00:09:34 192 daemon.warn klogd: hwif->dma_command : c3009f10
Jan  1 00:09:34 192 daemon.warn klogd: hwif->dma_status : c3009f12
Jan  1 00:09:34 192 daemon.warn klogd: ******** PCI configuration register : __ide_dma_read(), before ide_execure_command()********
Jan  1 00:09:34 192 daemon.warn klogd: 0x00 : 00200008
Jan  1 00:09:34 192 daemon.warn klogd: 0x04 : 01e0d000
Jan  1 00:09:34 192 daemon.warn klogd: 0x0C : 00000000
Jan  1 00:09:34 192 daemon.warn klogd: 0x10 : 00280008
Jan  1 00:09:34 192 daemon.warn klogd: 0x18 : 00080000
Jan  1 00:09:34 192 daemon.warn klogd: 0x20 : 00000000
Jan  1 00:09:34 192 daemon.warn klogd: 0x24 : 00000000
Jan  1 00:09:34 192 daemon.warn klogd: 0x28 : 00000000
Jan  1 00:09:34 192 daemon.warn klogd: 0x2C : 00000000
Jan  1 00:09:34 192 daemon.warn klogd: 0x80 : a157a157
Jan  1 00:09:34 192 daemon.warn klogd: 0x84 : a157a157
Jan  1 00:09:34 192 daemon.warn klogd: 0x88 : a157a157
Jan  1 00:09:34 192 daemon.warn klogd: 0xA0 : 10c10201
Jan  1 00:09:34 192 daemon.warn klogd: 0xA4 : 10c110c1
Jan  1 00:09:34 192 daemon.warn klogd: 0xA8 : 10c110c1
Jan  1 00:09:34 192 daemon.warn klogd: 0xAC : 00010001
Jan  1 00:09:34 192 daemon.warn klogd: 0xB4 : 00000033
Jan  1 00:09:34 192 daemon.warn klogd: ide_execute_command() started... cmd : 00000025
Jan  1 00:09:34 192 daemon.warn klogd: ******** PCI configuration register : __ide_dma_read(), after ide_execure_command()********
Jan  1 00:09:34 192 daemon.warn klogd: 0x00 : 00200008
Jan  1 00:09:34 192 daemon.warn klogd: 0x04 : 01e0d000
Jan  1 00:09:34 192 daemon.warn klogd: 0x0C : 00000000
Jan  1 00:09:34 192 daemon.warn klogd: 0x10 : 00280008
Jan  1 00:09:34 192 daemon.warn klogd: 0x18 : 00080000
Jan  1 00:09:34 192 daemon.warn klogd: 0x20 : 00000000
Jan  1 00:09:34 192 daemon.warn klogd: 0x24 : 00000000
Jan  1 00:09:34 192 daemon.warn klogd: 0x28 : 00000000
Jan  1 00:09:34 192 daemon.warn klogd: 0x2C : 00000000
Jan  1 00:09:34 192 daemon.warn klogd: 0x80 : 00000000
Jan  1 00:09:34 192 daemon.warn klogd: 0x84 : 00000000
Jan  1 00:09:34 192 daemon.warn klogd: 0x88 : 00000000
Jan  1 00:09:34 192 daemon.warn klogd: 0xA0 : 10c10201
Jan  1 00:09:34 192 daemon.warn klogd: 0xA4 : 10c110c1
Jan  1 00:09:34 192 daemon.warn klogd: 0xA8 : 10c110c1
Jan  1 00:09:34 192 daemon.warn klogd: 0xAC : 00010001
Jan  1 00:09:34 192 daemon.warn klogd: 0xB4 : 00000033
Jan  1 00:09:34 192 daemon.warn klogd: ***** __ide_dma_begin() called....
Jan  1 00:09:34 192 daemon.warn klogd: dma_cmd before start DMA : 08
Jan  1 00:09:34 192 daemon.warn klogd: dma_cmd after start DMA : 09
Jan  1 00:09:34 192 daemon.warn klogd: ide_dma_count : 0
Jan  1 00:09:34 192 daemon.warn klogd: ***** __ide_dma_begin() called....
Jan  1 00:09:34 192 daemon.warn klogd: dma_cmd before start DMA : 09
Jan  1 00:09:34 192 daemon.warn klogd: dma_cmd after start DMA : 09
******** PCI configuration register : dma_timer_expiry() *********
0x48 : 00010000

0x00 : 00220009
0x04 : 01e0d000
0x0C : 00000000
0x10 : 00220009
0x18 : 00080000
0x20 : 00000000
0x24 : 00000000
0x28 : 00000000
0x2C : 00000000
0x80 : 00000000
0x84 : 00000000
0x88 : 00000000
0xA0 : 10c10201
0xA4 : 10c110c1
0xA8 : 10c110c1
0xAC : 10c110c1
0xB4 : 00000033
0xC0 : ff7fff7f
0xC4 : ff7fff7f
0xC8 : ff7fff7f
0xE0 : 10c10201
0xE4 : 10c110c1
0xE8 : 10c110c1
0xEC : 00010001
0xF4 : 00000033
PCI status|PCI Command 0x04 : 2a900007
hda: dma_timer_expiry: dma status == 0x22
***** __ide_dma_end() called....
dma_cmd before stop DMA : 09
dma_cmd after stop DMA : 08
dma_stat : 22
hda: error waiting for DMA
***** __ide_dma_end() called....
dma_cmd before stop DMA : 08
dma_cmd after stop DMA : 08
dma_stat : 20
hda: dma timeout retry: status=0x7f { DriveReady DeviceFault SeekComplete DataRequest CorrectedError Index Error }
hda: dma timeout retry: error=0x7f { DriveStatusError UncorrectableError SectorIdNotFound TrackZeroNotFound AddrMarkNotFound }, LBAse0hda: DMA disabled
Jan  1 00:09:55 192 daemon.warn ide0: reset: success




PCI configuration register displayed above means BASE ADDRESS 5 offet....
in __ide_dma_read(), it give WIN_READDMA_EXT command(0x25) to ATA device and
set dma_cmd(address offset:0x10) to 0x09 (PCI Bus Master Enable bit set)
but DMA doesn't work properly and dma_timer_expiry handler is called leaving error
0x10 : 00220009, Bit[17] - PCI Bus Master Error - IDE 0 ...

I feel it is not normal to display..
0x80 : a157a157
0x84 : a157a157
0x88 : a157a157

is it right ??


in PIO mode, hdparm -t /dev/hda works fine...
$ /sbin/hdparm -d0 /dev/hda
$ /sbin/hdparm -t /dev/hda  --> works...

but even in PIO mode, fdisk with w option failed.
$ /sbin/fdisk /dev/hda
ide_execute_command() started... cmd : 00000029
Jan  1 00:31:12 192 daemon.warn ide_execute_command() started... cmd : 00000029
klogd: ide_execute_command() started... cmd : 00000029
Jan  1 00:31:12 192 daemon.warn klogd: ide_execute_command() started... cmd : 00000029

The number of cylinders for this disk is set to 10011.
There is nothing wrong with that, but this is larger than 1024,
and could in certain setups cause problems with:
1) software that runs at boot time (e.g., old versions of LILO)
2) booting and partitioning software from other OSs
   (e.g., DOS FDISK, OS/2 FDISK)

Command (m for help): p

Disk /dev/hda: 255 heads, 63 sectors, 10011 cylinders
Units = cylinders of 16065 * 512 bytes

   Device Boot    Start       End    Blocks   Id  System
/dev/hda1             1     10011  80413326   83  Linux

Command (m for help): w
The partition table has been altered!

Calling ioctl() to re-read partition table.
 hda: unknown partition table
Jan  1 00:31:23 192 daemon.info klogd:  hda: unknown partition table
 hda: unknown partition table
Jan  1 00:31:25 192 daemon.info klogd:  hda: unknown partition table

WARNING: If you have created or modified any DOS 6.x
partitions, please see the fdisk manual page for additional
information.
Syncing disks.
$ /sbin/mkfs.ext2 /dev/hda1
mke2fs 1.19, 13-Jul-2000 for EXT2 FS 0.5b, 95/08/09
/sbin/mkfs.ext2: Device size reported to be zero.  Invalid partition specified, or
        partition table wasn't reread after running fdisk, due to
        a modified partition being busy and in use.  You may need to reboot
        to re-read your partition table


please, give me any advice or suggestion.
I will try to recognize SCSI device from now.... thanks.



>----- Original Message -----
>From: Chris Zimman chris@cryptoapps.com
>To: linuxppc-embedded@lists.linuxppc.org
>Date: Mon, 29 Dec 2003 03:50:10 -0600
>Subject: Re: [Question]DMA problem in Sil0680A...
>
>
>On Mon, Dec 29, 2003 at 01:16:17PM +0900, ?????? wrote:
>>
>> I'm trying to recognize IDE drive via Sil0680A driver
>> in embedded linux enviroments. see below.
>>
>> * OS : denx(http://www.denx.de) linuxppc_devel_2.4 (2.4.23)
>> * board : custom board for DVR
>> * bootloader : u-boot 0.4.0
>> * chipset : sil0680a(Siliconimage ultra ATA/133 PCI to ATA Host Controller)
>
>[ snip ]
>
>This could be one of at least a few things.  First, make sure that you're
>actually getting the interrupt signaling the end of DMA.  See
>drivers/ide/ide-dma.c:ide_dma_intr().
>
>Without knowing how you have things wired up on the board, it's hard to give
>definite suggestions about what might be wrong.  But in general, if you're
>not getting the interrupt, check the interrupt routing etc. (found in
>platforms/sycamore.c or whatever you called it if you've made a custom
>setup for your board).
>
>What external IRQ is the sil680 using?
>
>By the looks of your PCI table, you also have a QLogic SCSI controller
>on the board.  Have you tried that to see if it works?
>
>--Chris
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
