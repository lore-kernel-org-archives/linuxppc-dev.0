Return-Path: <zhong@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp07.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C5D3C2C009C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Jun 2013 19:42:53 +1000 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zhong@linux.vnet.ibm.com>;
 Thu, 13 Jun 2013 15:06:09 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id A979B125804E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Jun 2013 15:11:36 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5D9ghRU25559138
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Jun 2013 15:12:44 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5D9gdJt012401
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Jun 2013 19:42:41 +1000
Message-ID: <1371116555.3704.15.camel@ThinkPad-T5421>
Subject: Re: [RFC PATCH powerpc] Set cpu sibling mask before online cpu
From: Li Zhong <zhong@linux.vnet.ibm.com>
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Date: Thu, 13 Jun 2013 17:42:35 +0800
In-Reply-To: <51B6E0F4.6040008@linux.vnet.ibm.com>
References: <1368699626.2618.183.camel@ThinkPad-T5421>
 <1370934016.8250.83.camel@pasglop> <51B6E0F4.6040008@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>,
 PowerPC email list <linuxppc-dev@lists.ozlabs.org>,
 Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-06-11 at 14:03 +0530, Srivatsa S. Bhat wrote:
> On 06/11/2013 12:30 PM, Benjamin Herrenschmidt wrote:
> > On Thu, 2013-05-16 at 18:20 +0800, Li Zhong wrote:
> >> It seems following race is possible:
> >>
> > 
> >  .../...
> > 
> >>  	vdso_getcpu_init();
> >>  #endif
> >> -	notify_cpu_starting(cpu);
> >> -	set_cpu_online(cpu, true);
> >>  	/* Update sibling maps */
> >>  	base = cpu_first_thread_sibling(cpu);
> >>  	for (i = 0; i < threads_per_core; i++) {
> >> -		if (cpu_is_offline(base + i))
> >> +		if (cpu_is_offline(base + i) && (cpu != base + i))
> >>  			continue;
> >>  		cpumask_set_cpu(cpu, cpu_sibling_mask(base + i));
> >>  		cpumask_set_cpu(base + i, cpu_sibling_mask(cpu));
> >> @@ -667,6 +665,10 @@ __cpuinit void start_secondary(void *unused)
> >>  	}
> >>  	of_node_put(l2_cache);
> >>  
> >> +	smp_wmb();
> >> +	notify_cpu_starting(cpu);
> >> +	set_cpu_online(cpu, true);
> >> +
> > 
> > So we could have an online CPU with an empty sibling mask. Now we can
> > have a sibling that isn't online ... Is that ok ?
> 
> I think it is OK. We do the same thing on x86 as well - we set up the
> sibling links before calling notify_cpu_starting() and setting the cpu
> in the cpu_online_mask. In fact, there is even a comment explicitly
> noting that order:
> 
> arch/x86/kernel/smpboot.c:
>  220         /*
>  221          * This must be done before setting cpu_online_mask
>  222          * or calling notify_cpu_starting.
>  223          */
>  224         set_cpu_sibling_map(raw_smp_processor_id());
>  225         wmb();
>  226 
>  227         notify_cpu_starting(cpuid);
>  228 
>  229         /*
>  230          * Allow the master to continue.
>  231          */
>  232         cpumask_set_cpu(cpuid, cpu_callin_mask);
> 
> 
> So I agree with Li Zhong's solution.
> 
> [Arch-specific CPU hotplug code consolidation efforts such as [1] would
> have weeded out such nasty bugs.. I guess we should revive that patchset
> sometime soon.]
> 

Thank you both for the review and comments. 

Good to know that it matches that of x86, and there is a patchset
consolidating the code. With the patches in [1], it seems we only need
the line to include the "to be onlined cpu" in this patch. 

Thanks, Zhong 

> Regards,
> Srivatsa S. Bhat
> 
> [1]. https://lwn.net/Articles/500185/
> 
