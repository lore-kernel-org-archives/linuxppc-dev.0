Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 12AAEDDE02
	for <linuxppc-dev@ozlabs.org>; Tue,  8 May 2007 10:58:51 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l480wlQD017974
	for <linuxppc-dev@ozlabs.org>; Mon, 7 May 2007 20:58:47 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l480wlDe179830
	for <linuxppc-dev@ozlabs.org>; Mon, 7 May 2007 18:58:47 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l480wkD8010210
	for <linuxppc-dev@ozlabs.org>; Mon, 7 May 2007 18:58:47 -0600
Date: Mon, 7 May 2007 20:07:04 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: dwg@au1.ibm.com
Subject: Re: [PATCH v4 7/7] Holly bootwrapper
Message-ID: <20070508010704.GL23995@crusty.rchland.ibm.com>
References: <1178572962.2990.197.camel@zod.rchland.ibm.com>
	<1178573530.2990.214.camel@zod.rchland.ibm.com>
	<20070508001604.GC7449@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070508001604.GC7449@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 08, 2007 at 10:16:04AM +1000, David Gibson wrote:
> On Mon, May 07, 2007 at 04:32:10PM -0500, Josh Boyer wrote:
> > @@ -129,6 +129,7 @@ image-$(CONFIG_PPC_CELLEB)		+= zImage.ps
> >  image-$(CONFIG_PPC_CHRP)		+= zImage.chrp
> >  image-$(CONFIG_PPC_EFIKA)		+= zImage.chrp
> >  image-$(CONFIG_PPC_PMAC)		+= zImage.pmac
> > +image-$(CONFIG_PPC_HOLLY)		+= zImage.holly-elf
> 
> Since ELF appears to be the standard image type, I'd suggest just
> calling it zImage.holly.

Fine by me.  Though PIBS can take either elf or treeboot images.  Was just
being explicit.

> 
> >  image-$(CONFIG_DEFAULT_UIMAGE)		+= uImage
> >  
> >  ifneq ($(CONFIG_DEVICE_TREE),"")
> > @@ -164,6 +165,12 @@ $(obj)/zImage.ps3: vmlinux
> >  $(obj)/zImage.initrd.ps3: vmlinux
> >  	@echo "  WARNING zImage.initrd.ps3 not supported (yet)"
> >  
> > +$(obj)/zImage.holly-elf: vmlinux $(wrapperbits)
> > +	$(call if_changed,wrap,holly,$(obj)/dts/holly.dts,,)
> > +
> > +$(obj)/zImage.initrd.holly-elf: vmlinux $(wrapperbits) $(obj)/ramdisk.image.gz
> > +	$(call if_changed,wrap,holly,$(obj)/dts/holly.dts,,$(obj)/ramdisk.image.gz)
> 
> Um.. won't this need corresponding changes to the wrapper script.  I
> don't see them..

No...  -i to the wrapper script handles an initrd.  And quiet_cmd_wrap
optionally takes a 5th argument for it.  What other changes are you thinking?

> > +void platform_init(unsigned long r3, unsigned long r4, unsigned long r5)
> > +{
> > +	u32 heapsize = 0x8000000 - (u32)_end; /* 128M */
> 
> Urg... careful here.  Can you guarantee that 128M are present at this
> point?  I know I do this in Ebony; I need to fix that..

I believe so.  I can make it smaller in a future patch that will add some
other things to the bootwrapper.

josh
