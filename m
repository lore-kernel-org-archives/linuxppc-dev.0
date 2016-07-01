Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rgy3H6ctkzDqhC
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Jul 2016 23:30:51 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u61DTZWx046975
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Jul 2016 09:30:49 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23w62fmcst-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 Jul 2016 09:30:48 -0400
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ravi.bangoria@linux.vnet.ibm.com>;
 Fri, 1 Jul 2016 07:30:47 -0600
Subject: Re: [PATCH v3 3/4] perf annotate: add powerpc support
To: Balbir Singh <bsingharora@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org,
 acme@kernel.org, linuxppc-dev@lists.ozlabs.org
References: <1467267262-4589-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
 <1467267262-4589-4-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
 <1467267714.7296.6.camel@ellerman.id.au>
 <57762D2A.9040103@linux.vnet.ibm.com> <1467377311.12509.3.camel@gmail.com>
Cc: ananth@in.ibm.com, David.Laight@ACULAB.COM,
 naveen.n.rao@linux.vnet.ibm.com, dja@axtens.net,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Date: Fri, 1 Jul 2016 19:00:33 +0530
MIME-Version: 1.0
In-Reply-To: <1467377311.12509.3.camel@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <57767079.50205@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Balbir,

On Friday 01 July 2016 06:18 PM, Balbir Singh wrote:
> On Fri, 2016-07-01 at 14:13 +0530, Ravi Bangoria wrote:
>> Thanks Michael for your suggestion.
>>   
>> On Thursday 30 June 2016 11:51 AM, Michael Ellerman wrote:
>>>   
>>> On Thu, 2016-06-30 at 11:44 +0530, Ravi Bangoria wrote:
>>>>   
>>>> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
>>>> index 36a5825..b87eac7 100644
>>>> --- a/tools/perf/util/annotate.c
>>>> +++ b/tools/perf/util/annotate.c
>>>> @@ -476,6 +481,125 @@ static int ins__cmp(const void *a, const void *b)
>>> ...
>>>>   
>>>> +
>>>> +static struct ins *ins__find_powerpc(const char *name)
>>>> +{
>>>> +	int i;
>>>> +	struct ins *ins;
>>>> +	struct ins_ops *ops;
>>>> +	static struct instructions_powerpc head;
>>>> +	static bool list_initialized;
>>>> +
>>>> +	/*
>>>> +	 * - Interested only if instruction starts with 'b'.
>>>> +	 * - Few start with 'b', but aren't branch instructions.
>>>> +	 * - Let's also ignore instructions involving 'ctr' and
>>>> +	 *   'tar' since target branch addresses for those can't
>>>> +	 *   be determined statically.
>>>> +	 */
>>>> +	if (name[0] != 'b'             ||
>>>> +	    !strncmp(name, "bcd", 3)   ||
>>>> +	    !strncmp(name, "brinc", 5) ||
>>>> +	    !strncmp(name, "bper", 4)  ||
>>>> +	    strstr(name, "ctr")        ||
>>>> +	    strstr(name, "tar"))
>>>> +		return NULL;
>>> It would be good if 'bctr' was at least recognised as a branch, even if we
>>> can't determine the target. They are very common.
>> We can not show arrow for this since we don't know the target location.
>> can you please suggest how you intends perf to display bctr?
>>   
>> bctr can be classified into two variants -- 'bctr' and 'bctrl'.
>>   
>> 'bctr' will be considered as jump instruction but jump__parse() won't
>> be able to find any target location and hence it will set target to
>> UINT64_MAX which transform 'bctr' to 'bctr UINT64_MAX'. This
>> looks misleading.
>>   
>> bctrl will be considered as call instruction but call_parse() won't
>> be able to find any target function and hence it won't show any
>> navigation arrow for this instruction. Which is same as filter it
>> beforehand.
>>
> The target location and function are in the counter. Can't we add
> this to instruction ops? Is it a major change to add it?

Of course we can add it.

What I mean is we can not determine target location statically by parsing
objdump output. For example, consider snippet:

objdump output:

   c000000000143848:       lwarx   r8,0,r10
   c00000000014384c:       addic   r8,r8,1
   c000000000143850:       stwcx.  r8,0,r10
   c000000000143854:       bne-    c000000000143848 <.rcu_idle_exit+0x58>

corresponding perf annotate output:

   58:  lwarx  r8,0,r10
          addic  r8,r8,1
          stwcx. r8,0,r10
          bne-   58

tui will show up arrow before 'bne- 58' instruction, that indicate it as
a jump instruction. When we focus on 'bne- 58' instruction, arrow will
span from that instruction to instruction with 58th offset( lwarx ).
By pressing Enter, it will jump focus to the target.

In case of 'bctr', we can not determine target location statically
and hence we can not provide any navigation options. Same for
'bctrl' as well.

Please correct me if I misunderstood anything.

-Ravi

>   
> Balbir Singh.
>
