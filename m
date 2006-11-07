Return-Path: <pradeepsampath@yahoo.com>
Received: from web83209.mail.mud.yahoo.com (web83209.mail.mud.yahoo.com
	[216.252.101.65]) by ozlabs.org (Postfix) with SMTP id 6D28867D19
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Nov 2006 05:05:10 +1100 (EST)
Message-ID: <20061107180508.2760.qmail@web83209.mail.mud.yahoo.com>
Date: Tue, 7 Nov 2006 10:05:08 -0800 (PST)
From: Pradeep Sampath <pradeepsampath@yahoo.com>
Subject: Re: minor progress with plb_temac v3.00a, EDK 8.2, & 2.6.18.1
To: "David H. Lynch Jr." <dhlii@dlasys.net>, robert corley <rdcorle@yahoo.com>
In-Reply-To: <454D203D.4060908@dlasys.net>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-63313519-1162922708=:1116"
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

--0-63313519-1162922708=:1116
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hello,
   
  I was able to get the booting with a ramdisk working and also  David B./Peter's uartlite patches to work. Now I see the linux command line without any kernel panics. Thanks to everybody out there.
   
  Next step is to get the PLB TEMAC 3.00.a working...
   
  Question 1: I have started with the xapp902 reference design. I replaced the existing plb_temac_0 and hard_temac_0 instances with the plb_temac_0 (version 3.00.a) and hard_temac_0 (version 3.00.b). When I "generate libraries and BSP" I get the following error.
  
ERROR:MDT - intc () - Internal error: Number of interrupt inputs on opb_intc_0
   (1) is not the same as length of total number of interrupt sources (2). If
   any interrupt source is a vector then libgen does not support this use case
       while executing
   "error "Internal error: Number of interrupt inputs on $periph_name
   ($num_intr_inputs) is not the same as length of total number of interrupt.....
  .....
   ARG: C_PHY_TYPE VALUE: 1
ERROR:MDT - Error while running "generate" for processor ppc405_0...
   
  Or is it better to generate the EDK design from start rather than using the reference design?
   
  Question 2: For the adapter.c for TEMAC, I am using the C:\EDK\sw\ThirdParty\bsp\linux_2_6_v1_00_a\drivers\temac_linux_2_6_v2_00_b\src\adapter.c as indicated by Rick Moleres. Can I use it as is or it requires further tweaking? If yes, then what are the changes.
   
  Question 3: Are the files under linux\arch\ppc\platforms\xilinx_ocp required? I thought the files in ../drivers/xilinx_edk => should take care of all the dma stuff?

  Could someone provide some insight into all these questions?
  -Pradeep
  

"David H. Lynch Jr." <dhlii@dlasys.net> wrote:
  robert corley wrote:           Pradeep;

Booting with a ramdisk is a matter of putting the appropriate image in the arch/ppc/boot/images directory (I obtained mine from the gsrd design files), adding the root=/dev/ram rw on the command-line boot options, making the .config changes for ram disk support and initrd usage, and issuing a make zImage.initrd command.

Beware when upgrading to 2.6.18.1 as you may have difficulties with the adapter.c you obtained previously.  The adapter.c in EDK 8.2 is not as easy to find.  Using the EDK to generate software components for linux will not expose the proper adapter.c.  I had to use the path that Rick Moleres posted earlier to retrieve the adapter.c which I used for 2.6.18.1 and in my notes.

-cy



    I am booting with a ramdisk using initramfs. Aside from its being somewhat harder to find documentation I beleive it is actually easier.
    
    In the simplest form, create a directory on your host that contains exactly what you want on the ramdisk.
    Enable CONFIG_INITRAMFS
    and point the CONFIG_INITRAMFS_SOURCE  to that directory.

    It is pretty much that simple. The linux build process creates a kernel - I use zImage.elf that has the ramdisk compressed and concatentated.
    Nothing except the Linux kernel itself has to make any accomidations for the ramdisk. The bootloader does not have to deal with another file, or pass pointers to it to Linux, ....
    It took some time to get it working - mostly because I did nto know what I was doing, but in hindsight it is really easy.



        ----- Original Message ----
From: Pradeep Sampath <pradeepsampath@yahoo.com>
To: robert corley <rdcorle@yahoo.com>
Sent: Thursday, November 2, 2006 7:57:25 PM
Subject: Re: minor progress with plb_temac v3.00a, EDK 8.2, & 2.6.18.1

  This is great! I played around for a while with the Sysace CF driver patches and got it to work. Since you are booting with ramdisk image would you be kind enough to add more text on how to do that? I see that you are using UART Lite? Does it require any special setting for the boot logs to show up on the standard hyperterminal. 
   
  I am planning on rebuilding the whole system using EDK 8.2 and linux kernel 2.6.18.1.
   
  -Pradeep

