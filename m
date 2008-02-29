Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-quonix.sasl.smtp.pobox.com
	[208.72.237.25]) by ozlabs.org (Postfix) with ESMTP id A7033DDEC2
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Mar 2008 11:12:03 +1100 (EST)
Date: Thu, 28 Feb 2008 18:39:06 -0600
From: Nathan Lynch <ntl@pobox.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 3/3] ppc64-specific memory notifier support
Message-ID: <20080229003906.GP16241@localdomain>
References: <1204217028.28696.10.camel@dyn9047017100.beaverton.ibm.com>
	<1204217166.28696.15.camel@dyn9047017100.beaverton.ibm.com>
	<1204243875.7729.3.camel@concordia.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1204243875.7729.3.camel@concordia.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Badari Pulavarty <pbadari@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael Ellerman wrote:
> On Thu, 2008-02-28 at 08:46 -0800, Badari Pulavarty wrote:
> > Hotplug memory notifier for ppc64. This gets invoked by writing
> > the device-node that needs to be removed to /proc/ppc64/ofdt.
> > We need to adjust the sections and remove sysfs entries by
> > calling __remove_pages(). Then call arch specific code to
> > get rid of htab mappings for the section of memory.
> > 
> > Signed-off-by: Badari Pulavarty <pbadari@us.ibm.com>
> > ---
> >  arch/powerpc/platforms/pseries/Makefile         |    1 
> >  arch/powerpc/platforms/pseries/hotplug-memory.c |   98 ++++++++++++++++++++++++
> >  2 files changed, 99 insertions(+)
> > 
> > Index: linux-2.6.25-rc2/arch/powerpc/platforms/pseries/hotplug-memory.c
> > ===================================================================
> > --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> > +++ linux-2.6.25-rc2/arch/powerpc/platforms/pseries/hotplug-memory.c	2008-02-28 08:20:14.000000000 -0800
> 
> > +
> > +static struct notifier_block pseries_smp_nb = {
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
> This is going to fire on non-pseries LPAR platforms, like iSeries and
> PS3. Which is not what you want I think.

Well, the notifier will be registered, yes, but it will never be
called because that path is reachable only from a write to
/proc/ppc64/ofdt, which is not created on non-pseries.

Maybe it should be

machine_device_initcall(pseries, pseries_memory_hotplug_init);

(and pseries_cpu_hotplug_init in hotplug-cpu.c should be changed to
machine_arch_initcall)
