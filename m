Return-Path: <junita_ppc@yahoo.com>
Received: from web53702.mail.yahoo.com (web53702.mail.yahoo.com
	[206.190.37.23]) by ozlabs.org (Postfix) with SMTP id DB67467B6F
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Apr 2005 06:58:44 +1000 (EST)
Message-ID: <20050413205839.71410.qmail@web53702.mail.yahoo.com>
Date: Wed, 13 Apr 2005 13:58:39 -0700 (PDT)
From: Junita Ajith <junita_ppc@yahoo.com>
To: Clemens Koller <clemens.koller@anagramm.de>,
	linuxppc-embedded@ozlabs.org, ari@gdatech.com
In-Reply-To: <425CDCD1.3040302@anagramm.de>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-932264845-1113425919=:71056"
Subject: Re: Help needed Linux-2.6 - MPC8541
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-932264845-1113425919=:71056
Content-Type: text/plain; charset=us-ascii

Hello Clement Koller,
      Thanks for your response.
 
We have both Marvel & Intel's phy in our 8541 board.
 
As of now in the kernel we have just enabled support for Marvel's PHY.
  
It doesnt even  come to the point of detecting  the PHY ID (88E1011S). It just reads the PHy Address(Board specific) correclty.
 
Even before it gets into gianfar_phy.c it hangs at gianfar.c.
 
This is the screen dump.
---------------------------------------
 
 
Board: PCI-G8500 [PowerQUICC III]
        CPU: 825 MHz
        CCB: 330 MHz
        DDR: 165 MHz
        LBC: 82 MHz
L1 D-cache 32KB, L1 I-cache 32KB enabled.
I2C:   ready
DRAM:  256 MB
RMCG8400 in PCI Host Mode.
RMCG8400 is the PCI Arbiter.
FLASH:  8 MB
L2 cache enabled: 256KB
In:    serial
Out:   serial
Err:   serial
Net:   MOTO ENET0: PHY is Marvell 88E1011S (1410c67)
MOTO ENET2: PHY is Intel LXT971A (1378e2)
MOTO ENET0, MOTO ENET2
Hit any key to stop autoboot:  0
RMCG8500#>tftp 2000000 8541/vmlinux.img
Speed: 1000, full duplex
Using MOTO ENET0 device
TFTP from server 192.168.201.11; our IP address is 192.168.201.191
Filename '8541/vmlinux.img'.
Load address: 0x2000000
Loading: #################################################################
         #################################################################
         ###########################################
done
Bytes transferred = 883219 (d7a13 hex)
RMCG8500#>tftp 3000000 8541/ramdisk.image-8541.hdr
Speed: 1000, full duplex
Using MOTO ENET0 device
TFTP from server 192.168.201.11; our IP address is 192.168.201.191
Filename '8541/ramdisk.image-8541.hdr'.
Load address: 0x3000000
Loading: #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         ##################
done
Bytes transferred = 2751871 (29fd7f hex)
RMCG8500#>bootm 2000000 3000000
## Booting image at 02000000 ...
   Image Name:   PCIG8400-Rel-1.1
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    883155 Bytes = 862.5 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Loading RAMDisk Image at 03000000 ...
   Image Name:   PCIG8400
   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
   Data Size:    2751807 Bytes =  2.6 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Loading Ramdisk to 0fd12000, end 0ffb1d3f ... OK
Memory CAM mapping: CAM0=256Mb, CAM1=0Mb, CAM2=0Mb residual: 0Mb
Linux version 2.6.11 (pari@sjswsvr11) (gcc version 3.3.2) #16 Tue Apr 5 11:19:57
 PDT 2005
