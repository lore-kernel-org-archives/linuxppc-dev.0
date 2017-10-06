Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y7lpB0gywzDqhg
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Oct 2017 21:13:22 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Santosh Sivaraj <santosh@fossix.org>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <fweisbec@gmail.com>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] powerpc/vdso64: Coarse timer support preparatory patch
In-Reply-To: <20171006090302.q4oquzdyytjkawuf@naverao1-tp.localdomain>
References: <20170918092336.21912-1-santosh@fossix.org>
 <20171006090302.q4oquzdyytjkawuf@naverao1-tp.localdomain>
Date: Fri, 06 Oct 2017 21:13:20 +1100
Message-ID: <87tvzc4m9r.fsf@concordia.ellerman.id.au>
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

Thanks for reviewing Naveen.

"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:
> On 2017/09/18 09:23AM, Santosh Sivaraj wrote:
>> diff --git a/arch/powerpc/kernel/vdso64/gettimeofday.S b/arch/powerpc/kernel/vdso64/gettimeofday.S
>> index 382021324883..a0b4943811db 100644
>> --- a/arch/powerpc/kernel/vdso64/gettimeofday.S
>> +++ b/arch/powerpc/kernel/vdso64/gettimeofday.S
>> @@ -60,18 +60,20 @@ V_FUNCTION_END(__kernel_gettimeofday)
>>   */
>>  V_FUNCTION_BEGIN(__kernel_clock_gettime)
>>    .cfi_startproc
>> +	mr	r11,r4			/* r11 saves tp */
>> +	mflr	r12			/* r12 saves lr */
>> +	lis	r7,NSEC_PER_SEC@h	/* want nanoseconds */
>> +	ori	r7,r7,NSEC_PER_SEC@l
>> +
>>  	/* Check for supported clock IDs */
>>  	cmpwi	cr0,r3,CLOCK_REALTIME
>>  	cmpwi	cr1,r3,CLOCK_MONOTONIC
>>  	cror	cr0*4+eq,cr0*4+eq,cr1*4+eq
>> -	bne	cr0,99f
>> +	beq	cr0,49f
>> 
>> -	mflr	r12			/* r12 saves lr */
>> +	b	99f		/* Fallback to syscall */
>
> 'beq', followed by a 'b' looks weird without considering the next patch.  
> I think this can be organized better to not have to update r7/r11/r12 if 
> using the system call. See next patch for my comments.
>
>>    .cfi_register lr,r12
>
> If you move the mflr, you should move the above line along with it.

s/should/must/.

It literally says "lr is saved in r12".

cheers
