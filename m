Return-Path: <akonovalov@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 18CCEDDEDA
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 16 Mar 2007 19:10:51 +1100 (EST)
Message-ID: <45FA5237.9040705@ru.mvista.com>
Date: Fri, 16 Mar 2007 11:15:51 +0300
From: Andrei Konovalov <akonovalov@ru.mvista.com>
MIME-Version: 1.0
To: Leonid <Leonid@a-k-a.net>
Subject: Re: Wrong board info for ML403.
References: <20070315103959.GA22215@moe.telargo.com><20070315104228.GD22215@moe.telargo.com>	<528646bc0703150624i2bac5ce4n7beebc88d8acbafe@mail.gmail.com>
	<406A31B117F2734987636D6CCC93EE3CB05902@ehost011-3.exch011.intermedia.net>
In-Reply-To: <406A31B117F2734987636D6CCC93EE3CB05902@ehost011-3.exch011.intermedia.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Hello,

Haven't tried using u-boot with these boards, but here are couple earlier postings
to this list (sorry if you have look through them already):

-------- Original Message --------
Subject: Re: ML403 patch for UBOOT
Date: Mon, 25 Sep 2006 09:19:10 -0700
From: Peter Ryser <peter.ryser@xilinx.com>
To: Linuxppc-embedded@ozlabs.org

You might want to start with XAPP542
http://direct.xilinx.com/bvdocs/appnotes/xapp542.pdf
http://direct.xilinx.com/bvdocs/appnotes/xapp542.zip

The zip file includes the U-Boot patch for Linux kernel 2.4.

- Peter
-------- End of Original Message --------


-------- Original Message --------
Subject: Re: Led astray? Xilinx ml410 + u-boot + Linux?
Date: Thu, 01 Feb 2007 06:57:50 -0800
From: Peter Ryser <peter.ryser@xilinx.com>
To: linuxppc-embedded@ozlabs.org

Joe,

please have a look at http://www.xilinx.com/ml410-p. The pages do
contain information, documentation, and examples on how to use U-Boot
and Linux 2.4 on the ML410.
<snip>
-------- End of Original Message --------

For me this sounds like
1) patching kernel is required to get the correct params from u-boot
2) Xilinx has the recipes for 2.4 kernel
3) there is no ready-to-use recipe for 2.6 kernel, but it should not
    be too difficult to adapt the one for 2.4 kernel


Thanks,
Andrei

