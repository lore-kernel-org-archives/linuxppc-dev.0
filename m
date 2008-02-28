Return-Path: <pbadari@us.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5CCCFDE4FE
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Feb 2008 05:54:24 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m1SIrk1C002554
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Feb 2008 13:53:46 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m1SIsGhY213992
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Feb 2008 11:54:16 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m1SIsF6E016232
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Feb 2008 11:54:16 -0700
Subject: Re: [PATCH 3/3] ppc64-specific memory notifier support
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Nathan Lynch <ntl@pobox.com>
In-Reply-To: <20080228172034.GL16241@localdomain>
References: <1204217028.28696.10.camel@dyn9047017100.beaverton.ibm.com>
	<1204217166.28696.15.camel@dyn9047017100.beaverton.ibm.com>
	<20080228172034.GL16241@localdomain>
Content-Type: text/plain
Date: Thu, 28 Feb 2008 10:57:30 -0800
Message-Id: <1204225050.28696.19.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-02-28 at 11:20 -0600, Nathan Lynch wrote:
> Badari Pulavarty wrote:
> 
> > +static struct notifier_block pseries_smp_nb = {
> 
> Rename this to pseries_mem_nb?

Sure.

> 
> > +	.notifier_call = pseries_memory_notifier,
> > +};
> > +
> > +static int __init pseries_memory_hotplug_init(void)
> > +{
> > +	if (firmware_has_feature(FW_FEATURE_LPAR))
> > +		pSeries_reconfig_notifier_register(&pseries_smp_nb);
> > +
> > +	return 0;
> > +}
> > +arch_initcall(pseries_memory_hotplug_init);
> 
> arch_initcall doesn't seem appropriate.  __initcall should be fine.
> 

Okay, if you say so :)

I based the code on arch/powerpc/platforms/pseries/hotplug-cpu.c 

Thanks,
Badari
