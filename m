Return-Path: <junita_ppc@yahoo.com>
Received: from web53705.mail.yahoo.com (web53705.mail.yahoo.com
	[206.190.37.26]) by ozlabs.org (Postfix) with SMTP id 4922B67B42
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Apr 2005 10:39:34 +1000 (EST)
Message-ID: <20050413003932.57133.qmail@web53705.mail.yahoo.com>
Date: Tue, 12 Apr 2005 17:39:32 -0700 (PDT)
From: Junita Ajith <junita_ppc@yahoo.com>
To: Andy Fleming <afleming@freescale.com>,
	linuxppc-embedded@ozlabs.org, pari@gdatech.com
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-310514976-1113352772=:56954"
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

--0-310514976-1113352772=:56954
Content-Type: text/plain; charset=us-ascii


Andy
 
   1. The code hangs exaclty at the point where it looks for the 'graceful transmit/receive' bits set in the IEVENT register. (IEVENT_GRSC , IEVENT_GTSC) .
                    File         - (linux-2.6/drivers/net/gianfar.c)
                    Function  - static int gfar_probe(struct device *device) ;
 
 In that ,we  write Graceful Receive Stop and Graceful  Transmit Stop, and then wait until the corresponding bits  in IEVENT indicate the stops have completed. 
 
  This never happens and hence hangs at the 'while' loop inside that function.
 
2. We are using Linux-2.6.11
 
Here's the serial output dump  with a few debug messages.
 
## Booting image at 02000000 ...
   Image Name:   PCIG8400-Rel-1.1
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    883221 Bytes = 862.5 kB
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
Inside gfar_probe()
einfo Phy ID 7
gfar 1: additional data!
Inside alloc_etherdev() for eth-1072721560
start e0024000
Resetting MAC........
--2--MACCFG1 is 0x80000000
MACCFG2 is 0x       0
-2- tempval 000000db
-3- tempval 00000000
-4-1- tempval 00000000
-4-2- tempval 00000000
-4-2-a tempval 00000000
-4-3 tempval 00000000
-4-4 tempval 00000000
Before loop -5- after writing to IEVENT tempval
-5- after writing to IEVENT tempval 80000000
-5- after writing to IEVENT tempval 80000000
-5- after writing to IEVENT tempval 80000000
-5- after writing to IEVENT tempval 80000000
-5- after writing to IEVENT tempval 80000000
-5- after writing to IEVENT tempval 80000000
-5- after writing to IEVENT tempval 80000000
 
 
 
thanks,
Junita
Andy Fleming <afleming@freescale.com> wrote:

Could you send me what the kernel prints up to the point of the hang?

Also, what version of 2.6 are you using? The board interface for the 
driver changed recently to support the new driver model.

Andy

On Apr 12, 2005, at 12:38, Junita Ajith wrote:

> Hi
> We are trying to port Linux-2.6 for our custom
> MPC8541 board.
>
> We have a TSEC and an FEC in the board.
>
> With the "Networking Support" disabled in the Kernel,
> the board boots up fine and gets to the prompt.
>
> But with the "Networking Support" enabled in the
> kernel the board hangs where it identifies the PHY,
> inspite of giving the corrct PHY ID.
>
>
> Any help is greatly appreciated.
>
> PS:
> We have linux-2.4 ported for the same board and so
> taking that as reference trying to port Linux-2.6 ,
> but havent succeeded yet.
>
> Thanks
> Junita
>
>
> 
> __________________________________
> Do you Yahoo!?
> Make Yahoo! your home page
> http://www.yahoo.com/r/hs
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>



		
---------------------------------
Do you Yahoo!?
 Yahoo! Small Business - Try our new resources site! 
--0-310514976-1113352772=:56954
Content-Type: text/html; charset=us-ascii

