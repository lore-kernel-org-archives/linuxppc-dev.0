Return-Path: <haren@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e38.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 63F642C0085
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Nov 2012 12:49:36 +1100 (EST)
Received: from /spool/local
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <haren@linux.vnet.ibm.com>;
 Mon, 26 Nov 2012 18:49:34 -0700
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
 [9.17.195.226])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 5E8551FF0046
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Nov 2012 18:49:26 -0700 (MST)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 qAR1nU26290548
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Nov 2012 18:49:30 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 qAR1nTq7028125
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Nov 2012 18:49:30 -0700
Message-ID: <50B41C27.4020905@linux.vnet.ibm.com>
Date: Mon, 26 Nov 2012 17:49:27 -0800
From: Haren Myneni <haren@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Neuling <michael.neuling@au1.ibm.com>
Subject: Re: [PATCH 5/6] powerpc: Macros for saving/restore PPR
References: <1351666574.32304.18.camel@hbabu-laptop>
 <27433.1353641997@neuling.org>
In-Reply-To: <27433.1353641997@neuling.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: anton@au1.ibm.com, paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/22/2012 07:39 PM, Michael Neuling wrote:
> Haren Myneni <haren@linux.vnet.ibm.com> wrote:
> 
>> [PATCH 5/6] powerpc: Macros for saving/restore PPR
>>
>> Several macros are defined for saving and restore user defined PPR value.
>>
>> Signed-off-by: Haren Myneni <haren@us.ibm.com>
>> ---
>>  arch/powerpc/include/asm/exception-64s.h |   29 +++++++++++++++++++++++++++++
>>  arch/powerpc/include/asm/ppc_asm.h       |   25 +++++++++++++++++++++++++
>>  arch/powerpc/include/asm/reg.h           |    1 +
>>  3 files changed, 55 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
>> index bfd3f1f..880ef7d 100644
>> --- a/arch/powerpc/include/asm/exception-64s.h
>> +++ b/arch/powerpc/include/asm/exception-64s.h
>> @@ -62,6 +62,35 @@
>>  #define EXC_HV	H
>>  #define EXC_STD
>>  
>> +/*
>> + * PPR save/restore macros used in exceptions_64s.S  
>> + * Used for P7 or later processors
>> + */
>> +#define SAVE_PPR(area, ra, rb)						\
>> +BEGIN_FTR_SECTION_NESTED(940)						\
>> +	ld	ra,PACACURRENT(r13);					\
>> +	ld	rb,area+EX_PPR(r13);	/* Read PPR from paca */	\
>> +	std	rb,TASKTHREADPPR(ra);					\
>> +END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,940)
>> +
>> +#define RESTORE_PPR_PACA(area, ra)					\
>> +BEGIN_FTR_SECTION_NESTED(941)						\
>> +	ld	ra,area+EX_PPR(r13);					\
>> +	mtspr	SPRN_PPR,ra;						\
>> +END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,941)
>> +
> 
> Can you add some documentation here on why we should use the different
> versions.
> 
> I'm trying to read the next patch and it's not clear to my why some have
> HMT_MEDIUM_NO_PPR and other times HMT_MEDIUM and others
> HTM_MEDIUM_HAS_PPR.
> 
> Looks like HTM_MEDIUM_NO_PPR sets the priority to medium on systems
> where we can't save/restore the PPR, hence it can be called earlier in
> the exception handler before we have free GPRs.  HTM_MEDIUM_HAS_PPR
> saves the priority on systems where it can, and then sets the priority
> to medium.
> 
> Maybe we should change the names 
>   HTM_MEDIUM_NO_PPR  => HTM_MEDIUM_PPR_DISCARD   and
>   HTM_MEDIUM_HAS_PPR => HTM_MEDIUM_PPR_SAVE
> But now I'm heading into bike shedding territory... plus I think I
> suggested the names you have currently, so I'm feeling a bit dumb now
> :-)

No problem, We can change these macro names if HTM_MEDIUM_PPR_DISCARD/
HTM_MEDIUM_PPR_SAVE gives better description.