Built 1 zonelists
Kernel command line: console=ttyS0,115200 root=/dev/ram rw doPci=1
OpenPIC Version 1.2 (1 CPUs and 44 IRQ sources) at fcfbb000
PID hash table entries: 2048 (order: 11, 32768 bytes)
Console: colour dummy device 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 254720k available (1252k kernel code, 444k data, 292k init, 0k highmem)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
Freeing initrd memory: 2687k freed
NET: Registered protocol family 16
PCI: Probing PCI hardware
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
Serial: 8250/16550 driver $Revision: 1.90 $ 1 ports, IRQ sharing enabled
ttyS0 at MMIO 0xfdf04500 (irq = 90) is a 16550A
io scheduler noop registered inside elv_register()
RAMDISK driver initialized: 16 RAM disks of 32768K size 1024 blocksize
Inside gfar_probe() of gianfar.c
*************************************
Inside alloc_etherdev() for eth-1072721460
PHY base Addr is 0xd1002000
Before DMA engine stop for IEVENT
value of DMACTRL reg before writing to it : 0x0
value to be written to DMACTRL reg : 0x18
value of DMACTRL reg after writing to it  : 0x80000000
value of IEVENT reg : 0x80000000
***************************************************************************
 
And after this it just gets into the loop where it looks if the 'Gracious receive and Gracious stop' bits of the IEVENT register are set.

In our case it doesnt get set and so the kernel hangs at that point.
 
Thanks 
Junita

Clemens Koller <clemens.koller@anagramm.de> wrote:
Hi, Junita!

What PHYs do you use on the 8541?
Check if they are supported in gianfar_phy or if they
can be used with Generic MII
Check if you get the the phy_id is correct.
Some more debug-output would be nice.

I had to add Intel LXT971 support to the gianfar_phy
for my platform which is a 100MBit MII PHY only.

Clemens Koller
_______________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Str. 45/1
81379 Muenchen
Germany

http://www.anagramm.de
Phone: +49-89-741518-50
Fax: +49-89-741518-19

