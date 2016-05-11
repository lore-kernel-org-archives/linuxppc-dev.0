Return-Path: <rashmicy@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r4Snd2qHFzDqCm
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 May 2016 17:44:53 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id y7so3170416pfb.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 May 2016 00:44:53 -0700 (PDT)
Subject: Re: [PATCH] powerpc/tm: Clean up duplication of code
To: Balbir Singh <bsingharora@gmail.com>, linuxppc-dev@lists.ozlabs.org
References: <1462942500-30188-1-git-send-email-rashmicy@gmail.com>
 <a3fd1cda-2462-1424-1ec0-bd4da23eb4f6@gmail.com>
From: Rashmica <rashmicy@gmail.com>
Message-ID: <5732E2EC.5080403@gmail.com>
Date: Wed, 11 May 2016 17:44:44 +1000
MIME-Version: 1.0
In-Reply-To: <a3fd1cda-2462-1424-1ec0-bd4da23eb4f6@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 11/05/16 15:03, Balbir Singh wrote:
>
> On 11/05/16 14:55, Rashmica Gupta wrote:
>> The same logic for tm_abort appears twice, so pull it out into a
>> function.
>>
>> Signed-off-by: Rashmica Gupta <rashmicy@gmail.com>
>> ---
>>   arch/powerpc/mm/hash_utils_64.c | 47 ++++++++++++++++++-----------------------
>>   1 file changed, 21 insertions(+), 26 deletions(-)
>>
>> diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
>> index 7635b1c6b5da..1cef8f5aee9b 100644
>> --- a/arch/powerpc/mm/hash_utils_64.c
>> +++ b/arch/powerpc/mm/hash_utils_64.c
>> @@ -1318,6 +1318,25 @@ out_exit:
>>   	local_irq_restore(flags);
>>   }
>>   
>> +#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
>> +	/* Transactions are not aborted by tlbiel, only tlbie.
>> +	 * Without, syncing a page back to a block device w/ PIO could pick up
>> +	 * transactional data (bad!) so we force an abort here.  Before the
>> +	 * sync the page will be made read-only, which will flush_hash_page.
>> +	 * BIG ISSUE here: if the kernel uses a page from userspace without
>> +	 * unmapping it first, it may see the speculated version.
>> +	 */
>> +static inline void abort_tm(int local)
>> +{
>> +	if (local && cpu_has_feature(CPU_FTR_TM) &&
>> +	    current->thread.regs &&
>> +	    MSR_TM_ACTIVE(current->thread.regs->msr)) {
>> +		tm_enable();
>> +		tm_abort(TM_CAUSE_TLBI);
>> +	}
>> +}
> While your at this do
>
> #else
>
> static inline void abort_tm(int local)
> {
> }
If I'm doing that, wouldn't it make more sense to write:

+static inline void abort_tm(int local)
+{
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+	if (local && cpu_has_feature(CPU_FTR_TM) &&
+	    current->thread.regs &&
+	    MSR_TM_ACTIVE(current->thread.regs->msr)) {
+		tm_enable();
+		tm_abort(TM_CAUSE_TLBI);
+	}
+#endif
+}


>> +#endif
>> +
>>   /* WARNING: This is called from hash_low_64.S, if you change this prototype,
>>    *          do not forget to update the assembly call site !
>>    */
>> @@ -1344,19 +1363,7 @@ void flush_hash_page(unsigned long vpn, real_pte_t pte, int psize, int ssize,
>>   	} pte_iterate_hashed_end();
>>   
>>   #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
> Then remove these extra #ifdef
>> -	/* Transactions are not aborted by tlbiel, only tlbie.
>> -	 * Without, syncing a page back to a block device w/ PIO could pick up
>> -	 * transactional data (bad!) so we force an abort here.  Before the
>> -	 * sync the page will be made read-only, which will flush_hash_page.
>> -	 * BIG ISSUE here: if the kernel uses a page from userspace without
>> -	 * unmapping it first, it may see the speculated version.
>> -	 */
>> -	if (local && cpu_has_feature(CPU_FTR_TM) &&
>> -	    current->thread.regs &&
>> -	    MSR_TM_ACTIVE(current->thread.regs->msr)) {
>> -		tm_enable();
>> -		tm_abort(TM_CAUSE_TLBI);
>> -	}
>> +	abort_tm(local);
>>   #endif
>>   }
>>   
>> @@ -1415,19 +1422,7 @@ void flush_hash_hugepage(unsigned long vsid, unsigned long addr,
>>   	}
>>   tm_abort:
>>   #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
> Then remove these extra #ifdef
>> -	/* Transactions are not aborted by tlbiel, only tlbie.
>> -	 * Without, syncing a page back to a block device w/ PIO could pick up
>> -	 * transactional data (bad!) so we force an abort here.  Before the
>> -	 * sync the page will be made read-only, which will flush_hash_page.
>> -	 * BIG ISSUE here: if the kernel uses a page from userspace without
>> -	 * unmapping it first, it may see the speculated version.
>> -	 */
>> -	if (local && cpu_has_feature(CPU_FTR_TM) &&
>> -	    current->thread.regs &&
>> -	    MSR_TM_ACTIVE(current->thread.regs->msr)) {
>> -		tm_enable();
>> -		tm_abort(TM_CAUSE_TLBI);
>> -	}
>> +	abort_tm(local);
>>   #endif
>>   	return;
>>   }
>>
