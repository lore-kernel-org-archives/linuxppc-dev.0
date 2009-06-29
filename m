Return-Path: <gary@mlbassoc.com>
Received: from mail.chez-thomas.org (hermes.mlbassoc.com [76.76.67.137])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 35799B7085
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 30 Jun 2009 04:11:07 +1000 (EST)
Message-ID: <4A4901A8.5010402@mlbassoc.com>
Date: Mon, 29 Jun 2009 12:02:16 -0600
From: Gary Thomas <gary@mlbassoc.com>
MIME-Version: 1.0
To: Mikhail Zaturenskiy <mzaturenskiy.st@gmail.com>
Subject: Re: Trouble "Transferring control to Linux (at address 00000000)"
References: <97dd5fd20906260913x351593c9raa429fd657eb42f0@mail.gmail.com>
	<4A44FD90.2040607@freescale.com>	<97dd5fd20906261012h34a85b33j9183eb9e41ed1181@mail.gmail.com>
	<1ba63b520906271401u5d012b0ex87a48820b616ae48@mail.gmail.com>
	<97dd5fd20906291053u1a07c3afla1c2ea0590d01f1e@mail.gmail.com>
In-Reply-To: <97dd5fd20906291053u1a07c3afla1c2ea0590d01f1e@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Scott Wood <scottwood@freescale.com>,
	=?ISO-8859-1?Q?Frank_Svendsb=F8e?= <frank.svendsboe@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Mikhail Zaturenskiy wrote:
