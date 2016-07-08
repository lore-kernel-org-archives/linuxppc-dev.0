Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rm74q0wLjzDqlj
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jul 2016 18:31:39 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, acme@kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: anton@ozlabs.org, ananth@in.ibm.com, dja@axtens.net,
 naveen.n.rao@linux.vnet.ibm.com, David.Laight@ACULAB.COM,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 3/4] perf annotate: add powerpc support
In-Reply-To: <577F31D9.4050808@linux.vnet.ibm.com>
References: <1467267262-4589-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
 <1467267262-4589-4-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
 <1467267714.7296.6.camel@ellerman.id.au>
 <57762D2A.9040103@linux.vnet.ibm.com>
 <87vb0j84fb.fsf@@concordia.ellerman.id.au>
 <577F31D9.4050808@linux.vnet.ibm.com>
Date: Fri, 08 Jul 2016 18:31:38 +1000
Message-ID: <87zipsmsyd.fsf@@concordia.ellerman.id.au>
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

Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com> writes:

> On Wednesday 06 July 2016 03:38 PM, Michael Ellerman wrote:
>
> I've sent v4 which enables annotate for bctr' instructions.
>
> for 'bctr', it will show down arrow(indicate jump) and 'bctrl' will show
> right arrow(indicate call). But no navigation options will be provided.
> By pressing Enter key on that, message will be shown that like
> "Invalid target"

Great thanks.

>>>> It doesn't look like we have the opcode handy here? Could we get it somehow?
>>>> That would make this a *lot* more robust.
>>> objdump prints machine code, but I don't know how difficult that would
>>> be to parse to get opcode.
>> Normal objdump -d output includes the opcode, eg:
>>
>> c00000000000886c:       2c 2c 00 00     cmpdi   r12,0
>>                          ^^^^^^^^^^^
>>
>> The only thing you need to know is the endian and you can reconstruct
>> the raw instruction.
>>
>> Then you can just decode the opcode, see how we do it in the kernel with
>> eg. instr_is_relative_branch().
>
> I'm sorry. I was thinking that you wants to show opcodes with perf
> annotate. But you were asking to use opcode instead of parsing
> instructions.

Yeah.

> This looks like rewrite parsing code. I don't know whether there is any
> library already available for this which we can directly use. I'm thinking
> about this.

OK don't worry about it for now. We should get this merged for starters
and we can always improve it later.

cheers
