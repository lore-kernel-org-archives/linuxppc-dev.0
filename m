Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 6C0B81A0406
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Apr 2015 18:16:01 +1000 (AEST)
Message-ID: <5523923F.2050502@c-s.fr>
Date: Tue, 07 Apr 2015 10:15:59 +0200
From: leroy christophe <christophe.leroy@c-s.fr>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v2 11/11] powerpc/8xx: Add support for TASK_SIZE greater
 than 0x80000000
References: <20150120095736.518681A5E86@localhost.localdomain>
 <1426898829.27998.256.camel@freescale.com>
In-Reply-To: <1426898829.27998.256.camel@freescale.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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


Le 21/03/2015 01:47, Scott Wood a écrit :
> On Tue, 2015-01-20 at 10:57 +0100, Christophe Leroy wrote:
>> By default, TASK_SIZE is set to 0x80000000 for PPC_8xx, which is most likely
>> sufficient for most cases. However, kernel configuration allows to set TASK_SIZE
>> to another value, so the 8xx shall handle it.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>>
>> ---
>> v2: no change
>>
>>   arch/powerpc/kernel/head_8xx.S | 25 +++++++++++++++++++------
>>   1 file changed, 19 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
>> index ead6448..92a6456 100644
>> --- a/arch/powerpc/kernel/head_8xx.S
>> +++ b/arch/powerpc/kernel/head_8xx.S
>> @@ -48,6 +48,19 @@
>>   	mtspr	spr, reg
>>   #endif
>>   
>> +/* Macro to test if an address is a kernel address */
>> +#if CONFIG_TASK_SIZE <= 0x80000000
>> +#define IS_KERNEL(tmp, addr)		\
>> +	andis.	tmp, addr, 0x8000	/* Address >= 0x80000000 */
>> +#define BRANCH_UNLESS_KERNEL(label)	beq	label
>> +#else
> This works if CONFIG_TASK_SIZE == 0x80000000, but what if it's less, and
> you have a kernel address < 0x80000000?
>
>
You are right, I didn't realise that PAGE_OFFSET was also configurable 
and could be different from 0xC0000000.
andis. (which is what is always used in the current kernel) can be used 
if CONFIG_TASK_SIZE <= 0x80000000 AND PAGE_OFFSET >= 0x80000000.
I will resubmit the patch accordingly.

Christophe
