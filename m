Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rpS3Q5LfvzDqwP
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jul 2016 13:23:29 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6C3JT0R037507
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jul 2016 23:23:27 -0400
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 243eud1pf1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jul 2016 23:23:26 -0400
Received: from localhost
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Tue, 12 Jul 2016 08:53:23 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id CA0C6125804F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jul 2016 08:56:11 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6C3NExU19988938
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jul 2016 08:53:14 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6C3NJMq030168
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jul 2016 08:53:21 +0530
Subject: Re: [PATCH v5] tools/perf: Fix the mask in regs_dump__printf and
 print_sample_iregs
To: Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
References: <1466660967-2016-1-git-send-email-maddy@linux.vnet.ibm.com>
 <20160628085434.GA28550@krava>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Yury Norov <ynorov@caviumnetworks.com>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@intel.com>, Wang Nan <wangnan0@huawei.com>,
 Michael Ellerman <mpe@ellerman.id.au>
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Tue, 12 Jul 2016 08:53:19 +0530
MIME-Version: 1.0
In-Reply-To: <20160628085434.GA28550@krava>
Content-Type: text/plain; charset=windows-1252
Message-Id: <3a43ebc8-687b-0c12-dbfe-25e60392eea7@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Arnaldo,

Any updates for this fix. Kindly let me know.

Maddy

On Tuesday 28 June 2016 02:24 PM, Jiri Olsa wrote:
> On Thu, Jun 23, 2016 at 11:19:27AM +0530, Madhavan Srinivasan wrote:
>
> SNIP
>
>> Changelog v1:
>> 1)updated commit message and patch subject
>> 2)Add the fix to print_sample_iregs() in builtin-script.c
>>
>>  tools/include/linux/bitmap.h |  2 ++
>>  tools/lib/bitmap.c           | 18 ++++++++++++++++++
>>  tools/perf/builtin-script.c  |  4 +++-
>>  tools/perf/util/session.c    |  4 +++-
>>  4 files changed, 26 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/include/linux/bitmap.h b/tools/include/linux/bitmap.h
>> index 28f5493da491..5e98525387dc 100644
>> --- a/tools/include/linux/bitmap.h
>> +++ b/tools/include/linux/bitmap.h
>> @@ -2,6 +2,7 @@
>>  #define _PERF_BITOPS_H
>>  
>>  #include <string.h>
>> +#include <limits.h>
> this could go in the bitmap.c file, but anyway:
>
> Acked-by: Jiri Olsa <jolsa@kernel.org>
>
> thanks,
> jirka
>
>>  #include <linux/bitops.h>
>>  
>>  #define DECLARE_BITMAP(name,bits) \
>> @@ -10,6 +11,7 @@
>>  int __bitmap_weight(const unsigned long *bitmap, int bits);
>>  void __bitmap_or(unsigned long *dst, const unsigned long *bitmap1,
>>  		 const unsigned long *bitmap2, int bits);
>> +void bitmap_from_u64(unsigned long *dst, u64 mask);
>>  
>>  #define BITMAP_FIRST_WORD_MASK(start) (~0UL << ((start) & (BITS_PER_LONG - 1)))
>>  
> SNIP
>
