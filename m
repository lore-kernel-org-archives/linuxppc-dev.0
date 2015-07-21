Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D2F6C1A019D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2015 15:05:04 +1000 (AEST)
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A0302140DBC
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Jul 2015 15:05:04 +1000 (AEST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 21 Jul 2015 15:05:03 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 04DBF3578048
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Jul 2015 15:05:00 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6L54p1437093422
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Jul 2015 15:04:59 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6L54QEM008378
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Jul 2015 15:04:26 +1000
Message-ID: <55ADD2C8.1060003@linux.vnet.ibm.com>
Date: Tue, 21 Jul 2015 10:34:08 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
CC: mikey@neuling.org
Subject: Re: [V2] powerpc/signal: Add helper function to fetch quad word
 aligned pointer
References: <20150721013754.0C58A140DDA@ozlabs.org>
In-Reply-To: <20150721013754.0C58A140DDA@ozlabs.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/21/2015 07:07 AM, Michael Ellerman wrote:
> On Mon, 2015-20-07 at 02:58:43 UTC, Anshuman Khandual wrote:
>> This patch adds one helper function 'sigcontext_vmx_regs' which computes
>> quad word aligned pointer for 'vmx_reserve' array element in sigcontext
>> structure making the code more readable.
>>
>> diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
>> index c7c24d2..bb9c939 100644
>> --- a/arch/powerpc/kernel/signal_64.c
>> +++ b/arch/powerpc/kernel/signal_64.c
>> @@ -74,6 +74,16 @@ static const char fmt64[] = KERN_INFO \
>>  	"%s[%d]: bad frame in %s: %016lx nip %016lx lr %016lx\n";
>>  
>>  /*
>> + * This computes quad word aligned pointer for 'vmx_reserve' array element
>> + * which is used primarily in assigning to the preceding pointer 'v_regs'
>> + * in sigcontext structure.
> 
> How about:
> 
>   * This computes a quad word aligned pointer inside the vmx_reserve array
>   * element. For historical reasons sigcontext might not be quad word aligned,
>   * but the location we write the VMX regs to must be. See the comment in
>   * sigcontext for more detail.

Yeah, its way better. Thanks !

> 
> 
>> + */
>> +static elf_vrreg_t __user *sigcontext_vmx_regs(struct sigcontext __user *sc)
>> +{
>> +	return (elf_vrreg_t __user *) (((unsigned long)sc->vmx_reserve + 15) & ~0xful);
>> +}
> 
> This doesn't build for ppc64e_defconfig:

This time, I did build test for some of the configs but not the entire
comprehensive list. Sorry, missed this one though, will take care next
time around.

> 
>   arch/powerpc/kernel/signal_64.c:82:28: error: 'sigcontext_vmx_regs' defined but not used [-Werror=unused-function]
>    static elf_vrreg_t __user *sigcontext_vmx_regs(struct sigcontext __user *sc)
>                             ^
> 
> For now I'll just #ifdef it.
> 
> Please do a test build of ppc64e_defconfig in future.
