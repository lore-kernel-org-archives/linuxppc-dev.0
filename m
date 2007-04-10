Return-Path: <bwarren@qstreams.com>
Received: from smtp101.biz.mail.re2.yahoo.com (smtp101.biz.mail.re2.yahoo.com
	[68.142.229.215]) by ozlabs.org (Postfix) with SMTP id 2126BDDF18
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 Apr 2007 00:48:04 +1000 (EST)
Subject: RE: MPC 8349e-mITX and MTD/Flash
From: Ben Warren <bwarren@qstreams.com>
To: "Benedict, Michael" <MBenedict@twacs.com>
In-Reply-To: <CF7E46FCFF66AD478BB72724345289EC2795D2@twx-exch01.twacs.local>
References: <CF7E46FCFF66AD478BB72724345289EC2795D1@twx-exch01.twacs.local>
	<572211.38645.qm@web306.biz.mail.mud.yahoo.com>
	<CF7E46FCFF66AD478BB72724345289EC2795D2@twx-exch01.twacs.local>
Content-Type: text/plain
Date: Tue, 10 Apr 2007 10:41:23 -0400
Message-Id: <1176216083.14027.20.camel@saruman.qstreams.net>
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

On Tue, 2007-04-10 at 09:06 -0500, Benedict, Michael wrote:
> Ben,
> 	I assume that you intended to CC the list but accidently hit
> "reply" instead.  If not, I apologize.  Thank you for all your help so
> far.
> 
You guessed right.  Sorry about that.  Thanks for bringing it back in!
> >-----Original Message-----
> >From: Ben Warren [mailto:bwarren@qstreams.com] 
> >Sent: Monday, April 09, 2007 4:30 PM
> >To: Benedict, Michael
> >Subject: Re: MPC 8349e-mITX and MTD/Flash
> >
> >I suspect that MTD doesn't know anything about how
> >your flash chip is organized.  Probably the easiest
> >thing to use is CONFIG_MTD_PHYSMAP.  Using this, you
> >can either pass the MTD partitioning info via kernel
> >command line, via static physmap structures in your
> >board code or, I believe, via device tree (I haven't
> >tried the last one).
> 
> The following is from my .config
> <snip>
> #
> # Mapping drivers for chip access
> #
> # CONFIG_MTD_COMPLEX_MAPPINGS is not set
> CONFIG_MTD_PHYSMAP=y
> CONFIG_MTD_PHYSMAP_START=0x8000000
> CONFIG_MTD_PHYSMAP_LEN=0x0
> CONFIG_MTD_PHYSMAP_BANKWIDTH=2
> # CONFIG_MTD_PHYSMAP_OF is not set
> CONFIG_MTD_PLATRAM=y
> <snip>
> 
> Is this what you are referring to?  Does something look obviously wrong
> with it?  I have taken that configuration from Freescale's reference
> .config that came with the platform.  I am using the latest kernel.org
> flat device tree for my platform, but the flash is not configured there.
> 
This is mostly right, but it only defines the physical mapping of the
NOR device, not how it is partitioned.  The PHYSMAP_LEN shouldn't be
zero, though.  In my case, I have:

CONFIG_MTD_PHYSMAP=y
CONFIG_MTD_PHYSMAP_START=0xfe000000
CONFIG_MTD_PHYSMAP_LEN=0x800000
CONFIG_MTD_PHYSMAP_BANKWIDTH=2

This indicates that the flash chip is mapped to address 0xfe000000, is
0x800000 bytes (8MB) and is two bytes wide (16 bits).

> After reading a little more, I suppose I am not expecting any
> partitions, but I would still think I should be able to `mtd_debug info`
> the block and char devices.  When I try, I get "No such device or
> address" errors.  Also, I would still expect something in my /proc/mtd,
> correct?  Any ideas are greatly appreciated.

I don't know for sure, but setting the LEN field properly might make it
show up in /proc/mtd.  

Here's some simple code you might find useful as a starting point for
statically defining the partitions in your board code.  It will allow
you to access /dev/mtdx and /dev/mtdblockx.  I don't know if this is the
'right' way, but it works:

#ifdef CONFIG_MTD_PHYSMAP

static int __init board_setup_mtd(void)
{
	int	ptbl_entries;
	static struct mtd_partition	*ptbl;

	ptbl_entries = 2;

	if ((ptbl = kcalloc(ptbl_entries, sizeof(struct mtd_partition),
			GFP_KERNEL)) == NULL) {
		printk(KERN_WARNING "Can't alloc MTD partition table\n");
		return -ENOMEM;
	}

	ptbl[0].name = "part-1";
	ptbl[0].size = 0x40000;		/* 256 k */
	ptbl[1].name = "part-2";
	ptbl[1].offset = 0x40000;
	ptbl[1].size = 0x7c0000; 	/* rest of 8MB */

	physmap_set_partitions(ptbl, ptbl_entries);
	return 0;
}
arch_initcall(board_setup_mtd);
#endif
