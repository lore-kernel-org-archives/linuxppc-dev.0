Return-Path: <svaidy@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp06.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0011EB7CE4
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Mar 2010 17:50:15 +1100 (EST)
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by e28smtp06.in.ibm.com (8.14.3/8.13.1) with ESMTP id o286oCoX007098
	for <linuxppc-dev@ozlabs.org>; Mon, 8 Mar 2010 12:20:12 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o286oCSd2617568
	for <linuxppc-dev@ozlabs.org>; Mon, 8 Mar 2010 12:20:12 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o286oBtT026676
	for <linuxppc-dev@ozlabs.org>; Mon, 8 Mar 2010 12:20:12 +0530
Date: Mon, 8 Mar 2010 12:20:06 +0530
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
To: Dipankar Sarma <dipankar@in.ibm.com>
Subject: Re: [RFC] powerpc: add support for new hcall H_BEST_ENERGY
Message-ID: <20100308065006.GA6281@dirshya.in.ibm.com>
References: <20100303181822.GH5439@dirshya.in.ibm.com>
	<20100305191810.GA10402@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20100305191810.GA10402@in.ibm.com>
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

* Dipankar Sarma <dipankar@in.ibm.com> [2010-03-06 00:48:11]:

> On Wed, Mar 03, 2010 at 11:48:22PM +0530, Vaidyanathan Srinivasan wrote:
> >  static void __init cpu_init_thread_core_maps(int tpc)
> > diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
> > index c667f0f..b3dd108 100644
> > --- a/arch/powerpc/platforms/pseries/Kconfig
> > +++ b/arch/powerpc/platforms/pseries/Kconfig
> > @@ -33,6 +33,16 @@ config PSERIES_MSI
> >         depends on PCI_MSI && EEH
> >         default y
> > 
> > +config PSERIES_ENERGY
> > +	tristate "pseries energy management capabilities driver"
> > +	depends on PPC_PSERIES
> > +	default y
> > +	help
> > +	  Provides interface to platform energy management capabilities
> > +	  on supported PSERIES platforms.
> > +	  Provides: /sys/devices/system/cpu/pseries_(de)activation_hint_list
> > +	  and /sys/devices/system/cpu/cpuN/pseries_(de)activation_hint
> > +
> >  config SCANLOG
> >  	tristate "Scanlog dump interface"
> >  	depends on RTAS_PROC && PPC_PSERIES
> 
> .....
> 
> > +static int __init pseries_energy_init(void)
> > +{
> > +	int cpu, err;
> > +	struct sys_device *cpu_sys_dev;
> > +
> > +	/* Create the sysfs files */
> > +	err = sysfs_create_file(&cpu_sysdev_class.kset.kobj,
> > +				&attr_cpu_activate_hint_list.attr);
> > +	if (!err)
> > +		err = sysfs_create_file(&cpu_sysdev_class.kset.kobj,
> > +				&attr_cpu_deactivate_hint_list.attr);
> > +
> > +	for_each_possible_cpu(cpu) {
> > +		cpu_sys_dev = get_cpu_sysdev(cpu);
> > +		err = sysfs_create_file(&cpu_sys_dev->kobj,
> > +				&attr_percpu_activate_hint.attr);
> > +		if (err)
> > +			break;
> > +		err = sysfs_create_file(&cpu_sys_dev->kobj,
> > +				&attr_percpu_deactivate_hint.attr);
> > +		if (err)
> > +			break;
> > +	}
> > +	return err;
> > +
> > +}
> 
> Shouldn't we create this only for supported platforms ?

Hi Dipankar,

Yes we will need a check like
firmware_has_feature(FW_FEATURE_BEST_ENERGY) to avoid sysfs files in
unsupported platforms.  I will add that check in the next iteration.

Thanks,
Vaidy
