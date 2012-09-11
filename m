Return-Path: <haren@linux.vnet.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e5.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E9D352C0089
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Sep 2012 15:18:28 +1000 (EST)
Received: from /spool/local
 by e5.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <haren@linux.vnet.ibm.com>;
 Tue, 11 Sep 2012 01:18:25 -0400
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 9BD8338C803B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Sep 2012 01:18:21 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q8B5ILqS37945560
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Sep 2012 01:18:21 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q8B5IKxS016749
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Sep 2012 02:18:21 -0300
Message-ID: <504EC99B.7000302@linux.vnet.ibm.com>
Date: Mon, 10 Sep 2012 22:18:19 -0700
From: Haren Myneni <haren@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 5/6] powerpc: Macros for saving/restore PPR
References: <1347191001.3418.19.camel@hbabu-laptop>
 <1347251044.2385.144.camel@pasglop>
In-Reply-To: <1347251044.2385.144.camel@pasglop>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org, mikey@neuling.org, paulus@samba.org,
 anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/09/2012 09:24 PM, Benjamin Herrenschmidt wrote:
> On Sun, 2012-09-09 at 04:43 -0700, Haren Myneni wrote:
>> Several macros are defined for saving and restore user defined PPR value.
>>
>> Signed-off-by: Haren Myneni <haren@us.ibm.com>
>> ---
>>  arch/powerpc/include/asm/exception-64s.h |   35 ++++++++++++++++++++++++++++++
>>  arch/powerpc/include/asm/reg.h           |    1 +
>>  2 files changed, 36 insertions(+)
>>
>> diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
>> index bfd3f1f..618fd18 100644
>> --- a/arch/powerpc/include/asm/exception-64s.h
>> +++ b/arch/powerpc/include/asm/exception-64s.h
>> @@ -62,6 +62,41 @@
>>  #define EXC_HV	H
>>  #define EXC_STD
>>  
>> +/*
>> + * PPR save/restore macros - Used on P7 or later processors
>> + */
>> +#define SAVE_PPR(area, ra, rb)						\
>> +BEGIN_FTR_SECTION_NESTED(940)						\
>> +	ld	ra,area+EX_PPR(r13);	/* Read PPR from paca */	\
>> +	clrrdi	rb,r1,THREAD_SHIFT;	/* thread_info struct */	\
>> +	std	ra,TI_PPR(rb);		/* Save PPR in thread_info */	\
>> +END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,940)
> 
> Why the thread info and not the thread struct ?

We can also use thread struct, but the saved ppr is needed as long as
the process is in kernel context. Once the process exits, we do not need
this value - means the kernel or any other command will not be reading
this value. Even the process can change this value later. Need to add
ppr in thread_struct which uses extra 8 bytes for each task.

Whereas thread_info is at the top of stack. No need to allocate extra
memory. Since the saved process PPR value is needed temporarily whenever
the process is in kernel, thought thread_info is proper. Also easy to
read - one less load instruction.

Saving in thread_info:

ld      r4,area+EX_PPR(r13);
clrrdi  r5,r1,THREAD_SHIFT;
std     r4,TI_PPR(r5);

Saving in thread_struct:

 ld      r4,PACACURRENT(r13)
 addi    r5,r4,THREAD
 ld      r4,paca+EX_PPR(r13);
 std     r4,THREAD_PPR(r5)

If you prefer thread_struct, I will change the patch. Please let me know.

Thanks
Haren

> 
> Cheers,
> Ben.
> 
>> +#define RESTORE_PPR(ra,rb)						\
>> +BEGIN_FTR_SECTION_NESTED(941)						\
>> +	clrrdi	ra,r1,THREAD_SHIFT;					\
>> +	ld	rb,TI_PPR(ra);		/* Read PPR from thread_info */	\
>> +	mtspr	SPRN_PPR,rb;		/* Restore PPR */		\
>> +END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,941)
>> +
>> +#define RESTORE_PPR_PACA(area,ra)					\
>> +BEGIN_FTR_SECTION_NESTED(942)						\
>> +	ld	ra,area+EX_PPR(r13);					\
>> +	mtspr	SPRN_PPR,ra;						\
>> +END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,942)
>> +
>> +#define HMT_MEDIUM_NO_PPR						\
>> +BEGIN_FTR_SECTION_NESTED(944)						\
>> +	HMT_MEDIUM;							\
>> +END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,0,944)  /*non P7*/		
>> +
>> +#define HMT_MEDIUM_HAS_PPR(area, ra)					\
>> +BEGIN_FTR_SECTION_NESTED(943)						\
>> +	mfspr	ra,SPRN_PPR;						\
>> +	std	ra,area+EX_PPR(r13);					\
>> +	HMT_MEDIUM;							\
>> +END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,943) /* P7 */
>> +
>>  #define __EXCEPTION_PROLOG_1(area, extra, vec)				\
>>  	GET_PACA(r13);							\
>>  	std	r9,area+EX_R9(r13);	/* save r9 - r12 */		\
>> diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
>> index 6386086..dff2f89 100644
>> --- a/arch/powerpc/include/asm/reg.h
>> +++ b/arch/powerpc/include/asm/reg.h
>> @@ -284,6 +284,7 @@
>>  #define SPRN_DBAT6U	0x23C	/* Data BAT 6 Upper Register */
>>  #define SPRN_DBAT7L	0x23F	/* Data BAT 7 Lower Register */
>>  #define SPRN_DBAT7U	0x23E	/* Data BAT 7 Upper Register */
>> +#define SPRN_PPR	0x380	/* SMT Thread status Register */
>>  
>>  #define SPRN_DEC	0x016		/* Decrement Register */
>>  #define SPRN_DER	0x095		/* Debug Enable Regsiter */
> 
> 
