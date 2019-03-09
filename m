Return-Path: <SRS0=JAc6=RM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E29AC43381
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 Mar 2019 12:52:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D954B20836
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 Mar 2019 12:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="WujHpPdx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D954B20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44GklZ4KD0zDqGZ
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 Mar 2019 23:51:54 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Gkj65zTGzDq6N
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Mar 2019 23:49:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="WujHpPdx"; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 44Gkj61frpz8tPx
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Mar 2019 23:49:46 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 44Gkj60Nw7z9s70; Sat,  9 Mar 2019 23:49:46 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="WujHpPdx"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 44Gkj30X9Xz9s71
 for <linuxppc-dev@ozlabs.org>; Sat,  9 Mar 2019 23:49:41 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44Gkhv4y4zz9vRZk;
 Sat,  9 Mar 2019 13:49:35 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=WujHpPdx; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id SMLMKhzvKavW; Sat,  9 Mar 2019 13:49:35 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44Gkhv3j6Wz9vRZj;
 Sat,  9 Mar 2019 13:49:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1552135775; bh=AaNWkZW4ECHnz0Z8otSqEAsnWULXLIJaJlvb9cP2WTk=;
 h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
 b=WujHpPdxR+arhhL25rv6oVdz3inLHc1430+QTwBvZkZMord7/eshxtrOIc9rwwwY5
 /F9LPb4vNvLIJ1xWEsOaIKZQAJxnL928KsSwuF4s0jMxjVP/5CE5wSD0E7TZTctMGp
 jEhyZy4lGXtmNHoDudqVvSJuks8e9m+4iH2ETRvg=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id C82F58BFBC;
 Sat,  9 Mar 2019 13:49:36 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id xexg7uXxzVaI; Sat,  9 Mar 2019 13:49:36 +0100 (CET)
Received: from [192.168.232.53] (unknown [192.168.232.53])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 605718B806;
 Sat,  9 Mar 2019 13:49:36 +0100 (CET)
Subject: Re: [PATCH v5 10/10] powerpc/mm: Detect bad KUAP faults
From: christophe leroy <christophe.leroy@c-s.fr>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
References: <20190308011619.22402-1-mpe@ellerman.id.au>
 <20190308011619.22402-10-mpe@ellerman.id.au>
 <f1332a90-4404-8226-baae-f586c3f21fbb@c-s.fr>