<DIV><BR>Andy</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;&nbsp; 1. The code hangs exaclty at the point where it looks for the 'graceful transmit/receive' bits set in the IEVENT register. (IEVENT_GRSC , IEVENT_GTSC) .</DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; File&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - (linux-2.6/drivers/net/gianfar.c)</DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Function&nbsp; -&nbsp;static int gfar_probe(struct device *device) ;</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;In that ,we&nbsp; write Graceful Receive Stop and Graceful&nbsp; Transmit Stop, and then wait until the corresponding bits&nbsp; in IEVENT indicate the stops have completed. </DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp; This never happens and hence hangs at the 'while' loop inside that function.</DIV>
<DIV>&nbsp;</DIV>
<DIV>2. We are using Linux-2.6.11</DIV>
<DIV>&nbsp;</DIV>
<DIV>Here's the serial output dump&nbsp; with a few debug messages.</DIV>
<DIV>&nbsp;</DIV>
<DIV>## Booting image at 02000000 ...<BR>&nbsp;&nbsp; Image Name:&nbsp;&nbsp; PCIG8400-Rel-1.1<BR>&nbsp;&nbsp; Image Type:&nbsp;&nbsp; PowerPC Linux Kernel Image (gzip compressed)<BR>&nbsp;&nbsp; Data Size:&nbsp;&nbsp;&nbsp; 883221 Bytes = 862.5 kB<BR>&nbsp;&nbsp; Load Address: 00000000<BR>&nbsp;&nbsp; Entry Point:&nbsp; 00000000<BR>&nbsp;&nbsp; Verifying Checksum ... OK<BR>&nbsp;&nbsp; Uncompressing Kernel Image ... OK<BR>## Loading RAMDisk Image at 03000000 ...<BR>&nbsp;&nbsp; Image Name:&nbsp;&nbsp; PCIG8400<BR>&nbsp;&nbsp; Image Type:&nbsp;&nbsp; PowerPC Linux RAMDisk Image (gzip compressed)<BR>&nbsp;&nbsp; Data Size:&nbsp;&nbsp;&nbsp; 2751807 Bytes =&nbsp; 2.6 MB<BR>&nbsp;&nbsp; Load Address: 00000000<BR>&nbsp;&nbsp; Entry Point:&nbsp; 00000000<BR>&nbsp;&nbsp; Verifying Checksum ... OK<BR>&nbsp;&nbsp; Loading Ramdisk to 0fd12000, end 0ffb1d3f ... OK<BR>Memory CAM mapping: CAM0=256Mb, CAM1=0Mb, CAM2=0Mb residual: 0Mb<BR>Linux version 2.6.11 (<A
 href="mailto:pari@sjswsvr11">pari@sjswsvr11</A>) (gcc version 3.3.2) #16 Tue Apr 5 11:19:57<BR>&nbsp;PDT 2005<BR>Built 1 zonelists<BR>Kernel command line: console=ttyS0,115200 root=/dev/ram rw doPci=1<BR>OpenPIC Version 1.2 (1 CPUs and 44 IRQ sources) at fcfbb000<BR>PID hash table entries: 2048 (order: 11, 32768 bytes)<BR>Console: colour dummy device 80x25<BR>Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)<BR>Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)<BR>Memory: 254720k available (1252k kernel code, 444k data, 292k init, 0k highmem)<BR>Mount-cache hash table entries: 512 (order: 0, 4096 bytes)<BR>checking if image is initramfs...it isn't (no cpio magic); looks like an initrd<BR>Freeing initrd memory: 2687k freed<BR>NET: Registered protocol family 16<BR>PCI: Probing PCI hardware<BR>devfs: 2004-01-31 Richard Gooch (<A href="mailto:rgooch@atnf.csiro.au">rgooch@atnf.csiro.au</A>)<BR>devfs: boot_options: 0x0<BR>Serial: 8250/16550 driver $Revision: 1.90
 $ 1 ports, IRQ sharing enabled<BR>ttyS0 at MMIO 0xfdf04500 (irq = 90) is a 16550A<BR>io scheduler noop registered inside elv_register()<BR>RAMDISK driver initialized: 16 RAM disks of 32768K size 1024 blocksize<BR>Inside gfar_probe()<BR>einfo Phy ID 7<BR>gfar 1: additional data!<BR>Inside alloc_etherdev() for eth-1072721560<BR>start e0024000<BR>Resetting MAC........</DIV>
<DIV>--2--MACCFG1 is 0x80000000</DIV>
<DIV>MACCFG2 is 0x&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<BR>-2- tempval 000000db<BR>-3- tempval 00000000<BR>-4-1- tempval 00000000<BR>-4-2- tempval 00000000<BR>-4-2-a tempval 00000000<BR>-4-3 tempval 00000000<BR>-4-4 tempval 00000000<BR>Before loop -5- after writing to IEVENT tempval<BR>-5- after writing to IEVENT tempval 80000000<BR>-5- after writing to IEVENT tempval 80000000<BR>-5- after writing to IEVENT tempval 80000000<BR>-5- after writing to IEVENT tempval 80000000<BR>-5- after writing to IEVENT tempval 80000000<BR>-5- after writing to IEVENT tempval 80000000<BR>-5- after writing to IEVENT tempval 80000000</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;</DIV>
<DIV>thanks,</DIV>
<DIV>Junita</DIV>
<DIV><B><I>Andy Fleming &lt;afleming@freescale.com&gt;</I></B> wrote:</DIV>
<BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid">
<P>Could you send me what the kernel prints up to the point of the hang?</P>
<P>Also, what version of 2.6 are you using? The board interface for the <BR>driver changed recently to support the new driver model.<BR><BR>Andy<BR><BR>On Apr 12, 2005, at 12:38, Junita Ajith wrote:<BR><BR>&gt; Hi<BR>&gt; We are trying to port Linux-2.6 for our custom<BR>&gt; MPC8541 board.<BR>&gt;<BR>&gt; We have a TSEC and an FEC in the board.<BR>&gt;<BR>&gt; With the "Networking Support" disabled in the Kernel,<BR>&gt; the board boots up fine and gets to the prompt.<BR>&gt;<BR>&gt; But with the "Networking Support" enabled in the<BR>&gt; kernel the board hangs where it identifies the PHY,<BR>&gt; inspite of giving the corrct PHY ID.<BR>&gt;<BR>&gt;<BR>&gt; Any help is greatly appreciated.<BR>&gt;<BR>&gt; PS:<BR>&gt; We have linux-2.4 ported for the same board and so<BR>&gt; taking that as reference trying to port Linux-2.6 ,<BR>&gt; but havent succeeded yet.<BR>&gt;<BR>&gt; Thanks<BR>&gt; Junita<BR>&gt;<BR>&gt;<BR>&gt; <BR>&gt; __________________________________<BR>&gt; Do you
 Yahoo!?<BR>&gt; Make Yahoo! your home page<BR>&gt; http://www.yahoo.com/r/hs<BR>&gt; _______________________________________________<BR>&gt; Linuxppc-embedded mailing list<BR>&gt; Linuxppc-embedded@ozlabs.org<BR>&gt; https://ozlabs.org/mailman/listinfo/linuxppc-embedded<BR>&gt;<BR><BR></P></BLOCKQUOTE><p>
		<hr size=1>Do you Yahoo!?<br> 
Yahoo! Small Business - <a href="http://us.rd.yahoo.com/evt=31637/*http://smallbusiness.yahoo.com/resources/">Try our new resources site!</a> 
--0-310514976-1113352772=:56954--
