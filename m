Return-Path: <rmachet@slac.stanford.edu>
Received: from nospam3.slac.stanford.edu (nospam3.slac.stanford.edu
	[134.79.18.120])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3F0A8DE438
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Apr 2008 10:31:51 +1000 (EST)
Subject: Re: [PATCH] sysdev,mv64x60: initialization of mv64x60 ethernet,
	serial and I2C
From: Remi Machet <rmachet@slac.stanford.edu>
To: Dale Farnsworth <dale@farnsworth.org>
In-Reply-To: <20080418205815.GA21162@farnsworth.org>
References: <1208475355.5789.30.camel@pcds-ts102.slac.stanford.edu>
	<20080418205815.GA21162@farnsworth.org>
Content-Type: text/plain
Date: Fri, 18 Apr 2008 17:31:45 -0700
Message-Id: <1208565105.5789.35.camel@pcds-ts102.slac.stanford.edu>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Dale,

Thanks for the comments, I will re-submit the patch on Monday without
the of_node_put and split in 2.

Remi

On Fri, 2008-04-18 at 13:58 -0700, Dale Farnsworth wrote:
> On Thu, Apr 17, 2008 at 04:35:55PM -0700, Remi Machet wrote:
> > This patch affects only the mv64x60 driver. It fixes 2 problem:
> 
> Hi Remi,
> 
> Thanks for finding and addressing these issues.
> BTW, since you're fixing 2 problems, you might split this into 2 patches.
> 
> > -If one of the devices of the mv64x60 init fails, the remaining 
> > devices are not initialized => I changed the code to display an
> > error and continue the initialization.
> 
> I agree that this is a good idea.  A small comment on details below.
> 
> > -I2C parameters freq_m and freq_n are assigned default in the code
> > but if those properties are not found in the open firmware description 
> > the init returns an error=> the code now uses the default
> > values if the properties are not found.
> 
> Yes.  Sigh, I can't believe I missed this.
> 
> > diff --git a/arch/powerpc/sysdev/mv64x60_dev.c b/arch/powerpc/sysdev/mv64x60_dev.c
> > index 047b310..ef0fc99 100644
> > --- a/arch/powerpc/sysdev/mv64x60_dev.c
> > +++ b/arch/powerpc/sysdev/mv64x60_dev.c
> > @@ -433,9 +431,15 @@ static int __init mv64x60_device_setup(void)
> >  	int err;
> >  
> >  	id = 0;
> > -	for_each_compatible_node(np, "serial", "marvell,mv64360-mpsc")
> > -		if ((err = mv64x60_mpsc_device_setup(np, id++)))
> > -			goto error;
> > +	for_each_compatible_node(np, "serial", "marvell,mv64360-mpsc") {
> > +		err = mv64x60_mpsc_device_setup(np, id++);
> > +		if (err) {
> > +			printk(KERN_ERR "Failed to initialize MV64x60 " \
> > +					"serial device %s: error %d.\n",
> > +					np->full_name, err);
> > +			of_node_put(np);
> 
> This of_node_put call (and the others you added) are not needed.
> 
> Thanks,
> -Dale
