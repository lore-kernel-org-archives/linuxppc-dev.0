Return-Path: <rwoodworth@securics.com>
Received: from securics.com (mail.securics.com [128.198.58.14])
	by ozlabs.org (Postfix) with ESMTP id 58EA3DDD04
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Jan 2008 02:47:51 +1100 (EST)
Subject: Re: Load Kernel 2.6 using U-boot on ML403
From: Robert Woodworth <rwoodworth@securics.com>
To: Yedu Jathavedan <yeduj@ece.pdx.edu>
In-Reply-To: <20080126231047.y3lm7epb0gw4cog8@webmail.cecs.pdx.edu>
References: <20080126231047.y3lm7epb0gw4cog8@webmail.cecs.pdx.edu>
Content-Type: text/plain
Date: Mon, 28 Jan 2008 08:47:36 -0700
Message-Id: <1201535256.4734.2.camel@PisteOff>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Do you really need u-boot??

I'm using an ML403 without u-boot.  I've generated my .ace file with the
zImage.elf directly and it works fine.



If there is a choice of u-boot or not, why choose u-boot?


RJW.




On Sat, 2008-01-26 at 23:10 -0800, Yedu Jathavedan wrote:
> Hi,
> I have downloaded the 2.6 kernel from
> http://git.secretlab.ca/git/linux-2.6-virtex.git , installed &
> compiled it. I used "make ARCH=ppc CROSS_COMPILE=ppc_4xx-
> ml403_defconfig" to build the .config file. (As explained in
> http://wiki.secretlab.ca/index.php/Linux_on_Xilinx_Virtex)
> 
> Problem -
> 
> 
> 1)Downloaded(sourceforge.net) & compiled the U-boot 1.1.6 files to get
> u-boot, u-boot.srec & u-boot.bin (I didn't find ml403 board config for
> the uboot. So used ml300_config). 
> 
> After this, I tried to convert the u-boot (README says that this is an
> ELF file) into an ace file. But, it gave me the error saying unable to
> read elf file. Is it because ML403 board is not supported or is it
> possible that the u-boot image that I created is corrupted?
> 
> $ xmd -tcl genace.tcl -jprog -board ml403 -hw download.bit -elf u-boot
> -ace uboot.ace
> Xilinx EDK 9.1 Build EDK_J.19
> Executing xmd script : $HOME/EDK/data/xmd/genace.tcl
> 
> #######################################################################
> XMD GenACE utility. Generate SystemACE File from bit/elf/data Files
> #######################################################################
> Target Type not defined for Processor 1, Using default Target Type
> ppc_hw
> GenACE Options:
>         Board      : ml403
>         Jtag Devs  : xcf32p xc4vfx12 xc95144xl
>         FPGA pos   : 2
>         JPROG      : true
>         HW File    : download.bit
>         ACE File   : uboot.ace
>         nCPUs      : 1
> 
>         Processor ppc_hw_1 Information
>                 Debug opt : -debugdevice devicenr 2 cpunr 1
>                 ELF files : u-boot
>                 Start PC Address : 0xfff80000
> 
> ############################################################
> Converting Bitstream 'download.bit' to SVF file 'download.svf'
> Executing 'impact -batch bit2svf.scr'
> Copying download.svf File to  uboot.svf File
> ############################################################
> Converting ELF file 'u-boot' to SVF file 'u-boot.svf'
> Error: E02 Failed to download ELF file
> 
> ERROR(1053): UNABLE to Read Elf File. The Elf File Maybe Corrupted
>         : u-boot
> #$
> 
> 
> ______________________________________________________________________
> Problem -
> 2) Since generating ace files failed, I tried to search the net for an
> u-boot ace file that could run on ML403 & found it at
> http://88.191.24.164/docenligne/projets/samba/2006/linux-embarque-sur-ml-403/u-boot-ml403.ace/view
> 
> I copied this ace file (u-boot-ml403.ace) along with the kernel 2.6
> image (uImage) onto my CF card & booted the board. After loading the
> kernel, it fails to read the correct root device. I tried changing the
> "bootargs" env variable root = /dev/xsysace/disc0/part2 rw to root
> = /dev/xsysace2 rw & root = /dev/xsda2 rw.
> 
> But, it failed in both cases. (There was a previous post on Problem2 a
> year ago & he solved it by giving root =/dev/xsysace2)
> 
> Environment size: 246/1020 bytes
> #u-boot> setenv bootargs console=ttyS0,9600 root=/dev/xsysace2 rw     
> #u-boot> fatload ace 0 0x400000 uImage
> reading uImage
> 
> 952237 bytes read
> #u-boot>  bootm 0x400000
> ## Booting image at 00400000 ...
>    Image Name:   Linux-2.6.24-rc3
>    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>    Data Size:    952173 Bytes = 929.9 kB
>    Load Address: 00000000
>    Entry Point:  00000000
>    Verifying Checksum ... OK
>    Uncompressing Kernel Image ... OK
> [    0.000000] Linux version 2.6.24-rc3 (icdt@icdt05) (gcc version
> 4.0.0 (DENX ELDK 4.0 4.0.0)) #1 Fri Jan 25 21:23:54 PST 2008
> [    0.000000] Xilinx ML403 Reference System (Virtex-4 FX)
> [    0.000000] Zone PFN ranges:
> [    0.000000]   DMA             0 ->    16384
> [    0.000000]   Normal      16384 ->    16384
> [    0.000000] Movable zone start PFN for each node
> [    0.000000] early_node_map[1] active PFN ranges
> [    0.000000]     0:        0 ->    16384
> [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
> Total pages: 16256
> [    0.000000] Kernel command line: console=ttyS0,9600 ip=off
> root=/dev/xsysace  root=/dev/xsysace2 rw
> [    0.000000] Xilinx INTC #0 at 0xD1000FC0 mapped to 0xFDFFEFC0
> [    0.000000] PID hash table entries: 256 (order: 8, 1024 bytes)
> [    0.000179] Console: colour dummy device 80x25
> [    0.000669] Dentry cache hash table entries: 8192 (order: 3, 32768
> bytes)
> [    0.001431] Inode-cache hash table entries: 4096 (order: 2, 16384
> bytes)
> [    0.015197] Memory: 62860k available (1452k kernel code, 496k data,
> 96k init, 0k highmem)
> [    0.204614] Mount-cache hash table entries: 512
> [    0.209345] net_namespace: 64 bytes
> [    0.213840] NET: Registered protocol family 16
> [    0.252576] NET: Registered protocol family 2
> [    0.288713] IP route cache hash table entries: 1024 (order: 0, 4096
> bytes)
> [    0.291229] TCP established hash table entries: 2048 (order: 2,
> 16384 bytes)
> [    0.291535] TCP bind hash table entries: 2048 (order: 1, 8192
> bytes)
> [    0.291709] TCP: Hash tables configured (established 2048 bind
> 2048)
> [    0.291737] TCP reno registered
> [    0.301433] sysctl table check failed: /kernel/l2cr .1.31 Missing
> strategy
> [    0.301509] Call Trace:
> [    0.301528] [c3c17e80] [c00084f4] show_stack+0x4c/0x174
> (unreliable)
> [    0.301611] [c3c17eb0] [c00305e0] set_fail+0x50/0x68
> [    0.301678] [c3c17ed0] [c0030c68] sysctl_check_table+0x670/0x6bc
> [    0.301726] [c3c17f10] [c0030c7c] sysctl_check_table+0x684/0x6bc
> [    0.301771] [c3c17f50] [c001df28] register_sysctl_table+0x5c/0xac
> [    0.301832] [c3c17f70] [c01dca84] register_ppc_htab_sysctl
> +0x18/0x2c
> [    0.301897] [c3c17f80] [c01d6848] kernel_init+0xc8/0x284
> [    0.301938] [c3c17ff0] [c0004af8] kernel_thread+0x44/0x60
> [    0.307739] io scheduler noop registered
> [    0.307792] io scheduler anticipatory registered (default)
> [    0.307817] io scheduler deadline registered
> [    0.307967] io scheduler cfq registered
> [    0.364669] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports,
> IRQ sharing disabled
> [    0.370815] serial8250.0: ttyS0 at MMIO 0xa0001003 (irq = 9) is a
> 16450
> [    0.370893] console [ttyS0] enabled
> [    3.286815] RAMDISK driver initialized: 16 RAM disks of 65536K size
> 1024 blocksize
> [    3.376997] tun: Universal TUN/TAP device driver, 1.6
> [    3.437161] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
> [    3.512736] mice: PS/2 mouse device common for all mice
> [    3.574814] TCP cubic registered
> [    3.613145] NET: Registered protocol family 1
> [    3.665227] NET: Registered protocol family 17
> [    3.720647] VFS: Cannot open root device "xsysace2" or
> unknown-block(0,0)
> [    3.801333] Please append a correct "root=" boot option; here are
> the available partitions:
> [    3.901354] Kernel panic - not syncing: VFS: Unable to mount root
> fs on unknown-block(0,0)
> [    4.000286] Rebooting in 180 seconds..
> 
> 
> ______________________________________________________________________
> Can anyone help me with either one (or both) of the above problems?  I
> have pretty much run out of ideas. :(
> 
> Thanks & Regards,
> Yedu
> 
> 
> Hi,
> 
> Goal - To use the USB Host on ML403 in a PowerPC processor reference
> system to store some data on a Thumb Drive.
> 
> Background - I downloaded the 2.6 kernel from
> http://git.secretlab.ca/git/linux-2.6-virtex.git , installed &
> compiled it to get uImage & zImage.elf files. I used "make
> ml403_defconfig" to build the .config file. (As explained in
> http://wiki.secretlab.ca/index.php/Linux_on_Xilinx_Virtex)
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
