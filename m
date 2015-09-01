Return-Path: <hemant@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6E41C1A06F9
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Sep 2015 16:48:59 +1000 (AEST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hemant@linux.vnet.ibm.com>;
 Tue, 1 Sep 2015 12:18:56 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 267DDE0024
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Sep 2015 12:18:11 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t816mqmM14549102
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Sep 2015 12:18:53 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t816mnTO029680
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Sep 2015 12:18:52 +0530
Message-ID: <55E54A4F.6090205@linux.vnet.ibm.com>
Date: Tue, 01 Sep 2015 12:18:47 +0530
From: Hemant Kumar <hemant@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Arnaldo Carvalho de Melo <acme@kernel.org>
CC: maddy@linux.vnet.ibm.com, srikar@linux.vnet.ibm.com,
 linux-kernel@vger.kernel.org, warrier@linux.vnet.ibm.com,
 paulus@samba.org, scottwood@freescale.com, sukadev@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, mingo@kernel.org,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v6 1/2] perf,kvm/powerpc: Add kvm_perf.h for powerpc
References: <1441003681-10259-1-git-send-email-hemant@linux.vnet.ibm.com>
 <20150831201300.GG4423@kernel.org>
In-Reply-To: <20150831201300.GG4423@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

(cc'ing Michael Ellerman with this reply)

Hi Arnaldo,

On 09/01/2015 01:43 AM, Arnaldo Carvalho de Melo wrote:
> Em Mon, Aug 31, 2015 at 12:18:00PM +0530, Hemant Kumar escreveu:
>> To analyze the exit events with perf, we need to export the related
>> tracepoints through kvm_perf.h. kvm_perf.h is to be added in the
>> arch/powerpc directory, where the kvm tracepoints needed to trace the
>> KVM exit events are defined.
>>
>> To indicate that the tracepoints are book3s_hv specific, suffix _HV has
>> been added to the tracepoint macros. Additionally, we also need to
>> define the generic macros (albeit, with null strings) suffix, because
>> the preprocessor looks for them in the generic code in builtin-kvm.c.
>>
>> Signed-off-by: Hemant Kumar <hemant@linux.vnet.ibm.com>
> humm, there are two patchkits, this one with two patches, the other with
> 3, this one for the kernel, the other one for tools/, but for the tools/
> part to work, does this one needs to be applied first?
>
> Should I try to process the 5 together, applying thest two first?

Yes, this patchset needs to be applied before applying the other patchset,
since there is a direct dependency on these two for the tooling part to
work.

> I see there are no acks from powerpc arch maintainers, how should we
> proceed here? If there are no problems with the arch bits, and if it is
> just to enable the tooling part, again, should I process the 5 as just
> one series?

The reason to split the earlier patchset into two was to separate the
tooling/perf/ and arch/powerpc/ side patches, as asked by Michael..

Here is the link to that discussion :
http://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg86916.html

If Michael is ok with the patches, you can process all the 5 patches 
together. Michael?


> - Arnaldo
>
>> ---
>> Changes since v5:
>> - Moved back the tracepoint definitions from kvm_perf_book3s.h to kvm_perf.h
>>
>>   arch/powerpc/include/uapi/asm/kvm_perf.h | 21 +++++++++++++++++++++
>>   1 file changed, 21 insertions(+)
>>   create mode 100644 arch/powerpc/include/uapi/asm/kvm_perf.h
>>
>> diff --git a/arch/powerpc/include/uapi/asm/kvm_perf.h b/arch/powerpc/include/uapi/asm/kvm_perf.h
>> new file mode 100644
>> index 0000000..68f105e
>> --- /dev/null
>> +++ b/arch/powerpc/include/uapi/asm/kvm_perf.h
>> @@ -0,0 +1,21 @@
>> +#ifndef _ASM_POWERPC_KVM_PERF_H
>> +#define _ASM_POWERPC_KVM_PERF_H
>> +
>> +#include <asm/kvm.h>
>> +
>> +#define DECODE_STR_LEN 40
>> +
>> +#define VCPU_ID "vcpu_id"
>> +
>> +/* For Book3S_HV machines */
>> +#define KVM_ENTRY_TRACE_HV "kvm_hv:kvm_guest_enter"
>> +#define KVM_EXIT_TRACE_HV "kvm_hv:kvm_guest_exit"
>> +#define KVM_EXIT_REASON_HV "trap"
>> +
>> +/* This is to shut the compiler up */
>> +#define KVM_ENTRY_TRACE ""
>> +#define KVM_EXIT_TRACE ""
>> +#define KVM_EXIT_REASON ""
>> +
>> +
>> +#endif /* _ASM_POWERPC_KVM_PERF_H */
>> -- 
>> 1.9.3
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

-- 
Thanks,
Hemant Kumar
