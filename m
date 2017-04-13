Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w3f7H0QtJzDq7g
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 21:43:23 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anju T Sudhakar <anju@linux.vnet.ibm.com>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 ego@linux.vnet.ibm.com, bsingharora@gmail.com, benh@kernel.crashing.org,
 paulus@samba.org, anton@samba.org, sukadev@linux.vnet.ibm.com,
 mikey@neuling.org, dja@axtens.net, eranian@google.com,
 Hemant Kumar <hemant@linux.vnet.ibm.com>
Subject: Re: [PATCH v6 03/11] powerpc/powernv: Detect supported IMC units and
 its events
In-Reply-To: <50380e09-9f5e-d2d4-ce91-26c616b2ce5e@linux.vnet.ibm.com>
References: <1491231308-15282-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1491231308-15282-4-git-send-email-maddy@linux.vnet.ibm.com>
 <87r316hqy9.fsf@linux.vnet.ibm.com>
 <50380e09-9f5e-d2d4-ce91-26c616b2ce5e@linux.vnet.ibm.com>
Date: Thu, 13 Apr 2017 21:43:22 +1000
Message-ID: <87o9w08rdx.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anju T Sudhakar <anju@linux.vnet.ibm.com> writes:
> On Thursday 06 April 2017 02:07 PM, Stewart Smith wrote:
>> Madhavan Srinivasan <maddy@linux.vnet.ibm.com> writes:
>>> --- a/arch/powerpc/platforms/powernv/opal-imc.c
>>> +++ b/arch/powerpc/platforms/powernv/opal-imc.c
>>> @@ -33,6 +33,388 @@
>> <snip>
>>> +static void imc_pmu_setup(struct device_node *parent)
>>> +{
>>> +	struct device_node *child;
>>> +	int pmu_count = 0, rc = 0;
>>> +	const struct property *pp;
>>> +
>>> +	if (!parent)
>>> +		return;
>>> +
>>> +	/* Setup all the IMC pmus */
>>> +	for_each_child_of_node(parent, child) {
>>> +		pp = of_get_property(child, "compatible", NULL);
>>> +		if (pp) {
>>> +			/*
>>> +			 * If there is a node with a "compatible" field,
>>> +			 * that's a PMU node
>>> +			 */
>>> +			rc = imc_pmu_create(child, pmu_count);
>>> +			if (rc)
>>> +				return;
>>> +			pmu_count++;
>>> +		}
>>> +	}
>>> +}
>> This doesn't strike me as the right kind of structure, the presence of a
>> compatible property really just says "hey, there's this device and it's
>> compatible with these ways of accessing it".
>>
>> I'm guessing the idea behind having imc-nest-offset/size in a top level
>> node is because it's common to everything under it and the aim is to not
>> blow up the device tree to be enormous.
>>
>> So why not go after each ibm,imc-counters-nest compatible node under the
>> top level ibm,opal-in-memory-counters node? (i'm not convinced that
>> having ibm,ibmc-counters-nest versus ibm,imc-counters-core and
>> ibm,imc-counters-thread as I see in the dts is correct though, as
>> they're all accessed exactly the same way?)
>
> The idea here is, we have one directory which contains common events 
> information for nest(same incase of core and thread), and one directory 
> for each nest(/core/thread) pmu.

> So while parsing we need to make sure that the node which we are parsing 
> is the pmu node, not the node which contains the common event 
> information. We use the "compatible" property here for that purpose. 
> Because we don't have a compatible property for the node which contains 
> events info.

That's a really bad hack.

You can use the compatible property to detect the node you're looking
for, but you need to look at the *value* of the property and check it's
what you expect. Just checking that it's there is fragile.

cheers
