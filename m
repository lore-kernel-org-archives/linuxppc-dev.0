Return-Path: <Alexander.Povolotsky@marconi.com>
Received: from mailgate.pit.comms.marconi.com (mailgate.pit.comms.marconi.com
	[169.144.68.6]) by ozlabs.org (Postfix) with ESMTP id 0B6A72BF07
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Dec 2004 07:39:18 +1100 (EST)
Message-ID: <313680C9A886D511A06000204840E1CF0A64741C@whq-msgusr-02.pit.comms.marconi.com>
From: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>
To: "'Tom Rini'" <trini@kernel.crashing.org>, "'wd@denx.de'" <wd@denx.de>,
	"'Kumar Gala'" <kumar.gala@freescale.com>, dan@embeddededge.com
Date: Mon, 27 Dec 2004 15:38:50 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Cc: linuxppc-embedded@ozlabs.org
Subject: simple bootloader 2.6.10-rc3 8xx
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I have in .config
...
CONFIG_ADVANCED_OPTIONS=y
CONFIG_HIGHMEM_START=0xfe000000
# CONFIG_LOWMEM_SIZE_BOOL is not set
CONFIG_LOWMEM_SIZE=0x30000000
CONFIG_KERNEL_START_BOOL=y
CONFIG_KERNEL_START=0xc0000000
# CONFIG_TASK_SIZE_BOOL is not set
CONFIG_TASK_SIZE=0x80000000
# CONFIG_CONSISTENT_START_BOOL is not set
CONFIG_CONSISTENT_START=0xff100000
# CONFIG_CONSISTENT_SIZE_BOOL is not set
CONFIG_CONSISTENT_SIZE=0x00200000
CONFIG_BOOT_LOAD_BOOL=y
CONFIG_BOOT_LOAD=0x00400000
...

I get (I did not include ramdisk/initrd into the image loaded) :

loaded at:     00180000 00268160
relocated to:  00400000 004E8160
board data at: 004E6124 004E6140
relocated to:  0040509C 004050B8
zimage at:     00405891 004E5926
avail ram:     004E9000 02000000

Is above dispostion looks correct ?

Then load_kernel() (in arch/ppc/boot/simple/misc-embedded.c) fails during
uncompressing kernel whithin: 

gunzip(0, 0x400000, zimage_start, &zimage_size);

Specifically within gunzip() (in arch/ppc/boot/common/misc-common.c) it
fails after successfully passing 
through zlib_inflateInit2() .  I think it fails in in zlib_inflate() .

Any ideas/advise ?
Why second argument while calling gunzip() is set to 0x400000 ?

Thanks,
Alex 
