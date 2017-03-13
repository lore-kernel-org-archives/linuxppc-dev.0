Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vhb0C1RHyzDqXy
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Mar 2017 22:16:11 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2DBE3Ne096267
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Mar 2017 07:16:05 -0400
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
 by mx0a-001b2d01.pphosted.com with ESMTP id 294enbn1s7-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Mar 2017 07:16:04 -0400
Received: from localhost
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 13 Mar 2017 16:46:01 +0530
Received: from d28av08.in.ibm.com (d28av08.in.ibm.com [9.184.220.148])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v2DBFxk545023458
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Mar 2017 16:45:59 +0530
Received: from d28av08.in.ibm.com (localhost [127.0.0.1])
 by d28av08.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v2DBFvwH026964
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Mar 2017 16:45:59 +0530
Subject: Re: [PATCH v2 1/6] powerpc/perf: Define big-endian version of
 perf_mem_data_src
To: Peter Zijlstra <peterz@infradead.org>
References: <1488796993-25495-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1488796993-25495-2-git-send-email-maddy@linux.vnet.ibm.com>
 <20170306112228.GZ6515@twins.programming.kicks-ass.net>
 <2fc7e466-1675-ef27-b820-ef33ed0be7da@linux.vnet.ibm.com>
 <20170307102359.GE6515@twins.programming.kicks-ass.net>
Cc: mpe@ellerman.id.au, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Wang Nan <wangnan0@huawei.com>, Alexei Starovoitov <ast@kernel.org>,
 Stephane Eranian <eranian@google.com>
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Mon, 13 Mar 2017 16:45:51 +0530
MIME-Version: 1.0
In-Reply-To: <20170307102359.GE6515@twins.programming.kicks-ass.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <78c1b95d-2e82-f998-74ba-ebb1fdf5bb45@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Tuesday 07 March 2017 03:53 PM, Peter Zijlstra wrote:
> On Tue, Mar 07, 2017 at 03:28:17PM +0530, Madhavan Srinivasan wrote:
>>
>> On Monday 06 March 2017 04:52 PM, Peter Zijlstra wrote:
>>> On Mon, Mar 06, 2017 at 04:13:08PM +0530, Madhavan Srinivasan wrote:
>>>> From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
>>>>
>>>> perf_mem_data_src is an union that is initialized via the ->val field
>>>> and accessed via the bitmap fields. For this to work on big endian
>>>> platforms, we also need a big-endian represenation of perf_mem_data_src.
>>> Doesn't this break interpreting the data on a different endian machine?
>> IIUC, we will need this patch to not to break the interpreting data
>> on a different endian machine. Data collected from power8 LE/BE
>> guests with this patchset applied. Kindly correct me if I missed
>> your question here.
> So your patch adds compile time bitfield differences. My worry was that
> there was no dynamic conversion routine in the tools (it has for a lot
> of other places).
>
> This yields two questions:
>
>   - are these two static layouts identical? (seeing that you illustrate
>     cross-endian things working this seems likely).
>
>   - should you not have fixed this in the tool only? This patch
>     effectively breaks ABI on big-endian architectures.

IIUC, we are the first BE user for this feature
(Kindly correct me if I am wrong), so technically we
are not breaking ABI here :) .  But let me also look  at
the dynamic conversion part.

Maddy

>
