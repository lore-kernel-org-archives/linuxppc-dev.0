Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sw7w53QqYzDt1r
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Oct 2016 11:37:09 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Balbir Singh <bsingharora@gmail.com>, linuxppc-dev@ozlabs.org
Cc: anton@samba.org
Subject: Re: [PATCH] powerpc/mm: Drop dump_numa_memory_topology()
In-Reply-To: <f10b9e4e-da30-fea5-5e02-b65b014ad527@gmail.com>
References: <1476336450-27862-1-git-send-email-mpe@ellerman.id.au>
 <f10b9e4e-da30-fea5-5e02-b65b014ad527@gmail.com>
Date: Fri, 14 Oct 2016 11:37:08 +1100
Message-ID: <8760ovepfv.fsf@concordia.ellerman.id.au>
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

Balbir Singh <bsingharora@gmail.com> writes:

> On 13/10/16 16:27, Michael Ellerman wrote:
>> At boot we dump the NUMA memory topology in dump_numa_memory_topology(),
>> at KERN_DEBUG level, resulting in output like:
>> 
>>   Node 0 Memory: 0x0-0x100000000
>>   Node 1 Memory: 0x100000000-0x200000000
>> 
>> Which is nice enough, but immediately after that we iterate over each
>> node and call setup_node_data(), which also prints out the node ranges,
>> at KERN_INFO, giving eg:
>> 
>>   numa: Initmem setup node 0 [mem 0x00000000-0xffffffff]
>>   numa: Initmem setup node 1 [mem 0x100000000-0x1ffffffff]
>> 
>> So drop dump_numa_memory_topology() as superfluous chatter.
>> 
>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>> ---
>
> Actually the ranges for the lower output seem a little better
> (inclusive), the output on top is not clear

I think everyone knows what it means but it's not entirely precise, so
yeah the inclusive range is better.

cheers
