Return-Path: <shawnxjin@gmail.com>
Received: from mail-ew0-f42.google.com (mail-ew0-f42.google.com
	[209.85.215.42]) by ozlabs.org (Postfix) with ESMTP id C92C4B70A6
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Sep 2010 06:22:55 +1000 (EST)
Received: by ewy2 with SMTP id 2so394894ewy.15
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Sep 2010 13:22:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <52CF90264091A14888078A031D780F4306C8C0E5@ism-mail03.corp.ad.wrs.com>
References: <AANLkTinhvh+G1Q8yU0y5bMDVi5Sc=pYqSfAbXCeuHvBH@mail.gmail.com>
	<4C91C77B.8080501@windriver.com>
	<AANLkTikrYdi=V6jM4HS3V4XzMutGdkPA2qHRBgviKHM8@mail.gmail.com>
	<52CF90264091A14888078A031D780F4306C8BD30@ism-mail03.corp.ad.wrs.com>
	<20100921125247.49f8d101@udp111988uds.am.freescale.net>
	<52CF90264091A14888078A031D780F4306C8C0A0@ism-mail03.corp.ad.wrs.com>
	<AANLkTi=kySFBW8Lwt_hoOZMObGc=kFom22GjbwoccQR-@mail.gmail.com>
	<52CF90264091A14888078A031D780F4306C8C0E5@ism-mail03.corp.ad.wrs.com>
Date: Wed, 22 Sep 2010 13:22:51 -0700
Message-ID: <AANLkTi=xoc+4bDTG5MHuRMEPAwfn5vKsDEXJtO22JKiA@mail.gmail.com>
Subject: Re: [U-Boot] cuImage and multi image?
From: Shawn Jin <shawnxjin@gmail.com>
To: "Chen, Tiejun" <Tiejun.Chen@windriver.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Scott Wood <scottwood@freescale.com>, ppcdev <linuxppc-dev@ozlabs.org>,
	uboot <u-boot@lists.denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>> I have a large ramdisk image. The size of the image itself (i.e. the
>> *.gz) is about 4MB. When the ramdisk was being decompressed
>
> Did you try to change link_address on the file, arch/powerpc/boot/wrapper?

No. I don't have to. Right? The link_address is still 0x400000.

> Did you try boot the uImage and the ramdisk separately? For example, you can boot this as the following command:
> # bootm ${kernel_addr} ${ramdisk_addr} ${fdt_addr}

Mine is a cuImage. I'm pretty sure that my ramdisk is valid when it's
a separate image. I used "bootm <kernel_addr> <ramdisk_addr>" to boot.

> Can you paste the whole log from the u-boot prompt?

In the previous run the ramdisk image was corrupted because the single
image was loaded at 0x800000. But the boot message showed that the
initrd image was at 0x0066c000-0x009ae825. So it was over the 8MB
area.

However after the load address was changed to 0x04000000 (64MB), the
ramdisk still seemed corrupted but with different error messages.

=> bootm
## Booting image at 04000000 ...
   Image Name:   Linux-2.6.33.5
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    4424922 Bytes =  4.2 MB
   Load Address: 00400000
   Entry Point:  00400554
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
Memory <- <0x0 0x8000000> (128MB)
ENET0: local-mac-address <- 00:09:9b:01:58:64
CPU clock-frequency <- 0x7270e00 (120MHz)
CPU timebase-frequency <- 0x7270e0 (8MHz)
CPU bus-frequency <- 0x3938700 (60MHz)

zImage starting: loaded at 0x00400000 (sp: 0x07d1cbd0)
Allocating 0x22a1e1 bytes for kernel ...
gunzipping (0x00000000 <- 0x0040c000:0x0066b0ac)...done 0x21c6c8 bytes
Attached initrd image at 0x0066c000-0x009ae825
initrd head: 0x1f8b0808

Linux/PowerPC load: root=/dev/ram
Finalizing device tree... flat tree at 0x9bb300
Using my870 machine description
Linux version 2.6.33.5 (shawn@ubuntu) (gcc version 4.2.2) #4 Tue Sep
21 09:23:51 PDT 2010
Found initrd at 0xc066c000:0xc09ae825
Zone PFN ranges:
  DMA      0x00000000 -> 0x00008000
  Normal   0x00008000 -> 0x00008000
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0: 0x00000000 -> 0x00008000
MMU: Allocated 72 bytes of context maps for 16 contexts
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32512
Kernel command line: root=/dev/ram
PID hash table entries: 512 (order: -1, 2048 bytes)
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 124072k/131072k available (2080k kernel code, 6836k reserved,
84k data, 52k bss, 104k init)
Kernel virtual memory layout:
  * 0xfffdf000..0xfffff000  : fixmap
  * 0xfde00000..0xfe000000  : consistent mem
  * 0xfddfa000..0xfde00000  : early ioremap
  * 0xc9000000..0xfddfa000  : vmalloc & ioremap
SLUB: Genslabs=12, HWalign=16, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
....
<snipped>
....
RAMDISK: gzip image found at block 0
uncompression error
VFS: Mounted root (ext2 filesystem) readonly on device 1:0.
Freeing unused kernel memory: 104k init
EXT2-fs (ram0): error: ext2_check_page: bad entry in directory #336: :
unaligned directory entry - offset=0, inode=74187384, rec_len=2081,
name_len=126
EXT2-fs (ram0): error: remounting filesystem read-only
attempt to access beyond end of device
ram0: rw=0, want=156831968, limit=32768
Buffer I/O error on device ram0, logical block 78415983
attempt to access beyond end of device
ram0: rw=0, want=112233212, limit=32768
Buffer I/O error on device ram0, logical block 56116605
attempt to access beyond end of device
ram0: rw=0, want=6626681482, limit=32768
Buffer I/O error on device ram0, logical block 3313340740
attempt to access beyond end of device
ram0: rw=0, want=184684282, limit=32768
Buffer I/O error on device ram0, logical block 92342140
Kernel panic - not syncing: No init found.  Try passing init= option to kernel.
Call Trace:
[c7821f30] [c0006cd8] show_stack+0x40/0x168 (unreliable)
[c7821f70] [c001cefc] panic+0x8c/0x178
[c7821fc0] [c00026d4] init_post+0xe4/0xf4
[c7821fd0] [c01ee224] kernel_init+0x108/0x130
[c7821ff0] [c000dcc0] kernel_thread+0x4c/0x68
Rebooting in 180 seconds..

Thanks,
-Shawn.
