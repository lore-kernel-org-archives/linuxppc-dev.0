Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 465B52C00AF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jul 2013 15:45:20 +1000 (EST)
Message-ID: <51DCF518.4090105@windriver.com>
Date: Wed, 10 Jul 2013 13:46:00 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Bhushan Bharat-R65777 <R65777@freescale.com>
Subject: Re: [v3][PATCH 7/8] book3e/kexec/kdump: redefine VIRT_PHYS_OFFSET
References: <1373357007-30785-1-git-send-email-tiejun.chen@windriver.com>
 <1373357007-30785-8-git-send-email-tiejun.chen@windriver.com>
 <6A3DF150A5B70D4F9B66A25E3F7C888D070AE138@039-SN2MPN1-011.039d.mgd.msft.net>
In-Reply-To: <6A3DF150A5B70D4F9B66A25E3F7C888D070AE138@039-SN2MPN1-011.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Wood Scott-B07421 <B07421@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/10/2013 01:20 PM, Bhushan Bharat-R65777 wrote:
>
>
>> -----Original Message-----
>> From: Linuxppc-dev [mailto:linuxppc-dev-
>> bounces+bharat.bhushan=freescale.com@lists.ozlabs.org] On Behalf Of Tiejun Chen
>> Sent: Tuesday, July 09, 2013 1:33 PM
>> To: benh@kernel.crashing.org
>> Cc: linuxppc-dev@lists.ozlabs.org; linux-kernel@vger.kernel.org
>> Subject: [v3][PATCH 7/8] book3e/kexec/kdump: redefine VIRT_PHYS_OFFSET
>>
>> Book3e is always aligned 1GB to create TLB so we should
>> use (KERNELBASE - MEMORY_START) as VIRT_PHYS_OFFSET to
>> get __pa/__va properly while boot kdump.
>>
>> Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
>> ---
>>   arch/powerpc/include/asm/page.h |    2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
>> index 988c812..5b00081 100644
>> --- a/arch/powerpc/include/asm/page.h
>> +++ b/arch/powerpc/include/asm/page.h
>> @@ -112,6 +112,8 @@ extern long long virt_phys_offset;
>>   /* See Description below for VIRT_PHYS_OFFSET */
>>   #ifdef CONFIG_RELOCATABLE_PPC32
>>   #define VIRT_PHYS_OFFSET virt_phys_offset
>> +#elif defined(CONFIG_PPC_BOOK3E_64)
>> +#define VIRT_PHYS_OFFSET (KERNELBASE - MEMORY_START)
>
> Can you please explain this code a bit more. I am not understanding this part:)

Nothing is special, we only need to redefine this to make sure __va()/__pa() can 
work well for BOOk3E-64 in BOOKE case:

#ifdef CONFIG_BOOKE
#define __va(x) ((void *)(unsigned long)((phys_addr_t)(x) + VIRT_PHYS_OFFSET))
#define __pa(x) ((unsigned long)(x) - VIRT_PHYS_OFFSET)

And the arch/powerpc/include/asm/page.h file has more descriptions inline :)

Tiejun
