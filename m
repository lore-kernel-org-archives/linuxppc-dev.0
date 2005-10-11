Return-Path: <dmytro.bablinyuk@rftechnology.com.au>
Received: from mfep3.connect.com.au (fep3.mfe.bur.connect.com.au [203.63.86.3])
	by ozlabs.org (Postfix) with ESMTP id CF658683D5
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Oct 2005 13:10:29 +1000 (EST)
Message-ID: <434B2D23.2020208@rftechnology.com.au>
Date: Tue, 11 Oct 2005 13:10:27 +1000
From: Dmytro Bablinyuk <dmytro.bablinyuk@rftechnology.com.au>
MIME-Version: 1.0
To: Robin Gilks <robin.gilks@tait.co.nz>
References: <20051010234614.1FE2A353D84@atlas.denx.de><434B03A2.8060608@rfte	chnology.com.au>
	<434B12C5.2050809@tait.co.nz>
In-Reply-To: <434B12C5.2050809@tait.co.nz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: boot-time partitions and bootargs for 2.6.14
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> struct map_info physmap_map = {
>    .name = "fred",
>    .size = WINDOW_SIZE,
>    .buswidth = BUSWIDTH,
>    .phys = WINDOW_ADDR,
> };
> and a command line something like:
> mtdparts=fred:1024k(Linux),4096k(FS),2048k(Unused),512k(U-Boot),512()

Thank you Robin,

Yes, I have 'working' jffs2.img (original from board).
I checked for spaces - it looks ok. It has 'physically_mapped_flash'.
What I think is the problem with no discovering the flash - it should 
call 'add_mtd_partitions' in 'mtdpart.c' after finding the chip but it 
is not calling it and looks like because it's not finding the flash 
(8272ADS, Sharp 28F016SC).

I have:
...
RAMDISK driver initialized: 16 RAM disks of 32768K size 1024 blocksize
loop: loaded (max 8 devices)
$Id: ftl.c,v 1.55 2005/01/17 13:47:21 hvr Exp $
physmap flash device: 800000 at ff800000
eth0: FCC ENET Version 0.3, 00:04:9f:91:22:33
...

And probably I should expect something like this:
...
PPChameleon: Found 1 x16 devices at 0x0 in 16-bit bank
	 Amd/Fujitsu Extended Query Table at 0x0040
	PPChameleon: Swapping erase regions for broken CFI table.
	number of CFI chips: 1
	cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
===>	Creating 3 MTD partitions on "PPChameleon":
===>	0x00000000-0x00180000 : "linux"
===>	0x00180000-0x003c0000 : "user"
===>	0x003c0000-0x00400000 : "u-boot"

I may be missing something, from my understanding it should find the 
chip before mounting root. And it looks like it couldn't find the chip.
Again, I may be wrong and very likely I missed something.

But I will really appreciate if somebody can help me with this.
