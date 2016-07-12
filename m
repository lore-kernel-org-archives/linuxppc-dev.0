Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rpQhT2RwXzDqwQ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jul 2016 12:22:01 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6C2Dx1Y124621
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jul 2016 22:21:58 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0b-001b2d01.pphosted.com with ESMTP id 243edd8u7r-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jul 2016 22:21:58 -0400
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ravi.bangoria@linux.vnet.ibm.com>;
 Mon, 11 Jul 2016 20:21:57 -0600
Subject: Re: [PATCH v3 3/4] perf annotate: add powerpc support
To: acme@kernel.org
References: <1467267262-4589-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
 <1467267262-4589-4-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
 <1467267714.7296.6.camel@ellerman.id.au>
 <57762D2A.9040103@linux.vnet.ibm.com>
 <87vb0j84fb.fsf@@concordia.ellerman.id.au>
 <577F31D9.4050808@linux.vnet.ibm.com>
 <87zipsmsyd.fsf@@concordia.ellerman.id.au>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, anton@ozlabs.org, ananth@in.ibm.com,
 dja@axtens.net, naveen.n.rao@linux.vnet.ibm.com, David.Laight@ACULAB.COM,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Date: Tue, 12 Jul 2016 07:51:46 +0530
MIME-Version: 1.0
In-Reply-To: <87zipsmsyd.fsf@@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <5784543A.9030801@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Arnaldo,

On Friday 08 July 2016 02:01 PM, Michael Ellerman wrote:
> Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com> writes:
>
>> On Wednesday 06 July 2016 03:38 PM, Michael Ellerman wrote:
>>
>> I've sent v4 which enables annotate for bctr' instructions.
>>
>> for 'bctr', it will show down arrow(indicate jump) and 'bctrl' will show
>> right arrow(indicate call). But no navigation options will be provided.
>> By pressing Enter key on that, message will be shown that like
>> "Invalid target"
> Great thanks.

I've sent v4 series. Please review it.

-Ravi

>>>>> It doesn't look like we have the opcode handy here? Could we get it somehow?
>>>>> That would make this a *lot* more robust.
>>>> objdump prints machine code, but I don't know how difficult that would
>>>> be to parse to get opcode.
>>> Normal objdump -d output includes the opcode, eg:
>>>
>>> c00000000000886c:       2c 2c 00 00     cmpdi   r12,0
>>>                           ^^^^^^^^^^^
>>>
>>> The only thing you need to know is the endian and you can reconstruct
>>> the raw instruction.
>>>
>>> Then you can just decode the opcode, see how we do it in the kernel with
>>> eg. instr_is_relative_branch().
>> I'm sorry. I was thinking that you wants to show opcodes with perf
>> annotate. But you were asking to use opcode instead of parsing
>> instructions.
> Yeah.
>
>> This looks like rewrite parsing code. I don't know whether there is any
>> library already available for this which we can directly use. I'm thinking
>> about this.
> OK don't worry about it for now. We should get this merged for starters
> and we can always improve it later.
>
> cheers
>