robert corley <rdcorle@yahoo.com> wrote:
  For those interested, I have acheived some measure of success with the plb_temac driver.

I have attached a txt file of what I had to do to get it working under 2.6.18.1

I am using the plb_temac in DMA mode 3

Below you will see the boot dump.

For those able to help, can anyone provide insight as to the failure of setting PHY link speed?

-cy



====================
----------------------------------------------------------------------
2.6.18.1 kernel with all patches
11/02/2006 15:30
plb_temac v3.00a
hard_temac v3.00b


loaded at: 00400000 009F1138
board data at: 009EF120 009EF138
relocated to: 004040B4 004040CC
zimage at: 00404EC7 0057C1F2
initrd at: 0057D000 009EE6FE
avail ram: 009F2000 04000000


Linux/PPC load: console=ttyUL0 single ip=192.168.1.100:192.168.1.144:192.168.1.1:255.255.255.0:nab:: ramdisk_size=4660000 root=/dev/ram rw

Uncompressing Linux...done.

Now booting the kernel

[ 0.000000] Linux version 2.6.18.1 (rdcorle@athena) (gcc version 3.4.2) #2 Thu Nov 2 21:56:32 UTC 2006
[ 0.000000] Xilinx ML403 Reference System (Virtex-4 FX)
[ 0.000000] Built 1 zonelists. Total pages: 16384
[ 0.000000] Kernel command line: console=ttyUL0 single ip=192.168.1.100:192.168.1.144:192.168.1.1:255.255.255.0:nab:: ramdisk_size=4660000 root=/dev/ram rw
[ 0.000000] Xilinx INTC #0 at 0xD1000FC0 mapped to 0xFDFFFFC0
[ 0.000000] PID hash table entries: 512 (order: 9, 2048 bytes)
[ 0.000158] Console: colour dummy device 80x25
[ 0.000568] Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
[ 0.001277] Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
[ 0.012895] Memory: 57060k available (2548k kernel code, 640k data, 96k init, 0k highmem)
[ 0.104378] Mount-cache hash table entries: 512
[ 0.106721] checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
[ 2.414242] Freeing initrd memory: 4549k freed
[ 2.418712] NET: Registered protocol family 16
[ 2.427313] NET: Registered protocol family 2
[ 2.464244] IP route cache hash table entries: 512 (order: -1, 2048 bytes)
[ 2.465037] TCP established hash table entries: 2048 (order: 1, 8192 bytes)
[ 2.465205] TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
[ 2.465296] TCP: Hash tables configured (established 2048 bind 1024)
[ 2.465324] TCP reno registered
[ 2.474633] NTFS driver 2.1.27 [Flags: R/O].
[ 2.475046] JFS: nTxBlock = 481, nTxLock = 3854
[ 2.477623] SGI XFS with no debug enabled
[ 2.479001] io scheduler noop registered
[ 2.479109] io scheduler anticipatory registered
[ 2.479197] io scheduler deadline registered
[ 2.479402] io scheduler cfq registered (default)
[ 2.517627] uartlite.0: ttyUL0 at MMIO 0xa0000000 (irq = 1) is a uartlite
[ 2.691029] RAMDISK driver initialized: 16 RAM disks of 4660000K size 1024 blocksize
[ 2.703933] loop: loaded (max 8 devices)
[ 2.709698] XTemac: using sgDMA mode.
[ 2.713493] XTemac: using TxDRE mode
[ 2.717081] XTemac: using RxDRE mode
[ 2.720678] XTemac: buffer descriptor size: 32768 (0x8000)
[ 2.726622] XTemac: (buffer_descriptor_init) phy: 0x580000, virt: 0xff100000, size: 0x8000
[ 2.741073] eth0: Xilinx TEMAC #0 at 0x60000000 mapped to 0xC5050000, irq=0
[ 2.748080] eth0: XTemac id 1.0f, block id 5, type 8
[ 2.753636] mice: PS/2 mouse device common for all mice
[ 2.759529] TCP bic registered
[ 3.264317] eth0: XTemac: Options: 0xb8f2
[ 15.227339] eth0: XTemac: Not able to set the speed to 1000 (status: 0x148)
[ 25.200394] eth0: XTemac: Not able to set the speed to 100 (status: 0x148)
[ 35.173357] eth0: XTemac: Not able to set the speed to 10 (status: 0x148)
[ 35.180122] eth0: XTemac: could not negotiate speed
[ 35.187740] eth0: XTemac: Send Threshold = 16, Receive Threshold = 2
[ 35.194116] eth0: XTemac: Send Wait bound = 1, Receive Wait bound = 1
[ 36.205399] IP-Config: Complete:
[ 36.208459] device=eth0, addr=192.168.1.100, mask=255.255.255.0, gw=192.168.1.1,
[ 36.216339] host=nab, domain=, nis-domain=(none),
[ 36.221487] bootserver=192.168.1.144, rootserver=192.168.1.144, rootpath=
[ 36.229826] RAMDISK: Compressed image found at block 0
[ 37.200498] eth0: XTemac: PHY Link carrier lost.
[ 39.097820] VFS: Mounted root (ext2 filesystem).
[ 39.102751] Freeing unused kernel memory: 96k init
[ 39.108356] ulite_startup: UART status = 0x0014
[ 39.124619] ulite_startup: UART status = 0x0014
[ 39.134313] ulite_startup: UART status = 0x0014


