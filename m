Return-Path: <hemant@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 382891A1A3B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2015 20:37:43 +1000 (AEST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hemant@linux.vnet.ibm.com>;
 Wed, 29 Jul 2015 16:07:41 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id C56433940076
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2015 16:07:36 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6TAbGvJ28770480
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2015 16:07:16 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6TAbEPr002457
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2015 16:07:15 +0530
Message-ID: <55B8ACD9.8090404@linux.vnet.ibm.com>
Date: Wed, 29 Jul 2015 16:07:13 +0530
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
In-Reply-To: <1437077417.2993.108.camel@freescale.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Scott,

On 07/17/2015 01:40 AM, Scott Wood wrote:
> On Thu, 2015-07-16 at 21:18 +0530, Hemant Kumar wrote:
>> To analyze the exit events with perf, we need kvm_perf.h to be added in
>> the arch/powerpc directory, where the kvm tracepoints needed to trace
>> the KVM exit events are defined.
>>
>> This patch adds "kvm_perf_book3s.h" to indicate that the tracepoints are
>> book3s specific. Generic "kvm_perf.h" then can just include
>> "kvm_perf_book3s.h".
>>
>> Signed-off-by: Hemant Kumar <hemant@linux.vnet.ibm.com>
>> ---
>> Changes:
>> - Not exporting the exit reasons compared to previous patchset (suggested
>> by Paul)
>>
>>   arch/powerpc/include/uapi/asm/kvm_perf.h        |  6 ++++++
>>   arch/powerpc/include/uapi/asm/kvm_perf_book3s.h | 14 ++++++++++++++
>>   2 files changed, 20 insertions(+)
>>   create mode 100644 arch/powerpc/include/uapi/asm/kvm_perf.h
>>   create mode 100644 arch/powerpc/include/uapi/asm/kvm_perf_book3s.h
>>
>> diff --git a/arch/powerpc/include/uapi/asm/kvm_perf.h
>> b/arch/powerpc/include/uapi/asm/kvm_perf.h
>> new file mode 100644
>> index 0000000..5ed2ff3
>> --- /dev/null
>> +++ b/arch/powerpc/include/uapi/asm/kvm_perf.h
>> @@ -0,0 +1,6 @@
>> +#ifndef _ASM_POWERPC_KVM_PERF_H
>> +#define _ASM_POWERPC_KVM_PERF_H
>> +
>> +#include <asm/kvm_perf_book3s.h>
>> +
>> +#endif
>> diff --git a/arch/powerpc/include/uapi/asm/kvm_perf_book3s.h
>> b/arch/powerpc/include/uapi/asm/kvm_perf_book3s.h
>> new file mode 100644
>> index 0000000..8c8d8c2
>> --- /dev/null
>> +++ b/arch/powerpc/include/uapi/asm/kvm_perf_book3s.h
>> @@ -0,0 +1,14 @@
>> +#ifndef _ASM_POWERPC_KVM_PERF_BOOK3S_H
>> +#define _ASM_POWERPC_KVM_PERF_BOOK3S_H
>> +
>> +#include <asm/kvm.h>
>> +
>> +#define DECODE_STR_LEN 20
>> +
>> +#define VCPU_ID "vcpu_id"
>> +
>> +#define KVM_ENTRY_TRACE "kvm_hv:kvm_guest_enter"
>> +#define KVM_EXIT_TRACE "kvm_hv:kvm_guest_exit"
>> +#define KVM_EXIT_REASON "trap"
>> +
>> +#endif /* _ASM_POWERPC_KVM_PERF_BOOK3S_H */
> Again, why is book3s stuff being presented via uapi as generic
> <asm/kvm_perf.h> with generic symbol names?
>
> -Scott

Ok.

We can change the KVM_ENTRY_TRACE macro to something like
KVM_BOOK3S_ENTRY_TRACE and likewise for KVM_EXIT_TRACE
and KVM_EXIT_REASON and then, to resolve the issue of generic
macro names in the userspace side, we can handle it using __weak
modifier.

What would you suggest?

> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

-- 
Thanks,
Hemant Kumar
