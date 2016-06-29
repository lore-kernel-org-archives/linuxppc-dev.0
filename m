Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rfmZc0F95zDqmN
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 01:20:23 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5TFEVU0055058
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 11:20:21 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23uuhtvtrm-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 11:20:21 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ravi.bangoria@linux.vnet.ibm.com>;
 Wed, 29 Jun 2016 09:20:20 -0600
Subject: Re: [PATCH v2 3/4] perf annotate: add powerpc support
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
References: <1467198958-9195-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
 <1467198958-9195-4-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
 <20160629144521.GC14508@naverao1-tp.localdomain>
Cc: linux-kernel@vger.kernel.org, acme@kernel.org,
 linuxppc-dev@lists.ozlabs.org, anton@ozlabs.org, mpe@ellerman.id.au,
 ananth@in.ibm.com, dja@axtens.net, David.Laight@ACULAB.COM
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Date: Wed, 29 Jun 2016 20:49:49 +0530
MIME-Version: 1.0
In-Reply-To: <20160629144521.GC14508@naverao1-tp.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <5773E715.1000203@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thanks Naveen,

On Wednesday 29 June 2016 08:15 PM, Naveen N. Rao wrote:
> On 2016/06/29 04:45PM, Ravi Bangoria wrote:
>> From: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
>>
>> Powerpc has long list of branch instructions and hardcoding them in
>> table appears to be error-prone. So, add new function to find
>> instruction instead of creating table. This function dynamically
>> create table(list of 'struct ins'), and instead of creating object
>> every time, first check if list already contain object for that
>> nemonics.
>>
>> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
>> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
>> ---
>> Changes in v2:
>>    - Corrected few memory leaks.
>>    - Created Dynamic list for powerpc to optimize memory consumption
>>
>>   tools/perf/util/annotate.c | 121 +++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 121 insertions(+)
>>
>> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
>> index 36a5825..812bfad 100644
>> --- a/tools/perf/util/annotate.c
>> +++ b/tools/perf/util/annotate.c
>> @@ -461,6 +461,11 @@ static struct ins instructions_arm[] = {
>>   	{ .name = "bne",   .ops  = &jump_ops, },
>>   };
>>
>> +struct instructions_powerpc {
>> +	struct ins *ins;
>> +	struct list_head list;
>> +};
>> +
>>   static int ins__key_cmp(const void *name, const void *insp)
>>   {
>>   	const struct ins *ins = insp;
>> @@ -476,6 +481,120 @@ static int ins__cmp(const void *a, const void *b)
>>   	return strcmp(ia->name, ib->name);
>>   }
>>
>> +static int list_add__ins_powerpc(struct instructions_powerpc *head,
>> +				 struct ins *ins)
>> +{
>> +	struct instructions_powerpc *ins_powerpc;
>> +
>> +	ins_powerpc = zalloc(sizeof(struct instructions_powerpc));
>> +	if (!ins_powerpc)
>> +		return -1;
>> +
>> +	ins_powerpc->ins = ins;
>> +	list_add_tail(&(ins_powerpc->list), &(head->list));
>> +
>> +	return 0;
>> +}
>> +
>> +static struct ins *list_search__ins_powerpc(struct instructions_powerpc *head,
>> +					    const char *name)
>> +{
>> +	struct instructions_powerpc *pos;
>> +
>> +	list_for_each_entry(pos, &head->list, list) {
>> +		if (!strcmp(pos->ins->name, name))
>> +			return pos->ins;
>> +	}
>> +	return NULL;
>> +}
>> +
>> +static struct ins *ins__find_powerpc(const char *name)
>> +{
>> +	int i;
>> +	struct ins *ins;
>> +	static struct instructions_powerpc head;
>> +	static bool list_initialized;
>> +
>> +	if (!list_initialized) {
>> +		INIT_LIST_HEAD(&head.list);
>> +		list_initialized = true;
>> +	}
>> +
>> +	/*
>> +	 * Search if we already created object of 'struct ins'
>> +	 * for this instruction
>> +	 */
>> +	ins = list_search__ins_powerpc(&head, name);
>> +	if (ins)
>> +		return ins;
>> +
>> +	ins = zalloc(sizeof(struct ins));
>> +	if (!ins)
>> +		return NULL;
>> +
>> +	ins->name = strdup(name);
>> +	if (!ins->name)
>> +		goto err;
> You can move the above two inside the below if condition, so that you
> only allocate memory if needed.
>
> Or, what would be better would be to pass 'name' and the appropriate ops
> pointer to the helper above (list_add__ins_powerpc) and have that
> allocate 'struct ins' and insert into the list.

Yes I will think about this.

>> +
>> +	if (name[0] == 'b') {
>> +		/* branch instructions */
>> +		ins->ops = &jump_ops;
>> +
>> +		/*
>> +		 * - Few start with 'b', but aren't branch instructions.
>> +		 * - Let's also ignore instructions involving 'ctr' and
>> +		 *   'tar' since target branch addresses for those can't
>> +		 *   be determined statically.
>> +		 */
>> +		if (!strncmp(name, "bcd", 3)   ||
>> +		    !strncmp(name, "brinc", 5) ||
>> +		    !strncmp(name, "bper", 4)  ||
>> +		    strstr(name, "ctr")        ||
>> +		    strstr(name, "tar"))
>> +			goto err;
> You are still leaking ins->name here.

Ah!! Sorry. I missed that we are using strdup here. Will correct it.

-Ravi
