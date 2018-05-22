Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40qjV90xkFzDqL3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 May 2018 14:34:40 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4M4Y8qP116464
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 May 2018 00:34:37 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2j48vv6hcp-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 May 2018 00:34:37 -0400
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Mon, 21 May 2018 22:34:36 -0600
Date: Tue, 22 May 2018 10:04:30 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Neuling <mikey@neuling.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>,
 "Oliver O'Halloran" <oohall@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] powerpc: Detect the presence of big-core with
 interleaved threads
Reply-To: ego@linux.vnet.ibm.com
References: <1526037444-22876-1-git-send-email-ego@linux.vnet.ibm.com>
 <1526037444-22876-2-git-send-email-ego@linux.vnet.ibm.com>
 <87h8n5xfot.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87h8n5xfot.fsf@concordia.ellerman.id.au>
Message-Id: <20180522043430.GB5213@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Michael,

On Fri, May 18, 2018 at 11:21:22PM +1000, Michael Ellerman wrote:
> "Gautham R. Shenoy" <ego@linux.vnet.ibm.com> writes:
> 
> > diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
> > index 0af5c11..884dff2 100644
> > --- a/arch/powerpc/kernel/setup-common.c
> > +++ b/arch/powerpc/kernel/setup-common.c
> > @@ -436,8 +438,56 @@ static void __init cpu_init_thread_core_maps(int tpc)
> >  	printk(KERN_DEBUG " (thread shift is %d)\n", threads_shift);
> >  }
> >  
> > -
> >  u32 *cpu_to_phys_id = NULL;
> > +/*
> > + * check_for_interleaved_big_core - Checks if the core represented by
> > + *	 dn is a big-core whose threads are interleavings of the
> > + *	 threads of the component small cores.
> > + *
> > + * @dn: device node corresponding to the core.
> > + *
> > + * Returns true if the core is a interleaved big-core.
> > + * Returns false otherwise.
> > + */
> > +static inline bool check_for_interleaved_big_core(struct device_node *dn)
> > +{
> > +	int len, nr_groups, threads_per_group;
> > +	const __be32 *thread_groups;
> > +	__be32 *thread_list, *first_cpu_idx;
> > +	int cur_cpu, next_cpu, i, j;
> > +
> > +	thread_groups = of_get_property(dn, "ibm,thread-groups", &len);
> > +	if (!thread_groups)
> > +		return false;
> 
> There are better device tree APIs than bare of_get_property() these
> days, can you try to use those?

Ok, I will use them.

> 
> > +	nr_groups = be32_to_cpu(*(thread_groups + 1));
> > +	if (nr_groups <= 1)
> > +		return false;
> 
> eg. this would be of_property_read_u32_index()
> 

Ok.

> > @@ -565,7 +615,16 @@ void __init smp_setup_cpu_maps(void)
> >  	vdso_data->processorCount = num_present_cpus();
> >  #endif /* CONFIG_PPC64 */
> >  
> > -        /* Initialize CPU <=> thread mapping/
> > +	dn = of_find_node_by_type(NULL, "cpu");
> > +	if (dn) {
> > +		if (check_for_interleaved_big_core(dn)) {
> > +			has_interleaved_big_core = true;
> > +			pr_info("Detected interleaved big-cores\n");
> > +		}
> > +		of_node_put(dn);
> > +	}
> 
> This is a bit untidy, given how unlikely it is that you would have no
> CPUs :)

This can actually go into the earlier loop where we initialize the
smp_processor_ids(). I have fixed it in the next iteration.

> 
> You should be able to do the lookup of the property and the setting of
> has_interleaved_big_core all inside
> check_for_interleaved_big_core().

Yes, that's what I am doing in the next iteration.

> 
> cheers
> 
