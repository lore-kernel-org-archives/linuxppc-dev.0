Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rk5s43qfszDqpM
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jul 2016 11:29:28 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u651TQWu013344
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 4 Jul 2016 21:29:26 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23x9s2dqcu-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 Jul 2016 21:29:26 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ravi.bangoria@linux.vnet.ibm.com>;
 Mon, 4 Jul 2016 19:29:25 -0600
Subject: Re: [PATCH v3 3/4] perf annotate: add powerpc support
To: Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org,
 acme@kernel.org, linuxppc-dev@lists.ozlabs.org
References: <1467267262-4589-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
 <1467267262-4589-4-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
 <1467267714.7296.6.camel@ellerman.id.au>
 <57762D2A.9040103@linux.vnet.ibm.com>
Cc: anton@ozlabs.org, ananth@in.ibm.com, dja@axtens.net,
 naveen.n.rao@linux.vnet.ibm.com, David.Laight@ACULAB.COM,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Date: Tue, 5 Jul 2016 06:58:55 +0530
MIME-Version: 1.0
In-Reply-To: <57762D2A.9040103@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <577B0D57.3080702@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

On Friday 01 July 2016 02:13 PM, Ravi Bangoria wrote:
> Thanks Michael for your suggestion.
>
> On Thursday 30 June 2016 11:51 AM, Michael Ellerman wrote:
>> On Thu, 2016-06-30 at 11:44 +0530, Ravi Bangoria wrote:
>>> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
>>> index 36a5825..b87eac7 100644
>>> --- a/tools/perf/util/annotate.c
>>> +++ b/tools/perf/util/annotate.c
>>> @@ -476,6 +481,125 @@ static int ins__cmp(const void *a, const void *b)
>> ...
>>> +
>>> +static struct ins *ins__find_powerpc(const char *name)
>>> +{
>>> +    int i;
>>> +    struct ins *ins;
>>> +    struct ins_ops *ops;
>>> +    static struct instructions_powerpc head;
>>> +    static bool list_initialized;
>>> +
>>> +    /*
>>> +     * - Interested only if instruction starts with 'b'.
>>> +     * - Few start with 'b', but aren't branch instructions.
>>> +     * - Let's also ignore instructions involving 'ctr' and
>>> +     *   'tar' since target branch addresses for those can't
>>> +     *   be determined statically.
>>> +     */
>>> +    if (name[0] != 'b'             ||
>>> +        !strncmp(name, "bcd", 3)   ||
>>> +        !strncmp(name, "brinc", 5) ||
>>> +        !strncmp(name, "bper", 4)  ||
>>> +        strstr(name, "ctr")        ||
>>> +        strstr(name, "tar"))
>>> +        return NULL;
>> It would be good if 'bctr' was at least recognised as a branch, even 
>> if we
>> can't determine the target. They are very common.
>
> We can not show arrow for this since we don't know the target location.
> can you please suggest how you intends perf to display bctr?
>
> bctr can be classified into two variants -- 'bctr' and 'bctrl'.
>
> 'bctr' will be considered as jump instruction but jump__parse() won't
> be able to find any target location and hence it will set target to
> UINT64_MAX which transform 'bctr' to 'bctr UINT64_MAX'. This
> looks misleading.
>
> bctrl will be considered as call instruction but call_parse() won't
> be able to find any target function and hence it won't show any
> navigation arrow for this instruction. Which is same as filter it
> beforehand.
>
>> It doesn't look like we have the opcode handy here? Could we get it 
>> somehow?
>> That would make this a *lot* more robust.
>
> objdump prints machine code, but I don't know how difficult that would
> be to parse to get opcode.

Perf uses  --no-show-raw with objdump and hence objdump output does not
show opcodes. So change in current  objdump output may requires changes
in current parsing logic. Additionally I need to change tui as well to show
opcodes. This looks quite more work.

And this patchset is about enabling annotate for cross arch. So if you 
really
need opcode with perf anotate, can we do it separately?

Please let me know your thoughts.

-Ravi

>
> -Ravi
>
>> cheers
>>
>