Junita Ajith wrote:
> Andy
> 
> 1. The code hangs exaclty at the point where it looks for the 'graceful transmit/receive' bits set in the IEVENT register. (IEVENT_GRSC , IEVENT_GTSC) .
> File - (linux-2.6/drivers/net/gianfar.c)
> Function - static int gfar_probe(struct device *device) ;
> 
> In that ,we write Graceful Receive Stop and Graceful Transmit Stop, and then wait until the corresponding bits in IEVENT indicate the stops have completed. 
> 
> This never happens and hence hangs at the 'while' loop inside that function.
> 
> 2. We are using Linux-2.6.11
> 
> Here's the serial output dump with a few debug messages.
> 
> ## Booting image at 02000000 ...
> Image Name: PCIG8400-Rel-1.1
> Image Type: PowerPC Linux Kernel Image (gzip compressed)
> Data Size: 883221 Bytes = 862.5 kB
> Load Address: 00000000
> Entry Point: 00000000
> Verifying Checksum ... OK
> Uncompressing Kernel Image ... OK
> ## Loading RAMDisk Image at 03000000 ...
> Image Name: PCIG8400
> Image Type: PowerPC Linux RAMDisk Image (gzip compressed)
> Data Size: 2751807 Bytes = 2.6 MB
> Load Address: 00000000
> Entry Point: 00000000
> Verifying Checksum ... OK
> Loading Ramdisk to 0fd12000, end 0ffb1d3f ... OK
> Memory CAM mapping: CAM0=256Mb, CAM1=0Mb, CAM2=0Mb residual: 0Mb
> Linux version 2.6.11 (pari@sjswsvr11) (gcc version 3.3.2) #16 Tue Apr 5 11:19:57
> PDT 2005
> Built 1 zonelists
> Kernel command line: console=ttyS0,115200 root=/dev/ram rw doPci=1
> OpenPIC Version 1.2 (1 CPUs and 44 IRQ sources) at fcfbb000
> PID hash table entries: 2048 (order: 11, 32768 bytes)
> Console: colour dummy device 80x25
> Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
> Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
> Memory: 254720k available (1252k kernel code, 444k data, 292k init, 0k highmem)
> Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
> checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
> Freeing initrd memory: 2687k freed
> NET: Registered protocol family 16
> PCI: Probing PCI hardware
> devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
> devfs: boot_options: 0x0
> Serial: 8250/16550 driver $Revision: 1.90 $ 1 ports, IRQ sharing enabled
> ttyS0 at MMIO 0xfdf04500 (irq = 90) is a 16550A
> io scheduler noop registered inside elv_register()
> RAMDISK driver initialized: 16 RAM disks of 32768K size 1024 blocksize
> Inside gfar_probe()
> einfo Phy ID 7
> gfar 1: additional data!
> Inside alloc_etherdev() for eth-1072721560
> start e0024000
> Resetting MAC........
> --2--MACCFG1 is 0x80000000
> MACCFG2 is 0x 0
> -2- tempval 000000db
> -3- tempval 00000000
> -4-1- tempval 00000000
> -4-2- tempval 00000000
> -4-2-a tempval 00000000
> -4-3 tempval 00000000
> -4-4 tempval 00000000
> Before loop -5- after writing to IEVENT tempval
> -5- after writing to IEVENT tempval 80000000
> -5- after writing to IEVENT tempval 80000000
> -5- after writing to IEVENT tempval 80000000
> -5- after writing to IEVENT tempval 80000000
> -5- after writing to IEVENT tempval 80000000
> -5- after writing to IEVENT tempval 80000000
> -5- after writing to IEVENT tempval 80000000
> 
> 
> 
> thanks,
> Junita
> Andy Fleming wrote:
> 
> Could you send me what the kernel prints up to the point of the hang?
> 
> Also, what version of 2.6 are you using? The board interface for the 
> driver changed recently to support the new driver model.
> 
> Andy
> 
> On Apr 12, 2005, at 12:38, Junita Ajith wrote:
> 
> 
>>Hi
>>We are trying to port Linux-2.6 for our custom
>>MPC8541 board.
>>
>>We have a TSEC and an FEC in the board.
>>
>>With the "Networking Support" disabled in the Kernel,
>>the board boots up fine and gets to the prompt.
>>
>>But with the "Networking Support" enabled in the
>>kernel the board hangs where it identifies the PHY,
>>inspite of giving the corrct PHY ID.
>>
>>
>>Any help is greatly appreciated.
>>
>>PS:
>>We have linux-2.4 ported for the same board and so
>>taking that as reference trying to port Linux-2.6 ,
>>but havent succeeded yet.
>>
>>Thanks
>>Junita
>>
>>
>>
>>__________________________________
>>Do you Yahoo!?
>>Make Yahoo! your home page
>>http://www.yahoo.com/r/hs
>>_______________________________________________
>>Linuxppc-embedded mailing list
>>Linuxppc-embedded@ozlabs.org
>>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>>
> 
> 
> 
> 
> 
> ---------------------------------
> Do you Yahoo!?
> Yahoo! Small Business - Try our new resources site! 
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-932264845-1113425919=:71056
Content-Type: text/html; charset=us-ascii

