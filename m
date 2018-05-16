Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40m1nn6kFTzF1sg
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 May 2018 14:35:25 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4G4XvBe129004
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 May 2018 00:35:23 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2j07a05qpn-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 May 2018 00:35:22 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Tue, 15 May 2018 22:35:22 -0600
Date: Wed, 16 May 2018 10:05:16 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Michael Neuling <mikey@neuling.org>
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
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
 <1526268071.30369.20.camel@neuling.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1526268071.30369.20.camel@neuling.org>
Message-Id: <20180516043516.GA14826@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Mikey,
On Mon, May 14, 2018 at 01:21:11PM +1000, Michael Neuling wrote:
> Thanks for posting this... A couple of comments below.

Thanks for the review. Replies below.

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
> Can you document what this property looks like? Seems to be nr_groups,
> threads_per_group, thread_list. Can you explain what each of these
> > mean?

Sure. I will document this in the next version of the patch.

ibm,thread-groups[0..N-1] array defines which group of threads in the
CPU-device node can be grouped together based on the property.

ibm,thread-groups[0] tells us the property based on which the threads
are being grouped together. If this value is 1, it implies that
the threads in the same group share L1, translation cache.

ibm,thread-groups[1] tells us how many such thread groups exist.
ibm,thread-groups[2] tells us the number of threads in each such group.
ibm,thread-groups[3..N-1] is the list of threads identified by
"ibm,ppc-interrupt-server#s" arranged as per their membership in the
grouping.

Example: If ibm,thread-groups[ ] = {1,2,4,5,6,7,8,9,10,11,12}
it implies that there are 2 groups of 4 threads each, where each group
of threads share L1, translation cache.

The "ibm,ppc-interrupt-server#s" of the first group is  {5,6,7,8} and
the "ibm,ppc-interrupt-server#s" of the second group is {9, 10, 11, 12}

> 
> If we get configured with an SMT2 big-core (ie. two interleaved SMT1 normal
> cores), will this code also work there?

No, this code won't work there. I hadn't considered the case where
each group consists of only one thread. Thanks for pointing this out.

> 
> > +
> > +	nr_groups = be32_to_cpu(*(thread_groups + 1));
> > +	if (nr_groups <= 1)
> > +		return false;
> > +
> > +	threads_per_group = be32_to_cpu(*(thread_groups + 2));
> > +	thread_list = (__be32 *)thread_groups + 3;
> > +
> > +	/*
> > +	 * In case of an interleaved big-core, the thread-ids of the
> > +	 * big-core can be obtained by interleaving the the thread-ids
> > +	 * of the component small
> > +	 *
> > +	 * Eg: On a 8-thread big-core with two SMT4 small cores, the
> > +	 * threads of the two component small cores will be
> > +	 * {0, 2, 4, 6} and {1, 3, 5, 7}.
> > +	 */
> > +	for (i = 0; i < nr_groups; i++) {
> > +		first_cpu_idx = thread_list + i * threads_per_group;
> > +
> > +		for (j = 0; j < threads_per_group - 1; j++) {
> > +			cur_cpu = be32_to_cpu(*(first_cpu_idx + j));
> > +			next_cpu = be32_to_cpu(*(first_cpu_idx + j + 1));
> > +			if (next_cpu != cur_cpu + nr_groups)
> > +				return false;
> > +		}
> > +	}
> > +	return true;
> > +}
> >  
> >  /**
> >   * setup_cpu_maps - initialize the following cpu maps:
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
> 
> Is there a runtime way to check this also?  If the dmesg buffer overflows, we
> lose this.

Where do you suggest we put this ? Should it be a part of
/proc/cpuinfo ?

> 
> Mikey

--
Thanks and Regards
gautham.
