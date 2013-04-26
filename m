Return-Path: <qiudayu@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp05.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 33C2A2C00E8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2013 12:03:16 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <qiudayu@linux.vnet.ibm.com>;
 Fri, 26 Apr 2013 11:58:09 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 051B83578058
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2013 12:03:10 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3Q233p121168282
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2013 12:03:03 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3Q238FO015625
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2013 12:03:09 +1000
Message-ID: <5179E056.2000709@linux.vnet.ibm.com>
Date: Fri, 26 Apr 2013 10:03:02 +0800
From: Mike Qiu <qiudayu@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Chen Gang <gang.chen@asianux.com>
Subject: Re: [PATCH v2] PowerPC: kernel: compiling issue, make additional
 room in exception vector area
References: <5177965D.9090406@linux.vnet.ibm.com>
 <20130424083142.GB26834@concordia> <51779941.8080403@linux.vnet.ibm.com>
 <30651.1366799858@ale.ozlabs.ibm.com> <1366807638.5911.2.camel@localhost>
 <5178816D.3000309@asianux.com> <5178ABA2.4030109@linux.vnet.ibm.com>
 <20130425062539.GA421@iris.ozlabs.ibm.com> <517918AB.4020508@asianux.com>
 <30269.1366931768@ale.ozlabs.ibm.com> <5179D302.9060203@asianux.com>
 <5179D5D8.8080102@asianux.com> <5179DA23.8000407@asianux.com>
In-Reply-To: <5179DA23.8000407@asianux.com>
Content-Type: text/plain; charset=GB2312
Cc: sfr@canb.auug.org.au, Michael Neuling <mikey@neuling.org>, matt@ozlabs.org,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
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

于 2013/4/26 9:36, Chen Gang 写道:
> On 2013年04月26日 09:18, Chen Gang wrote:
>> On 2013年04月26日 09:06, Chen Gang wrote:
>>>> CFAR is the Come From Register.  It saves the location of the last
>>>>> branch and is hence overwritten by any branch.
>>>>>
>>> Do we process it just like others done (e.g. 0x300, 0xe00, 0xe20 ...) ?
>>> 	. = 0x900
>>> 	.globl decrementer_pSeries
>>> decrementer_pSeries:
>>>  	HMT_MEDIUM_PPR_DISCARD
>>> 	SET_SCRATCH0(r13)
>>> 	b decrementer_pSeries_0
>>>
>>> 	...
>>>
>>>
> Oh, it seems EXCEPTION_PROLOG_1 will save the regesters which related
> with CFAR, so I think need move EXCEPTION_PROLOG_1 to near 0x900.

I will try your diff V2, to see if the machine can boot up
> ---------------------------------diff v2 begin-----------------------------
>
> diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
> index e789ee7..f0489c4 100644
> --- a/arch/powerpc/kernel/exceptions-64s.S
> +++ b/arch/powerpc/kernel/exceptions-64s.S
> @@ -254,7 +254,15 @@ hardware_interrupt_hv:
>  	STD_EXCEPTION_PSERIES(0x800, 0x800, fp_unavailable)
>  	KVM_HANDLER_PR(PACA_EXGEN, EXC_STD, 0x800)
>
> -	MASKABLE_EXCEPTION_PSERIES(0x900, 0x900, decrementer)
> +	. = 0x900
> +	.globl decrementer_pSeries
> +decrementer_pSeries:
> +	HMT_MEDIUM_PPR_DISCARD
> +	SET_SCRATCH0(r13)		/* save r13 */
> +	EXCEPTION_PROLOG_0(PACA_EXGEN)
> +	EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_TEST_PR, 0x900)
> +	b	decrementer_pSeries_0
> +
>  	STD_EXCEPTION_HV(0x980, 0x982, hdecrementer)
>
>  	MASKABLE_EXCEPTION_PSERIES(0xa00, 0xa00, doorbell_super)
> @@ -536,6 +544,11 @@ ALT_FTR_SECTION_END_IFCLR(CPU_FTR_ARCH_206)
>  #endif
>
>  	.align	7
> +	/* moved from 0x900 */
> +decrementer_pSeries_0:
> +	EXCEPTION_PROLOG_PSERIES_1(decrementer_common, EXC_STD)
> +
> +	.align	7
>  	/* moved from 0xe00 */
>  	STD_EXCEPTION_HV_OOL(0xe02, h_data_storage)
>  	KVM_HANDLER_SKIP(PACA_EXGEN, EXC_HV, 0xe02)
>
>
> ---------------------------------diff v2 end-------------------------------
>
>
>> Such as the fix below, is it OK (just like 0x300 or 0x200 has done) ?
>>
>> Please check, thanks.
>>
>> ---------------------------diff begin-------------------------------------
>>
>> diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
>> index e789ee7..a0a5ff2 100644
>> --- a/arch/powerpc/kernel/exceptions-64s.S
>> +++ b/arch/powerpc/kernel/exceptions-64s.S
>> @@ -254,7 +254,14 @@ hardware_interrupt_hv:
>>  	STD_EXCEPTION_PSERIES(0x800, 0x800, fp_unavailable)
>>  	KVM_HANDLER_PR(PACA_EXGEN, EXC_STD, 0x800)
>>  
>> -	MASKABLE_EXCEPTION_PSERIES(0x900, 0x900, decrementer)
>> +	. = 0x900
>> +	.globl decrementer_pSeries
>> +decrementer_pSeries:
>> +	HMT_MEDIUM_PPR_DISCARD
>> +	SET_SCRATCH0(r13)		/* save r13 */
>> +	EXCEPTION_PROLOG_0(PACA_EXGEN)
>> +	b	decrementer_pSeries_0
>> +
>>  	STD_EXCEPTION_HV(0x980, 0x982, hdecrementer)
>>  
>>  	MASKABLE_EXCEPTION_PSERIES(0xa00, 0xa00, doorbell_super)
>> @@ -536,6 +543,12 @@ ALT_FTR_SECTION_END_IFCLR(CPU_FTR_ARCH_206)
>>  #endif
>>  
>>  	.align	7
>> +	/* moved from 0x900 */
>> +decrementer_pSeries_0:
>> +	EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_TEST_PR, 0x900)
>> +	EXCEPTION_PROLOG_PSERIES_1(decrementer_common, EXC_STD)
>> +
>> +	.align	7
>>  	/* moved from 0xe00 */
>>  	STD_EXCEPTION_HV_OOL(0xe02, h_data_storage)
>>  	KVM_HANDLER_SKIP(PACA_EXGEN, EXC_HV, 0xe02)
>>
>> ---------------------------diff end---------------------------------------
>>
>
