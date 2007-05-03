Return-Path: <jdl@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3654EDE02D
	for <linuxppc-dev@ozlabs.org>; Fri,  4 May 2007 03:39:01 +1000 (EST)
Subject: Re: [PATCH] Remove CPU_FTR_NEED_COHERENT for 7448.
From: Jon Loeliger <jdl@freescale.com>
To: Adrian Cox <adrian@humboldt.co.uk>
In-Reply-To: <1178212026.5586.17.camel@localhost.localdomain>
References: <1178141683.32136.46.camel@ld0161-tx32>
	<1178187440.20944.12.camel@localhost.localdomain>
	<1178208838.17201.52.camel@ld0161-tx32>
	<1178212026.5586.17.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1178213931.17201.87.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Thu, 03 May 2007 12:38:51 -0500
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-05-03 at 12:07, Adrian Cox wrote:
> On Thu, 2007-05-03 at 11:13 -0500, Jon Loeliger wrote:
> > > The problem is that many 32-bit PowerPC machines needed
> > > CPU_FTR_NEED_COHERENT set for a second reason: compatibility with the
> > > cache in the MPC107. This was handled by CPU_FTR_COMMON in cputable.h
> > > before the L2 prefetch bug was known.  There may be other host bridges
> > > that cache, but nobody will have noticed because all the CPUs had
> > > CPU_FTR_NEED_COHERENT set already.
> 
> > Yes, you are correct and your concern is valid.  However,
> > this case is still being handled by CONFIG_MPC10X_BRIDGE
> > to deal with the MPC106/MPC107/etc north bridges.
> 
> My only concern here is that some other Northbridges may have a similar
> cache issue to the MPC107, but that we haven't noticed because the
> cputable entry has been a crutch for them. If we remove the entry, will
> some other 7448 designs quietly stop working?  I think the Tsi108/109
> are probably safe, but I don't know about other bridges.
> 
> > The CPU doesn't impose this requirement, the north bridge does.
> > It might even better be named something like
> >     CPU_FTR_NORTHBRDIGE_NEEDS_COHERENT.
> 
> Yes - we end up turning on coherency for multiple reasons - SMP, the L2
> prefetch bug, or the cache in the MPC107. I quite like Ben H's idea of
> doing this in machine_probe().

Hmmmm... I see...  Would you prefer something like this instead:

        static int __init mpc86xx_hpcn_probe(void)
        {
        	unsigned long root = of_get_flat_dt_root();
        
        	if (of_flat_dt_is_compatible(root, "mpc86xx")) {
        		/*
        		 * get number_of_cpus() from somewhere
        		 * perhaps the device tree?
        		 */
        		if (number_of_cpus() == 1)
        			cur_cpu_spec->cpu_features &= ~CPU_FTR_NEED_COHERENT;
        
        		return 1;       /* Looks good */
        	}
        
        	return 0;
        }
        
Though, rather than a dynamic test for number_of_cpus() == 1, perhaps
just another #ifndef CONFIG_SMP around that feature removal?

Thanks,
jdl
