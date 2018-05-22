Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40qjQV6BxZzDqL5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 May 2018 14:31:30 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4M4NuJV041122
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 May 2018 00:31:28 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2j46jkjt79-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 May 2018 00:31:28 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Mon, 21 May 2018 22:31:27 -0600
Date: Tue, 22 May 2018 10:01:19 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Gautham R Shenoy <ego@linux.vnet.ibm.com>,
 Michael Neuling <mikey@neuling.org>,
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
 <20180516043516.GA14826@in.ibm.com>
 <87k1s1xg0z.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87k1s1xg0z.fsf@concordia.ellerman.id.au>
Message-Id: <20180522043119.GA5213@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Michael,

On Fri, May 18, 2018 at 11:14:04PM +1000, Michael Ellerman wrote:
> Gautham R Shenoy <ego@linux.vnet.ibm.com> writes:
> ...
> >> > @@ -565,7 +615,16 @@ void __init smp_setup_cpu_maps(void)
> >> >  	vdso_data->processorCount = num_present_cpus();
> >> >  #endif /* CONFIG_PPC64 */
> >> >  
> >> > -        /* Initialize CPU <=> thread mapping/
> >> > +	dn = of_find_node_by_type(NULL, "cpu");
> >> > +	if (dn) {
> >> > +		if (check_for_interleaved_big_core(dn)) {
> >> > +			has_interleaved_big_core = true;
> >> > +			pr_info("Detected interleaved big-cores\n");
> >> 
> >> Is there a runtime way to check this also?  If the dmesg buffer overflows, we
> >> lose this.
> >
> > Where do you suggest we put this ? Should it be a part of
> > /proc/cpuinfo ?
> 
> Hmm, it'd be nice not to pollute it with more junk.
> 
> Can you just look at the pir files in sysfs?

Sure Michael. I will explore this option.

If we add a file called l1cache_thread_group, then the siblings of the
big-core that share the L1-cache can be described as follows.

	# cd  /sys/devices/system/cpu
	# grep . cpu[0-7]/l1cache_thread_group
	cpu0/l1cache_thread_group:0,2,4,6
	cpu1/l1cache_thread_group:1,3,5,7
	cpu2/l1cache_thread_group:0,2,4,6
	cpu3/l1cache_thread_group:1,3,5,7
	cpu4/l1cache_thread_group:0,2,4,6
	cpu5/l1cache_thread_group:1,3,5,7
	cpu6/l1cache_thread_group:0,2,4,6
	cpu7/l1cache_thread_group:1,3,5,7

> 
> eg. on a normal system:
> 
>   # cd /sys/devices/system/cpu
>   # grep . cpu[0-7]/pir
>   cpu0/pir:20
>   cpu1/pir:21
>   cpu2/pir:22
>   cpu3/pir:23
>   cpu4/pir:24
>   cpu5/pir:25
>   cpu6/pir:26
>   cpu7/pir:27


> 
> 
> cheers
> 