BusyBox v1.00-pre9 (2004.04.18-19:53+0000) Built-in shell (ash)
Enter 'help' for a list of built-in commands.

-sh: can't access tty; job control turned off


steps for plb_temac drivers under EDK 8.2.02i (w/SP2.4+0)
Using plb_temac v3.00a & hard_temac v3.00b

Generate s/w libraries

1. copy or ftp the following files from C:\EDK\sw\ThirdParty\bsp\linux_2_6_v1_00_a\linux\
to the base directory of the linux source tree

USED:
arch\ppc\platforms\4xx\xparameters\xparameters.h

** UNUSED
arch\ppc\platforms\4xx\virtex.c
arch\ppc\boot\simple\embed_config.c
include\linux\xilinx_devices.h

2. copy C:\EDK\sw\ThirdParty\bsp\linux_2_6_v1_00_a\drivers\temac_linux_2_6_v2_00_b\src\adapter.c to
../drivers/net/xilinx_temac/adapter.c

3. copy or ftp ..\linux\arch\ppc\platforms\xilinx_ocp => drivers/xilinx_edk
Note: Remove all old files first *except* Kconfig, xio.h

4. modify drivers/xilinx_edk/Makefile with the following to look like this:

# Linux file to EXPORT_SYMBOL all of the Xilinx entries.
obj-$(CONFIG_XILINX_EDK) += xilinx_syms.o
#
# # The Xilinx OS independent code.
xilinx_syms-objs := xbasic_types.o \
xdmav3.o xdmav3_intr.o xdmav3_selftest.o xdmav3_simple.o xdmav3_sg.o \
xipif_v1_23_b.o \
xpacket_fifo_l_v2_00_a.o xpacket_fifo_v2_00_a.o \
xversion.o

5. Modify your copied xparameters_ml403.h (see notes below) as follows:
add these lines after #define XPAR_PLB_TEMAC_0_INCLUDE_RX_CSUM

#define XPAR_TEMAC_0_IPIF_RDFIFO_DEPTH XPAR_PLB_TEMAC_0_RXFIFO_DEPTH
#define XPAR_TEMAC_0_IPIF_WRFIFO_DEPTH XPAR_PLB_TEMAC_0_TXFIFO_DEPTH
#define XPAR_TEMAC_0_MAC_FIFO_DEPTH XPAR_PLB_TEMAC_0_MAC_FIFO_DEPTH
#define XPAR_TEMAC_0_TEMAC_DCR_HOST 0
#define XPAR_TEMAC_0_INCLUDE_DRE 1


6. (optional) modify arch/ppc/platforms/virtex.h to accomodate RX_CSUM XPAR

struct xtemac_platform_data {
#ifdef XPAR_TEMAC_0_INCLUDE_RX_CSUM
u8 tx_dre;
u8 rx_dre;
u8 tx_csum;
u8 rx_csum;
u8 phy_type;
#endif
u8 dma_mode;
u32 rx_pkt_fifo_depth;
u32 tx_pkt_fifo_depth;
u16 mac_fifo_depth;
u8 dcr_host;
u8 dre;
u8 mac_addr[6];
};

7. Modify ../drivers/net/xilinx_temac/adapter.c to remove #include and
add #include 
add #include 

____________________________________________________________________________________
NOTES:
1. Don't forget to copy EDK-generated xparameters.h to ../arch/ppc/platforms/4xx/xparameters/xparameters_ml403.h



=====================================================
Files in latest patch:
../drivers/net/xilinx_temac =
Makefile
adapter.c
xtemac.c
xtemac_control.c
xtemac_fifo.c
xtemac_intr.c
xtemac_intr_fifo.c
xtemac_intr_sgdma.c
xtemac_l.c
xtemac_sgdma.c
xtemac.h
xtemac_i.h
xtemac_l.h

Files in ..\linux\drivers\net\xilinx_temac => (** = new files)