<DIV>Hello Clement Koller,</DIV>
<DIV>&nbsp;&nbsp;&nbsp; &nbsp; Thanks for your response.</DIV>
<DIV>&nbsp;</DIV>
<DIV>We have both Marvel &amp; Intel's phy in our 8541 board.</DIV>
<DIV>&nbsp;</DIV>
<DIV>As of now in the kernel we have just enabled support for Marvel's PHY.</DIV>
<DIV>&nbsp; </DIV>
<DIV>It doesnt even&nbsp; come to the point of detecting&nbsp; the PHY ID (88E1011S). It just reads the PHy Address(Board specific)&nbsp;correclty.</DIV>
<DIV>&nbsp;</DIV>
<DIV>Even before it gets into gianfar_phy.c it hangs at gianfar.c.</DIV>
<DIV>&nbsp;</DIV>
<DIV>This is the screen dump.</DIV>
<DIV>---------------------------------------</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;</DIV>
<DIV>Board: PCI-G8500 [PowerQUICC III]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CPU: 825 MHz<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CCB: 330 MHz<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DDR: 165 MHz<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LBC: 82 MHz<BR>L1 D-cache 32KB, L1 I-cache 32KB enabled.<BR>I2C:&nbsp;&nbsp; ready<BR>DRAM:&nbsp; 256 MB<BR>RMCG8400 in PCI Host Mode.<BR>RMCG8400 is the PCI Arbiter.<BR>FLASH:&nbsp; 8 MB<BR>L2 cache enabled: 256KB<BR>In:&nbsp;&nbsp;&nbsp; serial<BR>Out:&nbsp;&nbsp; serial<BR>Err:&nbsp;&nbsp; serial<BR>Net:&nbsp;&nbsp; MOTO ENET0: PHY is Marvell 88E1011S (1410c67)<BR>MOTO ENET2: PHY is Intel LXT971A (1378e2)<BR>MOTO ENET0, MOTO ENET2<BR>Hit any key to stop autoboot:&nbsp; 0<BR>RMCG8500#&gt;tftp 2000000 8541/vmlinux.img<BR>Speed: 1000, full duplex<BR>Using MOTO ENET0 device<BR>TFTP from server 192.168.201.11; our IP address is 192.168.201.191<BR>Filename '8541/vmlinux.img'.<BR>Load address: 0x2000000<BR>Loading:
 #################################################################<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #################################################################<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ###########################################<BR>done<BR>Bytes transferred = 883219 (d7a13 hex)<BR>RMCG8500#&gt;tftp 3000000 8541/ramdisk.image-8541.hdr<BR>Speed: 1000, full duplex<BR>Using MOTO ENET0 device<BR>TFTP from server 192.168.201.11; our IP address is 192.168.201.191<BR>Filename '8541/ramdisk.image-8541.hdr'.<BR>Load address: 0x3000000<BR>Loading: #################################################################<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #################################################################<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #################################################################<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 #################################################################<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #################################################################<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #################################################################<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #################################################################<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #################################################################<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ##################<BR>done<BR>Bytes transferred = 2751871 (29fd7f hex)<BR>RMCG8500#&gt;bootm 2000000 3000000<BR>## Booting image at 02000000 ...<BR>&nbsp;&nbsp; Image Name:&nbsp;&nbsp; PCIG8400-Rel-1.1<BR>&nbsp;&nbsp; Image Type:&nbsp;&nbsp; PowerPC Linux Kernel Image (gzip compressed)<BR>&nbsp;&nbsp; Data Size:&nbsp;&nbsp;&nbsp; 883155 Bytes = 862.5 kB<BR>&nbsp;&nbsp; Load Address:
 00000000<BR>&nbsp;&nbsp; Entry Point:&nbsp; 00000000<BR>&nbsp;&nbsp; Verifying Checksum ... OK<BR>&nbsp;&nbsp; Uncompressing Kernel Image ... OK<BR>## Loading RAMDisk Image at 03000000 ...<BR>&nbsp;&nbsp; Image Name:&nbsp;&nbsp; PCIG8400<BR>&nbsp;&nbsp; Image Type:&nbsp;&nbsp; PowerPC Linux RAMDisk Image (gzip compressed)<BR>&nbsp;&nbsp; Data Size:&nbsp;&nbsp;&nbsp; 2751807 Bytes =&nbsp; 2.6 MB<BR>&nbsp;&nbsp; Load Address: 00000000<BR>&nbsp;&nbsp; Entry Point:&nbsp; 00000000<BR>&nbsp;&nbsp; Verifying Checksum ... OK<BR>&nbsp;&nbsp; Loading Ramdisk to 0fd12000, end 0ffb1d3f ... OK<BR>Memory CAM mapping: CAM0=256Mb, CAM1=0Mb, CAM2=0Mb residual: 0Mb<BR>Linux version 2.6.11 (<A href="mailto:pari@sjswsvr11">pari@sjswsvr11</A>) (gcc version 3.3.2) #16 Tue Apr 5 11:19:57<BR>&nbsp;PDT 2005<BR>Built 1 zonelists<BR>Kernel command line: console=ttyS0,115200 root=/dev/ram rw doPci=1<BR>OpenPIC Version 1.2 (1 CPUs and 44 IRQ sources) at fcfbb000<BR>PID hash table entries: 2048 (order: 11, 32768
 bytes)<BR>Console: colour dummy device 80x25<BR>Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)<BR>Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)<BR>Memory: 254720k available (1252k kernel code, 444k data, 292k init, 0k highmem)<BR>Mount-cache hash table entries: 512 (order: 0, 4096 bytes)<BR>checking if image is initramfs...it isn't (no cpio magic); looks like an initrd<BR>Freeing initrd memory: 2687k freed<BR>NET: Registered protocol family 16<BR>PCI: Probing PCI hardware<BR>devfs: 2004-01-31 Richard Gooch (<A href="mailto:rgooch@atnf.csiro.au">rgooch@atnf.csiro.au</A>)<BR>devfs: boot_options: 0x0<BR>Serial: 8250/16550 driver $Revision: 1.90 $ 1 ports, IRQ sharing enabled<BR>ttyS0 at MMIO 0xfdf04500 (irq = 90) is a 16550A<BR>io scheduler noop registered inside elv_register()<BR>RAMDISK driver initialized: 16 RAM disks of 32768K size 1024 blocksize</DIV>
