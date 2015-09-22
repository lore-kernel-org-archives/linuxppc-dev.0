Return-Path: <raghavendra.kt@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 760AF1A001E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2015 20:47:43 +1000 (AEST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <raghavendra.kt@linux.vnet.ibm.com>;
 Tue, 22 Sep 2015 20:47:41 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id EEEFF2BB0054
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2015 20:47:37 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8MAlPlo33358012
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2015 20:47:34 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8MAl3o3027134
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2015 20:47:04 +1000
Message-ID: <560131F2.8000901@linux.vnet.ibm.com>
Date: Tue, 22 Sep 2015 16:18:18 +0530
From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>
CC: benh@kernel.crashing.org, paulus@samba.org, anton@samba.org,
 akpm@linux-foundation.org, nacc@linux.vnet.ibm.com,
 gkurz@linux.vnet.ibm.com, grant.likely@linaro.org,
 nikunj@linux.vnet.ibm.com, vdavydov@parallels.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH V2  2/2] powerpc:numa Do not allocate bootmem memory for
 non existing nodes
References: <1442282917-16893-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
 <1442282917-16893-3-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
 <1442899743.18408.5.camel@ellerman.id.au>
In-Reply-To: <1442899743.18408.5.camel@ellerman.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/22/2015 10:59 AM, Michael Ellerman wrote:
> On Tue, 2015-09-15 at 07:38 +0530, Raghavendra K T wrote:
>>
>> ... nothing
>
> Sure this patch looks obvious, but please give me a changelog that proves
> you've thought about it thoroughly.
>
> For example is it OK to use for_each_node() at this point in boot? Is there any
> historical reason why we did it with a hard coded loop? If so what has changed.
> What systems have you tested on? etc. etc.
>
> cheers

Changelog:

With the setup_nr_nodes(), we have already initialized
node_possible_map. So it is safe to use for_each_node here.

There are many places in the kernel that use hardcoded 'for' loop with
nr_node_ids, because all other architectures have numa nodes populated
serially. That should be reason we had maintained same for powerpc.

But since on power we have sparse numa node ids possible, we
unnecessarily allocate memory for non existent numa nodes.

For e.g., on a system with 0,1,16,17 as numa nodes nr_node_ids=18
and we allocate memory for nodes 2-14.

The patch is boot tested on a 4 node tuleta [ confirming with printks ].
that it works as expected.

>
>> Signed-off-by: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
>> ---
>>   arch/powerpc/mm/numa.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
>> index 8b9502a..8d8a541 100644
>> --- a/arch/powerpc/mm/numa.c
>> +++ b/arch/powerpc/mm/numa.c
>> @@ -80,7 +80,7 @@ static void __init setup_node_to_cpumask_map(void)
>>   		setup_nr_node_ids();
>>
>>   	/* allocate the map */
>> -	for (node = 0; node < nr_node_ids; node++)
>> +	for_each_node(node)
>>   		alloc_bootmem_cpumask_var(&node_to_cpumask_map[node]);
>>
>>   	/* cpumask_of_node() will now work */
>
>
>
>
>
