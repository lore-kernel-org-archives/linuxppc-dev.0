Return-Path: <hbathini@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tVX1H2TwkzDvyZ
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Dec 2016 22:26:59 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uB2BOnpv007869
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 2 Dec 2016 06:26:57 -0500
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [125.16.236.7])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2737vtgj0a-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Dec 2016 06:26:56 -0500
Received: from localhost
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Fri, 2 Dec 2016 16:56:53 +0530
Received: from d28relay09.in.ibm.com (d28relay09.in.ibm.com [9.184.220.160])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 94A623940064
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Dec 2016 16:56:49 +0530 (IST)
Received: from d28av06.in.ibm.com (d28av06.in.ibm.com [9.184.220.48])
 by d28relay09.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uB2BQn2512517614
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 2 Dec 2016 16:56:49 +0530
Received: from d28av06.in.ibm.com (localhost [127.0.0.1])
 by d28av06.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uB2BQmfT008965
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 2 Dec 2016 16:56:49 +0530
Subject: Re: [PATCH v2 2/5] ia64: reuse append_elf_note() and final_note()
 functions
To: Dave Young <dyoung@redhat.com>
References: <148007477669.1053.4107773905913128028.stgit@hbathini.in.ibm.com>
 <148007484315.1053.12317233313990302812.stgit@hbathini.in.ibm.com>
 <20161201045653.GA13670@dhcp-128-65.nay.redhat.com>
Cc: linux-kernel@vger.kernel.org, fenghua.yu@intel.com, tony.luck@intel.com,
 linux-ia64@vger.kernel.org, kexec@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, ebiederm@xmission.com,
 Michael Ellerman <mpe@ellerman.id.au>, vgoyal@redhat.com
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Fri, 2 Dec 2016 16:56:48 +0530
MIME-Version: 1.0
In-Reply-To: <20161201045653.GA13670@dhcp-128-65.nay.redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <fe3784de-a68b-5d6e-a9ab-f77a7da781a8@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Dave,


Thanks for the review.


On Thursday 01 December 2016 10:26 AM, Dave Young wrote:
> Hi Hari
>
> Personally I like V1 more, but split the patch 2 is easier for ia64
> people to reivew.  I did basic x86 testing, it runs ok.
>
> On 11/25/16 at 05:24pm, Hari Bathini wrote:
>> Get rid of multiple definitions of append_elf_note() & final_note()
>> functions. Reuse these functions compiled under CONFIG_CRASH_CORE.
>>
>> Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
>> ---
>>   arch/ia64/kernel/crash.c   |   22 ----------------------
>>   include/linux/crash_core.h |    4 ++++
>>   kernel/crash_core.c        |    6 +++---
>>   kernel/kexec_core.c        |   28 ----------------------------
>>   4 files changed, 7 insertions(+), 53 deletions(-)
>>
>> diff --git a/arch/ia64/kernel/crash.c b/arch/ia64/kernel/crash.c
>> index 2955f35..75859a0 100644
>> --- a/arch/ia64/kernel/crash.c
>> +++ b/arch/ia64/kernel/crash.c
>> @@ -27,28 +27,6 @@ static int kdump_freeze_monarch;
>>   static int kdump_on_init = 1;
>>   static int kdump_on_fatal_mca = 1;
>>   
>> -static inline Elf64_Word
>> -*append_elf_note(Elf64_Word *buf, char *name, unsigned type, void *data,
>> -		size_t data_len)
>> -{
>> -	struct elf_note *note = (struct elf_note *)buf;
>> -	note->n_namesz = strlen(name) + 1;
>> -	note->n_descsz = data_len;
>> -	note->n_type   = type;
>> -	buf += (sizeof(*note) + 3)/4;
>> -	memcpy(buf, name, note->n_namesz);
>> -	buf += (note->n_namesz + 3)/4;
>> -	memcpy(buf, data, data_len);
>> -	buf += (data_len + 3)/4;
>> -	return buf;
>> -}
>> -
>> -static void
>> -final_note(void *buf)
>> -{
>> -	memset(buf, 0, sizeof(struct elf_note));
>> -}
>> -
> The above IA64 version looks better than the functions in kexec_core.c
> about the Elf64_Word type usage and the simpler final_note function.

Hmmm.. Is void* better over Elf64_Word* to be agnostic of Elf32 or Elf64 
type?


> Care to update crash_core.c to use this instead?

Sure. Will resend.

Thanks
Hari