<DIV>Inside gfar_probe() of gianfar.c<BR>*************************************<BR>Inside alloc_etherdev() for eth-1072721460</DIV>
<DIV>PHY base Addr is 0xd1002000</DIV>
<DIV>Before DMA engine stop for IEVENT</DIV>
<DIV>value of DMACTRL reg before writing to it : 0x0<BR>value to be written to DMACTRL reg : 0x18<BR>value of DMACTRL reg after writing to it&nbsp; : 0x80000000<BR>value of IEVENT reg : 0x80000000</DIV>
<DIV>***************************************************************************</DIV>
<DIV>&nbsp;</DIV>
<DIV>And after this it just gets into the loop where it looks if the 'Gracious receive and Gracious stop' bits of the IEVENT register are set.<BR></DIV>
<DIV>In our case it doesnt get set and so the kernel hangs at that point.</DIV>
<DIV>&nbsp;</DIV>
<DIV>Thanks <BR>Junita<BR><BR><B><I>Clemens Koller &lt;clemens.koller@anagramm.de&gt;</I></B> wrote:</DIV>
<BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid">Hi, Junita!<BR><BR>What PHYs do you use on the 8541?<BR>Check if they are supported in gianfar_phy or if they<BR>can be used with Generic MII<BR>Check if you get the the phy_id is correct.<BR>Some more debug-output would be nice.<BR><BR>I had to add Intel LXT971 support to the gianfar_phy<BR>for my platform which is a 100MBit MII PHY only.<BR><BR>Clemens Koller<BR>_______________________________<BR>R&amp;D Imaging Devices<BR>Anagramm GmbH<BR>Rupert-Mayer-Str. 45/1<BR>81379 Muenchen<BR>Germany<BR><BR>http://www.anagramm.de<BR>Phone: +49-89-741518-50<BR>Fax: +49-89-741518-19<BR><BR>Junita Ajith wrote:<BR>&gt; Andy<BR>&gt; <BR>&gt; 1. The code hangs exaclty at the point where it looks for the 'graceful transmit/receive' bits set in the IEVENT register. (IEVENT_GRSC , IEVENT_GTSC) .<BR>&gt; File - (linux-2.6/drivers/net/gianfar.c)<BR>&gt; Function - static int gfar_probe(struct device
 *device) ;<BR>&gt; <BR>&gt; In that ,we write Graceful Receive Stop and Graceful Transmit Stop, and then wait until the corresponding bits in IEVENT indicate the stops have completed. <BR>&gt; <BR>&gt; This never happens and hence hangs at the 'while' loop inside that function.<BR>&gt; <BR>&gt; 2. We are using Linux-2.6.11<BR>&gt; <BR>&gt; Here's the serial output dump with a few debug messages.<BR>&gt; <BR>&gt; ## Booting image at 02000000 ...<BR>&gt; Image Name: PCIG8400-Rel-1.1<BR>&gt; Image Type: PowerPC Linux Kernel Image (gzip compressed)<BR>&gt; Data Size: 883221 Bytes = 862.5 kB<BR>&gt; Load Address: 00000000<BR>&gt; Entry Point: 00000000<BR>&gt; Verifying Checksum ... OK<BR>&gt; Uncompressing Kernel Image ... OK<BR>&gt; ## Loading RAMDisk Image at 03000000 ...<BR>&gt; Image Name: PCIG8400<BR>&gt; Image Type: PowerPC Linux RAMDisk Image (gzip compressed)<BR>&gt; Data Size: 2751807 Bytes = 2.6 MB<BR>&gt; Load Address: 00000000<BR>&gt; Entry Point: 00000000<BR>&gt; Verifying
 Checksum ... OK<BR>&gt; Loading Ramdisk to 0fd12000, end 0ffb1d3f ... OK<BR>&gt; Memory CAM mapping: CAM0=256Mb, CAM1=0Mb, CAM2=0Mb residual: 0Mb<BR>&gt; Linux version 2.6.11 (pari@sjswsvr11) (gcc version 3.3.2) #16 Tue Apr 5 11:19:57<BR>&gt; PDT 2005<BR>&gt; Built 1 zonelists<BR>&gt; Kernel command line: console=ttyS0,115200 root=/dev/ram rw doPci=1<BR>&gt; OpenPIC Version 1.2 (1 CPUs and 44 IRQ sources) at fcfbb000<BR>&gt; PID hash table entries: 2048 (order: 11, 32768 bytes)<BR>&gt; Console: colour dummy device 80x25<BR>&gt; Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)<BR>&gt; Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)<BR>&gt; Memory: 254720k available (1252k kernel code, 444k data, 292k init, 0k highmem)<BR>&gt; Mount-cache hash table entries: 512 (order: 0, 4096 bytes)<BR>&gt; checking if image is initramfs...it isn't (no cpio magic); looks like an initrd<BR>&gt; Freeing initrd memory: 2687k freed<BR>&gt; NET: Registered protocol family
 16<BR>&gt; PCI: Probing PCI hardware<BR>&gt; devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)<BR>&gt; devfs: boot_options: 0x0<BR>&gt; Serial: 8250/16550 driver $Revision: 1.90 $ 1 ports, IRQ sharing enabled<BR>&gt; ttyS0 at MMIO 0xfdf04500 (irq = 90) is a 16550A<BR>&gt; io scheduler noop registered inside elv_register()<BR>&gt; RAMDISK driver initialized: 16 RAM disks of 32768K size 1024 blocksize<BR>&gt; Inside gfar_probe()<BR>&gt; einfo Phy ID 7<BR>&gt; gfar 1: additional data!<BR>&gt; Inside alloc_etherdev() for eth-1072721560<BR>&gt; start e0024000<BR>&gt; Resetting MAC........<BR>&gt; --2--MACCFG1 is 0x80000000<BR>&gt; MACCFG2 is 0x 0<BR>&gt; -2- tempval 000000db<BR>&gt; -3- tempval 00000000<BR>&gt; -4-1- tempval 00000000<BR>&gt; -4-2- tempval 00000000<BR>&gt; -4-2-a tempval 00000000<BR>&gt; -4-3 tempval 00000000<BR>&gt; -4-4 tempval 00000000<BR>&gt; Before loop -5- after writing to IEVENT tempval<BR>&gt; -5- after writing to IEVENT tempval 80000000<BR>&gt; -5- after
 writing to IEVENT tempval 80000000<BR>&gt; -5- after writing to IEVENT tempval 80000000<BR>&gt; -5- after writing to IEVENT tempval 80000000<BR>&gt; -5- after writing to IEVENT tempval 80000000<BR>&gt; -5- after writing to IEVENT tempval 80000000<BR>&gt; -5- after writing to IEVENT tempval 80000000<BR>&gt; <BR>&gt; <BR>&gt; <BR>&gt; thanks,<BR>&gt; Junita<BR>&gt; Andy Fleming <AFLEMING@FREESCALE.COM>wrote:<BR>&gt; <BR>&gt; Could you send me what the kernel prints up to the point of the hang?<BR>&gt; <BR>&gt; Also, what version of 2.6 are you using? The board interface for the <BR>&gt; driver changed recently to support the new driver model.<BR>&gt; <BR>&gt; Andy<BR>&gt; <BR>&gt; On Apr 12, 2005, at 12:38, Junita Ajith wrote:<BR>&gt; <BR>&gt; <BR>&gt;&gt;Hi<BR>&gt;&gt;We are trying to port Linux-2.6 for our custom<BR>&gt;&gt;MPC8541 board.<BR>&gt;&gt;<BR>&gt;&gt;We have a TSEC and an FEC in the board.<BR>&gt;&gt;<BR>&gt;&gt;With the "Networking Support" disabled in the
 Kernel,<BR>&gt;&gt;the board boots up fine and gets to the prompt.<BR>&gt;&gt;<BR>&gt;&gt;But with the "Networking Support" enabled in the<BR>&gt;&gt;kernel the board hangs where it identifies the PHY,<BR>&gt;&gt;inspite of giving the corrct PHY ID.<BR>&gt;&gt;<BR>&gt;&gt;<BR>&gt;&gt;Any help is greatly appreciated.<BR>&gt;&gt;<BR>&gt;&gt;PS:<BR>&gt;&gt;We have linux-2.4 ported for the same board and so<BR>&gt;&gt;taking that as reference trying to port Linux-2.6 ,<BR>&gt;&gt;but havent succeeded yet.<BR>&gt;&gt;<BR>&gt;&gt;Thanks<BR>&gt;&gt;Junita<BR>&gt;&gt;<BR>&gt;&gt;<BR>&gt;&gt;<BR>&gt;&gt;__________________________________<BR>&gt;&gt;Do you Yahoo!?<BR>&gt;&gt;Make Yahoo! your home page<BR>&gt;&gt;http://www.yahoo.com/r/hs<BR>&gt;&gt;_______________________________________________<BR>&gt;&gt;Linuxppc-embedded mailing list<BR>&gt;&gt;Linuxppc-embedded@ozlabs.org<BR>&gt;&gt;https://ozlabs.org/mailman/listinfo/linuxppc-embedded<BR>&gt;&gt;<BR>&gt; <BR>&gt; <BR>&gt; <BR>&gt;
 <BR>&gt; <BR>&gt; ---------------------------------<BR>&gt; Do you Yahoo!?<BR>&gt; Yahoo! Small Business - Try our new resources site! <BR>&gt; <BR>&gt; <BR>&gt; ------------------------------------------------------------------------<BR>&gt; <BR>&gt; _______________________________________________<BR>&gt; Linuxppc-embedded mailing list<BR>&gt; Linuxppc-embedded@ozlabs.org<BR>&gt; https://ozlabs.org/mailman/listinfo/linuxppc-embedded<BR></BLOCKQUOTE><p>__________________________________________________<br>Do You Yahoo!?<br>Tired of spam?  Yahoo! Mail has the best spam protection around <br>http://mail.yahoo.com 
--0-932264845-1113425919=:71056--
