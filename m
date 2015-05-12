Return-Path: <hemant@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6A1CA1A0048
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2015 02:17:02 +1000 (AEST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hemant@linux.vnet.ibm.com>;
 Tue, 12 May 2015 21:46:59 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id C39F63940053
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 21:46:57 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4CGGt7V14745728
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 21:46:55 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4CGGswb025729
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 21:46:55 +0530
Message-ID: <55522774.5030400@linux.vnet.ibm.com>
Date: Tue, 12 May 2015 21:46:52 +0530
From: Hemant Kumar <hemant@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v3 3/3] kvm/powerpc: Export HCALL reason codes
References: <1431046385-5772-1-git-send-email-hemant@linux.vnet.ibm.com>
 <1431046385-5772-3-git-send-email-hemant@linux.vnet.ibm.com>
 <1431382467.16357.476.camel@freescale.com>
In-Reply-To: <1431382467.16357.476.camel@freescale.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: maddy@linux.vnet.ibm.com, srikar@linux.vnet.ibm.com, peterz@infradead.org,
 agraf@suse.de, kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org,
 mingo@redhat.com, paulus@samba.org, acme@kernel.org,
 warrier@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 05/12/2015 03:44 AM, Scott Wood wrote:
> On Fri, 2015-05-08 at 06:23 +0530, Hemant Kumar wrote:
>> For perf to analyze the KVM events like hcalls, we need the
>> hypervisor calls and their codes to be exported through uapi.
>>
>> This patch moves most of the pSeries hcall codes from
>> arch/powerpc/include/asm/hvcall.h to
>> arch/powerpc/include/uapi/asm/hcall_codes.h.
>> It also moves the mapping <hcall_code-to-hcall_reason> from
>> arch/powerpc/kvm/trace_hv.h to
>> arch/powerpc/include/uapi/asm/trace_hcall.h.
>>
>> Signed-off-by: Hemant Kumar <hemant@linux.vnet.ibm.com>
>> ---
>>   arch/powerpc/include/asm/hvcall.h           | 120 +--------------------------
>>   arch/powerpc/include/uapi/asm/hcall_codes.h | 123 ++++++++++++++++++++++++++++
>>   arch/powerpc/include/uapi/asm/trace_hcall.h | 122 +++++++++++++++++++++++++++
>>   arch/powerpc/kvm/trace_hv.h                 | 117 +-------------------------
> When moving to uapi please add proper namespacing to indicate that this
> is pseries specific.
>

Sure, will add that.

>> diff --git a/arch/powerpc/include/uapi/asm/trace_hcall.h b/arch/powerpc/include/uapi/asm/trace_hcall.h
>> new file mode 100644
>> index 0000000..00eac01
>> --- /dev/null
>> +++ b/arch/powerpc/include/uapi/asm/trace_hcall.h
>> @@ -0,0 +1,122 @@
>> +#ifndef _KVM_TRACE_HCALL_MAP_H
>> +#define _KVM_TRACE_HCALL_MAP_H
>> +
>> +#include "hcall_codes.h"
>> +
>> +#define kvm_trace_symbol_hcall\
>> +	{H_REMOVE,"H_REMOVE"},					\
>> +	{H_ENTER,"H_ENTER"},					\
>> +	{H_READ,"H_READ"},					\
>> +	{H_CLEAR_MOD,"H_CLEAR_MOD"},				\
> This is a rather odd way of exposing an array to userspace...
>

Didn't get you here. Can you please elaborate?

I see some other files like arch/x86/include/uapi/asm/vmx.h exposing the 
reasons in a similar way.

Thanks for the review.

-- 
Hemant Kumar
