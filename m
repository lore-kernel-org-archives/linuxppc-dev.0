Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id EE229DDFDC
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Mar 2007 07:28:41 +1100 (EST)
Date: Thu, 22 Mar 2007 21:28:42 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [RFC PATCH] power-management elements for 603e/fsl
In-Reply-To: <1174510775.3944.64.camel@johannes.berg>
Message-ID: <Pine.LNX.4.60.0703222121450.7207@poirot.grange>
References: <Pine.LNX.4.60.0703182216130.4143@poirot.grange>
	<1174510775.3944.64.camel@johannes.berg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 21 Mar 2007, Johannes Berg wrote:

> On Sun, 2007-03-18 at 22:40 +0100, Guennadi Liakhovetski wrote:
> 
> > +static int ls_pm_valid(suspend_state_t state)
> > +{
> > +	switch (state) {
> > +	case PM_SUSPEND_STANDBY:
> > +	case PM_SUSPEND_MEM:
> > +		return 1;
> 
> Better just implement only one of them. Having two that do exactly the
> same thing is confusing. Since you don't turn off the CPU feel free to
> call it standby, but it doesn't really matter to me, there doesn't seem
> to be a good set of rules to apply as to which name to use.
> 
> I just posted a patchset that exports a pm_valid_only_mem function in
> pm.h, you should use that as the .valid callback if you decided to call
> your sleep state 'mem'.
> 
> > +/*
> > + * Set to PM_DISK_FIRMWARE so we can quickly veto suspend-to-disk.
> > + */
> 
> > +//	.pm_disk_mode	= PM_DISK_FIRMWARE,
> 
> Both the comment and .pm_disk_mode are bogus, I just removed all such
> comments from all other users. It's just wrong, the pm_disk_mode is
> something that most likely ACPI will only ever use (though I could
> probably implement it for PMU as well)
>  
> > +# contains only the suspend handler for time
> > +obj-$(CONFIG_PM)		+= timer.o
> > +
> 
> That seems to have slipped into this patch :)

Thanks for the comments, Johannes. I'll address them all and the rest that 
you gave me on IRC in the next version of this patch. Meanwhile, I'll have 
to wait to some timer suspend / resume code in the mainline to base upon. 
As linkstation uses generic rtc, it would be logical to use the patch from 
David Brownell, which is currently in -mm. So, will have to either wait a 
bit, or base my patch on that.

Thanks
Guennadi
---
Guennadi Liakhovetski
