Return-Path: <punit.agrawal@arm.com>
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 40bjRg0mtSzF2TC
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 May 2018 01:50:54 +1000 (AEST)
From: Punit Agrawal <punit.agrawal@arm.com>
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Cc: <akpm@linux-foundation.org>, <mhocko@kernel.org>, <peterz@infradead.org>,
 <kirill@shutemov.name>, <ak@linux.intel.com>, <dave@stgolabs.net>,
 <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
 <benh@kernel.crashing.org>, <mpe@ellerman.id.au>, <paulus@samba.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 <hpa@zytor.com>, Will Deacon <will.deacon@arm.com>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Andrea Arcangeli <aarcange@redhat.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>, <kemi.wang@intel.com>,
 <sergey.senozhatsky.work@gmail.com>,
 Daniel Jordan <daniel.m.jordan@oracle.com>,
 David Rientjes <rientjes@google.com>, Jerome Glisse <jglisse@redhat.com>,
 Ganesh Mahendran <opensource.ganesh@gmail.com>, <linux-kernel@vger.kernel.org>,
 <linux-mm@kvack.org>, <haren@linux.vnet.ibm.com>,
 <khandual@linux.vnet.ibm.com>, <npiggin@gmail.com>, <bsingharora@gmail.com>,
 <paulmck@linux.vnet.ibm.com>, Tim Chen <tim.c.che
 n@linux.intel.com>,  <linuxppc-dev@lists.ozlabs.org>,  <x86@kernel.org>
Subject: Re: [PATCH v10 00/25] Speculative page faults
References: <1523975611-15978-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <87bmdynnv4.fsf@e105922-lin.cambridge.arm.com>
 <eef94f4f-800e-9994-d926-a71b80552ebc@linux.vnet.ibm.com>
Date: Wed, 02 May 2018 16:50:49 +0100
In-Reply-To: <eef94f4f-800e-9994-d926-a71b80552ebc@linux.vnet.ibm.com>
 (Laurent Dufour's message of "Wed, 2 May 2018 16:45:19 +0200")
Message-ID: <87vac6m4yu.fsf@e105922-lin.cambridge.arm.com>
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

Hi Laurent,

Thanks for your reply.

Laurent Dufour <ldufour@linux.vnet.ibm.com> writes:

> On 02/05/2018 16:17, Punit Agrawal wrote:
>> Hi Laurent,
>> 
>> One query below -
>> 
>> Laurent Dufour <ldufour@linux.vnet.ibm.com> writes:
>> 
>> [...]
>> 
>>>
>>> Ebizzy:
>>> -------
>>> The test is counting the number of records per second it can manage, the
>>> higher is the best. I run it like this 'ebizzy -mTRp'. To get consistent
>>> result I repeated the test 100 times and measure the average result. The
>>> number is the record processes per second, the higher is the best.
>>>
>>>   		BASE		SPF		delta	
>>> 16 CPUs x86 VM	12405.52	91104.52	634.39%
>>> 80 CPUs P8 node 37880.01	76201.05	101.16%
>> 
>> How do you measure the number of records processed? Is there a specific
>> version of ebizzy that reports this? I couldn't find a way to get this
>> information with the ebizzy that's included in ltp.
>
> I'm using the original one : http://ebizzy.sourceforge.net/

Turns out I missed the records processed in the verbose output enabled
by "-vvv". Sorry for the noise.

[...]

>> 
>> A trial run showed increased fault handling when SPF is enabled on an
>> 8-core ARM64 system running 4.17-rc3. I am using a port of your x86
>> patch to enable spf on arm64.
>> 
>> SPF
>> ---
>> 
>> Performance counter stats for './ebizzy -vvvmTRp':
>> 
>>          1,322,736      faults                                                      
>>          1,299,241      software/config=11/                                         
>> 
>>       10.005348034 seconds time elapsed
>> 
>> No SPF
>> -----
>> 
>>  Performance counter stats for './ebizzy -vvvmTRp':
>> 
>>            708,916      faults
>>                  0      software/config=11/
>> 
>>       10.005807432 seconds time elapsed
>
> Thanks for sharing these good numbers !


A quick run showed 71041 (no-spf) vs 122306 (spf) records/s (~72%
improvement).

I'd like to do some runs on a slightly larger system (if I can get my
hands on one) to see how the patches behave. I'll also have a closer
look at your series - the previous comments were just somethings I
observed as part of trying the functionality on arm64.

Thanks,
Punit