> Hi guys, I've been working off your suggestions and here's my update
> on where I'm at now.
> 
> For reference, attached are my current
> "linux-2.6-denx/arch/powerpc/boot/dts/ep88xc.dts" and
> "u-boot-2009.03/include/configs/EP88x.h".
> 
>> I might be able to help out. Scott's right. According to U-Boots
>> include/configs/EP88x.h,
>> CONFIG_SYS_IMMR is 0xf0000000, but the Linux the ep88xc.dts is
>> referring to an IMMR set
>> to 0xfa200000. Replace every instance of 0xfa20 with 0xf000, and it may work.
> I did notice the IMMR discrepancy and as Frank suggested adjusted the
> 0xfa20xxxx values to 0xf000xxxx in my DTS, though I'm wondering if it
> would be better to have just set my CONFIG_SYS_IMMR to 0xfa200000? Not
> sure if that would break more than it would fix. Anyways, I have not
> noticed any difference in output after changing this in the DTS, but
> I'll leave it this way as it seems more correct.
> 
>>>> Also, make sure u-boot is properly updating the memory size in the device
>>>> tree.  Can you dump the post-fixup device tree in u-boot?
>>> Not sure, but I'll try to find out if that's possible. It'd certainly
>>> answer a lot of questions...
> While I have not yet figured out how to dump the post-fixup tree... I
> can see that U-Boot doesn't seem to be doing proper fixup because
> after manually setting all the DTS fields that U-Boot was supposed to
> fill in (clock frequency, RAM start/end, etc.), the kernel seems to be
> going through a fairly normal boot sequence. Without me manually
> setting those fields, they remain initialized to 0. The only issue is
> that no output goes to the console.
> 
> Here is my current output.
>>From U-Boot:
> 
> U-Boot 2009.03-svn8591 (Jun 29 2009 - 11:25:23)
> 
> CPU:   MPC885ZPnn at 100 MHz [40.0...133.0 MHz]
>        8 kB I-Cache 8 kB D-Cache FEC present
> Board: EP88xC 1.1  CPLD revision 2
> DRAM:  64 MB
> FLASH: 32 MB
> In:    serial
> Out:   serial
> Err:   serial
> Net:   FEC ETHERNET, FEC2 ETHERNET
> Hit any key to stop autoboot:  0
> => tftp ep88x_uimage2
> Using FEC ETHERNET device
> TFTP from server 10.0.54.129; our IP address is 10.0.54.150
> Filename 'ep88x_uimage2'.
> Load address: 0x400000
> Loading: #################################################################
>          ########
> done
> Bytes transferred = 1057419 (10228b hex)
> => tftp 750000 ep88x_dtb2
> Using FEC ETHERNET device
> TFTP from server 10.0.54.129; our IP address is 10.0.54.150
> Filename 'ep88x_dtb2'.
> Load address: 0x750000
> Loading: #
> done
> Bytes transferred = 7725 (1e2d hex)
> => bootm 400000 - 750000
> ## Booting kernel from Legacy Image at 00400000 ...
>    Image Name:   Linux-2.6.30-rc2-01402-gd4e2f68-
>    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>    Data Size:    1057355 Bytes =  1 MB
>    Load Address: 00000000
>    Entry Point:  00000000
>    Verifying Checksum ... OK
> ## Flattened Device Tree blob at 00750000
>    Booting using the fdt blob at 0x750000
>    Uncompressing Kernel Image ... OK
> 
> 
>>From Kernel via postmortem analysis - sorry it's a little messy, my
> debugger ICDPPCZ is not that great at producing memory dumps so I had
> to do some cleanup/conversion to make the results at least somewhat
> legible:
> 
> <6>Using Embedded Planet EP88xC machine description?
> <5>Linux version 2.6.30-rc2-??1402-gd4e2f68-dirty
> (devone@localhost.localdomain) (gcc version 4.2.2) #1 Mon J??n 29
> 11:35:28 CDT 2009?
> <7>Top of RAM: 0x4000000' Total RAM: 0x4000000?
> <7>Memory??hole size: 0MB?
> <4>Zone PFN ranges:?
> <4>  DMA      0x00000000 -> 0x00004000?
> <4>  ??ormal   0x00004000 -> 0x00004000?
> <4>Movable zone start PFN for each node?
> <4>ear??y_node_map[1] active PFN ranges?
> <4>    0: 0x00000000 -> 0x00004000?
> <7>On node 0??totalpages: 16384?
> <7>free_area_init_node: node 0' pgdat c021bf7c' node_mem_map ??023f000?
> <7>  DMA zone: 128 pages used for memmap?
> <7>  DMA zone: 0 pages reserve???
> <7>  DMA zone: 16256 pages' LIFO batch:3?
> <6>MMU: Allocated 72 bytes of context??maps for 16 contexts?
> <4>Built 1 zonelists in Zone order' mobility grouping on. ??Total pages: 16256?
> <5>Kernel command line: console=ttyS0'9600n8 loglevel=7?
> <6>N??_IRQS:512?
> <7>irq: irq 5 on host /soc@f0000000/interrupt-controller@0 mapped to
> ??irtual irq 16?
> <7>irq: irq 0 on host /soc@f0000000/cpm@9c0/interrupt-controller@??30
> mapped to virtual irq 17?
> <4>PID hash table entries: 256 (order: 8' 1024 byte??)?
> <4>Decrementer Frequency = 0x7bfa48?
> <7>irq: irq 15 on host /soc@f0000000/inte??rupt-controller@0 mapped to
> virtual irq 18?
> <7>time_init: decrementer frequency ?? 8.125000 MHz?
> <7>time_init: processor frequency   = 130.000000 MHz?
> <6>clocksour??e: timebase mult[1ec4ec4f] shift[22] registered?
> <7>clockevent: decrementer mult??214] shift[16] cpu[0]?
> <6>Dentry cache hash table entries: 8192 (order: 3' 32768??bytes)?
> <6>Inode-cache hash table entries: 4096 (order: 2' 16384 bytes)?
> <6>Memor??: 62532k/65536k available (2064k kernel code' 2940k
> reserved' 100k data' 99k bs??' 96k init)?
> <6>SLUB: Genslabs=12' HWalign=16' Order=0-3' MinObjects=0' CPUs=1' ??odes=1?
> <6>Calibrating delay loop... 16.12 BogoMIPS (lpj=80640)?
> <4>Mount-cache h??sh table entries: 512?
> <6>net_namespace: 296 bytes?
> <6>NET: Registered protocol f??mily 16?
> <4>bio: create slab <bio-0> at 0?
> <7>Switched to high resolution mode on??CPU 0?
> <6>NET: Registered protocol family 2?
> <6>IP route cache hash table entries?? 1024 (order: 0' 4096 bytes)?
> <6>TCP established hash table entries: 2048 (order?? 2' 16384 bytes)?
> <6>TCP bind hash table entries: 2048 (order: 1' 8192 bytes)?
> <6??TCP: Hash tables configured (established 2048 bind 2048)?
> <6>TCP reno registered??
> <6>NET: Registered protocol family 1?
> <6>msgmni has been set to 122?
> <6>io schedu??er noop registered?
> <6>io scheduler deadline registered (default)?
> <6>Generic RTC??Driver v1.07?
> <7>irq: irq 4 on host /soc@f0000000/cpm@9c0/interrupt-controller@9??0
> mapped to virtual irq 19?
> <6>f0000a80.serial: ttyCPM0 at MMIO 0xc500ea80 (irq ?? 19) is a CPM UART?
> <7>irq: irq 29 on host /soc@f0000000/cpm@9c0/interrupt-contr??ller@930
> mapped to virtual irq 29?
> <6>f0000a20.serial: ttyCPM1 at MMIO 0xc501aa2?? (irq = 29) is a CPM UART?
> <7>irq: irq 3 on host /soc@f0000000/interrupt-control??er@0 mapped to
> virtual irq 20?
> <6>eth0: fs_enet: 00:00:00:00:00:00?
> <7>irq: irq 7??on host /soc@f0000000/interrupt-controller@0 mapped to
> virtual irq 21?
> <6>eth1: ??s_enet: 00:00:00:00:00:00?
> <6>FEC MII Bus: probed?
> <6>fe000000.flash: Found 2 x16??devices at 0x0 in 32-bit bank?
> <4> Amd/Fujitsu Extended Query Table at 0x0040?
> <4??fe000000.flash: CFI does not contain boot bank location. Assuming top.?
> <5>numbe?? of CFI chips: 1?
> <5>cfi_cmdset_0002: Disabling erase-suspend-program due to cod?? brokenness.?
> <6>TCP cubic registered?
> <6>NET: Registered protocol family 17?
> <6>R??C: Registered udp transport module.?
> <6>RPC: Registered tcp transport module.?
> <3??Root-NFS: No NFS server available' giving up.?
> <3>VFS: Unable to mount root fs v??a NFS' trying floppy.?
> <4>VFS: Cannot open root device "<NULL>" or unknown-block??2'0)?
> <4>Please append a correct "root=" boot option; here are the available
> par??itions:?
> <4>1f00           32768 mtdblock0 driver: of-flash?
> <0>Kernel panic - no?? syncing: VFS: Unable to mount root fs on
> unknown-block(2'0)?
> <4>Call Trace:?
> <4>??c381fed0] [c00069e0] show_stack+0x44/0x16c (unreliable)?
> <4>[c381ff10] [c001bc6c?? panic+0x8c/0x168?
> <4>[c381ff60] [c01ecb80] mount_block_root+0x12c/0x244?
> <4>[c38??ffb0] [c01ecdf4] prepare_namespace+0x4c/0x1c4?
> <4>[c381ffd0] [c01ec1b0] kernel_i??it+0xd0/0xfc?
> <4>[c381fff0] [c000da60] kernel_thread+0x4c/0x68?
> <0>Rebooting in 1??0 seconds..?????????????????????????????????
> 
> At this point, my primary goal is to get console output working before
> I do anything else. I've tried different "console=x" boot arguments
> and I've added the "chosen" section to my DTS, but still no output.
> Anyone have suggestions about this? Is something else messed up in my
> DTS?

Did you try 'root=ttyCPM0,9600'?


-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