Makefile
adapter.c
xtemac.c
xtemac_control.c
xtemac_fifo.c
xtemac_g.c**
xtemac_intr.c
xtemac_intr_fifo.c
xtemac_intr_sgdma.c
xtemac_l.c
xtemac_selftest.c**
xtemac_sgdma.c
xtemac_sinit.c**
xtemac_stats.c**
xtemac.h
xtemac_i.h
xtemac_l.h

============================================================
Files in ../drivers/xilinx_edk =>

Kconfig
Makefile
xbasic_types.c
xdmav2.c
xdmav2_intr.c
xdmav2_sg.c
xdmav2_simple.c
xilinx_syms.c
xpacket_fifo_l_v2_00_a.c
xpacket_fifo_v2_00_a.c
xbasic_types.h
xdmabdv2.h
xdmav2.h
xdmav2_l.h
xio.h
xpacket_fifo_l_v2_00_a.h
xpacket_fifo_v2_00_a.h
xstatus.h

Files in ..\linux\arch\ppc\platforms\xilinx_ocp=>
Makefile
xbasic_types.c
xutil_memtest.c
xpacket_fifo_v2_00_a.c
xdmav3.c
xpacket_fifo_l_v2_00_a.c
xdmav3_intr.c
xipif_v1_23_b.c
xdmav3_selftest.c
xdmav3_sg.c
xdmav3_simple.c
xversion.c
xenv.h
xenv_none.h
xenv_vxworks.h
xdmav3_l.h
xipif_v1_23_b.h
xdmav3.h
xpacket_fifo_l_v2_00_a.h
xdmabdv3.h
xpacket_fifo_v2_00_a.h
xparameters_ml300.h
xstatus.h
xutil.h
xbasic_types.h
xenv_linux.h
xversion.h
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded






---------------------------------
  _______________________________________________  Linuxppc-embedded mailing list  Linuxppc-embedded@ozlabs.org  https://ozlabs.org/mailman/listinfo/linuxppc-embedded



--   Dave Lynch             DLA Systems  Software Development:               Embedded Linux  717.627.3770         dhlii@dlasys.net    http://www.dlasys.net  fax: 1.253.369.9244               Cell: 1.717.587.7774  Over 25 years' experience in platforms, languages, and technologies too numerous to list.    "Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."  Albert Einstein  


