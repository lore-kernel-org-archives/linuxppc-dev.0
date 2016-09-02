Return-Path: <rui.teng@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sQNw22s7TzDrht
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Sep 2016 12:52:49 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u822h02w129877
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Sep 2016 22:52:46 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 256bg7w00p-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Sep 2016 22:52:46 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <rui.teng@linux.vnet.ibm.com>;
 Thu, 1 Sep 2016 20:52:45 -0600
Subject: Re: [PATCH] powerpc: Clean up tm_abort duplication in hash_utils_64.c
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
References: <1472183410-18522-1-git-send-email-rui.teng@linux.vnet.ibm.com>
 <17335881.L5K12VaGEe@hactar>
Cc: linux-kernel@vger.kernel.org, paulus@samba.org
From: Rui Teng <rui.teng@linux.vnet.ibm.com>
Date: Fri, 2 Sep 2016 10:52:38 +0800
MIME-Version: 1.0
In-Reply-To: <17335881.L5K12VaGEe@hactar>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <6642c870-763d-c896-aab4-a1bc36bb9015@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 9/1/16 11:46 PM, Thiago Jung Bauermann wrote:
> Am Freitag, 26 August 2016, 11:50:10 schrieb Rui Teng:
>> The same logic appears twice and should probably be pulled out into a
>> function.
>>
>> Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
>> Signed-off-by: Rui Teng <rui.teng@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/mm/hash_utils_64.c | 45
>> +++++++++++++++++------------------------ 1 file changed, 19
>> insertions(+), 26 deletions(-)
>>
>> diff --git a/arch/powerpc/mm/hash_utils_64.c
>> b/arch/powerpc/mm/hash_utils_64.c index 0821556..69ef702 100644
>> --- a/arch/powerpc/mm/hash_utils_64.c
>> +++ b/arch/powerpc/mm/hash_utils_64.c
>> @@ -1460,6 +1460,23 @@ out_exit:
>>  	local_irq_restore(flags);
>>  }
>>
>> +/*
>> + * Transactions are not aborted by tlbiel, only tlbie.
>> + * Without, syncing a page back to a block device w/ PIO could pick up
>> + * transactional data (bad!) so we force an abort here.  Before the
>> + * sync the page will be made read-only, which will flush_hash_page.
>> + * BIG ISSUE here: if the kernel uses a page from userspace without
>> + * unmapping it first, it may see the speculated version.
>> + */
>> +void local_tm_abort(int local)
>> +{
>> +	if (local && cpu_has_feature(CPU_FTR_TM) && current->thread.regs &&
>> +		MSR_TM_ACTIVE(current->thread.regs->msr)) {
>> +		tm_enable();
>> +		tm_abort(TM_CAUSE_TLBI);
>> +	}
>> +}
>> +
>
> Since local_tm_abort is only used in this file, it should be static.
OK
>
> Also, since both places calling it are guarded by
> CONFIG_PPC_TRANSACTIONAL_MEM, wouldn't it be cleaner if the #ifdef was here
> instead and the #else block defined an empty static inline function? Then
> the call sites wouldn't need to be guarded.
I have considered this style before, but I am worried about the call
stacks increased by empty function and forgot the inline function.
Will send v2 with your comments.

Thanks!

>