Leonid wrote:
> Hi:
> 
> I'm trying to bring up Linux on Xilinx ML403 reference board.
> 
> I took 2.6.19.2 kernel from DENX. EDK project for ML403 I took from
> official Xilinx site.
> 
> I could bring up u-boot on the board, everything is working fine (see
> ml403.h file attached). Then I compiled uImage for kernel and tried to
> download it - I don't see any kernel's outputs:
> 
> TFTP from server 192.168.0.141; our IP address is 192.168.0.203
> Filename 'LM200/rel/1.0.1d-403/uImage'.
> Load address: 0x1000000
> Loading: T
> #################################################################
>  
> #################################################################
>          #######################################
> done
> Bytes transferred = 861735 (d2627 hex)
> ## Booting image at 01000000 ...
>    Image Name:   Linux-2.6.19.2
>    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>    Data Size:    861671 Bytes = 841.5 kB
>    Load Address: 00000000
>    Entry Point:  00000000
>    Verifying Checksum ... OK
>    Uncompressing Kernel Image ... OK
> ## Current stack ends at 0x03E676F0 => set upper limit to 0x00800000
> ## cmdline at 0x007FFF00 ... 0x007FFFF8
> memstart    = 0x00000000
> memsize     = 0x04000000
> flashstart  = 0x28000000
> flashsize   = 0x00800000
> flashoffset = 0x00000000
> sramstart   = 0x00000000
> sramsize    = 0x00000000
> bootflags   = 0x0000003C
> procfreq    =    300 MHz
> plb_busfreq =    100 MHz
> ethaddr     = 00:01:02:CB:CB:71
> IP addr     = 192.168.0.203
> baudrate    = 115200 bps
> No initrd
> ## Transferring control to Linux (at address 00000000) ...
> 
> I have read a lot of posts and reviewed the source code and I think
> these kernel trees I'm using are properly patched for using u-boot; I
> only included asm/ppcboot.h into xilinx_403.h:
> 
> /* U-boot expects the bd_t to look like the one in ppcboot.h, not like
> this. */
> #ifdef NOT_USING_UBOOT
> typedef struct board_info {
> 	unsigned int	 bi_memsize;		/* DRAM installed, in
> bytes */
> 	unsigned char	 bi_enetaddr[6];	/* Local Ethernet MAC
> address */
> 	unsigned int	 bi_intfreq;		/* Processor speed, in
> Hz */
> 	unsigned int	 bi_busfreq;		/* PLB Bus speed, in Hz
> */
> 	unsigned int	 bi_pci_busfreq;	/* PCI Bus speed, in Hz
> */
> } bd_t;
> 
> /* Some 4xx parts use a different timebase frequency from the internal
> clock.
> */
> #define bi_tbfreq bi_intfreq
> 
> #else
> #include <asm/ppcboot.h>
> #endif /* UBOOT */
> 
> Anyway I tried to compile zImage.elf and download it directly to RAM
> using XMD. Here I had partial success: first time after FPGA image
> downloading I try it, I see the following (it doesn't happen if I try to
> repeat downloading again without reloading FPGA image first):
> 
> ====
> loaded at:     00400000 004DA13C
> board data at: 004D8124 004D813C
> relocated to:  00404090 004040A8
> zimage at:     00404E1D 004D7401
> avail ram:     004DB000 04000000
> 
> Linux/PPC load: console=ttyS0,115200
> Uncompressing Linux...done.
> Now booting the kernel
> [    0.000000] Linux version 2.6.19.2 (root@mylinux.a-k-a.local) (gcc
> version 4.0.0 (DENX ELDK 4.1 4.0.0)) #6 Thu Mar 15 05:46:09 PST 2007
> [    0.000000] Xilinx ML403 Reference System (Virtex-4 FX)
> [    0.000000] Zone PFN ranges:
> [    0.000000]   DMA             0 ->    16384
> [    0.000000]   Normal      16384 ->    16384
> [    0.000000] early_node_map[1] active PFN ranges
> [    0.000000]     0:        0 ->    16384
> [    0.000000] Built 1 zonelists.  Total pages: 16256
> [    0.000000] Kernel command line: console=ttyS0,115200
> [    0.000000] Xilinx INTC #0 at 0xD1000FC0 mapped to 0xFDFFEFC0
> [    0.000000] PID hash table entries: 256 (order: 8, 1024 bytes)
> [    0.000188] Console: colour dummy device 80x25
> [    0.000701] Dentry cache hash table entries: 8192 (order: 3, 32768
> bytes)
> [    0.001489] Inode-cache hash table entries: 4096 (order: 2, 16384
> bytes)
> [    0.015326] Memory: 63104k available (1324k kernel code, 436k data,
> 92k init, 0k highmem)
> [    0.108476] Mount-cache hash table entries: 512
> [    0.114051] NET: Registered protocol family 16
> [    0.128395] NET: Registered protocol family 2
> [    0.168472] IP route cache hash table entries: 512 (order: -1, 2048
> bytes)
> [    0.169340] TCP established hash table entries: 2048 (order: 1, 8192
> bytes)
> [    0.169539] TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
> [    0.169648] TCP: Hash tables configured (established 2048 bind 1024)
> [    0.169679] TCP reno registered
> [    0.173555] io scheduler noop registered
> [    0.173600] io scheduler anticipatory registered (default)
> [    0.173630] io scheduler deadline registered
> [    0.173756] io scheduler cfq registered
> [    0.221629] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ
> sharing disabled
> [    0.227023] serial8250.0: ttyS0 at MMIO 0xa0001003 (irq = 9) is a
> 16450
> [    0.398738] RAMDISK driver initialized: 16 RAM disks of 65536K size
> 1024 blocksize
> [    0.407941] tun: Universal TUN/TAP device driver, 1.6
> [    0.412993] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
> [    0.420583] mice: PS/2 mouse device common for all mice
> [    0.426040] TCP cubic registered
> [    0.429347] NET: Registered protocol family 1
> [    0.433727] NET: Registered protocol family 17
> [    0.439482] VFS: Cannot open root device "<NULL>" or
> unknown-block(0,0)
> [    0.446095] Please append a correct "root=" boot option
> [    0.451282] Kernel panic - not syncing: VFS: Unable to mount root fs
> on unknown-block(0,0)
> [    0.459492]  <0>Rebooting in 180 seconds..
> 
> I don't care about kernel panic for now - it's to be expected since I
> don't provide any filesystem. 
> 
> So, kernel itself is workable, it looks like uImage doesn't pick up
> correct board info parameters from u-boot. Where u-boot write them and
> where Linux looks for them? What is the simplest way to sync between
> u-boot and kernel?
> 
> Thanks,
> 
> Leonid.
> 
> 
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
