Return-Path: <mzaturenskiy.st@gmail.com>
Received: from mail-pz0-f202.google.com (mail-pz0-f202.google.com
	[209.85.222.202])
	by bilbo.ozlabs.org (Postfix) with ESMTP id EF14DB70F0
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  3 Jul 2009 02:27:52 +1000 (EST)
Received: by pzk40 with SMTP id 40so1621037pzk.26
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 02 Jul 2009 09:27:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4A4CBC0C.1040001@mlbassoc.com>
References: <97dd5fd20907011104t773c3fc9tca7f0fe56ea22477@mail.gmail.com>
	<1ba63b520907011252w4c1e9abck65cba3791f57260f@mail.gmail.com>
	<97dd5fd20907011314j1974728fs745bbc62e2b1e6ec@mail.gmail.com>
	<1ba63b520907020010u46a3b495h79672fc4f6d84c14@mail.gmail.com>
	<97dd5fd20907020643s52cc65aah8ee315c3592d5e1@mail.gmail.com>
	<4A4CBC0C.1040001@mlbassoc.com>
From: Mikhail Zaturenskiy <mzaturenskiy.st@gmail.com>
Date: Thu, 2 Jul 2009 11:27:31 -0500
Message-ID: <97dd5fd20907020927v2680a7f8m2657193394bd6323@mail.gmail.com>
Subject: Re: RAMDISK on EP88xc
To: Gary Thomas <gary@mlbassoc.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: =?ISO-8859-1?Q?Frank_Svendsb=F8e?= <frank.svendsboe@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>> I haven't tried CONFIG_BLK_DEV or CONFIG_BLK_DEV_LOOP and am still
>> playing around with the values for CONFIG_BLK_DEV_RAM_COUNT and
>> CONFIG_BLK_DEV_RAM_SIZE. Strangely, the DEV_RAM defines are completely
>> missing from my config so I have to put them in manually... (as
>> opposed to via menuconfig). I'll post back when it's working or when
>> I've tried all of this and still am getting some error.
>
> If you don't have CONFIG_BLK_DEV defined, you can't have CONFIG_BLK_DEV_R=
AM_COUNT
> or CONFIG_BLK_DEV_RAM_SIZE. =A0Use 'menuconfig' to help straighten this o=
ut.
>
>> Meanwhile a side question - why does BLK_DEV_RAM_COUNT default to 16?
>
> This is just the number of unique RAM disk devices supported.

I see, thanks Gary, I'll leave that unmodified then. I only really
need 1 but it doesn't seem to negatively affect anything if I leave it
at 16.

Just as an intermediate update on the issue, I've made progress and it
hangs later down the line, see below:
***************************************************************************=
*********
Using Embedded Planet EP88xC machine description
Linux version 2.6.30-rc2-01402-gd4e2f68-dirty (devone@localhost.localdomain=
) (gc
c version 4.2.2) #3 Thu Jul 2 11:00:54 CDT 2009
Found initrd at 0xc3dbb000:0xc3f6d056
Zone PFN ranges:
  DMA      0x00000000 -> 0x00004000
  Normal   0x00004000 -> 0x00004000
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0: 0x00000000 -> 0x00004000
MMU: Allocated 72 bytes of context maps for 16 contexts
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 16256
Kernel command line: console=3DttyCPM0,9600n8 root=3D/dev/ram loglevel=3D7 =
init=3D/sbin/
init
NR_IRQS:512
PID hash table entries: 256 (order: 8, 1024 bytes)
Decrementer Frequency =3D 0x5f5e10
clocksource: timebase mult[28000000] shift[22] registered
console [ttyCPM0] enabled
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 60716k/65536k available (2136k kernel code, 4752k reserved, 100k da=
ta, 9
9k bss, 112k init)
SLUB: Genslabs=3D12, HWalign=3D16, Order=3D0-3, MinObjects=3D0, CPUs=3D1, N=
odes=3D1
Calibrating delay loop... 12.39 BogoMIPS (lpj=3D61952)
Mount-cache hash table entries: 512
net_namespace: 296 bytes
NET: Registered protocol family 16
bio: create slab <bio-0> at 0
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 2048 (order: 2, 16384 bytes)
TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
TCP: Hash tables configured (established 2048 bind 2048)
TCP reno registered
NET: Registered protocol family 1
checking if image is initramfs...
rootfs image is not initramfs (no cpio magic); looks like an initrd
Freeing initrd memory: 1736k freed
msgmni has been set to 122
io scheduler noop registered
io scheduler deadline registered (default)
Generic RTC Driver v1.07
f0000a80.serial: ttyCPM0 at MMIO 0xc500ea80 (irq =3D 19) is a CPM UART
f0000a20.serial: ttyCPM1 at MMIO 0xc5016a20 (irq =3D 29) is a CPM UART
brd: module loaded
loop: module loaded
eth0: fs_enet: 00:00:00:00:00:00
eth1: fs_enet: 00:00:00:00:00:00
FEC MII Bus: probed
fe000000.flash: Found 2 x16 devices at 0x0 in 32-bit bank
 Amd/Fujitsu Extended Query Table at 0x0040
fe000000.flash: CFI does not contain boot bank location. Assuming top.
number of CFI chips: 1
cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
TCP cubic registered
NET: Registered protocol family 17
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RAMDISK: gzip image found at block 0
VFS: Mounted root (ext2 filesystem) readonly on device 1:0.
Freeing unused kernel memory: 112k init
***************************************************************************=
*********

Now searching for cause, looks like it's "init" related...
