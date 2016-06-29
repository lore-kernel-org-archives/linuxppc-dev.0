Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rfYC74VzyzDrD1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 16:47:47 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5T6d7MK141771
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 02:47:45 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23utc8pwh0-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 02:47:44 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ravi.bangoria@linux.vnet.ibm.com>;
 Wed, 29 Jun 2016 00:47:43 -0600
Subject: Re: [PATCH 3/4] perf annotate: add powerpc support
To: David Laight <David.Laight@ACULAB.COM>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "acme@kernel.org" <acme@kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
References: <1467113807-29571-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
 <1467113807-29571-4-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
 <063D6719AE5E284EB5DD2968C1650D6D5F4E67FA@AcuExch.aculab.com>
Cc: "ananth@in.ibm.com" <ananth@in.ibm.com>,
 "naveen.n.rao@linux.vnet.ibm.com" <naveen.n.rao@linux.vnet.ibm.com>,
 "dja@axtens.net" <dja@axtens.net>
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Date: Wed, 29 Jun 2016 12:17:29 +0530
MIME-Version: 1.0
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D5F4E67FA@AcuExch.aculab.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <57736F01.1010308@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thanks David.

On Tuesday 28 June 2016 09:37 PM, David Laight wrote:
> From: Ravi Bangoria
>> Sent: 28 June 2016 12:37
>>
>> Powerpc has long list of branch instructions and hardcoding them in table
>> appears to be error-prone. So, add new function to find instruction
>> instead of creating table.
>>
>> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
>> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
>> ---
>>   tools/perf/util/annotate.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 64 insertions(+)
>>
>> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
>> index 36a5825..96c6610 100644
>> --- a/tools/perf/util/annotate.c
>> +++ b/tools/perf/util/annotate.c
>> @@ -476,6 +476,68 @@ static int ins__cmp(const void *a, const void *b)
>>   	return strcmp(ia->name, ib->name);
>>   }
>>
>> +static struct ins *ins__find_powerpc(const char *name)
> It would be better if the function name include 'branch'.
>
>> +{
>> +	int i;
>> +	struct ins *ins;
>> +
>> +	ins = zalloc(sizeof(struct ins));
>> +	if (!ins)
>> +		return NULL;
>> +
>> +	ins->name = strdup(name);
>> +	if (!ins->name)
>> +		return NULL;
> 	You leak 'ins' here.
>
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
>> +			return NULL;
> 	More importantly you leak 'ins' and 'ins->name' here.
> 	And on other paths below.

Yes. Fair points.

I can create linked list that maintain allocated instructions and
lookup it every time before allocating memory. But for this,
I need to free memory at the end and it's becoming complicated.

I can go back to normal approach of creating table for powerpc.
This is simplest. But only problem is powerpc has around 400 branch
instructions(which includes call and ret as well). And list them all is
bit error-prone.

Suggestions?

- Ravi

> ...
>
> 	David
>
