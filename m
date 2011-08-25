Return-Path: <gary@mlbassoc.com>
Received: from mail.chez-thomas.org (cl-316.chi-02.us.sixxs.net
	[IPv6:2001:4978:f:13b::2])
	by ozlabs.org (Postfix) with ESMTP id 9AC11B6F69
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 25 Aug 2011 21:11:38 +1000 (EST)
Message-ID: <4E562DE3.9020206@mlbassoc.com>
Date: Thu, 25 Aug 2011 05:11:31 -0600
From: Gary Thomas <gary@mlbassoc.com>
MIME-Version: 1.0
To: smitha.vanga@wipro.com
Subject: Re: Kernel boot up
References: <07ACDFB8ECA8EF47863A613BC01BBB22035E3A70@HYD-MKD-MBX02.wipro.com>
In-Reply-To: <07ACDFB8ECA8EF47863A613BC01BBB22035E3A70@HYD-MKD-MBX02.wipro.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2011-08-25 01:57, smitha.vanga@wipro.com wrote:
> Hi Scott,
>
> I am currently trying to bring up 2.6.39 kernel on a target based on MPC8247
> Processor, using the attched .dts file . I get the below logs while the kernel is booting.
> I see that the unflattening of the device tree and the initial loading of the kernel and ramdisk file system is happening correctly. Can you point me where exactly I can look for
> this issue. I am attaching the .config and .dts file I am using.

There doesn't seem to be anything wrong with the kernel in this log.
The failure is in the user code - in particular, udev is giving up
with these errors:
   /sbin/udevstart: '/lib/libc.so.6' library contains unsupported TLS
After that, all is lost as there will be no console, etc, for the
rest of the system to use...

You need to examine how you built the root file system and why you
are getting these errors.  This problem seems to be unique to uclibc

>
>
> bootm 1000000 2000000 c00000
> ## Current stack ends at 0x03e93cc8
> * kernel: cmdline image address = 0x01000000
> ## Booting kernel from Legacy Image at 01000000 ...
> Image Name: Linux-2.6.39
> Image Type: PowerPC Linux Kernel Image (gzip compressed)
> Data Size: 1766015 Bytes = 1.7 MiB
> Load Address: 00000000
> Entry Point: 00000000
> Verifying Checksum ... OK
> kernel data at 0x01000040, len = 0x001af27f (1766015)
> * ramdisk: cmdline image address = 0x02000000
> ## Loading init Ramdisk from Legacy Image at 02000000 ...
> Image Name:
> Image Type: PowerPC Linux RAMDisk Image (gzip compressed)
> Data Size: 2211111 Bytes = 2.1 MiB
> Load Address: 00000000
> Entry Point: 00000000
> Verifying Checksum ... OK
> ramdisk start = 0x02000040, ramdisk end = 0x0221bd67
> * fdt: cmdline image address = 0x00c00000
> ## Checking for 'FDT'/'FDT Image' at 00c00000
> * fdt: raw FDT blob
> ## Flattened Device Tree blob at 00c00000
> Booting using the fdt blob at 0xc00000
> of_flat_tree at 0x00c00000 size 0x00000f12
> Uncompressing Kernel Image ... OK
> kernel loaded at 0x00000000, end = 0x00389d20
> ## initrd_high = 0xffffffff, copy_to_ram = 1
> Loading Ramdisk to 03c76000, end 03e91d27 ... OK
> ramdisk load start = 0x03c76000, ramdisk load end = 0x03e91d27
> ## device tree at 00c00000 ... 00c00f11 (len=16146 [0x3F12])
> Loading Device Tree to 007fc000, end 007fff11 ... OK
> Updating property 'clock-frequency' = 00 fe 70 b8
> Updating property 'bus-frequency' = 03 f9 c2 e0
> Updating property 'timebase-frequency' = 00 7f 38 5c
> Updating property 'clock-frequency' = 09 f0 67 30
> ## Transferring control to Linux (at address 00000000) ...
> Booting using OF flat tree...
> Using Freescale MPC8272 ADS machine description
> Linux version 2.6.39 (2.6.39) (ktuser@ktuser) (gcc version 4.4.5 (Buildroot 2011
> .02) ) #5 Wed Aug 24 15:02:07 IST 2011
> Found initrd at 0xc3c76000:0xc3e91d27
> No bcsr in device tree
> Zone PFN ranges:
> DMA 0x00000000 -> 0x00004000
> Normal empty
> Movable zone start PFN for each node
> early_node_map[1] active PFN ranges
> 0: 0x00000000 -> 0x00004000
> Built 1 zonelists in Zone order, mobility grouping on. Total pages: 16256
> Kernel command line: mem=64M root=/dev/ram rw
> PID hash table entries: 256 (order: -2, 1024 bytes)
> Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
> Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
> Memory: 57972k/65536k available (3524k kernel code, 7564k reserved, 100k data, 1
> 137k bss, 168k init)
> Kernel virtual memory layout:
> * 0xfffdf000..0xfffff000 : fixmap
> * 0xfdfb6000..0xfe000000 : early ioremap
> * 0xc5000000..0xfdfb6000 : vmalloc & ioremap
> SLUB: Genslabs=15, HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
> NR_IRQS:512 nr_irqs:512 16
> No pci pic node in device tree.
> clocksource: timebase mult[1dfc2974] shift[22] registered
> console [ttyCPM0] enabled
> pid_max: default: 32768 minimum: 301
> Mount-cache hash table entries: 512
> NET: Registered protocol family 16
> PCI: Probing PCI hardware
> bio: create slab <bio-0> at 0
> vgaarb: loaded
> Switching to clocksource timebase
>
> brd: module loaded
> loop: module loaded
> of-flash ff800000.flash: do_map_probe() failed
> PPP generic driver version 2.4.2
> PPP Deflate Compression module registered
> tun: Universal TUN/TAP device driver, 1.6
> tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
> eth0: fs_enet: 00:00:00:00:00:00
> eth1: fs_enet: 00:00:00:00:00:00
> CPM2 Bitbanged MII: probed
> mousedev: PS/2 mouse device common for all mice
> TCP cubic registered
> NET: Registered protocol family 10
> IPv6 over IPv4 tunneling driver
> NET: Registered protocol family 17
> Freeing unused kernel memory: 168k init
> Populating /dev using udev: /sbin/udevd: '/lib/libc.so.6' library contains unsup
> ported TLS
> /sbin/udevd: '/lib/libc.so.6' library contains unsupported TLS
> /sbin/udevd: can't load library 'libc.so.6'
> FAIL
> /sbin/udevstart: '/lib/libc.so.6' library contains unsupported TLS
> /sbin/udevstart: '/lib/libc.so.6' library contains unsupported TLS
> /sbin/udevstart: can't load library 'libc.so.6'
> FAIL
> done
> Starting network...
>
> Regards,
>
> Smitha
>
> *Please do not print this email unless it is absolutely necessary. *
>
> The information contained in this electronic message and any attachments to this message are intended for the exclusive use of the addressee(s) and may contain proprietary,
> confidential or privileged information. If you are not the intended recipient, you should not disseminate, distribute or copy this e-mail. Please notify the sender immediately and
> destroy all copies of this message and any attachments.
>
> WARNING: Computer viruses can be transmitted via email. The recipient should check this email and any attachments for the presence of viruses. The company accepts no liability for
> any damage caused by any virus transmitted by this email.
>
> www.wipro.com
>
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
