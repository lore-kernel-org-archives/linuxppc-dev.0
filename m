Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xnczl3yJrzDrSS
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Sep 2017 08:03:46 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v86Lxt5b108186
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Sep 2017 18:03:44 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ctr0hnu74-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 Sep 2017 18:03:44 -0400
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Wed, 6 Sep 2017 18:03:43 -0400
Subject: Re: [PATCH V13 4/4] powerpc/vphn: Fix numa update end-loop bug
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 John Allen <jallen@linux.vnet.ibm.com>
References: <b967cb9b-efc4-3ff3-27c8-876a81250133@linux.vnet.ibm.com>
 <0babc60c-8e66-e2f2-c316-c569a2ee1dfb@linux.vnet.ibm.com>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Date: Wed, 6 Sep 2017 17:03:40 -0500
MIME-Version: 1.0
In-Reply-To: <0babc60c-8e66-e2f2-c316-c569a2ee1dfb@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <53b65d0a-65e5-2a45-dcba-bbc8e132f5bb@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 09/06/2017 09:45 AM, Nathan Fontenot wrote:
> On 09/01/2017 10:48 AM, Michael Bringmann wrote:
>> powerpc/vphn: On Power systems with shared configurations of CPUs
>> and memory, there are some issues with the association of additional
>> CPUs and memory to nodes when hot-adding resources.  This patch
>> fixes an end-of-updates processing problem observed occasionally
>> in numa_update_cpu_topology().
>>
>> Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/mm/numa.c |    7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
>> index 3a5b334..fccf23f 100644
>> --- a/arch/powerpc/mm/numa.c
>> +++ b/arch/powerpc/mm/numa.c
>> @@ -1410,6 +1410,13 @@ int numa_update_cpu_topology(bool cpus_locked)
>>  		cpu = cpu_last_thread_sibling(cpu);
>>  	}
>>
>> +	/*
>> +	 * Prevent processing of 'updates' from overflowing array
>> +	 * in cases where last entry filled in a 'next' pointer.
>> +	 */
>> +	if (i)
>> +		updates[i-1].next = NULL;
>> +
> 
> This really looks like the bug is in the code above this where we
> fill in the updates array for each of the sibling cpus. The code
> there assumes that if the current update entry is not the end that
> there will be more updates and blindly sets the next pointer.
> 
> Perhaps correcting the logic in that code to next pointers. Set the
> ud pointer to NULL before the outer for_each_cpu() loop. Then in the
> inner for_each_cpu(sibling,...) loop update the ud-> next pointer as
> the first operation.
> 
> 		for_each_cpu(sibling, cpu_sibling_mask(cpu)) {
> 			if (ud)
> 				ud->next = &updates[i];
> 			...
> 		}
> 
> Obviously untested, but I think this would prevent setting the next
> pointer in the last update entry that is filled out erroneously.

The above fragment looks to skip initialization of the 'next' pointer
in the first element of the the 'updates'.  That would abort subsequent
evaluation of the array too soon, I believe.  I would like to take another look
to see whether the current check 'if (i < weight) ud->next = &updates[i];'
is having problems due to i being 0-relative and weight being 1-relative.

>   
> -Nathan

Michael

> 
>>  	pr_debug("Topology update for the following CPUs:\n");
>>  	if (cpumask_weight(&updated_cpus)) {
>>  		for (ud = &updates[0]; ud; ud = ud->next) {
>>
> 

-- 
Michael W. Bringmann
Linux Technology Center
IBM Corporation
Tie-Line  363-5196
External: (512) 286-5196
Cell:       (512) 466-0650
mwb@linux.vnet.ibm.com
