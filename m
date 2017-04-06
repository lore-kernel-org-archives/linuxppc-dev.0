Return-Path: <anju@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vzHZT4tzXzDqHq
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Apr 2017 19:33:21 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v369SbPR011574
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Apr 2017 05:33:12 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29ngh2gw96-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Apr 2017 05:33:11 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anju@linux.vnet.ibm.com>;
 Thu, 6 Apr 2017 03:33:11 -0600
Subject: Re: [PATCH v6 03/11] powerpc/powernv: Detect supported IMC units and
 its events
To: Stewart Smith <stewart@linux.vnet.ibm.com>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, mpe@ellerman.id.au
References: <1491231308-15282-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1491231308-15282-4-git-send-email-maddy@linux.vnet.ibm.com>
 <87r316hqy9.fsf@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 ego@linux.vnet.ibm.com, bsingharora@gmail.com,
 benh@kernel.crashing.org, paulus@samba.org, anton@samba.org,
 sukadev@linux.vnet.ibm.com, mikey@neuling.org, dja@axtens.net,
 eranian@google.com, Hemant Kumar <hemant@linux.vnet.ibm.com>
From: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Date: Thu, 6 Apr 2017 15:03:00 +0530
MIME-Version: 1.0
In-Reply-To: <87r316hqy9.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <50380e09-9f5e-d2d4-ce91-26c616b2ce5e@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Stewart,


Thanks for the review.


On Thursday 06 April 2017 02:07 PM, Stewart Smith wrote:
> Madhavan Srinivasan <maddy@linux.vnet.ibm.com> writes:
>> --- a/arch/powerpc/platforms/powernv/opal-imc.c
>> +++ b/arch/powerpc/platforms/powernv/opal-imc.c
>> @@ -33,6 +33,388 @@
> <snip>
>> +static void imc_pmu_setup(struct device_node *parent)
>> +{
>> +	struct device_node *child;
>> +	int pmu_count = 0, rc = 0;
>> +	const struct property *pp;
>> +
>> +	if (!parent)
>> +		return;
>> +
>> +	/* Setup all the IMC pmus */
>> +	for_each_child_of_node(parent, child) {
>> +		pp = of_get_property(child, "compatible", NULL);
>> +		if (pp) {
>> +			/*
>> +			 * If there is a node with a "compatible" field,
>> +			 * that's a PMU node
>> +			 */
>> +			rc = imc_pmu_create(child, pmu_count);
>> +			if (rc)
>> +				return;
>> +			pmu_count++;
>> +		}
>> +	}
>> +}
> This doesn't strike me as the right kind of structure, the presence of a
> compatible property really just says "hey, there's this device and it's
> compatible with these ways of accessing it".
>
> I'm guessing the idea behind having imc-nest-offset/size in a top level
> node is because it's common to everything under it and the aim is to not
> blow up the device tree to be enormous.
>
> So why not go after each ibm,imc-counters-nest compatible node under the
> top level ibm,opal-in-memory-counters node? (i'm not convinced that
> having ibm,ibmc-counters-nest versus ibm,imc-counters-core and
> ibm,imc-counters-thread as I see in the dts is correct though, as
> they're all accessed exactly the same way?)
>

The idea here is, we have one directory which contains common events 
information for nest(same incase of core and thread), and one directory 
for each nest(/core/thread) pmu.
So while parsing we need to make sure that the node which we are parsing 
is the pmu node, not the node which contains the common event 
information. We use the "compatible" property here for that purpose. 
Because we don't have a compatible property for the node which contains 
events info.




Regards,
Anju
