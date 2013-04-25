Return-Path: <qiudayu@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp04.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 001592C010E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2013 18:25:02 +1000 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <qiudayu@linux.vnet.ibm.com>;
 Thu, 25 Apr 2013 18:12:59 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id E8CE8357804A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2013 18:24:51 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3P8B6SW25428202
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2013 18:11:06 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3P8Oo2W018681
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2013 18:24:51 +1000
Message-ID: <5178E849.4090202@linux.vnet.ibm.com>
Date: Thu, 25 Apr 2013 16:24:41 +0800
From: Mike Qiu <qiudayu@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Chen Gang <gang.chen@asianux.com>
Subject: Re: [PATCH] PowerPC: kernel: compiling issue, make additional room
 in exception vector area
References: <5177965D.9090406@linux.vnet.ibm.com>
 <20130424083142.GB26834@concordia> <51779941.8080403@linux.vnet.ibm.com>
 <30651.1366799858@ale.ozlabs.ibm.com> <1366807638.5911.2.camel@localhost>
 <5178816D.3000309@asianux.com> <5178ABA2.4030109@linux.vnet.ibm.com>
 <5178E6C3.4060603@asianux.com> <5178E775.4030409@asianux.com>
In-Reply-To: <5178E775.4030409@asianux.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: sfr@canb.auug.org.au, Michael Neuling <mikey@neuling.org>, matt@ozlabs.org,
 linux-kernel@vger.kernel.org, paulus@samba.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

于 2013/4/25 16:21, Chen Gang 写道:
> Hello Mike:
>
> Please try this patch, at least it can pass compiling with the config
> file which you provided under my cross-compiling envrionments.
>
> I do not give a running test now, so better to try to run the new kernel
> with this patch.
OK, I will use your patch, and I will send out the result later.

Thanks

Mike
> Thanks.
>
> On 2013年04月25日 16:18, Chen Gang wrote:
>> When CONFIG_KVM_BOOK3S_64_PR is enabled,
>> MASKABLE_EXCEPTION_PSERIES(0x900 ...) will includes __KVMTEST, it will
>> exceed 0x980 which STD_EXCEPTION_HV(0x980 ...) will use, it will cause
>> compiling issue.
>>
>> The related errors:
>> arch/powerpc/kernel/exceptions-64s.S: Assembler messages:
>> arch/powerpc/kernel/exceptions-64s.S:258: Error: attempt to move .org backwards
>> make[1]: *** [arch/powerpc/kernel/head_64.o] Error 1
>>
>>
>> Signed-off-by: Chen Gang <gang.chen@asianux.com>
>> ---
>>   arch/powerpc/include/asm/kvm_asm.h   |    2 +-
>>   arch/powerpc/kernel/exceptions-64s.S |    6 +++---
>>   2 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/kvm_asm.h b/arch/powerpc/include/asm/kvm_asm.h
>> index b9dd382..2c65bae 100644
>> --- a/arch/powerpc/include/asm/kvm_asm.h
>> +++ b/arch/powerpc/include/asm/kvm_asm.h
>> @@ -86,7 +86,7 @@
>>   #define BOOK3S_INTERRUPT_PROGRAM	0x700
>>   #define BOOK3S_INTERRUPT_FP_UNAVAIL	0x800
>>   #define BOOK3S_INTERRUPT_DECREMENTER	0x900
>> -#define BOOK3S_INTERRUPT_HV_DECREMENTER	0x980
>> +#define BOOK3S_INTERRUPT_HV_DECREMENTER	0x988
>>   #define BOOK3S_INTERRUPT_SYSCALL	0xc00
>>   #define BOOK3S_INTERRUPT_TRACE		0xd00
>>   #define BOOK3S_INTERRUPT_H_DATA_STORAGE	0xe00
>> diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
>> index e789ee7..bb0e677 100644
>> --- a/arch/powerpc/kernel/exceptions-64s.S
>> +++ b/arch/powerpc/kernel/exceptions-64s.S
>> @@ -255,7 +255,7 @@ hardware_interrupt_hv:
>>   	KVM_HANDLER_PR(PACA_EXGEN, EXC_STD, 0x800)
>>   
>>   	MASKABLE_EXCEPTION_PSERIES(0x900, 0x900, decrementer)
>> -	STD_EXCEPTION_HV(0x980, 0x982, hdecrementer)
>> +	STD_EXCEPTION_HV(0x988, 0x982, hdecrementer)
>>   
>>   	MASKABLE_EXCEPTION_PSERIES(0xa00, 0xa00, doorbell_super)
>>   	KVM_HANDLER_PR(PACA_EXGEN, EXC_STD, 0xa00)
>> @@ -698,7 +698,7 @@ machine_check_common:
>>   
>>   	STD_EXCEPTION_COMMON_ASYNC(0x500, hardware_interrupt, do_IRQ)
>>   	STD_EXCEPTION_COMMON_ASYNC(0x900, decrementer, .timer_interrupt)
>> -	STD_EXCEPTION_COMMON(0x980, hdecrementer, .hdec_interrupt)
>> +	STD_EXCEPTION_COMMON(0x988, hdecrementer, .hdec_interrupt)
>>   #ifdef CONFIG_PPC_DOORBELL
>>   	STD_EXCEPTION_COMMON_ASYNC(0xa00, doorbell_super, .doorbell_exception)
>>   #else
>> @@ -802,7 +802,7 @@ hardware_interrupt_relon_hv:
>>   	STD_RELON_EXCEPTION_PSERIES(0x4700, 0x700, program_check)
>>   	STD_RELON_EXCEPTION_PSERIES(0x4800, 0x800, fp_unavailable)
>>   	MASKABLE_RELON_EXCEPTION_PSERIES(0x4900, 0x900, decrementer)
>> -	STD_RELON_EXCEPTION_HV(0x4980, 0x982, hdecrementer)
>> +	STD_RELON_EXCEPTION_HV(0x4988, 0x982, hdecrementer)
>>   	MASKABLE_RELON_EXCEPTION_PSERIES(0x4a00, 0xa00, doorbell_super)
>>   	STD_RELON_EXCEPTION_PSERIES(0x4b00, 0xb00, trap_0b)
>>   
>>
>
