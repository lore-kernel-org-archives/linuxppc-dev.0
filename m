Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yjm5Z2W9BzDrb6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Nov 2017 17:10:42 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] powernv: Avoid calling trace tlbie in kexec path.
In-Reply-To: <1511442295.rqmndvaowx.naveen@linux.ibm.com>
References: <151137178794.14123.18003389448303728066.stgit@jupiter.in.ibm.com>
 <CAKTCnzkSJo0wKx96=N2fxDVZ8KaM+uT3sUHGNgtdOD=RLajwCg@mail.gmail.com>
 <8737552nta.fsf@concordia.ellerman.id.au>
 <1511442295.rqmndvaowx.naveen@linux.ibm.com>
Date: Fri, 24 Nov 2017 17:10:41 +1100
Message-ID: <87o9ns1a1q.fsf@concordia.ellerman.id.au>
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

"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:

> Michael Ellerman wrote:
>> Balbir Singh <bsingharora@gmail.com> writes:
>> 
>>> On Thu, Nov 23, 2017 at 4:32 AM, Mahesh J Salgaonkar
>>> <mahesh@linux.vnet.ibm.com> wrote:
>>>> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>>>>
>>>> Rebooting into a new kernel with kexec fails in trace_tlbie() which is
>>>> called from native_hpte_clear(). This happens if the running kernel has
>>>> CONFIG_LOCKDEP enabled. With lockdep enabled, the tracepoints always
>>>> execute few RCU checks regardless of whether tracing is on or off.
>>>> We are already in the last phase of kexec sequence in real mode with
>>>> HILE_BE set. At this point the RCU check ends up in RCU_LOCKDEP_WARN and
>>>> causes kexec to fail.
>>>>
>>>
>>> Effectively we can't enter the trace point code after we've set
>>> HILE_BE.  Do we need
>>> a fixes tag? Or is this a side-effect of a new generic change?
>> 
>> Yes I added:
>> 
>> Fixes: 0428491cba92 ("powerpc/mm: Trace tlbie(l) instructions")
>> Cc: stable@vger.kernel.org # v4.13+
>> 
>>> I think the right thing in the longer run might be to do a TRACE_EVENT_CONDITION
>>> and have the condition do the right thing, but what you have for now is good.
>> 
>> No I think the right thing is to not call trace points from kexec code,
>> it's too fragile. TRACE_EVENT_CONDITION wouldn't have saved us from this
>> RCU breakage.
>
> I agree on the fragile part, though it appears to me that a 
> TRACE_EVENT_CONDITION() with a check for is_kexec (that needs to be 
> added) will prevent breakage since both the LOCKDEP block as well as the 
> tracepoint itself are guarded by the condition. So, none of the rcu code 
> should be executed as long as we set is_kexec at the right time.  

Yes you're right, I misread that.

So maybe that is an option. But it still makes me nervous :)

cheers
