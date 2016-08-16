Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sD1BX14XpzDr45
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Aug 2016 15:29:23 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7G5SwId060157
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Aug 2016 01:29:22 -0400
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [125.16.236.9])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24syq39gpa-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Aug 2016 01:29:21 -0400
Received: from localhost
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Tue, 16 Aug 2016 10:59:18 +0530
Received: from d28relay07.in.ibm.com (d28relay07.in.ibm.com [9.184.220.158])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 497A71258026
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Aug 2016 11:02:27 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay07.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7G5TDwW30343398
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Aug 2016 10:59:13 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7G5T7r1002042
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Aug 2016 10:59:12 +0530
Subject: Re: [PATCH] perf/core: Fix the mask in perf_output_sample_regs
To: Peter Zijlstra <peterz@infradead.org>
References: <1467568918-24377-1-git-send-email-maddy@linux.vnet.ibm.com>
 <20160811122710.GP6879@twins.programming.kicks-ass.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Yury Norov <ynorov@caviumnetworks.com>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Tue, 16 Aug 2016 10:59:05 +0530
MIME-Version: 1.0
In-Reply-To: <20160811122710.GP6879@twins.programming.kicks-ass.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <80480a53-c9db-d912-c560-0c31b81100ce@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Thursday 11 August 2016 05:57 PM, Peter Zijlstra wrote:
> Sorry, found it in my inbox while clearing out backlog..
>
> On Sun, Jul 03, 2016 at 11:31:58PM +0530, Madhavan Srinivasan wrote:
>> When decoding the perf_regs mask in perf_output_sample_regs(),
>> we loop through the mask using find_first_bit and find_next_bit functions.
>> While the exisitng code works fine in most of the case,
>> the logic is broken for 32bit kernel (Big Endian).
>> When reading u64 mask using (u32 *)(&val)[0], find_*_bit() assumes it gets
>> lower 32bits of u64 but instead gets upper 32bits which is wrong.
>> Proposed fix is to swap the words of the u64 to handle this case.
>> This is _not_ endianness swap.
> But it looks an awful lot like it..
Hit this issue when testing my perf_arch_regs patchset. Yep exactly
the reason for adding that comment in the commit message.


>
>> +++ b/kernel/events/core.c
>> @@ -5205,8 +5205,10 @@ perf_output_sample_regs(struct perf_output_handle *handle,
>>   			struct pt_regs *regs, u64 mask)
>>   {
>>   	int bit;
>> +	DECLARE_BITMAP(_mask, 64);
>>   
>> -	for_each_set_bit(bit, (const unsigned long *) &mask,
>> +	bitmap_from_u64(_mask, mask);
>> +	for_each_set_bit(bit, _mask,
>>   			 sizeof(mask) * BITS_PER_BYTE) {
>>   		u64 val;
>> +++ b/lib/bitmap.c
>> +void bitmap_from_u64(unsigned long *dst, u64 mask)
>> +{
>> +	dst[0] = mask & ULONG_MAX;
>> +
>> +	if (sizeof(mask) > sizeof(unsigned long))
>> +		dst[1] = mask >> 32;
>> +}
>> +EXPORT_SYMBOL(bitmap_from_u64);
> Looks small enough for an inline.
>
> Alternatively you can go all the way and add bitmap_from_u64array(), but
> that seems massive overkill.

Ok will make it inline and resend.

Maddy

>
> Tedious stuff.. I can't come up with anything prettier :/
>
