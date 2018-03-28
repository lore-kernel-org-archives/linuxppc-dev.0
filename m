Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40B0Qh4tyVzF2HN
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Mar 2018 18:49:46 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2S7YLf3018698
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Mar 2018 03:49:44 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2h06e29w9h-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Mar 2018 03:49:42 -0400
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Wed, 28 Mar 2018 08:49:40 +0100
Subject: Re: [PATCH v9 01/24] mm: Introduce CONFIG_SPECULATIVE_PAGE_FAULT
To: David Rientjes <rientjes@google.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: paulmck@linux.vnet.ibm.com, peterz@infradead.org,
 akpm@linux-foundation.org, kirill@shutemov.name, ak@linux.intel.com,
 mhocko@kernel.org, dave@stgolabs.net, jack@suse.cz,
 Matthew Wilcox <willy@infradead.org>, benh@kernel.crashing.org,
 mpe@ellerman.id.au, paulus@samba.org, Ingo Molnar <mingo@redhat.com>,
 hpa@zytor.com, Will Deacon <will.deacon@arm.com>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Andrea Arcangeli <aarcange@redhat.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>, kemi.wang@intel.com,
 sergey.senozhatsky.work@gmail.com, Daniel Jordan
 <daniel.m.jordan@oracle.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 haren@linux.vnet.ibm.com, khandual@linux.vnet.ibm.com,
 npiggin@gmail.com, bsingharora@gmail.com,
 Tim Chen <tim.c.chen@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
 x86@kernel.org
References: <1520963994-28477-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <1520963994-28477-2-git-send-email-ldufour@linux.vnet.ibm.com>
 <alpine.DEB.2.20.1803251442090.80485@chino.kir.corp.google.com>
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Wed, 28 Mar 2018 09:49:29 +0200
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1803251442090.80485@chino.kir.corp.google.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <32c80b6a-28c6-bf63-ed7b-6a042ae18e8f@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi David,

Thanks a lot for your deep review on this series.

On 25/03/2018 23:50, David Rientjes wrote:
> On Tue, 13 Mar 2018, Laurent Dufour wrote:
> 
>> This configuration variable will be used to build the code needed to
>> handle speculative page fault.
>>
>> By default it is turned off, and activated depending on architecture
>> support.
>>
>> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
>> Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
>> ---
>>  mm/Kconfig | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/mm/Kconfig b/mm/Kconfig
>> index abefa573bcd8..07c566c88faf 100644
>> --- a/mm/Kconfig
>> +++ b/mm/Kconfig
>> @@ -759,3 +759,6 @@ config GUP_BENCHMARK
>>  	  performance of get_user_pages_fast().
>>  
>>  	  See tools/testing/selftests/vm/gup_benchmark.c
>> +
>> +config SPECULATIVE_PAGE_FAULT
>> +       bool
> 
> Should this be configurable even if the arch supports it?

Actually, this is not configurable unless by manually editing the .config file.

I made it this way on the Thomas's request :
https://lkml.org/lkml/2018/1/15/969

That sounds to be the smarter way to achieve that, isn't it ?

Laurent.
