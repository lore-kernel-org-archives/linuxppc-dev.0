Return-Path: <desnesn@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ysx5m39qSzDsNH
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Dec 2017 00:24:12 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vB7DO1IL041388
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Dec 2017 08:24:09 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2eq4c2prnc-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Dec 2017 08:24:08 -0500
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <desnesn@linux.vnet.ibm.com>;
 Thu, 7 Dec 2017 06:24:08 -0700
Subject: Re: [PATCH] [powerpc-next] Fix powerpc64 alignment of .toc section in
 kernel modules
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, amodra@gmail.com
Cc: benh@kernel.crashing.org, paulus@samba.org, ard.biesheuvel@linaro.org,
 rusty@rustcorp.com.au
References: <20171206191228.30830-1-desnesn@linux.vnet.ibm.com>
 <877etylo6i.fsf@concordia.ellerman.id.au>
From: =?UTF-8?Q?Desnes_Augusto_Nunes_do_Ros=c3=a1rio?=
 <desnesn@linux.vnet.ibm.com>
Date: Thu, 7 Dec 2017 11:24:01 -0200
MIME-Version: 1.0
In-Reply-To: <877etylo6i.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <dd057271-5ee1-26b5-c7a7-a594940c2920@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Michael,

On 12/07/2017 10:25 AM, Michael Ellerman wrote:
> Hi Desnes,
> 
> Am I right that Alan largely wrote this patch?
> 
> If so it should probably be From: him, so that he is the author in the
> git log.

Yes, Alan Modra is the main author and I am just committing it with 
minor changes. Thus, the author change is necessary.

> 
> 
> Desnes Augusto Nunes do Rosario <desnesn@linux.vnet.ibm.com> writes:
>> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
>> index 1381693..c472f5b 100644
>> --- a/arch/powerpc/Makefile
>> +++ b/arch/powerpc/Makefile
>> @@ -63,6 +63,7 @@ UTS_MACHINE := $(subst $(space),,$(machine-y))
>>   ifdef CONFIG_PPC32
>>   KBUILD_LDFLAGS_MODULE += arch/powerpc/lib/crtsavres.o
>>   else
>> +KBUILD_LDFLAGS_MODULE += -T arch/powerpc/kernel/module.lds
> 
> This needs to be:
> 
> KBUILD_LDFLAGS_MODULE += -T $(srctree)/arch/powerpc/kernel/module.lds
> 
> Otherwise building with O=../build fails with:
> 
>    ld: cannot open linker script file arch/powerpc/kernel/module.lds: No such file or directory
> 
> I'll fix it up.

Indeed; this change is necessary to avoid any path errors.

> 
>> diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
>> index 759104b..9b2c5c1 100644
>> --- a/arch/powerpc/kernel/module_64.c
>> +++ b/arch/powerpc/kernel/module_64.c
>> @@ -374,11 +377,13 @@ int module_frob_arch_sections(Elf64_Ehdr *hdr,
>>   }
>>   
>>   /* r2 is the TOC pointer: it actually points 0x8000 into the TOC (this
>> -   gives the value maximum span in an instruction which uses a signed
>> -   offset) */
>> + * gives the value maximum span in an instruction which uses a signed
>> + * offset).  Round down to a 256 byte boundary for the odd case where
>> + * we are setting up r2 without a .toc section.
>> + */
>>   static inline unsigned long my_r2(const Elf64_Shdr *sechdrs, struct module *me)
>>   {
>> -	return sechdrs[me->arch.toc_section].sh_addr + 0x8000;
>> +	return (sechdrs[me->arch.toc_section].sh_addr & -256) + 0x8000;
> 
> I think it's more typical in the kernel to write -256 as ~0xff.
> 
> Again I can fix it up.

Good to know!

> 
> cheers
> 

Lastly, will you fix it up or do you want me to send a second version 
then? Whatever is best for you.

Thank you for the review.

-- 
Desnes Augusto Nunes do Rosário
------------------------------------------

Linux Developer - IBM / Brazil
M.Sc. in Electrical and Computer Engineering - UFRN

(11) 9595-30-900
desnesn@br.ibm.com
