Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rw9DJ6bJwzDqYY
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jul 2016 20:36:00 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
Cc: duwe@lst.de, aneesh.kumar@linux.vnet.ibm.com,
 Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH 1/2] powerpc/ftrace: Separate the heuristics for checking
 call sites
In-Reply-To: <578DBE29.6010100@linux.vnet.ibm.com>
References: <1468903711-5869-1-git-send-email-mpe@ellerman.id.au>
 <578DBE29.6010100@linux.vnet.ibm.com>
Date: Thu, 21 Jul 2016 20:36:00 +1000
Message-ID: <87k2gfth0v.fsf@@concordia.ellerman.id.au>
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

Madhavan Srinivasan <maddy@linux.vnet.ibm.com> writes:

> On Tuesday 19 July 2016 10:18 AM, Michael Ellerman wrote:
>> In __ftrace_make_nop() (the 64-bit version), we have code to deal with
>> two ftrace ABIs. There is the original ABI, which looks mostly like a
>> function call, and then the mprofile-kernel ABI which is just a branch.
>>
...
>> diff --git a/arch/powerpc/kernel/ftrace.c b/arch/powerpc/kernel/ftrace.c
>> index 7af6c4de044b..438442dac44c 100644
>> --- a/arch/powerpc/kernel/ftrace.c
>> +++ b/arch/powerpc/kernel/ftrace.c
>> @@ -144,6 +144,21 @@ __ftrace_make_nop(struct module *mod,
>>   		return -EINVAL;
>>   	}
>>   
>> +#ifdef CC_USING_MPROFILE_KERNEL
>> +	/* When using -mkernel_profile there is no load to jump over */
>> +	pop = PPC_INST_NOP;
>> +
>> +	if (probe_kernel_read(&op, (void *)(ip - 4), 4)) {
>> +		pr_err("Fetching instruction at %lx failed.\n", ip - 4);
>> +		return -EFAULT;
>> +	}
>> +
>> +	/* We expect either a mlfr r0, or a std r0, LRSAVE(r1) */
>
> nit..  "mflr" and not "mlfr"

Yep, copied from the old comment, but I'll fix it up. Thanks.

cheers
