Return-Path: <bwarren@qstreams.com>
Received: from smtp102.biz.mail.re2.yahoo.com (smtp102.biz.mail.re2.yahoo.com
	[68.142.229.216]) by ozlabs.org (Postfix) with SMTP id D428367B63
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 22 Jul 2006 04:24:24 +1000 (EST)
Subject: Re: problems with mounting JFFS2 using CFI for AM29LV160MT on
	ppc8245 k2.4.x
From: Ben Warren <bwarren@qstreams.com>
To: Arun Kumar <arunkat@gmail.com>
In-Reply-To: <edd12c050607210756h71bab7f8ve323edf3bf6077c6@mail.gmail.com>
References: <edd12c050607210756h71bab7f8ve323edf3bf6077c6@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 21 Jul 2006 12:20:17 -0400
Message-Id: <1153498817.19682.149.camel@saruman.qstreams.net>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
Reply-To: bwarren@qstreams.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Arun,

On Fri, 2006-07-21 at 20:26 +0530, Arun Kumar wrote:
> Hi ,
> Can anyone help me in this naive problem ?
> 
Then a naive answer is most fitting...  Turns out that's my specialty.

> #
> # Memory Technology Devices (MTD)
> #
> CONFIG_MTD=y
> CONFIG_MTD_DEBUG=y
> CONFIG_MTD_DEBUG_VERBOSE=2
> CONFIG_MTD_PARTITIONS=y
> CONFIG_MTD_CONCAT=y 
> CONFIG_MTD_REDBOOT_PARTS=y
> CONFIG_MTD_CMDLINE_PARTS=y
Probably get rid of REDBOOT if you're not using that bootloader
> 
> #
> # User Modules And Translation Layers
> #
> # CONFIG_MTD_CHAR is not set
> # CONFIG_MTD_BLOCK is not set
> # CONFIG_MTD_BLOCK_RO is not set
> # CONFIG_FTL is not set 
> # CONFIG_NFTL is not set
> # CONFIG_INFTL is not set
> 
You need to enable MTD_CHAR to read/write and MTD_BLOCK to mount

> Can any happy soul let me know  :-- 
> 
> 1)How to mount jffs2 on this flash and also to test mtd->read/write
> routines ?
Start with the char drivers (/dev/mtd0 etc.).  You'll need one for each
partition you want to experiment with.
How about creating the nodes manually?

mknod /dev/mtd0 c 90 0
mknod /dev/mtd1 c 90 2 etc. (minor # increments in 2s)

Add a block device for each partition:

mknod /dev/mtdblock0 b 31 0
mknod /dev/mtdblock1 b 31 1 etc.

Once you clean up #3 below, you should be able to read/write the char
devices using commands like 'cat', or write a simple user-space app
using "open, read, write", etc if you'd rather look at the actual binary
data.

You can then experiment with mounting the JFFS2.  I recommend booting to
an NFS file system then mounting the JFFS2 with something like:

mount -t jffs2 /dev/mtdblock5 /mnt/temp    (Use the correct partition)

> 
> 2) Is it ok not to see mtd0.. partions in /dev directory .
Pretty sure you'll need these
> 
> 3 ) Where do I register the mtd partitions to get them noticed
> here ?? 
Looks like your partitions are already being found, but are probably not
set up right.  I don't know if this is a static definition in your board
init code or passed by command line from the bootloader, but it looks
like the values don't line up with your device:

*********
Using physmap partition definition
Creating 3 MTD partitions on "phys_mapped_flash": 
0x00000000-0x00040000 : "foo-ets0"
mtd: Giving out device 0 to foo-ets0
0x00040000-0x001e0000 : "foo-ets1"
mtd: partition "agere-ets1" doesn't end on an erase block -- force
read-only 
mtd: Giving out device 1 to foo-ets1
0x001e0000-0x00200000 : "foo-ets2"
mtd: partition "foo-ets2" doesn't start on an erase block boundary --
force read-only
*********
--------------------------------------------------------------------------
Hopefully this helps you proceed a little bit.

regards,
Ben
