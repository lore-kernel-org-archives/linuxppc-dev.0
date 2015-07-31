Return-Path: <hemant@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 51C491A03F4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2015 18:55:41 +1000 (AEST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hemant@linux.vnet.ibm.com>;
 Fri, 31 Jul 2015 14:25:38 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 299DB3940060
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2015 14:25:35 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6V8tRlv51249286
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2015 14:25:28 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6V8tQNr006034
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2015 14:25:27 +0530
Message-ID: <55BB37FE.3040002@linux.vnet.ibm.com>
Date: Fri, 31 Jul 2015 14:25:26 +0530
From: Hemant Kumar <hemant@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
CC: maddy@linux.vnet.ibm.com, srikar@linux.vnet.ibm.com,
 linux-kernel@vger.kernel.org, acme@kernel.org, paulus@samba.org,
 warrier@linux.vnet.ibm.com, sukadev@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, mingo@kernel.org
Subject: Re: [PATCH v5 1/2] perf,kvm/ppc: Add kvm_perf.h for powerpc
References: <1437061722-15438-1-git-send-email-hemant@linux.vnet.ibm.com>
 <1437077417.2993.108.camel@freescale.com>
 <55B8ACD9.8090404@linux.vnet.ibm.com>
 <1438208530.2993.350.camel@freescale.com>
In-Reply-To: <1438208530.2993.350.camel@freescale.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 07/30/2015 03:52 AM, Scott Wood wrote:
> On Wed, 2015-07-29 at 16:07 +0530, Hemant Kumar wrote:
>> Hi Scott,
>>
>> On 07/17/2015 01:40 AM, Scott Wood wrote:
>>> On Thu, 2015-07-16 at 21:18 +0530, Hemant Kumar wrote:
>>>> To analyze the exit events with perf, we need kvm_perf.h to be added in
>>>> the arch/powerpc directory, where the kvm tracepoints needed to trace
>>>> the KVM exit events are defined.
>>>>
>>>> This patch adds "kvm_perf_book3s.h" to indicate that the tracepoints are
>>>> book3s specific. Generic "kvm_perf.h" then can just include
>>>> "kvm_perf_book3s.h".
>>>>
>>>> Signed-off-by: Hemant Kumar <hemant@linux.vnet.ibm.com>
>>>> ---
>>>> Changes:
>>>> - Not exporting the exit reasons compared to previous patchset
>>>> (suggested
>>>> by Paul)
>>>>
>>>>    arch/powerpc/include/uapi/asm/kvm_perf.h        |  6 ++++++
>>>>    arch/powerpc/include/uapi/asm/kvm_perf_book3s.h | 14 ++++++++++++++
>>>>    2 files changed, 20 insertions(+)
>>>>    create mode 100644 arch/powerpc/include/uapi/asm/kvm_perf.h
>>>>    create mode 100644 arch/powerpc/include/uapi/asm/kvm_perf_book3s.h
>>>>
>>>> diff --git a/arch/powerpc/include/uapi/asm/kvm_perf.h
>>>> b/arch/powerpc/include/uapi/asm/kvm_perf.h
>>>> new file mode 100644
>>>> index 0000000..5ed2ff3
>>>> --- /dev/null
>>>> +++ b/arch/powerpc/include/uapi/asm/kvm_perf.h
>>>> @@ -0,0 +1,6 @@
>>>> +#ifndef _ASM_POWERPC_KVM_PERF_H
>>>> +#define _ASM_POWERPC_KVM_PERF_H
>>>> +
>>>> +#include <asm/kvm_perf_book3s.h>
>>>> +
>>>> +#endif
>>>> diff --git a/arch/powerpc/include/uapi/asm/kvm_perf_book3s.h
>>>> b/arch/powerpc/include/uapi/asm/kvm_perf_book3s.h
>>>> new file mode 100644
>>>> index 0000000..8c8d8c2
>>>> --- /dev/null
>>>> +++ b/arch/powerpc/include/uapi/asm/kvm_perf_book3s.h
>>>> @@ -0,0 +1,14 @@
>>>> +#ifndef _ASM_POWERPC_KVM_PERF_BOOK3S_H
>>>> +#define _ASM_POWERPC_KVM_PERF_BOOK3S_H
>>>> +
>>>> +#include <asm/kvm.h>
>>>> +
>>>> +#define DECODE_STR_LEN 20
>>>> +
>>>> +#define VCPU_ID "vcpu_id"
>>>> +
>>>> +#define KVM_ENTRY_TRACE "kvm_hv:kvm_guest_enter"
>>>> +#define KVM_EXIT_TRACE "kvm_hv:kvm_guest_exit"
>>>> +#define KVM_EXIT_REASON "trap"
>>>> +
>>>> +#endif /* _ASM_POWERPC_KVM_PERF_BOOK3S_H */
>>> Again, why is book3s stuff being presented via uapi as generic
>>> <asm/kvm_perf.h> with generic symbol names?
>>>
>>> -Scott
>> Ok.
>>
>> We can change the KVM_ENTRY_TRACE macro to something like
>> KVM_BOOK3S_ENTRY_TRACE and likewise for KVM_EXIT_TRACE
>> and KVM_EXIT_REASON
> What about DECODE_STR_LEN and VCPU_ID?

DECODE_STR_LEN can be common, we can give a big enough size to it, if
we need to.
And, VCPU_ID depends on the field in the tracepoint payload data which is
specific to that tracepoint. This field is used to maintain the per vcpu 
record
and this field gives us the vcpu id. So, yeah, I guess, since, I can't 
find any
such field as "vcpu_id" in the kvm_exit tracepoint for book3e, we have to
make this specific to book3s.

>
> Where is this API documented?
>
>>   and then, to resolve the issue of generic
>> macro names in the userspace side, we can handle it using __weak
>> modifier.
> Does userspace get built differently for book3s versus book3e?  For now it'd
>
> be fine for userspace to check for book3s and not use the feature if it's
>
> book3e.  If and when book3e gains this feature, then userspace can be changed.

Well, I couldn't find any way to build user space differently for book3s and
book3e.

How about keeping this as it is after modifying the tracepoint macro names
to book3s specific in the uapi? And as and when booke decides to implement
this feature, a runtime check for event availability can be added then, 
IMHO.

What do you think?

>> What would you suggest?
> Another option would be to explain this interface so that we can figure out
> if book3e would even want different values for these, and if not, move it to
> asm/kvm.h.

Here is my understanding of the interface. We need to add handlers for
"is_begin_event", "is_end_event" and "decode_key" for any event type
(for which we want to collect the stats).
The first two handlers check when the respective events started/ended
and hence, the time difference stats, event start/end time etc. is 
calculated
in these functions. To check if the event has started or ended, they make
use of the macros KVM_ENTRY_TRACE and KVM_EXIT_TRACE. These
macros are exported from the kernel as uapi. Atleast, that's how x86 and
s390 do it.
"decode_key" hanlder is used to find out the reason for
that event (in case of book3s, its "trap" field of kvm_hv:kvm_guest_exit
payload) in semantic terms. It maps an info of interest found in that
particular tracepoint's data to a name(string) through a
table kvm_trace_symbol_exit. All the events are then classified into groups
based on this info.

So, for an exit event in case of book3s, kvm_hv:kvm_guest_exit has a "trap"
field which tells us the reason for a thread to exit the guest context by
encoding the trap code. We can map this trap code to the strings through
kvm_trace_symbol_exit table and then classify all the exits into groups 
based
on this trap code.

-- 
Thanks,
Hemant Kumar
