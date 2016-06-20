Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rY5l92Yd6zDq62
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 19:53:08 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5K9npaT082456
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 05:53:06 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23n2ta2b88-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 05:53:06 -0400
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 20 Jun 2016 19:53:03 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 328732CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 19:53:02 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5K9r2a25177662
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 19:53:02 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5K9r1Wq028977
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 19:53:02 +1000
Subject: Re: [PATCH v2] tools/perf: Fix the mask in regs_dump__printf and
To: Jiri Olsa <jolsa@redhat.com>, "Wangnan (F)" <wangnan0@huawei.com>
References: <1466412241-27502-1-git-send-email-maddy@linux.vnet.ibm.com>
 <20160620091818.GC27702@krava> <5767B6FD.4080708@huawei.com>
 <20160620094003.GA32172@krava>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Yury Norov <ynorov@caviumnetworks.com>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@intel.com>, Michael Ellerman <mpe@ellerman.id.au>
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Mon, 20 Jun 2016 15:22:57 +0530
MIME-Version: 1.0
In-Reply-To: <20160620094003.GA32172@krava>
Content-Type: text/plain; charset=windows-1252
Message-Id: <d9a12da2-bda7-67b2-1954-e99c4a101768@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Monday 20 June 2016 03:10 PM, Jiri Olsa wrote:
> On Mon, Jun 20, 2016 at 05:27:25PM +0800, Wangnan (F) wrote:
>>
>> On 2016/6/20 17:18, Jiri Olsa wrote:
>>> On Mon, Jun 20, 2016 at 02:14:01PM +0530, Madhavan Srinivasan wrote:
>>>> When decoding the perf_regs mask in regs_dump__printf(),
>>>> we loop through the mask using find_first_bit and find_next_bit functions.
>>>> "mask" is of type "u64", but sent as a "unsigned long *" to
>>>> lib functions along with sizeof(). While the exisitng code works fine in
>>>> most of the case, the logic is broken when using a 32bit perf on a
>>>> 64bit kernel (Big Endian). We end up reading the wrong word of the u64
>>>> first in the lib functions.
>>> hum, I still don't see why this happens.. why do we read the
>>> wrong word in this case?
>> If you read a u64 using (u32 *)(&val)[0] and (u32 *)(&val)[1]
>> you can get wrong value. This is what _find_next_bit() is doing.

Also in find_first_bit().

>>
>> In a big endian environment where 'unsigned long' is 32 bits
>> long, "(u32 *)(&val)[0]" gets upper 32 bits, but without this patch
>> perf assumes it gets lower 32 bits. The root cause is wrongly convert
>> u64 value to bitmap.
> i see, could you please put this into comment in the code?
>
> also we could have common function for that, to keep it on
> one place only, like bitmap_from_u64 or so

Sure will do.

>
> thanks,
> jirka
>