Right, HTM_MEDIUM_NO_PPR is used on systems where we do not save/restore
PPR. So the behaviour is same as before - just increases the priority.
HTM_MEDIUM_HAS_PPR will be executed on systems where CPU_FTR_HAS_PPR is
enabled. I will write some comments around these macros to make it clear.

We can also name them HMT_MEDIUM_CPU_NO_PPR_SAVE and
HMT_MEDIUM_CPU_HAS_PPR_SAVE since we are enabling PPR save/restore using
CPU_FTR macro.

Otherwise I will follow with your suggestions.


Thanks
Haren

> Mikey
> 
>> +#define HMT_MEDIUM_NO_PPR						\
>> +BEGIN_FTR_SECTION_NESTED(942)						\
>> +	HMT_MEDIUM;							\
>> +END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,0,942)  /*non P7*/		
>> +
>> +#define HMT_MEDIUM_HAS_PPR(area, ra)					\
>> +BEGIN_FTR_SECTION_NESTED(943)						\
>> +	mfspr	ra,SPRN_PPR;						\
>> +	std	ra,area+EX_PPR(r13);					\
>> +	HMT_MEDIUM;							\
>> +END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,943) 
>> +
>>  #define __EXCEPTION_PROLOG_1(area, extra, vec)				\
>>  	GET_PACA(r13);							\
>>  	std	r9,area+EX_R9(r13);	/* save r9 - r12 */		\
> 
> 
>> diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
>> index 376e36d..52649cc 100644
>> --- a/arch/powerpc/include/asm/ppc_asm.h
>> +++ b/arch/powerpc/include/asm/ppc_asm.h
>> @@ -389,6 +389,31 @@ END_FTR_SECTION_IFCLR(CPU_FTR_601)
>>  	FTR_SECTION_ELSE_NESTED(848);	\
>>  	mtocrf (FXM), RS;		\
>>  	ALT_FTR_SECTION_END_NESTED_IFCLR(CPU_FTR_NOEXECUTE, 848)
>> +
>> +/*
>> + * PPR restore macros used in entry_64.S
>> + * Used for P7 or later processors
>> + */
>> +#define HMT_MEDIUM_LOW_HAS_PPR						\
>> +BEGIN_FTR_SECTION_NESTED(944)						\
>> +	HMT_MEDIUM_LOW;							\
>> +END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,944)
>> +
>> +#define SET_DEFAULT_THREAD_PPR(ra, rb)					\
>> +BEGIN_FTR_SECTION_NESTED(945)						\
>> +	lis	ra,0xc;		/* default ppr=3 */			\
>> +	ld	rb,PACACURRENT(r13);					\
>> +	sldi	ra,ra,32;	/* 11- 13 bits are used for ppr */	\
>> +	std	ra,TASKTHREADPPR(rb);					\
>> +END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,945)
>> +
>> +#define RESTORE_PPR(ra, rb)						\
>> +BEGIN_FTR_SECTION_NESTED(946)						\
>> +	ld	ra,PACACURRENT(r13);					\
>> +	ld	rb,TASKTHREADPPR(ra);					\
>> +	mtspr	SPRN_PPR,rb;	/* Restore PPR */			\
>> +END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,946)
>> +
>>  #endif
>>  
>>  /*
>> diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
>> index d24c141..1723be3 100644
>> --- a/arch/powerpc/include/asm/reg.h
>> +++ b/arch/powerpc/include/asm/reg.h
>> @@ -287,6 +287,7 @@
>>  #define SPRN_DBAT6U	0x23C	/* Data BAT 6 Upper Register */
>>  #define SPRN_DBAT7L	0x23F	/* Data BAT 7 Lower Register */
>>  #define SPRN_DBAT7U	0x23E	/* Data BAT 7 Upper Register */
>> +#define SPRN_PPR	0x380	/* SMT Thread status Register */
>>  
>>  #define SPRN_DEC	0x016		/* Decrement Register */
>>  #define SPRN_DER	0x095		/* Debug Enable Regsiter */
>> -- 
>> 1.7.1
>>
>>
>>
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@lists.ozlabs.org
>> https://lists.ozlabs.org/listinfo/linuxppc-dev
>>
