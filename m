Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sFzxp5qTHzDqd7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 20:40:14 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7JAd9Xs053115
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 06:40:12 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24wg7ga5jc-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 06:40:11 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ravi.bangoria@linux.vnet.ibm.com>;
 Fri, 19 Aug 2016 04:40:10 -0600
Subject: Re: [PATCH v5 2/7] perf annotate: Add cross arch annotate support
To: Russell King - ARM Linux <linux@armlinux.org.uk>
References: <1471584546-11080-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
 <1471584546-11080-3-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
 <20160819075034.GG1041@n2100.armlinux.org.uk>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
 alexander.shishkin@linux.intel.com, treeze.taeung@gmail.com,
 naveen.n.rao@linux.vnet.ibm.com, markus@trippelsdorf.de,
 chris.ryder@arm.com, pawel.moll@arm.com, mhiramat@kernel.org,
 jolsa@kernel.org, mpe@ellerman.id.au, hemant@linux.vnet.ibm.com,
 namhyung@kernel.org, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Date: Fri, 19 Aug 2016 16:09:51 +0530
MIME-Version: 1.0
In-Reply-To: <20160819075034.GG1041@n2100.armlinux.org.uk>
Content-Type: text/plain; charset=windows-1252
Message-Id: <57B6E1F7.30005@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thanks Russell for reviewing.

On Friday 19 August 2016 01:20 PM, Russell King - ARM Linux wrote:
> On Fri, Aug 19, 2016 at 10:59:01AM +0530, Ravi Bangoria wrote:
>> -static struct ins instructions[] = {
>> +static struct ins instructions_x86[] = {
>>  	{ .name = "add",   .ops  = &mov_ops, },
>>  	{ .name = "addl",  .ops  = &mov_ops, },
>>  	{ .name = "addq",  .ops  = &mov_ops, },
>>  	{ .name = "addw",  .ops  = &mov_ops, },
>>  	{ .name = "and",   .ops  = &mov_ops, },
>> -#ifdef __arm__
>> -	{ .name = "b",     .ops  = &jump_ops, }, // might also be a call
>> -	{ .name = "bcc",   .ops  = &jump_ops, },
>> -	{ .name = "bcs",   .ops  = &jump_ops, },
>> -	{ .name = "beq",   .ops  = &jump_ops, },
>> -	{ .name = "bge",   .ops  = &jump_ops, },
>> -	{ .name = "bgt",   .ops  = &jump_ops, },
>> -	{ .name = "bhi",   .ops  = &jump_ops, },
>> -	{ .name = "bl",    .ops  = &call_ops, },
>> -	{ .name = "bls",   .ops  = &jump_ops, },
>> -	{ .name = "blt",   .ops  = &jump_ops, },
>> -	{ .name = "blx",   .ops  = &call_ops, },
>> -	{ .name = "bne",   .ops  = &jump_ops, },
>> -#endif
> Notice that ARM includes a lot of other instructions from this table,
> not just those above.
>
>>  	{ .name = "bts",   .ops  = &mov_ops, },
>>  	{ .name = "call",  .ops  = &call_ops, },
>>  	{ .name = "callq", .ops  = &call_ops, },
>> @@ -456,6 +444,21 @@ static struct ins instructions[] = {
>>  	{ .name = "retq",  .ops  = &ret_ops, },
>>  };
>>  
>> +static struct ins instructions_arm[] = {
>> +	{ .name = "b",     .ops  = &jump_ops, }, /* might also be a call */
>> +	{ .name = "bcc",   .ops  = &jump_ops, },
>> +	{ .name = "bcs",   .ops  = &jump_ops, },
>> +	{ .name = "beq",   .ops  = &jump_ops, },
>> +	{ .name = "bge",   .ops  = &jump_ops, },
>> +	{ .name = "bgt",   .ops  = &jump_ops, },
>> +	{ .name = "bhi",   .ops  = &jump_ops, },
>> +	{ .name = "bl",    .ops  = &call_ops, },
>> +	{ .name = "bls",   .ops  = &jump_ops, },
>> +	{ .name = "blt",   .ops  = &jump_ops, },
>> +	{ .name = "blx",   .ops  = &call_ops, },
>> +	{ .name = "bne",   .ops  = &jump_ops, },
>> +};
>> +
> ...
>> +	if (!strcmp(norm_arch, NORM_X86)) {
>> +		instructions = instructions_x86;
>> +		nmemb = ARRAY_SIZE(instructions_x86);
>> +	} else if (!strcmp(norm_arch, NORM_ARM)) {
>> +		instructions = instructions_arm;
>> +		nmemb = ARRAY_SIZE(instructions_arm);
> But these changes result in _only_ the ones that were in the #if __arm__
> being matched.  This is wrong.
>
> If we want to go that way, we need to add _all_ arm instructions to
> instructions_arm, not just those within the #if.

Yes, I've mentioned same in cover letter as well.

Can I add all x86 instructions for arm as well? If not, can you please provide
a list of arm instructions that needs to be added here.

-Ravi
