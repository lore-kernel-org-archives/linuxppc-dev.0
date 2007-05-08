Return-Path: <dwg@au1.ibm.com>
Received: from ausmtp06.au.ibm.com (ausmtp06.au.ibm.com [202.81.18.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp06.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C452BDDE0A
	for <linuxppc-dev@ozlabs.org>; Tue,  8 May 2007 11:07:19 +1000 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by ausmtp06.au.ibm.com (8.13.8/8.13.8) with ESMTP id l4818q558012004
	for <linuxppc-dev@ozlabs.org>; Tue, 8 May 2007 11:08:52 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.250.243])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l481Anoj146036
	for <linuxppc-dev@ozlabs.org>; Tue, 8 May 2007 11:10:49 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4817HRD006826
	for <linuxppc-dev@ozlabs.org>; Tue, 8 May 2007 11:07:18 +1000
Date: Tue, 8 May 2007 11:07:16 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH v4 7/7] Holly bootwrapper
Message-ID: <20070508010716.GH7449@localhost.localdomain>
References: <1178572962.2990.197.camel@zod.rchland.ibm.com>
	<1178573530.2990.214.camel@zod.rchland.ibm.com>
	<20070508001604.GC7449@localhost.localdomain>
	<20070508010704.GL23995@crusty.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070508010704.GL23995@crusty.rchland.ibm.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 07, 2007 at 08:07:04PM -0500, Josh Boyer wrote:
> On Tue, May 08, 2007 at 10:16:04AM +1000, David Gibson wrote:
> > On Mon, May 07, 2007 at 04:32:10PM -0500, Josh Boyer wrote:
> > > @@ -129,6 +129,7 @@ image-$(CONFIG_PPC_CELLEB)		+= zImage.ps
> > >  image-$(CONFIG_PPC_CHRP)		+= zImage.chrp
> > >  image-$(CONFIG_PPC_EFIKA)		+= zImage.chrp
> > >  image-$(CONFIG_PPC_PMAC)		+= zImage.pmac
> > > +image-$(CONFIG_PPC_HOLLY)		+= zImage.holly-elf
> > 
> > Since ELF appears to be the standard image type, I'd suggest just
> > calling it zImage.holly.
> 
> Fine by me.  Though PIBS can take either elf or treeboot images.  Was just
> being explicit.
> 
> > 
> > >  image-$(CONFIG_DEFAULT_UIMAGE)		+= uImage
> > >  
> > >  ifneq ($(CONFIG_DEVICE_TREE),"")
> > > @@ -164,6 +165,12 @@ $(obj)/zImage.ps3: vmlinux
> > >  $(obj)/zImage.initrd.ps3: vmlinux
> > >  	@echo "  WARNING zImage.initrd.ps3 not supported (yet)"
> > >  
> > > +$(obj)/zImage.holly-elf: vmlinux $(wrapperbits)
> > > +	$(call if_changed,wrap,holly,$(obj)/dts/holly.dts,,)
> > > +
> > > +$(obj)/zImage.initrd.holly-elf: vmlinux $(wrapperbits) $(obj)/ramdisk.image.gz
> > > +	$(call if_changed,wrap,holly,$(obj)/dts/holly.dts,,$(obj)/ramdisk.image.gz)
> > 
> > Um.. won't this need corresponding changes to the wrapper script.  I
> > don't see them..
> 
> No...  -i to the wrapper script handles an initrd.  And quiet_cmd_wrap
> optionally takes a 5th argument for it.  What other changes are you thinking?

Sorry, my mistake.  I wasn't thinking anything about the initrd.
You're invoking wrapper with "holly" as the platform, but there's
nothing to make it understand that as a platform.  But as you pointed
out on IRC, since this platform doesn't need any post-processing of
the image, the defaults in wrapper are sufficient.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
