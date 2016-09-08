Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sVFYv1Ms9zDsYy
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Sep 2016 19:35:31 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Daniel Axtens <dja@axtens.net>, linuxppc-dev@lists.ozlabs.org
Cc: Hari Bathini <hbathini@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 4/5] powerpc/fadump: Make ELF eflags depend on endian
In-Reply-To: <2cc58c5b-9465-207d-60d8-f09dff6ca0c8@linux.vnet.ibm.com>
References: <1473139963-7496-1-git-send-email-dja@axtens.net>
 <1473139963-7496-4-git-send-email-dja@axtens.net>
 <2cc58c5b-9465-207d-60d8-f09dff6ca0c8@linux.vnet.ibm.com>
Date: Thu, 08 Sep 2016 19:35:29 +1000
Message-ID: <87fupalony.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com> writes:

> On 09/06/2016 11:02 AM, Daniel Axtens wrote:
>> Firmware Assisted Dump is a facility to dump kernel core with assistance
>> from firmware.  As part of this process the kernel ELF version is
>> stored.
>> 
>> Currently, fadump.h defines this to 0 if it is not already defined. This
>> clashes with a define in elf.h which sets it based on the current task -
>> not based on the kernel.
>> 
>> When the kernel is compiled on LE, the kernel will always be version
>> 2. Otherwise it will be version 0. So the correct behaviour is to set
>> the ELF eflags based on the endianness of the kernel. Do that.
>> 
>> Remove the definition in fadump.h, which becomes unused.
>> 
>> Cc: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>> Cc: Hari Bathini <hbathini@linux.vnet.ibm.com>
>> Signed-off-by: Daniel Axtens <dja@axtens.net>
>> 
>> ---
>> 
>> Mahesh or Hari: I'm not familiar with this code at all, so if either of
>> you could check that this makes sense I would really appreciate that.
>> Thanks!
>> ---
>>  arch/powerpc/include/asm/fadump.h | 4 ----
>>  arch/powerpc/kernel/fadump.c      | 6 +++++-
>>  2 files changed, 5 insertions(+), 5 deletions(-)
>> 
>> diff --git a/arch/powerpc/include/asm/fadump.h b/arch/powerpc/include/asm/fadump.h
>> index b4407d0add27..0031806475f0 100644
>> --- a/arch/powerpc/include/asm/fadump.h
>> +++ b/arch/powerpc/include/asm/fadump.h
>> @@ -45,10 +45,6 @@
>> 
>>  #define memblock_num_regions(memblock_type)	(memblock.memblock_type.cnt)
>> 
>> -#ifndef ELF_CORE_EFLAGS
>> -#define ELF_CORE_EFLAGS 0
>> -#endif
>> -
>>  /* Firmware provided dump sections */
>>  #define FADUMP_CPU_STATE_DATA	0x0001
>>  #define FADUMP_HPTE_REGION	0x0002
>> diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
>> index 0638b82ce294..457f08e544c6 100644
>> --- a/arch/powerpc/kernel/fadump.c
>> +++ b/arch/powerpc/kernel/fadump.c
>> @@ -779,7 +779,11 @@ static int fadump_init_elfcore_header(char *bufp)
>>  	elf->e_entry = 0;
>>  	elf->e_phoff = sizeof(struct elfhdr);
>>  	elf->e_shoff = 0;
>> -	elf->e_flags = ELF_CORE_EFLAGS;
>> +#ifdef __LITTLE_ENDIAN__
>
> Wouldn't '#ifdef PPC64_ELF_ABI_v2' be more appropriate here ?

Actually I think even more correct is:

    #if defined(_CALL_ELF)
            elf->e_flags = _CALL_ELF;
    #else
            elf->e_flags = 0;
    #endif

So I'll do that.

cheers
