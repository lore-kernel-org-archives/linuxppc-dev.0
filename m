Return-Path: <svaidy@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp01.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8C598B70BB
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jul 2010 13:35:23 +1000 (EST)
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by e28smtp01.in.ibm.com (8.14.4/8.13.1) with ESMTP id o6M3ZJNJ004705
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jul 2010 09:05:19 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o6M3ZIbZ2625538
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jul 2010 09:05:19 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o6M3ZIVM000975
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jul 2010 09:05:18 +0530
Date: Thu, 22 Jul 2010 09:05:08 +0530
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH v3 2/2] powerpc: add support for new hcall H_BEST_ENERGY
Message-ID: <20100722033508.GA26718@dirshya.in.ibm.com>
References: <20100623060122.4957.33819.stgit@drishya.in.ibm.com>
	<20100623060415.4957.24478.stgit@drishya.in.ibm.com>
	<25049.1277689471@neuling.org>
	<20100628053252.GA12751@dirshya.in.ibm.com>
	<2127.1277705466@neuling.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <2127.1277705466@neuling.org>
Cc: Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
	linuxppc-dev@ozlabs.org
Reply-To: svaidy@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Michael Neuling <mikey@neuling.org> [2010-06-28 16:11:06]:

[snip]

> > These hints are abstract number given by the hypervisor based on
> > the extended knowledge the hypervisor has regarding the current system
> > topology and resource mappings.
> > 
> > The activate and the deactivate part is for the two distinct
> > operations that we could do for energy savings.  When we have more
> > capacity than required, we could deactivate few core to save energy.
> > The choice of the core to deactivate will be based on
> > /sys/devices/system/cpu/deactivate_hint_list.  The comma separated
> > list of cpus (cores) will be the preferred choice.
> > 
> > Once the system has few deactivated cores, based on workload demand we
> > may have to activate them to meet the demand.  In that case the
> > /sys/devices/system/cpu/activate_hint_list will be used to prefer the
> > core in-order among the deactivated cores.
> > 
> > In simple terms, activate_hint_list will be null until we deactivate
> > few cores.  Then we could look at the corresponding list for
> > activation or deactivation.
> 
> Can you put these details in the code and in the check-in comments.

Hi Mikey,

I have added these in the -v4 post.

> > Regarding your second point, there is a reason for both a list and
> > per-cpu interface.  The list gives us a system wide list of cores in
> > one shot for userspace to base their decision.  This will be the
> > preferred interface for most cases.  On the other hand, per-cpu file
> > /sys/device/system/cpu/cpuN/pseries_(de)activate_hint provide more
> > information since it exports the hint value as such.
> > 
> > The idea is that the list interface will be used to get a suggested
> > list of cores to manage, while the per-cpu value can be used to
> > further get fine grain information on a per-core bases from the
> > hypervisor.  This allows Linux to have access to all information that
> > the hypervisor has offered through this hcall interface.
> 
> OK, I didn't realise that they contained different info.  Just more
> reasons that this interface needs better documentation :-)
> 
> Overall, I'm mostly happy with the interface.  It's pretty light weight.

these too.

> > > Other comments below.
> > > 

[snip]

> > > > diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platfo
> rms/
> > > pseries/Kconfig
> > > > index c667f0f..b3dd108 100644
> > > > --- a/arch/powerpc/platforms/pseries/Kconfig
> > > > +++ b/arch/powerpc/platforms/pseries/Kconfig
> > > > @@ -33,6 +33,16 @@ config PSERIES_MSI
> > > >         depends on PCI_MSI && EEH
> > > >         default y
> > > > 
> > > > +config PSERIES_ENERGY
> > > 
> > > Probably need a less generic name.  PSERIES_ENERGY_MANAGEMENT?
> > > PSERIES_ENERGY_HOTPLUG_HINTS?
> >
> > PSERIES_ENERGY_MANAGEMENT may be good but too long for a config
> > option.
> > 
> > The idea is to collect all energy management functions in this module
> > as and when new features are introduced in the pseries platform.  This
> > hcall interface is the first to be included, but going forward in
> > future I do not propose to have different modules for other energy
> > management related features.
> > 
> > The name is specific enough for IBM pseries platform and energy
> > management functions and enablements.  Having less generic name below
> > this level will make it difficult to add all varieties of energy
> > management functions in future.
> 
> OK, I thought this might be the case but you never said.  Please say
> something like "This adds CONFIG_PSERIES_ENERGY which will be used for
> future power saving code" or some such.

I already had this comment in the patch description.  Did not want add
a comment in the Kconfig file as the CONFIG_ prefix is assumed in each
of the 

> > > > +
> > > > +/* Helper Routines to convert between drc_index to cpu numbers */
> > > > +
> > > > +static u32 cpu_to_drc_index(int cpu)
> > > > +{
> > > > +	struct device_node *dn = NULL;
> > > > +	const int *indexes;
> > > > +	int i;
> > > > +	dn = of_find_node_by_path("/cpus");
> > > > +	if (dn == NULL)
> > > > +		goto err;
> > > 
> > > Humm, I not sure this is really needed.  If you don't have /cpus you are
> > > probably not going to boot.
> > 
> > Good suggestion.  I could add all these checks in module_init.   I was
> > think if any of the functions being called is allocating memory and in
> > case they fail, we need to abort.
> > 
> > I just reviewed and look like of_find_node_by_path() will not sleep or
> > allocate any memory.  So if it succeeds once in module_init(), then it
> > will never fail! 
> > 
> > 
> > > > +	indexes = of_get_property(dn, "ibm,drc-indexes", NULL);
> > > > +	if (indexes == NULL)
> > > > +		goto err;
> > > 
> > > These checks should probably be moved to module init rather than /sfs
> > > read time.  If they fail, don't load the module and print a warning.  
> > > 
> > > These HCALLS and device-tree entire aren't going to be dynamic.
> > 
> > Agreed.  Only cause of runtime failure is OOM.  If none of these
> > allocate memory, moving these checks once at module_init() will be
> > a good optimization.
> 
> Cool, thanks.  

Hey, I did not yet remove the failure checks in this iteration.  I did
not have these checks earlier and Ben has suggested to check at each
call.  I will discuss with him about moving all checks to
module_init() time and then remove these.

--Vaidy
