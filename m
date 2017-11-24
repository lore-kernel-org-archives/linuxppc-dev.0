Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yjm4y3GlGzDrSw
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Nov 2017 17:10:10 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Balbir Singh <bsingharora@gmail.com>,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] powernv: Avoid calling trace tlbie in kexec path.
In-Reply-To: <CAKTCnz=yeLLFWzpVr6ZzRiSe7ggPJabA6Od6msXL2PP-+48GiA@mail.gmail.com>
References: <151137178794.14123.18003389448303728066.stgit@jupiter.in.ibm.com>
 <CAKTCnzkSJo0wKx96=N2fxDVZ8KaM+uT3sUHGNgtdOD=RLajwCg@mail.gmail.com>
 <8737552nta.fsf@concordia.ellerman.id.au>
 <1511442295.rqmndvaowx.naveen@linux.ibm.com>
 <CAKTCnz=yeLLFWzpVr6ZzRiSe7ggPJabA6Od6msXL2PP-+48GiA@mail.gmail.com>
Date: Fri, 24 Nov 2017 17:10:09 +1100
Message-ID: <87r2so1a2m.fsf@concordia.ellerman.id.au>
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

Balbir Singh <bsingharora@gmail.com> writes:
> On Fri, Nov 24, 2017 at 12:11 AM, Naveen N. Rao
> <naveen.n.rao@linux.vnet.ibm.com> wrote:
>> Michael Ellerman wrote:
>>> Balbir Singh <bsingharora@gmail.com> writes:
...
>>>
>>>> I think the right thing in the longer run might be to do a
>>>> TRACE_EVENT_CONDITION
>>>> and have the condition do the right thing, but what you have for now is
>>>> good.
>>>
>>>
>>> No I think the right thing is to not call trace points from kexec code,
>>> it's too fragile. TRACE_EVENT_CONDITION wouldn't have saved us from this
>>> RCU breakage.
>>
>> I agree on the fragile part, though it appears to me that a
>> TRACE_EVENT_CONDITION() with a check for is_kexec (that needs to be added)
>> will prevent breakage since both the LOCKDEP block as well as the tracepoint
>> itself are guarded by the condition. So, none of the rcu code should be
>> executed as long as we set is_kexec at the right time.  However, since there
>> are all of 1 tracepoint(s) affecting kexec, it is probably not worth the
>> effort at the moment.
>
> +1, I am good with this change for now. I agree that we should not
> call trace points
> from kexec code, the tracepoint was for other paths, but we should
> definitely avoid
> this path.
>
> Mahesh, is this path specific to hash or do we have similar issues in radix?

The radix code will trigger the tracepoints, so we should fix that. It
may not actually crash but that's secondary.

See:
  mmu_cleanup_all()
  -> radix__mmu_cleanup_all()
     -> radix__flush_tlb_all()
        -> trace_tlbie()

cheers
