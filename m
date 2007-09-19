Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp02.au.ibm.com (E23SMTP02.au.ibm.com [202.81.18.163])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp02.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C3411DDDF7
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Sep 2007 10:07:12 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.18.234])
	by e23smtp02.au.ibm.com (8.13.1/8.13.1) with ESMTP id l8K07C7o010708
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Sep 2007 10:07:12 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l8K07B1C4579422
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Sep 2007 10:07:11 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l8K06tRa013366
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Sep 2007 10:06:55 +1000
Date: Thu, 20 Sep 2007 09:49:30 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: Cleanups for physmap_of.c
Message-ID: <20070919234930.GB14404@localhost.localdomain>
References: <20070919041646.GA30212@localhost.localdomain>
	<20070919071433.69daf024@weaponx.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070919071433.69daf024@weaponx.rchland.ibm.com>
Cc: Vitaly Wool <vwool@ru.mvista.com>, Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Sep 19, 2007 at 07:14:33AM -0500, Josh Boyer wrote:
> On Wed, 19 Sep 2007 14:16:46 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
> 
> > This patch includes a whole batch of smallish cleanups for
> > drivers/mtd/physmap_of.c.
> > 
> > 	- A bunch of uneeded #includes are removed
> > 	- We switch to the modern linux/of.h etc. in place of
> > asm/prom.h
> > 	- Use some helper macros to avoid some ugly inline #ifdefs
> > 	- A few lines of unreachable code are removed
> > 	- A number of indentation / line-wrapping fixes
> > 	- More consistent use of kernel idioms such as if (!p) instead
> > of if (p == NULL)
> > 	- Clarify some printk()s and other informative strings.	
> 
> Most of that looks good.  Just a couple issues below.  Mostly it
> doesn't apply cleanly to my tree because you didn't base if off of the
> patch I sent out last week to fix optional partitions.

Ah, oops.  Didn't remember that patch.

> > 	- (the big one) Despite the name, this driver really has
> > nothing to do with drivers/mtd/physmap.c.  The fact that the flash
> > chips must be physically direct mapped is a constrant, but doesn't
> > really say anything about the actual purpose of this driver, which is
> > to instantiate MTD devices based on information from the device tree.
> > Therefore the physmap name is replaced everywhere within the file with
> > "of_flash".  The file itself and the Kconfig option is not renamed for
> > now (so that the diff is actually a diff).  That can come later.
> 
> Later when?  If we're all in agreement, then why don't we just apply
> your patch after you fix it up and I can move the file in my git tree.
> That way we don't forget about it.

Ok by me.  Well, except that it will need Makefile and Kconfig changes
for that, too.  I was going to send another patch with that once this
one was reviewed and merged.

[snip]
> > @@ -56,11 +53,9 @@ static int parse_obsolete_partitions(str
> > 
> >  	nr_parts = plen / sizeof(part[0]);
> > 
> > -	info->parts = kzalloc(nr_parts * sizeof(struct mtd_partition), GFP_KERNEL);
> > -	if (!info->parts) {
> > -		printk(KERN_ERR "Can't allocate the flash partition data!\n");
> > +	info->parts = kzalloc(nr_parts * sizeof(*info->parts), GFP_KERNEL);
> > +	if (!info->parts)
> >  		return -ENOMEM;
> 
> You dropped the printk here.  Any particular reason why?

I thought the the -ENOMEM was specific enough; we don't give
explanatory messages for other ENOMEM conditions in the driver.

> > 
> >  	names = of_get_property(dp, "partition-names", &plen);
> > 
> > @@ -86,8 +81,8 @@ static int parse_obsolete_partitions(str
> >  	return nr_parts;
> >  }
> > 
> > -static int __devinit process_partitions(struct physmap_flash_info *info,
> > -					struct of_device *dev)
> > +static int __devinit parse_partitions(struct of_flash *info,
> > +				      struct of_device *dev)
> >  {
> >  	const char *partname;
> >  	static const char *part_probe_types[]
> > @@ -109,87 +104,68 @@ static int __devinit process_partitions(
> >  	for (pp = dp->child; pp; pp = pp->sibling)
> >  		nr_parts++;
> > 
> > -	if (nr_parts) {
> > -		info->parts = kzalloc(nr_parts * sizeof(struct mtd_partition),
> > -				      GFP_KERNEL);
> > -		if (!info->parts) {
> > -			printk(KERN_ERR "Can't allocate the flash partition data!\n");
> > -			return -ENOMEM;
> > -		}
> > +	if (nr_parts == 0)
> > +		return parse_obsolete_partitions(dev, info, dp);
> 
> You reintroduced the optional partitions bug I fixed with:
> 
> http://git.infradead.org/?p=users/jwboyer/powerpc.git;a=commit;h=7cafc8f8c89d1f49039b7c345ca832fbd2d1e639

Ah yes.  Actually on consideration, your patch seems a roundabout way
of fixing it.  I'm inclined instead to change
parse_obsolete_partitions() to return 0 instead of -ENOENT.

I guess I'll fold that fix in.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