Message-ID: <8d24e5eb-7313-73d3-fd25-ec9e73e7abfc@c-s.fr>
Date: Sat, 9 Mar 2019 13:49:31 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <f1332a90-4404-8226-baae-f586c3f21fbb@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Antivirus: Avast (VPS 190309-0, 09/03/2019), Outbound message
X-Antivirus-Status: Clean
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 08/03/2019 à 09:53, Christophe Leroy a écrit :
> 
> 
> Le 08/03/2019 à 02:16, Michael Ellerman a écrit :
>> When KUAP is enabled we have logic to detect page faults that occur
>> outside of a valid user access region and are blocked by the AMR.
>>
>> What we don't have at the moment is logic to detect a fault *within* a
>> valid user access region, that has been incorrectly blocked by AMR.
>> This is not meant to ever happen, but it can if we incorrectly
>> save/restore the AMR, or if the AMR was overwritten for some other
>> reason.
>>
>> Currently if that happens we assume it's just a regular fault that
>> will be corrected by handling the fault normally, so we just return.
>> But there is nothing the fault handling code can do to fix it, so the
>> fault just happens again and we spin forever, leading to soft lockups.
>>
>> So add some logic to detect that case and WARN() if we ever see it.
>> Arguably it should be a BUG(), but it's more polite to fail the access
>> and let the kernel continue, rather than taking down the box. There
>> should be no data integrity issue with failing the fault rather than
>> BUG'ing, as we're just going to disallow an access that should have
>> been allowed.
>>
>> To make the code a little easier to follow, unroll the condition at
>> the end of bad_kernel_fault() and comment each case, before adding the
>> call to bad_kuap_fault().
>>
>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>> ---
>>
>> v5: New.
>>
>>   .../powerpc/include/asm/book3s/64/kup-radix.h | 12 +++++++++
>>   arch/powerpc/include/asm/kup.h                |  1 +
>>   arch/powerpc/mm/fault.c                       | 25 ++++++++++++++++---
>>   3 files changed, 35 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/book3s/64/kup-radix.h 
>> b/arch/powerpc/include/asm/book3s/64/kup-radix.h
>> index 3d60b04fc3f6..8d2ddc61e92e 100644
>> --- a/arch/powerpc/include/asm/book3s/64/kup-radix.h
>> +++ b/arch/powerpc/include/asm/book3s/64/kup-radix.h
>> @@ -100,6 +100,18 @@ static inline void prevent_user_access(void 
>> __user *to, const void __user *from,
>>       set_kuap(AMR_KUAP_BLOCKED);
>>   }
>> +static inline bool bad_kuap_fault(struct pt_regs *regs, bool is_write)
>> +{
>> +    if (mmu_has_feature(MMU_FTR_RADIX_KUAP) &&
>> +        ((is_write && (regs->kuap & AMR_KUAP_BLOCK_WRITE)) ||
>> +         (!is_write && (regs->kuap & AMR_KUAP_BLOCK_READ))))
>> +    {
> 
> Should this { go on the previous line ?
> 
>> +        WARN(true, "Bug: %s fault blocked by AMR!", is_write ? 
>> "Write" : "Read");
>> +        return true;
> 
> Could just be
>      return WARN(true, ....)
> 
> Or even
>      return WARN(mmu_has_feature(MMU_FTR_RADIX_KUAP) &&
>          ((is_write && (regs->kuap & AMR_KUAP_BLOCK_WRITE)) ||
>           (!is_write && (regs->kuap & AMR_KUAP_BLOCK_READ))), ...);

Could also be simplified as follows since (is_write && ...) and 
(!is_write && ...) are mutually exclusive:

mmu_has_feature(MMU_FTR_RADIX_KUAP) &&
(regs->kuap & (is_write ? AMR_KUAP_BLOCK_WRITE : AMR_KUAP_BLOCK_READ))

Christophe

> 
>> +    }
>> +
>> +    return false;
>> +}
>>   #endif /* CONFIG_PPC_KUAP */
>>   #endif /* __ASSEMBLY__ */
>> diff --git a/arch/powerpc/include/asm/kup.h 
>> b/arch/powerpc/include/asm/kup.h
>> index f79d4d970852..ccbd2a249575 100644
>> --- a/arch/powerpc/include/asm/kup.h
>> +++ b/arch/powerpc/include/asm/kup.h
>> @@ -28,6 +28,7 @@ static inline void prevent_user_access(void __user 
>> *to, const void __user *from,
>>                          unsigned long size) { }
>>   static inline void allow_read_from_user(const void __user *from, 
>> unsigned long size) {}
>>   static inline void allow_write_to_user(void __user *to, unsigned 
>> long size) {}
>> +static inline bool bad_kuap_fault(struct pt_regs *regs, bool 
>> is_write) { return false; }
>>   #endif /* CONFIG_PPC_KUAP */
>>   static inline void prevent_read_from_user(const void __user *from, 
>> unsigned long size)
>> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
>> index 463d1e9d026e..b5d3578d9f65 100644
>> --- a/arch/powerpc/mm/fault.c
>> +++ b/arch/powerpc/mm/fault.c
>> @@ -44,6 +44,7 @@
>>   #include <asm/mmu_context.h>
>>   #include <asm/siginfo.h>
>>   #include <asm/debug.h>
>> +#include <asm/kup.h>
>>   static inline bool notify_page_fault(struct pt_regs *regs)
>>   {
>> @@ -224,7 +225,7 @@ static int mm_fault_error(struct pt_regs *regs, 
>> unsigned long addr,
>>   /* Is this a bad kernel fault ? */
>>   static bool bad_kernel_fault(struct pt_regs *regs, unsigned long 
>> error_code,
>> -                 unsigned long address)
>> +                 unsigned long address, bool is_write)
> 
> We have regs, do we need is_write in addition ?
> 
> Christophe
> 
>>   {
>>       int is_exec = TRAP(regs) == 0x400;
>> @@ -235,6 +236,9 @@ static bool bad_kernel_fault(struct pt_regs *regs, 
>> unsigned long error_code,
>>                       address >= TASK_SIZE ? "exec-protected" : "user",
>>                       address,
>>                       from_kuid(&init_user_ns, current_uid()));
>> +
>> +        // Kernel exec fault is always bad
>> +        return true;
>>       }
>>       if (!is_exec && address < TASK_SIZE && (error_code & 
>> DSISR_PROTFAULT) &&
>> @@ -244,7 +248,22 @@ static bool bad_kernel_fault(struct pt_regs 
>> *regs, unsigned long error_code,
>>                       from_kuid(&init_user_ns, current_uid()));
>>       }
>> -    return is_exec || (address >= TASK_SIZE) || 
>> !search_exception_tables(regs->nip);
>> +    // Kernel fault on kernel address is bad
>> +    if (address >= TASK_SIZE)
>> +        return true;
>> +
>> +    // Fault on user outside of certain regions (eg. 
>> copy_tofrom_user()) is bad
>> +    if (!search_exception_tables(regs->nip))
>> +        return true;
>> +
>> +    // Read/write fault in a valid region (the exception table search 
>> passed
>> +    // above), but blocked by KUAP is bad, it can never succeed.
>> +    if (bad_kuap_fault(regs, is_write))
>> +        return true;
>> +
>> +    // What's left? Kernel fault on user in well defined regions 
>> (extable
>> +    // matched), and allowed by KUAP in the faulting context.
>> +    return false;
>>   }
>>   static bool bad_stack_expansion(struct pt_regs *regs, unsigned long 
>> address,
>> @@ -467,7 +486,7 @@ static int __do_page_fault(struct pt_regs *regs, 
>> unsigned long address,
>>        * take a page fault to a kernel address or a page fault to a user
>>        * address outside of dedicated places
>>        */
>> -    if (unlikely(!is_user && bad_kernel_fault(regs, error_code, 
>> address)))
>> +    if (unlikely(!is_user && bad_kernel_fault(regs, error_code, 
>> address, is_write)))
>>           return SIGSEGV;
>>       /*
>>

---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
https://www.avast.com/antivirus

