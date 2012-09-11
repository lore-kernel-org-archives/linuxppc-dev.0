Return-Path: <haren@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e2.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6594B2C0086
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Sep 2012 15:23:58 +1000 (EST)
Received: from /spool/local
 by e2.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <haren@linux.vnet.ibm.com>;
 Tue, 11 Sep 2012 01:23:55 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 24F0C6E803C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Sep 2012 01:23:23 -0400 (EDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q8B5NMMk171044
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Sep 2012 01:23:23 -0400
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q8B5NMG6031565
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Sep 2012 23:23:22 -0600
Message-ID: <504ECAC9.3080102@linux.vnet.ibm.com>
Date: Mon, 10 Sep 2012 22:23:21 -0700
From: Haren Myneni <haren@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/6] powerpc: Move branch instruction from
 ACCOUNT_CPU_USER_ENTRY to caller
References: <1347190604.3418.11.camel@hbabu-laptop>
 <1347235505.2385.134.camel@pasglop>
In-Reply-To: <1347235505.2385.134.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1
Cc: paulus@samba.org, mikey@neuling.org, linuxppc-dev@lists.ozlabs.org,
 anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/09/2012 05:05 PM, Benjamin Herrenschmidt wrote:
> On Sun, 2012-09-09 at 04:36 -0700, Haren Myneni wrote:
>> The first instruction in ACCOUNT_CPU_USER_ENTRY is 'beq' which checkes for
>> exceptions coming from kernel mode. PPR value will be saved immediately after
>> ACCOUNT_CPU_USER_ENTRY and is also for user level exceptions. So moved this
>> branch instruction in the caller code.
> 
> grep fail ? ACCOUNT_CPU_USER_ENTRY is used in exception-64e.S as well,
> so that needs to be updated too.

Sorry, I will make this change.

> 
> Cheers,
> Ben.
> 
>> Signed-off-by: Haren Myneni <haren@us.ibm.com>
>>
>> ---
>>  arch/powerpc/include/asm/exception-64s.h |    3 ++-
>>  arch/powerpc/include/asm/ppc_asm.h       |    2 --
>>  arch/powerpc/kernel/entry_64.S           |    3 ++-
>>  3 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
>> index a43c147..45702e0 100644
>> --- a/arch/powerpc/include/asm/exception-64s.h
>> +++ b/arch/powerpc/include/asm/exception-64s.h
>> @@ -176,8 +176,9 @@ do_kvm_##n:								\
>>  	std	r10,0(r1);		/* make stack chain pointer	*/ \
>>  	std	r0,GPR0(r1);		/* save r0 in stackframe	*/ \
>>  	std	r10,GPR1(r1);		/* save r1 in stackframe	*/ \
>> +	beq	4f;			/* if from kernel mode		*/ \
>>  	ACCOUNT_CPU_USER_ENTRY(r9, r10);				   \
>> -	std	r2,GPR2(r1);		/* save r2 in stackframe	*/ \
>> +4:	std	r2,GPR2(r1);		/* save r2 in stackframe	*/ \
>>  	SAVE_4GPRS(3, r1);		/* save r3 - r6 in stackframe	*/ \
>>  	SAVE_2GPRS(7, r1);		/* save r7, r8 in stackframe	*/ \
>>  	ld	r9,area+EX_R9(r13);	/* move r9, r10 to stackframe	*/ \
>> diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
>> index ea2a86e..376e36d 100644
>> --- a/arch/powerpc/include/asm/ppc_asm.h
>> +++ b/arch/powerpc/include/asm/ppc_asm.h
>> @@ -30,7 +30,6 @@
>>  #define ACCOUNT_STOLEN_TIME
>>  #else
>>  #define ACCOUNT_CPU_USER_ENTRY(ra, rb)					\
>> -	beq	2f;			/* if from kernel mode */	\
>>  	MFTB(ra);			/* get timebase */		\
>>  	ld	rb,PACA_STARTTIME_USER(r13);				\
>>  	std	ra,PACA_STARTTIME(r13);					\
>> @@ -38,7 +37,6 @@
>>  	ld	ra,PACA_USER_TIME(r13);					\
>>  	add	ra,ra,rb;		/* add on to user time */	\
>>  	std	ra,PACA_USER_TIME(r13);					\
>> -2:
>>  
>>  #define ACCOUNT_CPU_USER_EXIT(ra, rb)					\
>>  	MFTB(ra);			/* get timebase */		\
>> diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
>> index b40e0b4..8d21cc4 100644
>> --- a/arch/powerpc/kernel/entry_64.S
>> +++ b/arch/powerpc/kernel/entry_64.S
>> @@ -62,8 +62,9 @@ system_call_common:
>>  	std	r12,_MSR(r1)
>>  	std	r0,GPR0(r1)
>>  	std	r10,GPR1(r1)
>> +	beq	2f			/* if from kernel mode */
>>  	ACCOUNT_CPU_USER_ENTRY(r10, r11)
>> -	std	r2,GPR2(r1)
>> +2:	std	r2,GPR2(r1)
>>  	std	r3,GPR3(r1)
>>  	mfcr	r2
>>  	std	r4,GPR4(r1)
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
