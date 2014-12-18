Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 81FC11A084F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Dec 2014 18:05:15 +1100 (AEDT)
Message-ID: <54927CA7.4000907@c-s.fr>
Date: Thu, 18 Dec 2014 08:05:11 +0100
From: leroy christophe <christophe.leroy@c-s.fr>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [v2 PATCH 2/2] powerpc/8xx: use _PAGE_RO instead of _PAGE_RW
References: <20141217091432.072901A5E12@localhost.localdomain>
 <1418869363.5581.123.camel@freescale.com>
In-Reply-To: <1418869363.5581.123.camel@freescale.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Le 18/12/2014 03:22, Scott Wood a écrit :
> On Wed, 2014-12-17 at 10:14 +0100, Christophe Leroy wrote:
>> On powerpc 8xx, in TLB entries, 0x400 bit is set to 1 for read-only pages
>> and is set to 0 for RW pages. So we should use _PAGE_RO instead of _PAGE_RW
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>>
>> ---
>> v2 is a complete rework compared to v1
>>
>>   arch/powerpc/include/asm/pte-8xx.h | 7 +++----
>>   arch/powerpc/kernel/head_8xx.S     | 3 ---
>>   2 files changed, 3 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/pte-8xx.h b/arch/powerpc/include/asm/pte-8xx.h
>> index daa4616..4f5583e 100644
>> --- a/arch/powerpc/include/asm/pte-8xx.h
>> +++ b/arch/powerpc/include/asm/pte-8xx.h
>> @@ -46,7 +46,7 @@
>>    * require a TLB exception handler change.  It is assumed unused bits
>>    * are always zero.
>>    */
>> -#define _PAGE_RW	0x0400	/* lsb PP bits, inverted in HW */
>> +#define _PAGE_RO	0x0400	/* lsb PP bits */
> It looks like pte_update() needs to be updated to match.
>
>>   #define _PAGE_USER	0x0800	/* msb PP bits */
>>   /* set when neither _PAGE_USER nor _PAGE_RW are set */
> Also update this comment.
>
>>   #define _PAGE_KNLRO	0x0200
>> @@ -62,9 +62,8 @@
>>   #define PTE_ATOMIC_UPDATES	1
>>   
>>   /* We need to add _PAGE_SHARED to kernel pages */
>> -#define _PAGE_KERNEL_RO	(_PAGE_SHARED | _PAGE_KNLRO)
>> -#define _PAGE_KERNEL_ROX	(_PAGE_EXEC | _PAGE_KNLRO)
>> -#define _PAGE_KERNEL_RW	(_PAGE_DIRTY | _PAGE_RW | _PAGE_HWWRITE)
>> +#define _PAGE_KERNEL_RO	(_PAGE_SHARED | _PAGE_RO | _PAGE_KNLRO)
>> +#define _PAGE_KERNEL_ROX	(_PAGE_EXEC | _PAGE_RO | _PAGE_KNLRO)
>>   
>>   #endif /* __KERNEL__ */
>>   #endif /*  _ASM_POWERPC_PTE_8xx_H */
> Where did _PAGE_KERNEL_RW go?
>
>
It is already defined like this in pte-common.h:

#ifndef _PAGE_KERNEL_RW
#define _PAGE_KERNEL_RW        (_PAGE_DIRTY | _PAGE_RW | _PAGE_HWWRITE)
#endif


Christophe
