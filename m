Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yhg0454m9zDqsP
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Nov 2017 22:17:08 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Michael Bringmann <mwb@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: John Allen <jallen@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
Subject: Re: [PATCH V7 1/3] powerpc/nodes: Ensure enough nodes avail for
 operations
In-Reply-To: <2a2ded0a-333f-ae8b-cb4a-94a137550fbf@linux.vnet.ibm.com>
References: <8dc75276-0f5e-4c44-05eb-a194c3303c66@linux.vnet.ibm.com>
 <2a2ded0a-333f-ae8b-cb4a-94a137550fbf@linux.vnet.ibm.com>
Date: Wed, 22 Nov 2017 22:17:04 +1100
Message-ID: <87lgiy36mn.fsf@concordia.ellerman.id.au>
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

Nathan Fontenot <nfont@linux.vnet.ibm.com> writes:
> On 11/16/2017 11:24 AM, Michael Bringmann wrote:
...
>> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
>> index eb604b3..334a1ff 100644
>> --- a/arch/powerpc/mm/numa.c
>> +++ b/arch/powerpc/mm/numa.c
>> @@ -892,6 +892,37 @@ static void __init setup_node_data(int nid, u64 start_pfn, u64 end_pfn)
>>  	NODE_DATA(nid)->node_spanned_pages = spanned_pages;
>>  }
>> 
>> +static void __init find_possible_nodes(void)
>> +{
>> +	struct device_node *rtas;
>> +	u32 numnodes, i;
>> +
>> +	if (min_common_depth <= 0)
>> +		return;
>> +
>> +	rtas = of_find_node_by_path("/rtas");
>> +	if (!rtas)
>> +		return;
>> +
>> +	if (of_property_read_u32_index(rtas,
>> +				"ibm,max-associativity-domains",
>> +				min_common_depth, &numnodes))
>> +		goto out;
>> +
>> +	pr_info("numa: Nodes = %d (mcd = %d)\n", numnodes,
>> +		min_common_depth);
>
> numa.c already has a pr_fmt define, no need to pre-pend "numa:" to the
> information message.

And in fact no need to print that out here at all, it's covered
elsewhere. So just drop that pr_info() entirely.

cheers
