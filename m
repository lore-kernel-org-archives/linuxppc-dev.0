Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rm2Ff3c7czDqyq
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jul 2016 14:53:58 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u684mpJ1063748
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Jul 2016 00:53:56 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2415xndyhg-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 08 Jul 2016 00:53:55 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ravi.bangoria@linux.vnet.ibm.com>;
 Thu, 7 Jul 2016 22:53:55 -0600
Subject: Re: [PATCH v3 3/4] perf annotate: add powerpc support
To: Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org,
 acme@kernel.org, linuxppc-dev@lists.ozlabs.org
References: <1467267262-4589-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
 <1467267262-4589-4-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
 <1467267714.7296.6.camel@ellerman.id.au>
 <57762D2A.9040103@linux.vnet.ibm.com>
 <87vb0j84fb.fsf@@concordia.ellerman.id.au>
Cc: anton@ozlabs.org, ananth@in.ibm.com, dja@axtens.net,
 naveen.n.rao@linux.vnet.ibm.com, David.Laight@ACULAB.COM,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Date: Fri, 8 Jul 2016 10:23:45 +0530
MIME-Version: 1.0
In-Reply-To: <87vb0j84fb.fsf@@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <577F31D9.4050808@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

On Wednesday 06 July 2016 03:38 PM, Michael Ellerman wrote:
> Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com> writes:
>
>> On Thursday 30 June 2016 11:51 AM, Michael Ellerman wrote:
>>> On Thu, 2016-06-30 at 11:44 +0530, Ravi Bangoria wrote:
>>>> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
>>>> index 36a5825..b87eac7 100644
>>>> --- a/tools/perf/util/annotate.c
>>>> +++ b/tools/perf/util/annotate.c
>>>> @@ -476,6 +481,125 @@ static int ins__cmp(const void *a, const void *b)
>>> ...
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
> Yeah I understand you can't show an arrow.
>
> I guess it could just be an unterminated arrow? But I'm not sure if
> that's easy to do with the way the UI is constructed. eg. something
> like:
>
>      ld      r12,0(r12)
>      mtctr   r12
>      bctrl	------------------>
>      ld      r3,-32704(r2)
>
> But that's just an idea.

I've sent v4 which enables annotate for bctr' instructions.

for 'bctr', it will show down arrow(indicate jump) and 'bctrl' will show
right arrow(indicate call). But no navigation options will be provided.
By pressing Enter key on that, message will be shown that like
"Invalid target"

Please review it.

>> bctr can be classified into two variants -- 'bctr' and 'bctrl'.
>>
>> 'bctr' will be considered as jump instruction but jump__parse() won't
>> be able to find any target location and hence it will set target to
>> UINT64_MAX which transform 'bctr' to 'bctr UINT64_MAX'. This
>> looks misleading.
> Agreed.
>
>> bctrl will be considered as call instruction but call_parse() won't
>> be able to find any target function and hence it won't show any
>> navigation arrow for this instruction. Which is same as filter it
>> beforehand.
> OK.
>
> Maybe what I'm asking for is an enhancement and can be done later.
>
>>> It doesn't look like we have the opcode handy here? Could we get it somehow?
>>> That would make this a *lot* more robust.
>> objdump prints machine code, but I don't know how difficult that would
>> be to parse to get opcode.
> Normal objdump -d output includes the opcode, eg:
>
> c00000000000886c:       2c 2c 00 00     cmpdi   r12,0
>                          ^^^^^^^^^^^
>
> The only thing you need to know is the endian and you can reconstruct
> the raw instruction.
>
> Then you can just decode the opcode, see how we do it in the kernel with
> eg. instr_is_relative_branch().

I'm sorry. I was thinking that you wants to show opcodes with perf
annotate. But you were asking to use opcode instead of parsing
instructions.

This looks like rewrite parsing code. I don't know whether there is any
library already available for this which we can directly use. I'm thinking
about this.

- Ravi

> cheers
>
