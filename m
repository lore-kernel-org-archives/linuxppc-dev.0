Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rWF1B6VN1zDqw1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jun 2016 19:13:50 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5H99FV5054857
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jun 2016 05:13:48 -0400
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [125.16.236.2])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23kw2qjjxx-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jun 2016 05:13:48 -0400
Received: from localhost
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Fri, 17 Jun 2016 14:43:44 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 1BDD5E005A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jun 2016 14:47:19 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5H9DefH3670340
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jun 2016 14:43:40 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5H9DX3d003836
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jun 2016 14:43:39 +0530
Subject: Re: [PATCH] tools/perf: Fix the mask in regs_dump__printf
To: Jiri Olsa <jolsa@redhat.com>
References: <1466140958-1928-1-git-send-email-maddy@linux.vnet.ibm.com>
 <20160617063707.GA31475@krava>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Yury Norov <ynorov@caviumnetworks.com>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@intel.com>, Wang Nan <wangnan0@huawei.com>,
 Michael Ellerman <mpe@ellerman.id.au>
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Fri, 17 Jun 2016 14:43:31 +0530
MIME-Version: 1.0
In-Reply-To: <20160617063707.GA31475@krava>
Content-Type: text/plain; charset=windows-1252
Message-Id: <7abb0f9a-dea0-de86-ba0b-cebce0f11744@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Friday 17 June 2016 12:07 PM, Jiri Olsa wrote:
> On Fri, Jun 17, 2016 at 10:52:38AM +0530, Madhavan Srinivasan wrote:
>> When decoding the perf_regs mask in regs_dump__printf(),
>> we loop through the mask using find_first_bit and find_next_bit functions.
>> And mask is of type "u64". But "u64" is send as a "unsigned long *" to
>> lib functions along with sizeof().
>>
>> While the exisitng code works fine in most of the case, when using a
>> 32bit perf on a 64bit kernel (Big Endian), we end up reading the wrong word
>> in the u64 mask. Patch to fix the mask in regs_dump__printf().
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
>>  tools/perf/util/session.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
>> index 5214974e841a..2eaa42a4832a 100644
>> --- a/tools/perf/util/session.c
>> +++ b/tools/perf/util/session.c
>> @@ -940,8 +940,13 @@ static void branch_stack__printf(struct perf_sample *sample)
>>  static void regs_dump__printf(u64 mask, u64 *regs)
>>  {
>>  	unsigned rid, i = 0;
>> +	unsigned long _mask[sizeof(mask)/sizeof(unsigned long)];
>>  
>> -	for_each_set_bit(rid, (unsigned long *) &mask, sizeof(mask) * 8) {
>> +	_mask[0] = mask & ULONG_MAX;
>> +	if (sizeof(mask) > sizeof(unsigned long))
>> +		_mask[1] = mask >> 32;
>> +
> I think we should do this earlier when reading the mask,
> not at the moment we just print it, like we do for other
> types.. maybe we could do this as an extra bit for

Ok. I tried something like this. Currently
mask is read in perf_evsel__parse_sample(),
so added for both sample type (PERF_SAMPLE_REGS_USER
and PERF_SAMPLE_REGS_INTR)

 
                if (data->user_regs.abi) {
-                       u64 mask = evsel->attr.sample_regs_user;
+                       u.val64 = evsel->attr.sample_regs_user;
 
-                       sz = hweight_long(mask) * sizeof(u64);
+                       if (sizeof(u64) > sizeof(unsigned long)) {
+                               u64 mask = u.val64;
+                               u.val32[1] = mask >> 32;
+                               u.val32[0] = mask & ULONG_MAX;
+                       }
+
+                       sz = hweight_long(u.val64) * sizeof(u64);
                        OVERFLOW_CHECK(array, sz, max_size);
-                       data->user_regs.mask = mask;
+                       data->user_regs.mask = u.val64;
                        data->user_regs.regs = (u64 *)array;

Issue I see is when printing the mask value in a 32bit perf
on a 64bit kernel (big endian).

442044948492 0xdc0 [0x188]: PERF_RECORD_SAMPLE(IP, 0x1): 7299/7299:
0xc000000000059200 period: 12599 addr: 0
... intr regs: mask 0xffffffff000007ff ABI 32-bit
                            ^^^ shld have been 0x7ffffffffff

I agree it is better to fix this when reading, but
we need to swap again when printing?

> perf_event__swap_ops[PERF_RECORD_SAMPLE] function
>
> also there's print_sample_iregs in builtin-script.c that's
> most likely affected as well

My bad. Should have seen this too.

Maddy
>
> thanks,
> jirka
>
>> +	for_each_set_bit(rid, _mask, sizeof(mask) * 8) {
>>  		u64 val = regs[i++];
>>  
>>  		printf(".... %-5s 0x%" PRIx64 "\n",
>> -- 
>> 1.9.1
>>
