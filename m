Return-Path: <anju@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w619N1hHbzDqG4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Apr 2017 18:08:23 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3H84Sij019466
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Apr 2017 04:08:21 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29ufgx965e-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Apr 2017 04:08:20 -0400
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anju@linux.vnet.ibm.com>;
 Mon, 17 Apr 2017 02:08:20 -0600
Subject: Re: [PATCH v6 03/11] powerpc/powernv: Detect supported IMC units and
 its events
To: Michael Ellerman <mpe@ellerman.id.au>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
References: <1491231308-15282-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1491231308-15282-4-git-send-email-maddy@linux.vnet.ibm.com>
 <87r316hqy9.fsf@linux.vnet.ibm.com>
 <50380e09-9f5e-d2d4-ce91-26c616b2ce5e@linux.vnet.ibm.com>
 <87o9w08rdx.fsf@concordia.ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 ego@linux.vnet.ibm.com, bsingharora@gmail.com,
 benh@kernel.crashing.org, paulus@samba.org, anton@samba.org,
 sukadev@linux.vnet.ibm.com, mikey@neuling.org, dja@axtens.net,
 eranian@google.com, Hemant Kumar <hemant@linux.vnet.ibm.com>
From: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Date: Mon, 17 Apr 2017 13:38:10 +0530
MIME-Version: 1.0
In-Reply-To: <87o9w08rdx.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <8aacfd08-8007-172a-3e00-77a3c5bfdb08@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,


On Thursday 13 April 2017 05:13 PM, Michael Ellerman wrote:
> Anju T Sudhakar <anju@linux.vnet.ibm.com> writes:
>> On Thursday 06 April 2017 02:07 PM, Stewart Smith wrote:
>>> Madhavan Srinivasan <maddy@linux.vnet.ibm.com> writes:
>>>> --- a/arch/powerpc/platforms/powernv/opal-imc.c
>>>> +++ b/arch/powerpc/platforms/powernv/opal-imc.c
>>>> @@ -33,6 +33,388 @@
>>> <snip>
>>>> +static void imc_pmu_setup(struct device_node *parent)
>>>> +{
>>>> +	struct device_node *child;
>>>> +	int pmu_count = 0, rc = 0;
>>>> +	const struct property *pp;
>>>> +
>>>> +	if (!parent)
>>>> +		return;
>>>> +
>>>> +	/* Setup all the IMC pmus */
>>>> +	for_each_child_of_node(parent, child) {
>>>> +		pp = of_get_property(child, "compatible", NULL);
>>>> +		if (pp) {
>>>> +			/*
>>>> +			 * If there is a node with a "compatible" field,
>>>> +			 * that's a PMU node
>>>> +			 */
>>>> +			rc = imc_pmu_create(child, pmu_count);
>>>> +			if (rc)
>>>> +				return;
>>>> +			pmu_count++;
>>>> +		}
>>>> +	}
>>>> +}
>>> This doesn't strike me as the right kind of structure, the presence of a
>>> compatible property really just says "hey, there's this device and it's
>>> compatible with these ways of accessing it".
>>>
>>> I'm guessing the idea behind having imc-nest-offset/size in a top level
>>> node is because it's common to everything under it and the aim is to not
>>> blow up the device tree to be enormous.
>>>
>>> So why not go after each ibm,imc-counters-nest compatible node under the
>>> top level ibm,opal-in-memory-counters node? (i'm not convinced that
>>> having ibm,ibmc-counters-nest versus ibm,imc-counters-core and
>>> ibm,imc-counters-thread as I see in the dts is correct though, as
>>> they're all accessed exactly the same way?)
>> The idea here is, we have one directory which contains common events
>> information for nest(same incase of core and thread), and one directory
>> for each nest(/core/thread) pmu.
>> So while parsing we need to make sure that the node which we are parsing
>> is the pmu node, not the node which contains the common event
>> information. We use the "compatible" property here for that purpose.
>> Because we don't have a compatible property for the node which contains
>> events info.
> That's a really bad hack.
>
> You can use the compatible property to detect the node you're looking
> for, but you need to look at the *value* of the property and check it's
> what you expect. Just checking that it's there is fragile.
>
> cheers
>



ok. I will rework this code.



Thanks,
Anju
