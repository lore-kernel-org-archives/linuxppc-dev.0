Return-Path: <hemant@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6DA211A00B5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2015 14:03:35 +1000 (AEST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hemant@linux.vnet.ibm.com>;
 Thu, 21 May 2015 09:33:33 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 766E3394006E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2015 09:33:29 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4L43Spm41156792
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2015 09:33:28 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4L3M5oQ013031
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2015 08:52:07 +0530
Message-ID: <555D5902.1070300@linux.vnet.ibm.com>
Date: Thu, 21 May 2015 09:33:14 +0530
From: Hemant Kumar <hemant@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
CC: maddy@linux.vnet.ibm.com, srikar@linux.vnet.ibm.com, peterz@infradead.org,
 linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org, agraf@suse.de,
 mingo@redhat.com, paulus@samba.org, acme@kernel.org,
 warrier@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 1/2] perf/kvm: Port perf kvm to powerpc
References: <1431047266-6206-1-git-send-email-hemant@linux.vnet.ibm.com>
 <1431382120.16357.471.camel@freescale.com>
 <555224A4.5050502@linux.vnet.ibm.com> <1431487345.3868.2.camel@freescale.com>
In-Reply-To: <1431487345.3868.2.camel@freescale.com>
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

On 05/13/2015 08:52 AM, Scott Wood wrote:
> On Tue, 2015-05-12 at 21:34 +0530, Hemant Kumar wrote:
>> Hi Scott,
>>
>> On 05/12/2015 03:38 AM, Scott Wood wrote:
>>> On Fri, 2015-05-08 at 06:37 +0530, Hemant Kumar wrote:
>>>> diff --git a/arch/powerpc/include/uapi/asm/kvm_perf.h b/arch/powerpc/include/uapi/asm/kvm_perf.h
>>>> new file mode 100644
>>>> index 0000000..30fa670
>>>> --- /dev/null
>>>> +++ b/arch/powerpc/include/uapi/asm/kvm_perf.h
>>>> @@ -0,0 +1,15 @@
>>>> +#ifndef _ASM_POWERPC_KVM_PERF_H
>>>> +#define _ASM_POWERPC_KVM_PERF_H
>>>> +
>>>> +#include <asm/trace_book3s.h>
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
>>>> +#endif /* _ASM_POWERPC_KVM_PERF_H */
>>> Please make sure that anything book3s-specific is named that way.
>> Are you suggesting to name it to something like _ASM_POWERPC_BOOK3S_PERF_H ?
> My concern is seeing a generically named "kvm_perf.h" include a file
> called "trace_book3s.h" which defines "kvm_trace_symbol_hcall" with
> presumably book3s-specific content, as well as wondering how much of the
> rest of the file would be applicable if booke PPC were to implement perf
> kvm.
>
> I don't know enough about perf kvm to answer that question, but I've
> seen enough cases of book3s or pseries specific code that was apparently
> written with the belief that no other ppc64 implementations exist, or
> that no other ppc implementations would want to implement a certain
> feature, to be suspicous.  Usually such cases can be dealt with after
> the fact (albeit not as easily as if things were organized/namespaced
> properly from the beginning), but this is uapi...
>
> -Scott
>
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

Tried to address your comments in v4 :
http://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg89490.html
and
http://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg89485.html

-- 
Thanks,
Hemant Kumar