--0-63313519-1162922708=:1116
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<DIV>Hello,</DIV>  <DIV>&nbsp;</DIV>  <DIV>I was able to get the booting with a ramdisk working&nbsp;and also&nbsp;&nbsp;David B./Peter's&nbsp;uartlite patches to work. Now I see the linux command line without any kernel panics. Thanks to everybody out there.</DIV>  <DIV>&nbsp;</DIV>  <DIV>Next step is to get the PLB TEMAC 3.00.a working...</DIV>  <DIV>&nbsp;</DIV>  <DIV>Question 1: I have started with the xapp902 reference design. I replaced the existing plb_temac_0 and hard_temac_0 instances with the plb_temac_0 (version 3.00.a) and hard_temac_0 (version 3.00.b). When&nbsp;I "generate libraries and BSP"&nbsp;I get the following error.</DIV>  <DIV><BR>ERROR:MDT - intc () - Internal error: Number of interrupt inputs on opb_intc_0<BR>&nbsp;&nbsp; (1) is not the same as length of total number of interrupt sources (2). If<BR>&nbsp;&nbsp; any interrupt source is a vector then libgen does not support this use case<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while
 executing<BR>&nbsp;&nbsp; "error "Internal error: Number of interrupt inputs on $periph_name<BR>&nbsp;&nbsp; ($num_intr_inputs) is not the same as length of total number of interrupt.....</DIV>  <DIV>.....<BR>&nbsp;&nbsp; ARG: C_PHY_TYPE VALUE: 1<BR>ERROR:MDT - Error while running "generate" for processor ppc405_0...</DIV>  <DIV>&nbsp;</DIV>  <DIV>Or is it better to generate the EDK design from start rather than using the reference design?</DIV>  <DIV>&nbsp;</DIV>  <DIV>Question 2: For the adapter.c for TEMAC, I am using the C:\EDK\sw\ThirdParty\bsp\linux_2_6_v1_00_a\drivers\temac_linux_2_6_v2_00_b\src\adapter.c as indicated by Rick Moleres. Can I use it as is or it requires further tweaking? If yes, then what are the changes.</DIV>  <DIV>&nbsp;</DIV>  <DIV>Question 3:&nbsp;Are the files under linux\arch\ppc\platforms\xilinx_ocp required? I thought the files in ../drivers/xilinx_edk =&gt; should take care of all the dma stuff?<BR></DIV>  <DIV>Could&nbsp;someone provide
 some&nbsp;insight&nbsp;into all&nbsp;these questions?</DIV>  <DIV>-Pradeep</DIV>  <DIV><BR><BR><B><I>"David H. Lynch Jr." &lt;dhlii@dlasys.net&gt;</I></B> wrote:</DIV>  <BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid">robert corley wrote:   <BLOCKQUOTE cite=mid:20061104150210.7507.qmail@web56301.mail.re3.yahoo.com type="cite">  <STYLE type=text/css><!-- DIV {margin:0px;} --></STYLE>    <DIV style="FONT-SIZE: 12pt; FONT-FAMILY: times new roman,new york,times,serif">  <DIV style="FONT-SIZE: 12pt; FONT-FAMILY: times new roman,new york,times,serif">Pradeep;<BR><BR>Booting with a ramdisk is a matter of putting the appropriate image in the arch/ppc/boot/images directory (I obtained mine from the gsrd design files), adding the root=/dev/ram rw on the command-line boot options, making the .config changes for ram disk support and initrd usage, and issuing a make zImage.initrd command.<BR><BR>Beware when upgrading to 2.6.18.1 as
 you may have difficulties with the adapter.c you obtained previously.&nbsp; The adapter.c in EDK 8.2 is not as easy to find.&nbsp; Using the EDK to generate software components for linux will not expose the proper adapter.c.&nbsp; I had to use the path that Rick Moleres posted earlier to retrieve the adapter.c which I used for 2.6.18.1 and in my notes.<BR><BR>-cy<BR><BR></DIV></DIV></BLOCKQUOTE>&nbsp;&nbsp;&nbsp; I am booting with a ramdisk using initramfs. Aside from its being somewhat harder to find documentation I beleive it is actually easier.<BR>&nbsp;&nbsp;&nbsp; <BR>&nbsp;&nbsp;&nbsp; In the simplest form, create a directory on your host that contains exactly what you want on the ramdisk.<BR>&nbsp;&nbsp;&nbsp; Enable CONFIG_INITRAMFS<BR>&nbsp;&nbsp;&nbsp; and point the CONFIG_INITRAMFS_SOURCE&nbsp; to that directory.<BR><BR>&nbsp;&nbsp;&nbsp; It is pretty much that simple. The linux build process creates a kernel - I use zImage.elf that has the ramdisk compressed
 and concatentated.<BR>&nbsp;&nbsp;&nbsp; Nothing except the Linux kernel itself has to make any accomidations for the ramdisk. The bootloader does not have to deal with another file, or pass pointers to it to Linux, ....<BR>&nbsp;&nbsp;&nbsp; It took some time to get it working - mostly because I did nto know what I was doing, but in hindsight it is really easy.<BR><BR><BR><BR>  <BLOCKQUOTE cite=mid:20061104150210.7507.qmail@web56301.mail.re3.yahoo.com type="cite">  <DIV style="FONT-SIZE: 12pt; FONT-FAMILY: times new roman,new york,times,serif">  <DIV style="FONT-SIZE: 12pt; FONT-FAMILY: times new roman,new york,times,serif">  <DIV style="FONT-SIZE: 12pt; FONT-FAMILY: times new roman,new york,times,serif">----- Original Message ----<BR>From: Pradeep Sampath <A class=moz-txt-link-rfc2396E href="mailto:pradeepsampath@yahoo.com">&lt;pradeepsampath@yahoo.com&gt;</A><BR>To: robert corley <A class=moz-txt-link-rfc2396E
 href="mailto:rdcorle@yahoo.com">&lt;rdcorle@yahoo.com&gt;</A><BR>Sent: Thursday, November 2, 2006 7:57:25 PM<BR>Subject: Re: minor progress with plb_temac v3.00a, EDK 8.2, &amp; 2.6.18.1<BR><BR>  <DIV>This is great! I played around for a while with the Sysace&nbsp;CF&nbsp;driver patches and got it to work. Since you are booting with ramdisk image would you be kind enough to add more text on how to do that? I see that you are using UART Lite? Does it require any special setting for the boot&nbsp;logs to show up on the standard hyperterminal. </DIV>  <DIV>&nbsp;</DIV>  <DIV>I am planning on rebuilding the whole system using EDK 8.2 and linux kernel 2.6.18.1.</DIV>  <DIV>&nbsp;</DIV>  <DIV>-Pradeep<BR><BR><B><I>robert corley <A class=moz-txt-link-rfc2396E href="mailto:rdcorle@yahoo.com">&lt;rdcorle@yahoo.com&gt;</A></I></B> wrote:</DIV>  <BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: rgb(16,16,255) 2px solid">For those interested, I have
 acheived some measure of success with the plb_temac driver.<BR><BR>I have attached a txt file of what I had to do to get it working under 2.6.18.1<BR><BR>I am using the plb_temac in DMA mode 3<BR><BR>Below you will see the boot dump.<BR><BR>For those able to help, can anyone provide insight as to the failure of setting PHY link speed?<BR><BR>-cy<BR><BR><BR><BR>====================<BR>----------------------------------------------------------------------<BR>2.6.18.1 kernel with all patches<BR>11/02/2006 15:30<BR>plb_temac v3.00a<BR>hard_temac v3.00b<BR><BR><BR>loaded at: 00400000 009F1138<BR>board data at: 009EF120 009EF138<BR>relocated to: 004040B4 004040CC<BR>zimage at: 00404EC7 0057C1F2<BR>initrd at: 0057D000 009EE6FE<BR>avail ram: 009F2000 04000000<BR><BR><BR>Linux/PPC load: console=ttyUL0 single ip=192.168.1.100:192.168.1.144:192.168.1.1:255.255.255.0:nab:: ramdisk_size=4660000 root=/dev/ram rw<BR><BR>Uncompressing Linux...done.<BR><BR>Now booting the kernel<BR><BR>[
 0.000000] Linux version 2.6.18.1 (rdcorle@athena) (gcc version 3.4.2) #2 Thu Nov 2 21:56:32 UTC 2006<BR>[ 0.000000] Xilinx ML403 Reference System (Virtex-4 FX)<BR>[ 0.000000] Built 1 zonelists. Total pages: 16384<BR>[ 0.000000] Kernel command line: console=ttyUL0 single ip=192.168.1.100:192.168.1.144:192.168.1.1:255.255.255.0:nab:: ramdisk_size=4660000 root=/dev/ram rw<BR>[ 0.000000] Xilinx INTC #0 at 0xD1000FC0 mapped to 0xFDFFFFC0<BR>[ 0.000000] PID hash table entries: 512 (order: 9, 2048 bytes)<BR>[ 0.000158] Console: colour dummy device 80x25<BR>[ 0.000568] Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)<BR>[ 0.001277] Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)<BR>[ 0.012895] Memory: 57060k available (2548k kernel code, 640k data, 96k init, 0k highmem)<BR>[ 0.104378] Mount-cache hash table entries: 512<BR>[ 0.106721] checking if image is initramfs...it isn't (no cpio magic); looks like an initrd<BR>[ 2.414242] Freeing initrd memory:
 4549k freed<BR>[ 2.418712] NET: Registered protocol family 16<BR>[ 2.427313] NET: Registered protocol family 2<BR>[ 2.464244] IP route cache hash table entries: 512 (order: -1, 2048 bytes)<BR>[ 2.465037] TCP established hash table entries: 2048 (order: 1, 8192 bytes)<BR>[ 2.465205] TCP bind hash table entries: 1024 (order: 0, 4096 bytes)<BR>[ 2.465296] TCP: Hash tables configured (established 2048 bind 1024)<BR>[ 2.465324] TCP reno registered<BR>[ 2.474633] NTFS driver 2.1.27 [Flags: R/O].<BR>[ 2.475046] JFS: nTxBlock = 481, nTxLock = 3854<BR>[ 2.477623] SGI XFS with no debug enabled<BR>[ 2.479001] io scheduler noop registered<BR>[ 2.479109] io scheduler anticipatory registered<BR>[ 2.479197] io scheduler deadline registered<BR>[ 2.479402] io scheduler cfq registered (default)<BR>[ 2.517627] uartlite.0: ttyUL0 at MMIO 0xa0000000 (irq = 1) is a uartlite<BR>[ 2.691029] RAMDISK driver initialized: 16 RAM disks of 4660000K size 1024 blocksize<BR>[ 2.703933] loop: loaded (max 8
 devices)<BR>[ 2.709698] XTemac: using sgDMA mode.<BR>[ 2.713493] XTemac: using TxDRE mode<BR>[ 2.717081] XTemac: using RxDRE mode<BR>[ 2.720678] XTemac: buffer descriptor size: 32768 (0x8000)<BR>[ 2.726622] XTemac: (buffer_descriptor_init) phy: 0x580000, virt: 0xff100000, size: 0x8000<BR>[ 2.741073] eth0: Xilinx TEMAC #0 at 0x60000000 mapped to 0xC5050000, irq=0<BR>[ 2.748080] eth0: XTemac id 1.0f, block id 5, type 8<BR>[ 2.753636] mice: PS/2 mouse device common for all mice<BR>[ 2.759529] TCP bic registered<BR>[ 3.264317] eth0: XTemac: Options: 0xb8f2<BR>[ 15.227339] eth0: XTemac: Not able to set the speed to 1000 (status: 0x148)<BR>[ 25.200394] eth0: XTemac: Not able to set the speed to 100 (status: 0x148)<BR>[ 35.173357] eth0: XTemac: Not able to set the speed to 10 (status: 0x148)<BR>[ 35.180122] eth0: XTemac: could not negotiate speed<BR>[ 35.187740] eth0: XTemac: Send Threshold = 16, Receive Threshold = 2<BR>[ 35.194116] eth0: XTemac: Send Wait bound = 1, Receive
 Wait bound = 1<BR>[ 36.205399] IP-Config: Complete:<BR>[ 36.208459] device=eth0, addr=192.168.1.100, mask=255.255.255.0, gw=192.168.1.1,<BR>[ 36.216339] host=nab, domain=, nis-domain=(none),<BR>[ 36.221487] bootserver=192.168.1.144, rootserver=192.168.1.144, rootpath=<BR>[ 36.229826] RAMDISK: Compressed image found at block 0<BR>[ 37.200498] eth0: XTemac: PHY Link carrier lost.<BR>[ 39.097820] VFS: Mounted root (ext2 filesystem).<BR>[ 39.102751] Freeing unused kernel memory: 96k init<BR>[ 39.108356] ulite_startup: UART status = 0x0014<BR>[ 39.124619] ulite_startup: UART status = 0x0014<BR>[ 39.134313] ulite_startup: UART status = 0x0014<BR><BR><BR>BusyBox v1.00-pre9 (2004.04.18-19:53+0000) Built-in shell (ash)<BR>Enter 'help' for a list of built-in commands.<BR><BR>-sh: can't access tty; job control turned off<BR><BR><BR>steps for plb_temac drivers under EDK 8.2.02i (w/SP2.4+0)<BR>Using plb_temac v3.00a &amp; hard_temac v3.00b<BR><BR>Generate s/w libraries<BR><BR>1. copy
 or ftp the following files from C:\EDK\sw\ThirdParty\bsp\linux_2_6_v1_00_a\linux\<BR>to the base directory of the linux source tree<BR><BR>USED:<BR>arch\ppc\platforms\4xx\xparameters\xparameters.h<BR><BR>** UNUSED<BR>arch\ppc\platforms\4xx\virtex.c<BR>arch\ppc\boot\simple\embed_config.c<BR>include\linux\xilinx_devices.h<BR><BR>2. copy C:\EDK\sw\ThirdParty\bsp\linux_2_6_v1_00_a\drivers\temac_linux_2_6_v2_00_b\src\adapter.c to<BR>../drivers/net/xilinx_temac/adapter.c<BR><BR>3. copy or ftp ..\linux\arch\ppc\platforms\xilinx_ocp =&gt; drivers/xilinx_edk<BR>Note: Remove all old files first *except* Kconfig, xio.h<BR><BR>4. modify drivers/xilinx_edk/Makefile with the following to look like this:<BR><BR># Linux file to EXPORT_SYMBOL all of the Xilinx entries.<BR>obj-$(CONFIG_XILINX_EDK) += xilinx_syms.o<BR>#<BR># # The Xilinx OS independent code.<BR>xilinx_syms-objs := xbasic_types.o \<BR>xdmav3.o xdmav3_intr.o xdmav3_selftest.o xdmav3_simple.o xdmav3_sg.o \<BR>xipif_v1_23_b.o
 \<BR>xpacket_fifo_l_v2_00_a.o xpacket_fifo_v2_00_a.o \<BR>xversion.o<BR><BR>5. Modify your copied xparameters_ml403.h (see notes below) as follows:<BR>add these lines after #define XPAR_PLB_TEMAC_0_INCLUDE_RX_CSUM<BR><BR>#define XPAR_TEMAC_0_IPIF_RDFIFO_DEPTH XPAR_PLB_TEMAC_0_RXFIFO_DEPTH<BR>#define XPAR_TEMAC_0_IPIF_WRFIFO_DEPTH XPAR_PLB_TEMAC_0_TXFIFO_DEPTH<BR>#define XPAR_TEMAC_0_MAC_FIFO_DEPTH XPAR_PLB_TEMAC_0_MAC_FIFO_DEPTH<BR>#define XPAR_TEMAC_0_TEMAC_DCR_HOST 0<BR>#define XPAR_TEMAC_0_INCLUDE_DRE 1<BR><BR><BR>6. (optional) modify arch/ppc/platforms/virtex.h to accomodate RX_CSUM XPAR<BR><BR>struct xtemac_platform_data {<BR>#ifdef XPAR_TEMAC_0_INCLUDE_RX_CSUM<BR>u8 tx_dre;<BR>u8 rx_dre;<BR>u8 tx_csum;<BR>u8 rx_csum;<BR>u8 phy_type;<BR>#endif<BR>u8 dma_mode;<BR>u32 rx_pkt_fifo_depth;<BR>u32 tx_pkt_fifo_depth;<BR>u16 mac_fifo_depth;<BR>u8 dcr_host;<BR>u8 dre;<BR>u8 mac_addr[6];<BR>};<BR><BR>7. Modify ../drivers/net/xilinx_temac/adapter.c to remove #include and<BR>add
 #include <BR>add #include <BR><BR>____________________________________________________________________________________<BR>NOTES:<BR>1. Don't forget to copy EDK-generated xparameters.h to ../arch/ppc/platforms/4xx/xparameters/xparameters_ml403.h<BR><BR><BR><BR>=====================================================<BR>Files in latest patch:<BR>../drivers/net/xilinx_temac =<BR>Makefile<BR>adapter.c<BR>xtemac.c<BR>xtemac_control.c<BR>xtemac_fifo.c<BR>xtemac_intr.c<BR>xtemac_intr_fifo.c<BR>xtemac_intr_sgdma.c<BR>xtemac_l.c<BR>xtemac_sgdma.c<BR>xtemac.h<BR>xtemac_i.h<BR>xtemac_l.h<BR><BR>Files in ..\linux\drivers\net\xilinx_temac =&gt; (** = new
 files)<BR><BR>Makefile<BR>adapter.c<BR>xtemac.c<BR>xtemac_control.c<BR>xtemac_fifo.c<BR>xtemac_g.c**<BR>xtemac_intr.c<BR>xtemac_intr_fifo.c<BR>xtemac_intr_sgdma.c<BR>xtemac_l.c<BR>xtemac_selftest.c**<BR>xtemac_sgdma.c<BR>xtemac_sinit.c**<BR>xtemac_stats.c**<BR>xtemac.h<BR>xtemac_i.h<BR>xtemac_l.h<BR><BR>============================================================<BR>Files in ../drivers/xilinx_edk =&gt;<BR><BR>Kconfig<BR>Makefile<BR>xbasic_types.c<BR>xdmav2.c<BR>xdmav2_intr.c<BR>xdmav2_sg.c<BR>xdmav2_simple.c<BR>xilinx_syms.c<BR>xpacket_fifo_l_v2_00_a.c<BR>xpacket_fifo_v2_00_a.c<BR>xbasic_types.h<BR>xdmabdv2.h<BR>xdmav2.h<BR>xdmav2_l.h<BR>xio.h<BR>xpacket_fifo_l_v2_00_a.h<BR>xpacket_fifo_v2_00_a.h<BR>xstatus.h<BR><BR>Files in
 ..\linux\arch\ppc\platforms\xilinx_ocp=&gt;<BR>Makefile<BR>xbasic_types.c<BR>xutil_memtest.c<BR>xpacket_fifo_v2_00_a.c<BR>xdmav3.c<BR>xpacket_fifo_l_v2_00_a.c<BR>xdmav3_intr.c<BR>xipif_v1_23_b.c<BR>xdmav3_selftest.c<BR>xdmav3_sg.c<BR>xdmav3_simple.c<BR>xversion.c<BR>xenv.h<BR>xenv_none.h<BR>xenv_vxworks.h<BR>xdmav3_l.h<BR>xipif_v1_23_b.h<BR>xdmav3.h<BR>xpacket_fifo_l_v2_00_a.h<BR>xdmabdv3.h<BR>xpacket_fifo_v2_00_a.h<BR>xparameters_ml300.h<BR>xstatus.h<BR>xutil.h<BR>xbasic_types.h<BR>xenv_linux.h<BR>xversion.h<BR>_______________________________________________<BR>Linuxppc-embedded mailing list<BR><A class=moz-txt-link-abbreviated href="mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org</A><BR><SPAN><A href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded" target=_blank moz-do-not-send="true">https://ozlabs.org/mailman/listinfo/linuxppc-embedded</A></SPAN></BLOCKQUOTE><BR></DIV><BR></DIV></DIV><PRE wrap=""><HR width="90%" SIZE=4> 
 _______________________________________________  Linuxppc-embedded mailing list  <A class=moz-txt-link-abbreviated href="mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org</A>  <A class=moz-txt-link-freetext href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://ozlabs.org/mailman/listinfo/linuxppc-embedded</A></PRE></BLOCKQUOTE><BR><BR><PRE class=moz-signature cols="72">--   Dave Lynch             DLA Systems  Software Development:               Embedded Linux  717.627.3770         <A class=moz-txt-link-abbreviated href="mailto:dhlii@dlasys.net">dhlii@dlasys.net</A>    <A class=moz-txt-link-freetext href="http://www.dlasys.net/">http://www.dlasys.net</A>  fax: 1.253.369.9244               Cell: 1.717.587.7774  Over 25 years' experience in platforms, languages, and technologies too numerous to list.    "Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite
 direction."  Albert Einstein  </PRE></BLOCKQUOTE><BR>
--0-63313519-1162922708=:1116--
