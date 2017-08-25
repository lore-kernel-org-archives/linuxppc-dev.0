Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xdw203dxPzDrT9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Aug 2017 18:54:00 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7P8n3a5097638
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Aug 2017 04:53:57 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cjbsd1mx9-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Aug 2017 04:53:57 -0400
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Fri, 25 Aug 2017 09:53:55 +0100
Subject: Re: [PATCH v2 18/20] perf tools: Add support for the SPF perf event
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 paulmck@linux.vnet.ibm.com, peterz@infradead.org,
 akpm@linux-foundation.org, kirill@shutemov.name, ak@linux.intel.com,
 mhocko@kernel.org, dave@stgolabs.net, jack@suse.cz,
 Matthew Wilcox <willy@infradead.org>, benh@kernel.crashing.org,
 mpe@ellerman.id.au, paulus@samba.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 hpa@zytor.com, Will Deacon <will.deacon@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, haren@linux.vnet.ibm.com,
 npiggin@gmail.com, bsingharora@gmail.com,
 Tim Chen <tim.c.chen@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
 x86@kernel.org
References: <1503007519-26777-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <1503007519-26777-19-git-send-email-ldufour@linux.vnet.ibm.com>
 <6df385f1-7e7e-516f-525e-900af9bd5a01@linux.vnet.ibm.com>
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Fri, 25 Aug 2017 10:53:47 +0200
MIME-Version: 1.0
In-Reply-To: <6df385f1-7e7e-516f-525e-900af9bd5a01@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <b713236f-4d23-0b95-3e48-6fa64f0ce616@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 21/08/2017 10:48, Anshuman Khandual wrote:
> On 08/18/2017 03:35 AM, Laurent Dufour wrote:
>> Add support for the new speculative faults event.
>>
>> Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
>> ---
>>  tools/include/uapi/linux/perf_event.h | 1 +
>>  tools/perf/util/evsel.c               | 1 +
>>  tools/perf/util/parse-events.c        | 4 ++++
>>  tools/perf/util/parse-events.l        | 1 +
>>  tools/perf/util/python.c              | 1 +
>>  5 files changed, 8 insertions(+)
>>
>> diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
>> index b1c0b187acfe..3043ec0988e9 100644
>> --- a/tools/include/uapi/linux/perf_event.h
>> +++ b/tools/include/uapi/linux/perf_event.h
>> @@ -111,6 +111,7 @@ enum perf_sw_ids {
>>  	PERF_COUNT_SW_EMULATION_FAULTS		= 8,
>>  	PERF_COUNT_SW_DUMMY			= 9,
>>  	PERF_COUNT_SW_BPF_OUTPUT		= 10,
>> +	PERF_COUNT_SW_SPF_DONE			= 11,
> 
> Right, just one event for the success case. 'DONE' is redundant, only
> 'SPF' should be fine IMHO.
> 

Fair enough, I'll rename it PERF_COUNT_SW_SPF.

Thanks,
Laurent.
