Return-Path: <dhlii@dlasys.net>
Received: from mx.dlasys.net (24.152.213.223.res-cmts.eph.ptd.net
	[24.152.213.223]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 11E8367C0F
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  5 Nov 2006 10:21:56 +1100 (EST)
Message-ID: <454D203D.4060908@dlasys.net>
Date: Sat, 04 Nov 2006 18:20:29 -0500
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: robert corley <rdcorle@yahoo.com>
Subject: Re: minor progress with plb_temac v3.00a, EDK 8.2, & 2.6.18.1
References: <20061104150210.7507.qmail@web56301.mail.re3.yahoo.com>
In-Reply-To: <20061104150210.7507.qmail@web56301.mail.re3.yahoo.com>
Content-Type: multipart/alternative;
	boundary="------------090005000705090800040206"
Cc: linux linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------090005000705090800040206
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

robert corley wrote:
> Pradeep;
>
> Booting with a ramdisk is a matter of putting the appropriate image in 
> the arch/ppc/boot/images directory (I obtained mine from the gsrd 
> design files), adding the root=/dev/ram rw on the command-line boot 
> options, making the .config changes for ram disk support and initrd 
> usage, and issuing a make zImage.initrd command.
>
> Beware when upgrading to 2.6.18.1 as you may have difficulties with 
> the adapter.c you obtained previously.  The adapter.c in EDK 8.2 is 
> not as easy to find.  Using the EDK to generate software components 
> for linux will not expose the proper adapter.c.  I had to use the path 
> that Rick Moleres posted earlier to retrieve the adapter.c which I 
> used for 2.6.18.1 and in my notes.
>
> -cy
>
    I am booting with a ramdisk using initramfs. Aside from its being 
somewhat harder to find documentation I beleive it is actually easier.
   
    In the simplest form, create a directory on your host that contains 
exactly what you want on the ramdisk.
    Enable CONFIG_INITRAMFS
    and point the CONFIG_INITRAMFS_SOURCE  to that directory.

    It is pretty much that simple. The linux build process creates a 
kernel - I use zImage.elf that has the ramdisk compressed and concatentated.
    Nothing except the Linux kernel itself has to make any accomidations 
for the ramdisk. The bootloader does not have to deal with another file, 
or pass pointers to it to Linux, ....
    It took some time to get it working - mostly because I did nto know 
what I was doing, but in hindsight it is really easy.



> ----- Original Message ----
> From: Pradeep Sampath <pradeepsampath@yahoo.com>
> To: robert corley <rdcorle@yahoo.com>
> Sent: Thursday, November 2, 2006 7:57:25 PM
> Subject: Re: minor progress with plb_temac v3.00a, EDK 8.2, & 2.6.18.1
>
> This is great! I played around for a while with the Sysace CF driver 
> patches and got it to work. Since you are booting with ramdisk image 
> would you be kind enough to add more text on how to do that? I see 
> that you are using UART Lite? Does it require any special setting for 
> the boot logs to show up on the standard hyperterminal.
>  
> I am planning on rebuilding the whole system using EDK 8.2 and linux 
> kernel 2.6.18.1.
>  
> -Pradeep
>
> */robert corley <rdcorle@yahoo.com>/* wrote:
>
>     For those interested, I have acheived some measure of success with
>     the plb_temac driver.
>
>     I have attached a txt file of what I had to do to get it working
>     under 2.6.18.1
>
>     I am using the plb_temac in DMA mode 3
>
>     Below you will see the boot dump.
>
>     For those able to help, can anyone provide insight as to the
>     failure of setting PHY link speed?
>
>     -cy
>
>
>
>     ====================
>     ----------------------------------------------------------------------
>     2.6.18.1 kernel with all patches
>     11/02/2006 15:30
>     plb_temac v3.00a
>     hard_temac v3.00b
>
>
>     loaded at: 00400000 009F1138
>     board data at: 009EF120 009EF138
>     relocated to: 004040B4 004040CC
>     zimage at: 00404EC7 0057C1F2
>     initrd at: 0057D000 009EE6FE
>     avail ram: 009F2000 04000000
>
>
>     Linux/PPC load: console=ttyUL0 single
>     ip=192.168.1.100:192.168.1.144:192.168.1.1:255.255.255.0:nab::
>     ramdisk_size=4660000 root=/dev/ram rw
>
>     Uncompressing Linux...done.
>
>     Now booting the kernel
>
>     [ 0.000000] Linux version 2.6.18.1 (rdcorle@athena) (gcc version
>     3.4.2) #2 Thu Nov 2 21:56:32 UTC 2006
>     [ 0.000000] Xilinx ML403 Reference System (Virtex-4 FX)
>     [ 0.000000] Built 1 zonelists. Total pages: 16384
>     [ 0.000000] Kernel command line: console=ttyUL0 single
>     ip=192.168.1.100:192.168.1.144:192.168.1.1:255.255.255.0:nab::
>     ramdisk_size=4660000 root=/dev/ram rw
>     [ 0.000000] Xilinx INTC #0 at 0xD1000FC0 mapped to 0xFDFFFFC0
>     [ 0.000000] PID hash table entries: 512 (order: 9, 2048 bytes)
>     [ 0.000158] Console: colour dummy device 80x25
>     [ 0.000568] Dentry cache hash table entries: 8192 (order: 3, 32768
>     bytes)
>     [ 0.001277] Inode-cache hash table entries: 4096 (order: 2, 16384
>     bytes)
>     [ 0.012895] Memory: 57060k available (2548k kernel code, 640k
>     data, 96k init, 0k highmem)
>     [ 0.104378] Mount-cache hash table entries: 512
>     [ 0.106721] checking if image is initramfs...it isn't (no cpio
>     magic); looks like an initrd
>     [ 2.414242] Freeing initrd memory: 4549k freed
>     [ 2.418712] NET: Registered protocol family 16
>     [ 2.427313] NET: Registered protocol family 2
>     [ 2.464244] IP route cache hash table entries: 512 (order: -1,
>     2048 bytes)
>     [ 2.465037] TCP established hash table entries: 2048 (order: 1,
>     8192 bytes)
>     [ 2.465205] TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
>     [ 2.465296] TCP: Hash tables configured (established 2048 bind 1024)
>     [ 2.465324] TCP reno registered
>     [ 2.474633] NTFS driver 2.1.27 [Flags: R/O].
>     [ 2.475046] JFS: nTxBlock = 481, nTxLock = 3854
>     [ 2.477623] SGI XFS with no debug enabled
>     [ 2.479001] io scheduler noop registered
>     [ 2.479109] io scheduler anticipatory registered
>     [ 2.479197] io scheduler deadline registered
>     [ 2.479402] io scheduler cfq registered (default)
>     [ 2.517627] uartlite.0: ttyUL0 at MMIO 0xa0000000 (irq = 1) is a
>     uartlite
>     [ 2.691029] RAMDISK driver initialized: 16 RAM disks of 4660000K
>     size 1024 blocksize
>     [ 2.703933] loop: loaded (max 8 devices)
>     [ 2.709698] XTemac: using sgDMA mode.
>     [ 2.713493] XTemac: using TxDRE mode
>     [ 2.717081] XTemac: using RxDRE mode
>     [ 2.720678] XTemac: buffer descriptor size: 32768 (0x8000)
>     [ 2.726622] XTemac: (buffer_descriptor_init) phy: 0x580000, virt:
>     0xff100000, size: 0x8000
>     [ 2.741073] eth0: Xilinx TEMAC #0 at 0x60000000 mapped to
>     0xC5050000, irq=0
>     [ 2.748080] eth0: XTemac id 1.0f, block id 5, type 8
>     [ 2.753636] mice: PS/2 mouse device common for all mice
>     [ 2.759529] TCP bic registered
>     [ 3.264317] eth0: XTemac: Options: 0xb8f2
>     [ 15.227339] eth0: XTemac: Not able to set the speed to 1000
>     (status: 0x148)
>     [ 25.200394] eth0: XTemac: Not able to set the speed to 100
>     (status: 0x148)
>     [ 35.173357] eth0: XTemac: Not able to set the speed to 10
>     (status: 0x148)
>     [ 35.180122] eth0: XTemac: could not negotiate speed
>     [ 35.187740] eth0: XTemac: Send Threshold = 16, Receive Threshold = 2
>     [ 35.194116] eth0: XTemac: Send Wait bound = 1, Receive Wait bound = 1
>     [ 36.205399] IP-Config: Complete:
>     [ 36.208459] device=eth0, addr=192.168.1.100, mask=255.255.255.0,
>     gw=192.168.1.1,
>     [ 36.216339] host=nab, domain=, nis-domain=(none),
>     [ 36.221487] bootserver=192.168.1.144, rootserver=192.168.1.144,
>     rootpath=
>     [ 36.229826] RAMDISK: Compressed image found at block 0
>     [ 37.200498] eth0: XTemac: PHY Link carrier lost.
>     [ 39.097820] VFS: Mounted root (ext2 filesystem).
>     [ 39.102751] Freeing unused kernel memory: 96k init
>     [ 39.108356] ulite_startup: UART status = 0x0014
>     [ 39.124619] ulite_startup: UART status = 0x0014
>     [ 39.134313] ulite_startup: UART status = 0x0014
>
>
>     BusyBox v1.00-pre9 (2004.04.18-19:53+0000) Built-in shell (ash)
>     Enter 'help' for a list of built-in commands.
>
>     -sh: can't access tty; job control turned off
>
>
>     steps for plb_temac drivers under EDK 8.2.02i (w/SP2.4+0)
>     Using plb_temac v3.00a & hard_temac v3.00b
>
>     Generate s/w libraries
>
>     1. copy or ftp the following files from
>     C:\EDK\sw\ThirdParty\bsp\linux_2_6_v1_00_a\linux\
>     to the base directory of the linux source tree
>
>     USED:
>     arch\ppc\platforms\4xx\xparameters\xparameters.h
>
>     ** UNUSED
>     arch\ppc\platforms\4xx\virtex.c
>     arch\ppc\boot\simple\embed_config.c
>     include\linux\xilinx_devices.h
>
>     2. copy
>     C:\EDK\sw\ThirdParty\bsp\linux_2_6_v1_00_a\drivers\temac_linux_2_6_v2_00_b\src\adapter.c
>     to
>     ../drivers/net/xilinx_temac/adapter.c
>
>     3. copy or ftp ..\linux\arch\ppc\platforms\xilinx_ocp =>
>     drivers/xilinx_edk
>     Note: Remove all old files first *except* Kconfig, xio.h
>
>     4. modify drivers/xilinx_edk/Makefile with the following to look
>     like this:
>
>     # Linux file to EXPORT_SYMBOL all of the Xilinx entries.
>     obj-$(CONFIG_XILINX_EDK) += xilinx_syms.o
>     #
>     # # The Xilinx OS independent code.
>     xilinx_syms-objs := xbasic_types.o \
>     xdmav3.o xdmav3_intr.o xdmav3_selftest.o xdmav3_simple.o xdmav3_sg.o \
>     xipif_v1_23_b.o \
>     xpacket_fifo_l_v2_00_a.o xpacket_fifo_v2_00_a.o \
>     xversion.o
>
>     5. Modify your copied xparameters_ml403.h (see notes below) as
>     follows:
>     add these lines after #define XPAR_PLB_TEMAC_0_INCLUDE_RX_CSUM
>
>     #define XPAR_TEMAC_0_IPIF_RDFIFO_DEPTH XPAR_PLB_TEMAC_0_RXFIFO_DEPTH
>     #define XPAR_TEMAC_0_IPIF_WRFIFO_DEPTH XPAR_PLB_TEMAC_0_TXFIFO_DEPTH
>     #define XPAR_TEMAC_0_MAC_FIFO_DEPTH XPAR_PLB_TEMAC_0_MAC_FIFO_DEPTH
>     #define XPAR_TEMAC_0_TEMAC_DCR_HOST 0
>     #define XPAR_TEMAC_0_INCLUDE_DRE 1
>
>
>     6. (optional) modify arch/ppc/platforms/virtex.h to accomodate
>     RX_CSUM XPAR
>
>     struct xtemac_platform_data {
>     #ifdef XPAR_TEMAC_0_INCLUDE_RX_CSUM
>     u8 tx_dre;
>     u8 rx_dre;
>     u8 tx_csum;
>     u8 rx_csum;
>     u8 phy_type;
>     #endif
>     u8 dma_mode;
>     u32 rx_pkt_fifo_depth;
>     u32 tx_pkt_fifo_depth;
>     u16 mac_fifo_depth;
>     u8 dcr_host;
>     u8 dre;
>     u8 mac_addr[6];
>     };
>
>     7. Modify ../drivers/net/xilinx_temac/adapter.c to remove #include and
>     add #include
>     add #include
>
>     ____________________________________________________________________________________
>     NOTES:
>     1. Don't forget to copy EDK-generated xparameters.h to
>     ../arch/ppc/platforms/4xx/xparameters/xparameters_ml403.h
>
>
>
>     =====================================================
>     Files in latest patch:
>     ../drivers/net/xilinx_temac =
>     Makefile
>     adapter.c
>     xtemac.c
>     xtemac_control.c
>     xtemac_fifo.c
>     xtemac_intr.c
>     xtemac_intr_fifo.c
>     xtemac_intr_sgdma.c
>     xtemac_l.c
>     xtemac_sgdma.c
>     xtemac.h
>     xtemac_i.h
>     xtemac_l.h
>
>     Files in ..\linux\drivers\net\xilinx_temac => (** = new files)
>
>     Makefile
>     adapter.c
>     xtemac.c
>     xtemac_control.c
>     xtemac_fifo.c
>     xtemac_g.c**
>     xtemac_intr.c
>     xtemac_intr_fifo.c
>     xtemac_intr_sgdma.c
>     xtemac_l.c
>     xtemac_selftest.c**
>     xtemac_sgdma.c
>     xtemac_sinit.c**
>     xtemac_stats.c**
>     xtemac.h
>     xtemac_i.h
>     xtemac_l.h
>
>     ============================================================
>     Files in ../drivers/xilinx_edk =>
>
>     Kconfig
>     Makefile
>     xbasic_types.c
>     xdmav2.c
>     xdmav2_intr.c
>     xdmav2_sg.c
>     xdmav2_simple.c
>     xilinx_syms.c
>     xpacket_fifo_l_v2_00_a.c
>     xpacket_fifo_v2_00_a.c
>     xbasic_types.h
>     xdmabdv2.h
>     xdmav2.h
>     xdmav2_l.h
>     xio.h
>     xpacket_fifo_l_v2_00_a.h
>     xpacket_fifo_v2_00_a.h
>     xstatus.h
>
>     Files in ..\linux\arch\ppc\platforms\xilinx_ocp=>
>     Makefile
>     xbasic_types.c
>     xutil_memtest.c
>     xpacket_fifo_v2_00_a.c
>     xdmav3.c
>     xpacket_fifo_l_v2_00_a.c
>     xdmav3_intr.c
>     xipif_v1_23_b.c
>     xdmav3_selftest.c
>     xdmav3_sg.c
>     xdmav3_simple.c
>     xversion.c
>     xenv.h
>     xenv_none.h
>     xenv_vxworks.h
>     xdmav3_l.h
>     xipif_v1_23_b.h
>     xdmav3.h
>     xpacket_fifo_l_v2_00_a.h
>     xdmabdv3.h
>     xpacket_fifo_v2_00_a.h
>     xparameters_ml300.h
>     xstatus.h
>     xutil.h
>     xbasic_types.h
>     xenv_linux.h
>     xversion.h
>     _______________________________________________
>     Linuxppc-embedded mailing list
>     Linuxppc-embedded@ozlabs.org
>     https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
>
>
> ------------------------------------------------------------------------
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded


-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein


--------------090005000705090800040206
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
robert corley wrote:
<blockquote
 cite="mid:20061104150210.7507.qmail@web56301.mail.re3.yahoo.com"
 type="cite">
  <style type="text/css"><!-- DIV {margin:0px;} --></style>
  <div
 style="font-family: times new roman,new york,times,serif; font-size: 12pt;">
  <div
 style="font-family: times new roman,new york,times,serif; font-size: 12pt;">Pradeep;<br>
  <br>
Booting with a ramdisk is a matter of putting the appropriate image in
the arch/ppc/boot/images directory (I obtained mine from the gsrd
design files), adding the root=/dev/ram rw on the command-line boot
options, making the .config changes for ram disk support and initrd
usage, and issuing a make zImage.initrd command.<br>
  <br>
Beware when upgrading to 2.6.18.1 as you may have difficulties with the
adapter.c you obtained previously.&nbsp; The adapter.c in EDK 8.2 is not as
easy to find.&nbsp; Using the EDK to generate software components for linux
will not expose the proper adapter.c.&nbsp; I had to use the path that Rick
Moleres posted earlier to retrieve the adapter.c which I used for
2.6.18.1 and in my notes.<br>
  <br>
-cy<br>
  <br>
  </div>
  </div>
</blockquote>
&nbsp;&nbsp;&nbsp; I am booting with a ramdisk using initramfs. Aside from its being
somewhat harder to find documentation I beleive it is actually easier.<br>
&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; In the simplest form, create a directory on your host that contains
exactly what you want on the ramdisk.<br>
&nbsp;&nbsp;&nbsp; Enable CONFIG_INITRAMFS<br>
&nbsp;&nbsp;&nbsp; and point the CONFIG_INITRAMFS_SOURCE&nbsp; to that directory.<br>
<br>
&nbsp;&nbsp;&nbsp; It is pretty much that simple. The linux build process creates a
kernel - I use zImage.elf that has the ramdisk compressed and
concatentated.<br>
&nbsp;&nbsp;&nbsp; Nothing except the Linux kernel itself has to make any
accomidations for the ramdisk. The bootloader does not have to deal
with another file, or pass pointers to it to Linux, ....<br>
&nbsp;&nbsp;&nbsp; It took some time to get it working - mostly because I did nto know
what I was doing, but in hindsight it is really easy.<br>
<br>
<br>
<br>
<blockquote
 cite="mid:20061104150210.7507.qmail@web56301.mail.re3.yahoo.com"
 type="cite">
  <div
 style="font-family: times new roman,new york,times,serif; font-size: 12pt;">
  <div
 style="font-family: times new roman,new york,times,serif; font-size: 12pt;">
  <div
 style="font-family: times new roman,new york,times,serif; font-size: 12pt;">-----
Original Message ----<br>
From: Pradeep Sampath <a class="moz-txt-link-rfc2396E" href="mailto:pradeepsampath@yahoo.com">&lt;pradeepsampath@yahoo.com&gt;</a><br>
To: robert corley <a class="moz-txt-link-rfc2396E" href="mailto:rdcorle@yahoo.com">&lt;rdcorle@yahoo.com&gt;</a><br>
Sent: Thursday, November 2, 2006 7:57:25 PM<br>
Subject: Re: minor progress with plb_temac v3.00a, EDK 8.2, &amp;
2.6.18.1<br>
  <br>
  <div>This is great! I played around for a while with the
Sysace&nbsp;CF&nbsp;driver patches and got it to work. Since you are booting with
ramdisk image would you be kind enough to add more text on how to do
that? I see that you are using UART Lite? Does it require any special
setting for the boot&nbsp;logs to show up on the standard hyperterminal. </div>
  <div>&nbsp;</div>
  <div>I am planning on rebuilding the whole system using EDK 8.2 and
linux kernel 2.6.18.1.</div>
  <div>&nbsp;</div>
  <div>-Pradeep<br>
  <br>
  <b><i>robert corley <a class="moz-txt-link-rfc2396E" href="mailto:rdcorle@yahoo.com">&lt;rdcorle@yahoo.com&gt;</a></i></b> wrote:</div>
  <blockquote class="replbq"
 style="border-left: 2px solid rgb(16, 16, 255); padding-left: 5px; margin-left: 5px;">For
those interested, I have acheived some measure of success with the
plb_temac driver.<br>
    <br>
I have attached a txt file of what I had to do to get it working under
2.6.18.1<br>
    <br>
I am using the plb_temac in DMA mode 3<br>
    <br>
Below you will see the boot dump.<br>
    <br>
For those able to help, can anyone provide insight as to the failure of
setting PHY link speed?<br>
    <br>
-cy<br>
    <br>
    <br>
    <br>
====================<br>
----------------------------------------------------------------------<br>
2.6.18.1 kernel with all patches<br>
11/02/2006 15:30<br>
plb_temac v3.00a<br>
hard_temac v3.00b<br>
    <br>
    <br>
loaded at: 00400000 009F1138<br>
board data at: 009EF120 009EF138<br>
relocated to: 004040B4 004040CC<br>
zimage at: 00404EC7 0057C1F2<br>
initrd at: 0057D000 009EE6FE<br>
avail ram: 009F2000 04000000<br>
    <br>
    <br>
Linux/PPC load: console=ttyUL0 single
ip=192.168.1.100:192.168.1.144:192.168.1.1:255.255.255.0:nab::
ramdisk_size=4660000 root=/dev/ram rw<br>
    <br>
Uncompressing Linux...done.<br>
    <br>
Now booting the kernel<br>
    <br>
[ 0.000000] Linux version 2.6.18.1 (rdcorle@athena) (gcc version 3.4.2)
#2 Thu Nov 2 21:56:32 UTC 2006<br>
[ 0.000000] Xilinx ML403 Reference System (Virtex-4 FX)<br>
[ 0.000000] Built 1 zonelists. Total pages: 16384<br>
[ 0.000000] Kernel command line: console=ttyUL0 single
ip=192.168.1.100:192.168.1.144:192.168.1.1:255.255.255.0:nab::
ramdisk_size=4660000 root=/dev/ram rw<br>
[ 0.000000] Xilinx INTC #0 at 0xD1000FC0 mapped to 0xFDFFFFC0<br>
[ 0.000000] PID hash table entries: 512 (order: 9, 2048 bytes)<br>
[ 0.000158] Console: colour dummy device 80x25<br>
[ 0.000568] Dentry cache hash table entries: 8192 (order: 3, 32768
bytes)<br>
[ 0.001277] Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)<br>
[ 0.012895] Memory: 57060k available (2548k kernel code, 640k data, 96k
init, 0k highmem)<br>
[ 0.104378] Mount-cache hash table entries: 512<br>
[ 0.106721] checking if image is initramfs...it isn't (no cpio magic);
looks like an initrd<br>
[ 2.414242] Freeing initrd memory: 4549k freed<br>
[ 2.418712] NET: Registered protocol family 16<br>
[ 2.427313] NET: Registered protocol family 2<br>
[ 2.464244] IP route cache hash table entries: 512 (order: -1, 2048
bytes)<br>
[ 2.465037] TCP established hash table entries: 2048 (order: 1, 8192
bytes)<br>
[ 2.465205] TCP bind hash table entries: 1024 (order: 0, 4096 bytes)<br>
[ 2.465296] TCP: Hash tables configured (established 2048 bind 1024)<br>
[ 2.465324] TCP reno registered<br>
[ 2.474633] NTFS driver 2.1.27 [Flags: R/O].<br>
[ 2.475046] JFS: nTxBlock = 481, nTxLock = 3854<br>
[ 2.477623] SGI XFS with no debug enabled<br>
[ 2.479001] io scheduler noop registered<br>
[ 2.479109] io scheduler anticipatory registered<br>
[ 2.479197] io scheduler deadline registered<br>
[ 2.479402] io scheduler cfq registered (default)<br>
[ 2.517627] uartlite.0: ttyUL0 at MMIO 0xa0000000 (irq = 1) is a
uartlite<br>
[ 2.691029] RAMDISK driver initialized: 16 RAM disks of 4660000K size
1024 blocksize<br>
[ 2.703933] loop: loaded (max 8 devices)<br>
[ 2.709698] XTemac: using sgDMA mode.<br>
[ 2.713493] XTemac: using TxDRE mode<br>
[ 2.717081] XTemac: using RxDRE mode<br>
[ 2.720678] XTemac: buffer descriptor size: 32768 (0x8000)<br>
[ 2.726622] XTemac: (buffer_descriptor_init) phy: 0x580000, virt:
0xff100000, size: 0x8000<br>
[ 2.741073] eth0: Xilinx TEMAC #0 at 0x60000000 mapped to 0xC5050000,
irq=0<br>
[ 2.748080] eth0: XTemac id 1.0f, block id 5, type 8<br>
[ 2.753636] mice: PS/2 mouse device common for all mice<br>
[ 2.759529] TCP bic registered<br>
[ 3.264317] eth0: XTemac: Options: 0xb8f2<br>
[ 15.227339] eth0: XTemac: Not able to set the speed to 1000 (status:
0x148)<br>
[ 25.200394] eth0: XTemac: Not able to set the speed to 100 (status:
0x148)<br>
[ 35.173357] eth0: XTemac: Not able to set the speed to 10 (status:
0x148)<br>
[ 35.180122] eth0: XTemac: could not negotiate speed<br>
[ 35.187740] eth0: XTemac: Send Threshold = 16, Receive Threshold = 2<br>
[ 35.194116] eth0: XTemac: Send Wait bound = 1, Receive Wait bound = 1<br>
[ 36.205399] IP-Config: Complete:<br>
[ 36.208459] device=eth0, addr=192.168.1.100, mask=255.255.255.0,
gw=192.168.1.1,<br>
[ 36.216339] host=nab, domain=, nis-domain=(none),<br>
[ 36.221487] bootserver=192.168.1.144, rootserver=192.168.1.144,
rootpath=<br>
[ 36.229826] RAMDISK: Compressed image found at block 0<br>
[ 37.200498] eth0: XTemac: PHY Link carrier lost.<br>
[ 39.097820] VFS: Mounted root (ext2 filesystem).<br>
[ 39.102751] Freeing unused kernel memory: 96k init<br>
[ 39.108356] ulite_startup: UART status = 0x0014<br>
[ 39.124619] ulite_startup: UART status = 0x0014<br>
[ 39.134313] ulite_startup: UART status = 0x0014<br>
    <br>
    <br>
BusyBox v1.00-pre9 (2004.04.18-19:53+0000) Built-in shell (ash)<br>
Enter 'help' for a list of built-in commands.<br>
    <br>
-sh: can't access tty; job control turned off<br>
    <br>
    <br>
steps for plb_temac drivers under EDK 8.2.02i (w/SP2.4+0)<br>
Using plb_temac v3.00a &amp; hard_temac v3.00b<br>
    <br>
Generate s/w libraries<br>
    <br>
1. copy or ftp the following files from
C:\EDK\sw\ThirdParty\bsp\linux_2_6_v1_00_a\linux\<br>
to the base directory of the linux source tree<br>
    <br>
USED:<br>
arch\ppc\platforms\4xx\xparameters\xparameters.h<br>
    <br>
** UNUSED<br>
arch\ppc\platforms\4xx\virtex.c<br>
arch\ppc\boot\simple\embed_config.c<br>
include\linux\xilinx_devices.h<br>
    <br>
2. copy
C:\EDK\sw\ThirdParty\bsp\linux_2_6_v1_00_a\drivers\temac_linux_2_6_v2_00_b\src\adapter.c
to<br>
../drivers/net/xilinx_temac/adapter.c<br>
    <br>
3. copy or ftp ..\linux\arch\ppc\platforms\xilinx_ocp =&gt;
drivers/xilinx_edk<br>
Note: Remove all old files first *except* Kconfig, xio.h<br>
    <br>
4. modify drivers/xilinx_edk/Makefile with the following to look like
this:<br>
    <br>
# Linux file to EXPORT_SYMBOL all of the Xilinx entries.<br>
obj-$(CONFIG_XILINX_EDK) += xilinx_syms.o<br>
#<br>
# # The Xilinx OS independent code.<br>
xilinx_syms-objs := xbasic_types.o \<br>
xdmav3.o xdmav3_intr.o xdmav3_selftest.o xdmav3_simple.o xdmav3_sg.o \<br>
xipif_v1_23_b.o \<br>
xpacket_fifo_l_v2_00_a.o xpacket_fifo_v2_00_a.o \<br>
xversion.o<br>
    <br>
5. Modify your copied xparameters_ml403.h (see notes below) as follows:<br>
add these lines after #define XPAR_PLB_TEMAC_0_INCLUDE_RX_CSUM<br>
    <br>
#define XPAR_TEMAC_0_IPIF_RDFIFO_DEPTH XPAR_PLB_TEMAC_0_RXFIFO_DEPTH<br>
#define XPAR_TEMAC_0_IPIF_WRFIFO_DEPTH XPAR_PLB_TEMAC_0_TXFIFO_DEPTH<br>
#define XPAR_TEMAC_0_MAC_FIFO_DEPTH XPAR_PLB_TEMAC_0_MAC_FIFO_DEPTH<br>
#define XPAR_TEMAC_0_TEMAC_DCR_HOST 0<br>
#define XPAR_TEMAC_0_INCLUDE_DRE 1<br>
    <br>
    <br>
6. (optional) modify arch/ppc/platforms/virtex.h to accomodate RX_CSUM
XPAR<br>
    <br>
struct xtemac_platform_data {<br>
#ifdef XPAR_TEMAC_0_INCLUDE_RX_CSUM<br>
u8 tx_dre;<br>
u8 rx_dre;<br>
u8 tx_csum;<br>
u8 rx_csum;<br>
u8 phy_type;<br>
#endif<br>
u8 dma_mode;<br>
u32 rx_pkt_fifo_depth;<br>
u32 tx_pkt_fifo_depth;<br>
u16 mac_fifo_depth;<br>
u8 dcr_host;<br>
u8 dre;<br>
u8 mac_addr[6];<br>
};<br>
    <br>
7. Modify ../drivers/net/xilinx_temac/adapter.c to remove #include and<br>
add #include <br>
add #include <br>
    <br>
____________________________________________________________________________________<br>
NOTES:<br>
1. Don't forget to copy EDK-generated xparameters.h to
../arch/ppc/platforms/4xx/xparameters/xparameters_ml403.h<br>
    <br>
    <br>
    <br>
=====================================================<br>
Files in latest patch:<br>
../drivers/net/xilinx_temac =<br>
Makefile<br>
adapter.c<br>
xtemac.c<br>
xtemac_control.c<br>
xtemac_fifo.c<br>
xtemac_intr.c<br>
xtemac_intr_fifo.c<br>
xtemac_intr_sgdma.c<br>
xtemac_l.c<br>
xtemac_sgdma.c<br>
xtemac.h<br>
xtemac_i.h<br>
xtemac_l.h<br>
    <br>
Files in ..\linux\drivers\net\xilinx_temac =&gt; (** = new files)<br>
    <br>
Makefile<br>
adapter.c<br>
xtemac.c<br>
xtemac_control.c<br>
xtemac_fifo.c<br>
xtemac_g.c**<br>
xtemac_intr.c<br>
xtemac_intr_fifo.c<br>
xtemac_intr_sgdma.c<br>
xtemac_l.c<br>
xtemac_selftest.c**<br>
xtemac_sgdma.c<br>
xtemac_sinit.c**<br>
xtemac_stats.c**<br>
xtemac.h<br>
xtemac_i.h<br>
xtemac_l.h<br>
    <br>
============================================================<br>
Files in ../drivers/xilinx_edk =&gt;<br>
    <br>
Kconfig<br>
Makefile<br>
xbasic_types.c<br>
xdmav2.c<br>
xdmav2_intr.c<br>
xdmav2_sg.c<br>
xdmav2_simple.c<br>
xilinx_syms.c<br>
xpacket_fifo_l_v2_00_a.c<br>
xpacket_fifo_v2_00_a.c<br>
xbasic_types.h<br>
xdmabdv2.h<br>
xdmav2.h<br>
xdmav2_l.h<br>
xio.h<br>
xpacket_fifo_l_v2_00_a.h<br>
xpacket_fifo_v2_00_a.h<br>
xstatus.h<br>
    <br>
Files in ..\linux\arch\ppc\platforms\xilinx_ocp=&gt;<br>
Makefile<br>
xbasic_types.c<br>
xutil_memtest.c<br>
xpacket_fifo_v2_00_a.c<br>
xdmav3.c<br>
xpacket_fifo_l_v2_00_a.c<br>
xdmav3_intr.c<br>
xipif_v1_23_b.c<br>
xdmav3_selftest.c<br>
xdmav3_sg.c<br>
xdmav3_simple.c<br>
xversion.c<br>
xenv.h<br>
xenv_none.h<br>
xenv_vxworks.h<br>
xdmav3_l.h<br>
xipif_v1_23_b.h<br>
xdmav3.h<br>
xpacket_fifo_l_v2_00_a.h<br>
xdmabdv3.h<br>
xpacket_fifo_v2_00_a.h<br>
xparameters_ml300.h<br>
xstatus.h<br>
xutil.h<br>
xbasic_types.h<br>
xenv_linux.h<br>
xversion.h<br>
_______________________________________________<br>
Linuxppc-embedded mailing list<br>
<a class="moz-txt-link-abbreviated" href="mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org</a><br>
    <span><a moz-do-not-send="true" target="_blank"
 href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a></span></blockquote>
  <br>
  </div>
  <br>
  </div>
  </div>
  <pre wrap="">
<hr size="4" width="90%">
_______________________________________________
Linuxppc-embedded mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org</a>
<a class="moz-txt-link-freetext" href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a></pre>
</blockquote>
<br>
<br>
<pre class="moz-signature" cols="72">-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       <a class="moz-txt-link-abbreviated" href="mailto:dhlii@dlasys.net">dhlii@dlasys.net</a> 	  <a class="moz-txt-link-freetext" href="http://www.dlasys.net">http://www.dlasys.net</a>
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
</pre>
</body>
</html>

--------------090005000705090800040206--
