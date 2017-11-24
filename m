Return-Path: <srs0=luew=cw=gmail.com=bsingharora@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yjjV32xdjzDr8h
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Nov 2017 15:13:15 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3yjjV32XJTz8tCD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Nov 2017 15:13:15 +1100 (AEDT)
Received: from mail-ua0-x244.google.com (mail-ua0-x244.google.com
 [IPv6:2607:f8b0:400c:c08::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3yjjV25Mtgz9s3w
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Nov 2017 15:13:14 +1100 (AEDT)
Received: by mail-ua0-x244.google.com with SMTP id f14so13956609uaa.5
 for <linuxppc-dev@ozlabs.org>; Thu, 23 Nov 2017 20:13:14 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1511442295.rqmndvaowx.naveen@linux.ibm.com>
References: <151137178794.14123.18003389448303728066.stgit@jupiter.in.ibm.com>
 <CAKTCnzkSJo0wKx96=N2fxDVZ8KaM+uT3sUHGNgtdOD=RLajwCg@mail.gmail.com>
 <8737552nta.fsf@concordia.ellerman.id.au>
 <1511442295.rqmndvaowx.naveen@linux.ibm.com>
From: Balbir Singh <bsingharora@gmail.com>
Date: Fri, 24 Nov 2017 15:13:11 +1100
Message-ID: <CAKTCnz=yeLLFWzpVr6ZzRiSe7ggPJabA6Od6msXL2PP-+48GiA@mail.gmail.com>
Subject: Re: [PATCH] powernv: Avoid calling trace tlbie in kexec path.
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Nov 24, 2017 at 12:11 AM, Naveen N. Rao
<naveen.n.rao@linux.vnet.ibm.com> wrote:
> Michael Ellerman wrote:
>>
>> Balbir Singh <bsingharora@gmail.com> writes:
>>
>>> On Thu, Nov 23, 2017 at 4:32 AM, Mahesh J Salgaonkar
>>> <mahesh@linux.vnet.ibm.com> wrote:
>>>>
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
>>
>> Yes I added:
>>
>> Fixes: 0428491cba92 ("powerpc/mm: Trace tlbie(l) instructions")
>> Cc: stable@vger.kernel.org # v4.13+
>>
>>> I think the right thing in the longer run might be to do a
>>> TRACE_EVENT_CONDITION
>>> and have the condition do the right thing, but what you have for now is
>>> good.
>>
>>
>> No I think the right thing is to not call trace points from kexec code,
>> it's too fragile. TRACE_EVENT_CONDITION wouldn't have saved us from this
>> RCU breakage.
>
>
> I agree on the fragile part, though it appears to me that a
> TRACE_EVENT_CONDITION() with a check for is_kexec (that needs to be added)
> will prevent breakage since both the LOCKDEP block as well as the tracepoint
> itself are guarded by the condition. So, none of the rcu code should be
> executed as long as we set is_kexec at the right time.  However, since there
> are all of 1 tracepoint(s) affecting kexec, it is probably not worth the
> effort at the moment.
>

+1, I am good with this change for now. I agree that we should not
call trace points
from kexec code, the tracepoint was for other paths, but we should
definitely avoid
this path.

Mahesh, is this path specific to hash or do we have similar issues in radix?

Balbir Singh.
