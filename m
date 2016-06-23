Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rZqwd4lTyzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jun 2016 15:37:21 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5N5So9J074088
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jun 2016 01:37:19 -0400
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23q6r5b496-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jun 2016 01:37:19 -0400
Received: from localhost
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 23 Jun 2016 11:07:15 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 4410A1258063
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jun 2016 11:09:50 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5N5aQQd19726652
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jun 2016 11:06:26 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5N5b76Y032541
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jun 2016 11:07:12 +0530
Subject: Re: [PATCH v4] tools/perf: Fix the mask in regs_dump__printf and
 print_sample_iregs
To: Yury Norov <ynorov@caviumnetworks.com>
References: <1466658076-22928-1-git-send-email-maddy@linux.vnet.ibm.com>
 <20160623051824.GC13449@yury-N73SV>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@intel.com>, Wang Nan <wangnan0@huawei.com>,
 Michael Ellerman <mpe@ellerman.id.au>
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Thu, 23 Jun 2016 11:06:50 +0530
MIME-Version: 1.0
In-Reply-To: <20160623051824.GC13449@yury-N73SV>
Content-Type: text/plain; charset=windows-1252
Message-Id: <cc23aede-73c6-b9a9-a023-a819bef9a7bb@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Thursday 23 June 2016 10:48 AM, Yury Norov wrote:
> On Thu, Jun 23, 2016 at 10:31:16AM +0530, Madhavan Srinivasan wrote:
>> When decoding the perf_regs mask in regs_dump__printf(),
>> we loop through the mask using find_first_bit and find_next_bit functions.
>> "mask" is of type "u64", but sent as a "unsigned long *" to
>> lib functions along with sizeof().
>>
>> While the exisitng code works fine in most of the case,
>> the logic is broken when using a 32bit perf on a 64bit kernel (Big Endian).
>> When reading u64 using (u32 *)(&val)[0], perf (lib/find_*_bit()) assumes it gets
>> lower 32bits of u64 which is wrong. Proposed fix is to swap the words
>> of the u64 to handle this case. This is _not_ endianess swap.
>>
>> Suggested-by: Yury Norov <ynorov@caviumnetworks.com>
>> Cc: Yury Norov <ynorov@caviumnetworks.com>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
>> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>> Cc: Jiri Olsa <jolsa@kernel.org>
>> Cc: Adrian Hunter <adrian.hunter@intel.com>
>> Cc: Kan Liang <kan.liang@intel.com>
>> Cc: Wang Nan <wangnan0@huawei.com>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
>> ---
>> Changelog v3:
>> 1)Moved the swap function to lib/bitmap.c
>> 2)Added a macro for declaration
>> 3)Added the comments
>>
>> Changelog v2:
>> 1)Moved the swap code to a common function
>> 2)Added more comments in the code
>>
>> Changelog v1:
>> 1)updated commit message and patch subject
>> 2)Add the fix to print_sample_iregs() in builtin-script.c
>>
>>  tools/include/linux/bitmap.h |  5 +++++
>>  tools/lib/bitmap.c           | 18 ++++++++++++++++++
>>  tools/perf/builtin-script.c  |  4 +++-
>>  tools/perf/util/session.c    |  4 +++-
>>  4 files changed, 29 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/include/linux/bitmap.h b/tools/include/linux/bitmap.h
>> index 28f5493da491..6be9a7ddcb03 100644
>> --- a/tools/include/linux/bitmap.h
>> +++ b/tools/include/linux/bitmap.h
>> @@ -2,14 +2,19 @@
>>  #define _PERF_BITOPS_H
>>  
>>  #include <string.h>
>> +#include <limits.h>
>>  #include <linux/bitops.h>
>>  
>>  #define DECLARE_BITMAP(name,bits) \
>>  	unsigned long name[BITS_TO_LONGS(bits)]
>>  
>> +#define DECLARE_U64_BITMAP(__name) \
>> +	unsigned long __name[sizeof(u64)/sizeof(unsigned long)]
>> +
>>  int __bitmap_weight(const unsigned long *bitmap, int bits);
>>  void __bitmap_or(unsigned long *dst, const unsigned long *bitmap1,
>>  		 const unsigned long *bitmap2, int bits);
>> +void bitmap_from_u64(unsigned long *dst, u64 mask);
>>  
>>  #define BITMAP_FIRST_WORD_MASK(start) (~0UL << ((start) & (BITS_PER_LONG - 1)))
>>  
>> diff --git a/tools/lib/bitmap.c b/tools/lib/bitmap.c
>> index 0a1adc1111fd..464a0cc63e6a 100644
>> --- a/tools/lib/bitmap.c
>> +++ b/tools/lib/bitmap.c
>> @@ -29,3 +29,21 @@ void __bitmap_or(unsigned long *dst, const unsigned long *bitmap1,
>>  	for (k = 0; k < nr; k++)
>>  		dst[k] = bitmap1[k] | bitmap2[k];
>>  }
>> +
>> +/*
>> + * bitmap_from_u64 - Check and swap words within u64.
>> + *  @mask: source bitmap
>> + *  @dst:  destination bitmap
>> + *
>> + * In 32 bit big endian userspace on a 64bit kernel, 'unsigned long' is 32 bits.
>> + * When reading u64 using (u32 *)(&val)[0] and (u32 *)(&val)[1],
>> + * we will get wrong value for the mask. That is "(u32 *)(&val)[0]"
>> + * gets upper 32 bits of u64, but perf may expect lower 32bits of u64.
>> + */
>> +void bitmap_from_u64(unsigned long *dst, u64 mask)
>> +{
>> +	dst[0] = mask & ULONG_MAX;
>> +
>> +	if (sizeof(mask) > sizeof(unsigned long))
>> +		dst[1] = mask >> 32;
>> +}
>> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
>> index e3ce2f34d3ad..1120ca117071 100644
>> --- a/tools/perf/builtin-script.c
>> +++ b/tools/perf/builtin-script.c
>> @@ -412,11 +412,13 @@ static void print_sample_iregs(struct perf_sample *sample,
>>  	struct regs_dump *regs = &sample->intr_regs;
>>  	uint64_t mask = attr->sample_regs_intr;
>>  	unsigned i = 0, r;
>> +	DECLARE_U64_BITMAP(_mask);
> I thought again, and realized that it may be just
> 	DECLARE_BITMAP(_mask, 64);
>
> I think it's better than introduce new macro and I'd recommend you to
> send v5 doing this. But this version is OK to me as well. So it's up
> to you.

Yeah. Make sense. My bad did not look close at DECLARE_BITMAP.
Will send out a v5 now with that change.

Maddy
>
> Reviewed-by: Yury Norov <ynorov@caviumnetworks.com>
>
>>  	if (!regs)
>>  		return;
>>  
>> -	for_each_set_bit(r, (unsigned long *) &mask, sizeof(mask) * 8) {
>> +	bitmap_from_u64(_mask, mask);
>> +	for_each_set_bit(r, _mask, sizeof(mask) * 8) {
>>  		u64 val = regs->regs[i++];
>>  		printf("%5s:0x%"PRIx64" ", perf_reg_name(r), val);
>>  	}
>> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
>> index 5214974e841a..fab1f9c1e0f5 100644
>> --- a/tools/perf/util/session.c
>> +++ b/tools/perf/util/session.c
>> @@ -940,8 +940,10 @@ static void branch_stack__printf(struct perf_sample *sample)
>>  static void regs_dump__printf(u64 mask, u64 *regs)
>>  {
>>  	unsigned rid, i = 0;
>> +	DECLARE_U64_BITMAP(_mask);
>>  
>> -	for_each_set_bit(rid, (unsigned long *) &mask, sizeof(mask) * 8) {
>> +	bitmap_from_u64(_mask, mask);
>> +	for_each_set_bit(rid, _mask, sizeof(mask) * 8) {
>>  		u64 val = regs[i++];
>>  
>>  		printf(".... %-5s 0x%" PRIx64 "\n",
>> -- 
>> 1.9.1
