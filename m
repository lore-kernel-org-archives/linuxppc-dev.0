Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ylyQV1z4kzDrYx
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Nov 2017 07:02:58 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vARJxJrv037861
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Nov 2017 15:02:55 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2egp8k0v07-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Nov 2017 15:02:55 -0500
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Mon, 27 Nov 2017 13:02:54 -0700
Received: from b03ledav001.gho.boulder.ibm.com
 (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 vARK2qoi65208394
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Nov 2017 13:02:53 -0700
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DD24B6E03D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Nov 2017 13:02:52 -0700 (MST)
Received: from oc2832402873.ibm.com (unknown [9.53.92.243])
 by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP id BBDB96E038
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Nov 2017 13:02:52 -0700 (MST)
Subject: Re: [PATCH V7 1/3] powerpc/nodes: Ensure enough nodes avail for
 operations
To: linuxppc-dev@lists.ozlabs.org
References: <8dc75276-0f5e-4c44-05eb-a194c3303c66@linux.vnet.ibm.com>
 <2a2ded0a-333f-ae8b-cb4a-94a137550fbf@linux.vnet.ibm.com>
 <87lgiy36mn.fsf@concordia.ellerman.id.au>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Date: Mon, 27 Nov 2017 14:02:52 -0600
MIME-Version: 1.0
In-Reply-To: <87lgiy36mn.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Message-Id: <ff65dbb5-5d00-79e5-dc37-70208219395c@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

See below.

On 11/22/2017 05:17 AM, Michael Ellerman wrote:
> Nathan Fontenot <nfont@linux.vnet.ibm.com> writes:
>> On 11/16/2017 11:24 AM, Michael Bringmann wrote:
> ...
>>> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
>>> index eb604b3..334a1ff 100644
>>> --- a/arch/powerpc/mm/numa.c
>>> +++ b/arch/powerpc/mm/numa.c
>>> @@ -892,6 +892,37 @@ static void __init setup_node_data(int nid, u64 start_pfn, u64 end_pfn)
>>>  	NODE_DATA(nid)->node_spanned_pages = spanned_pages;
>>>  }
>>>
>>> +static void __init find_possible_nodes(void)
>>> +{
>>> +	struct device_node *rtas;
>>> +	u32 numnodes, i;
>>> +
>>> +	if (min_common_depth <= 0)
>>> +		return;
>>> +
>>> +	rtas = of_find_node_by_path("/rtas");
>>> +	if (!rtas)
>>> +		return;
>>> +
>>> +	if (of_property_read_u32_index(rtas,
>>> +				"ibm,max-associativity-domains",
>>> +				min_common_depth, &numnodes))
>>> +		goto out;
>>> +
>>> +	pr_info("numa: Nodes = %d (mcd = %d)\n", numnodes,
>>> +		min_common_depth);
>>
>> numa.c already has a pr_fmt define, no need to pre-pend "numa:" to the
>> information message.
> 
> And in fact no need to print that out here at all, it's covered
> elsewhere. So just drop that pr_info() entirely.
> 
> cheers
> 
> 

Okay.  pr_info() removed.

-- 
Michael W. Bringmann
Linux Technology Center
IBM Corporation
Tie-Line  363-5196
External: (512) 286-5196
Cell:       (512) 466-0650
mwb@linux.vnet.ibm.com
