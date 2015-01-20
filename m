Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id A1D061A0427
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jan 2015 22:32:42 +1100 (AEDT)
Message-ID: <54BE3CD7.4040208@c-s.fr>
Date: Tue, 20 Jan 2015 12:32:39 +0100
From: leroy christophe <christophe.leroy@c-s.fr>
MIME-Version: 1.0
To: David Laight <David.Laight@ACULAB.COM>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 "scottwood@freescale.com" <scottwood@freescale.com>
Subject: Re: [PATCH v2 07/11] powerpc/8xx: macro for handling CPU15 errata
References: <20150120095735.A55671A5E86@localhost.localdomain>
 <063D6719AE5E284EB5DD2968C1650D6D1CACEFD9@AcuExch.aculab.com>
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D1CACEFD9@AcuExch.aculab.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Le 20/01/2015 12:09, David Laight a écrit :
>  From Christophe Leroy
>> Having a macro will help keep clear code.
> It might remove an #if but it doesn't really help.
> All it means is that anyone reading the code has to hunt for
> the definition before proceeding.
>
> Some comment about what (and why) the extra code is needed
> might help.
The main reason is because of patch 09/11 where we have to duplicate 
this code. I prefer to just duplicate one line rather than duplicate the 
whole code (especially because in v1 of the PATCHset, it was duplicated 
twice):

-    DO_8xx_CPU15(r11, r10)
[...]
#ifdef CONFIG_MODULES
[...]
+    DO_8xx_CPU15(r10, r11)
[...]
+#else
+    mfspr    r10, SPRN_SRR0    /* Get effective address of fault */
+    DO_8xx_CPU15(r11, r10)

Is this approach wrong ?


>
> ...
>> +
>> +#ifdef CONFIG_8xx_CPU15
>> +#define DO_8xx_CPU15(tmp, addr)	\
>> +	addi	tmp, addr, PAGE_SIZE;	\
>> +	tlbie	tmp;			\
>> +	addi	tmp, addr, PAGE_SIZE;	\
> You've even transcribed this incorrectly.
Oops
>
> Clearly not tested :-)
Indeed it's been tested, but tests can only show that the code is not 
worth than before.
This code is there to fix a chip errata which (almost?) never happens.
In my production version, I have not activated this errata, and he have 
never seen the problem on any of the more than 200 boards that have run 
for at least 4 years.

Christophe
>
> 	David
>
>> +	tlbie	tmp
>> +#else
>> +#define DO_8xx_CPU15(tmp, addr)
>> +#endif
>> +
>>   InstructionTLBMiss:
>>   #ifdef CONFIG_8xx_CPU6
>>   	mtspr	SPRN_DAR, r3
>> @@ -304,12 +315,7 @@ InstructionTLBMiss:
>>   	EXCEPTION_PROLOG_0
>>   	mtspr	SPRN_SPRG_SCRATCH2, r10
>>   	mfspr	r10, SPRN_SRR0	/* Get effective address of fault */
>> -#ifdef CONFIG_8xx_CPU15
>> -	addi	r11, r10, PAGE_SIZE
>> -	tlbie	r11
>> -	addi	r11, r10, -PAGE_SIZE
>> -	tlbie	r11
>> -#endif
>> +	DO_8xx_CPU15(r11, r10)
>>
>>   	/* If we are faulting a kernel address, we have to use the
>>   	 * kernel page tables.
>> --
>> 2.1.0
>>
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@lists.ozlabs.org
>> https://lists.ozlabs.org/listinfo/linuxppc-dev
