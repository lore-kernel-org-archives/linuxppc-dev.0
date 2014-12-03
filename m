Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DC7CF1A09DB
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Dec 2014 02:05:51 +1100 (AEDT)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 4 Dec 2014 01:05:50 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 25A99357805C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Dec 2014 02:05:48 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sB3F5ljC38273118
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Dec 2014 02:05:48 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sB3F5lX3027147
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Dec 2014 02:05:47 +1100
Message-ID: <547F26BE.1020406@linux.vnet.ibm.com>
Date: Wed, 03 Dec 2014 20:35:34 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Gabriel Paubert <paubert@iram.es>
Subject: Re: [RFC PATCH 2/2]powerpc: rewrite local_* to use CR5 flag
References: <1417090721-25298-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1417090721-25298-3-git-send-email-maddy@linux.vnet.ibm.com>
 <20141201180116.GA15790@visitor2.iram.es>
In-Reply-To: <20141201180116.GA15790@visitor2.iram.es>
Content-Type: text/plain; charset=windows-1252
Cc: rusty@rustcorp.com.au, paulus@samba.org, anton@samba.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Monday 01 December 2014 11:31 PM, Gabriel Paubert wrote:
> On Thu, Nov 27, 2014 at 05:48:41PM +0530, Madhavan Srinivasan wrote:
>> This patch re-write the current local_* functions to CR5 based one.
>> Base flow for each function is 
>>
>> {
>> 	set cr5(eq)
>> 	load
>> 	..
>> 	store
>> 	clear cr5(eq)
>> }
>>
>> Above set of instructions are followed by a fixup section which points
>> to the entry of the function incase of interrupt in the flow. If the 
>> interrupt happens to be after the store, we just continue to last 
>> instruction in that block. 
>>
>> Currently only asm/local.h has been rewrite, and local64 is TODO.
>> Also the entire change is only for PPC64.
>>
>> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/include/asm/local.h | 306 +++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 306 insertions(+)
>>
>> diff --git a/arch/powerpc/include/asm/local.h b/arch/powerpc/include/asm/local.h
>> index b8da913..a26e5d3 100644
>> --- a/arch/powerpc/include/asm/local.h
>> +++ b/arch/powerpc/include/asm/local.h
>> @@ -11,6 +11,310 @@ typedef struct
>>  
>>  #define LOCAL_INIT(i)	{ ATOMIC_LONG_INIT(i) }
>>  
>> +#ifdef	CONFIG_PPC64
>> +
>> +static __inline__ long local_read(local_t *l)
>> +{
>> +	long t;
>> +
>> +	__asm__ __volatile__(
>> +"1:	crset   22\n"
>> +"2:"	PPC_LL" %0,0(%1)\n"
>> +"3:	crclr   22\n"
>> +"4:\n"
>> +"	.section __ex_table,\"a\"\n"
>> +	PPC_LONG_ALIGN "\n"
>> +	PPC_LONG "2b,1b\n"
>> +	PPC_LONG "3b,3b\n"
>> +"	.previous\n"
>> +	: "=&r" (t)
>> +	: "r" (&(l->a.counter)));
>> +
>> +	return t;
>> +}
>> +
>> +static __inline__ void local_set(local_t *l, long i)
>> +{
>> +	long t;
>> +
>> +	__asm__ __volatile__(
>> +"1:	crset   22\n"
>> +"2:"	PPC_LL" %0,0(%1)\n"
>> +"3:"	PPC405_ERR77(0,%2)
>> +"4:"	PPC_STL" %0,0(%2)\n"
>> +"5:	crclr   22\n"
>> +"6:\n"
>> +"	.section __ex_table,\"a\"\n"
>> +	PPC_LONG_ALIGN "\n"
>> +	PPC_LONG "2b,1b\n"
>> +	PPC_LONG "3b,1b\n"
>> +	PPC_LONG "4b,1b\n"
>> +	PPC_LONG "5b,5b\n"
>> +"	.previous\n"
>> +	: "=&r" (t)
>> +	: "r" (&(i)), "r" (&(l->a.counter)));
>> +}
>> +
> 
> Apart from the other comments on bloat which can very likely
> be removed by tracing backwards for a few instructions, removing
> the exception table entries which are 2 or 4 (64 bit?) times as 
> large as the instruction sequence, I don't understand at all why
> you need these sequences for the local_read and local_set functions.
>
> After all these are single instructions (why do you perform a read before
> the write in set when the result of the read is never used?).
>
Agreed. But the benchmark I used, also did check for local_read timing.
So for consistency I re-wrote the these functions. But will drop the
changes for these function in the next version.

> I believe read and set are better mapped to access_once (or assign_once
> or whatever it's called after the recent discussion on linux-kernel).
> You don't even need a memory barrier if it's for a single thread,
> so you could get away with a single volatile access to the variables.
> 

OK.

> For the other ones, I think that what you do is correct, except that
> the workaround for PPC405 erratum 77 is not needed since this erratum
> only affects the stwcx. instruction and the whole point of the patch
> is to avoid the use of an l?arx/st?cx. pair.

Yes. Will remove it.

With regards
Maddy

> 
> 	Regards,
> 	Gabriel
> 
>> +static __inline__ void local_add(long i, local_t *l)
>> +{
>> +	long t;
>> +
>> +	__asm__ __volatile__(
>> +"1:	crset   22\n"
>> +"2:"	PPC_LL" %0,0(%2)\n"
>> +"3:	add     %0,%1,%0\n"
>> +"4:"	PPC405_ERR77(0,%2)
>> +"5:"	PPC_STL" %0,0(%2)\n"
>> +"6:	crclr   22\n"
>> +"7:\n"
>> +"	.section __ex_table,\"a\"\n"
>> +	PPC_LONG_ALIGN "\n"
>> +	PPC_LONG "2b,1b\n"
>> +	PPC_LONG "3b,1b\n"
>> +	PPC_LONG "4b,1b\n"
>> +	PPC_LONG "5b,1b\n"
>> +	PPC_LONG "6b,6b\n"
>> +"	.previous\n"
>> +	: "=&r" (t)
>> +	: "r" (i), "r" (&(l->a.counter)));
>> +}
>> +
>> +static __inline__ void local_sub(long i, local_t *l)
>> +{
>> +	long t;
>> +
>> +	__asm__ __volatile__(
>> +"1:	crset   22\n"
>> +"2:"	PPC_LL" %0,0(%2)\n"
>> +"3:	subf    %0,%1,%0\n"
>> +"4:"	PPC405_ERR77(0,%2)
>> +"5:"	PPC_STL" %0,0(%2)\n"
>> +"6:	crclr   22\n"
>> +"7:\n"
>> +"	.section __ex_table,\"a\"\n"
>> +	PPC_LONG_ALIGN "\n"
>> +	PPC_LONG "2b,1b\n"
>> +	PPC_LONG "3b,1b\n"
>> +	PPC_LONG "4b,1b\n"
>> +	PPC_LONG "5b,1b\n"
>> +	PPC_LONG "6b,6b\n"
>> +"	.previous\n"
>> +	: "=&r" (t)
>> +	: "r" (i), "r" (&(l->a.counter)));
>> +}
>> +
>> +static __inline__ long local_add_return(long a, local_t *l)
>> +{
>> +	long t;
>> +
>> +	__asm__ __volatile__(
>> +"1:	crset   22\n"
>> +"2:"	PPC_LL" %0,0(%2)\n"
>> +"3:	add     %0,%1,%0\n"
>> +"4:"	PPC405_ERR77(0,%2)
>> +"5:"	PPC_STL "%0,0(%2)\n"
>> +"6:	crclr   22\n"
>> +"7:\n"
>> +"	.section __ex_table,\"a\"\n"
>> +	PPC_LONG_ALIGN "\n"
>> +	PPC_LONG "2b,1b\n"
>> +	PPC_LONG "3b,1b\n"
>> +	PPC_LONG "4b,1b\n"
>> +	PPC_LONG "5b,1b\n"
>> +	PPC_LONG "6b,6b\n"
>> +"	.previous\n"
>> +	: "=&r" (t)
>> +	: "r" (a), "r" (&(l->a.counter))
>> +	: "cc", "memory");
>> +
>> +	return t;
>> +}
>> +
>> +
>> +#define local_add_negative(a, l)	(local_add_return((a), (l)) < 0)
>> +
>> +static __inline__ long local_sub_return(long a, local_t *l)
>> +{
>> +	long t;
>> +
>> +	__asm__ __volatile__(
>> +"1:	crset   22\n"
>> +"2:"	PPC_LL" %0,0(%2)\n"
>> +"3:	subf    %0,%1,%0\n"
>> +"4:"	PPC405_ERR77(0,%2)
>> +"5:"	PPC_STL "%0,0(%2)\n"
>> +"6:	crclr   22\n"
>> +"7:\n"
>> +"	.section __ex_table,\"a\"\n"
>> +	PPC_LONG_ALIGN "\n"
>> +	PPC_LONG "2b,1b\n"
>> +	PPC_LONG "3b,1b\n"
>> +	PPC_LONG "4b,1b\n"
>> +	PPC_LONG "5b,1b\n"
>> +	PPC_LONG "6b,6b\n"
>> +"	.previous\n"
>> +	: "=&r" (t)
>> +	: "r" (a), "r" (&(l->a.counter))
>> +	: "cc", "memory");
>> +
>> +	return t;
>> +}
>> +
>> +static __inline__ long local_inc_return(local_t *l)
>> +{
>> +	long t;
>> +
>> +	__asm__ __volatile__(
>> +"1:	crset   22\n"
>> +"2:"	PPC_LL" %0,0(%1)\n"
>> +"3:	addic   %0,%0,1\n"
>> +"4:"	PPC405_ERR77(0,%1)
>> +"5:"	PPC_STL "%0,0(%1)\n"
>> +"6:	crclr   22\n"
>> +"7:\n"
>> +"	.section __ex_table,\"a\"\n"
>> +	PPC_LONG_ALIGN "\n"
>> +	PPC_LONG "2b,1b\n"
>> +	PPC_LONG "3b,1b\n"
>> +	PPC_LONG "4b,1b\n"
>> +	PPC_LONG "5b,1b\n"
>> +	PPC_LONG "6b,6b\n"
>> +"	.previous"
>> +	: "=&r" (t)
>> +	: "r" (&(l->a.counter))
>> +	: "cc", "xer", "memory");
>> +
>> +	return t;
>> +}
>> +
>> +/*
>> + * local_inc_and_test - increment and test
>> + * @l: pointer of type local_t
>> + *
>> + * Atomically increments @l by 1
>> + * and returns true if the result is zero, or false for all
>> + * other cases.
>> + */
>> +#define local_inc_and_test(l) (local_inc_return(l) == 0)
>> +
>> +static __inline__ long local_dec_return(local_t *l)
>> +{
>> +	long t;
>> +
>> +	__asm__ __volatile__(
>> +"1:	crset   22\n"
>> +"2:"	PPC_LL" %0,0(%1)\n"
>> +"3:	addic   %0,%0,-1\n"
>> +"4:"	PPC405_ERR77(0,%1)
>> +"5:"	PPC_STL "%0,0(%1)\n"
>> +"6:	crclr   22\n"
>> +"7:\n"
>> +"	.section __ex_table,\"a\"\n"
>> +	PPC_LONG_ALIGN "\n"
>> +	PPC_LONG "2b,1b\n"
>> +	PPC_LONG "3b,1b\n"
>> +	PPC_LONG "4b,1b\n"
>> +	PPC_LONG "5b,1b\n"
>> +	PPC_LONG "6b,6b\n"
>> +"	.previous\n"
>> +	: "=&r" (t)
>> +	: "r" (&(l->a.counter))
>> +	: "cc", "xer", "memory");
>> +
>> +	return t;
>> +}
>> +
>> +#define local_inc(l)	local_inc_return(l)
>> +#define local_dec(l)	local_dec_return(l)
>> +
>> +#define local_cmpxchg(l, o, n) \
>> +	(cmpxchg_local(&((l)->a.counter), (o), (n)))
>> +#define local_xchg(l, n) (xchg_local(&((l)->a.counter), (n)))
>> +
>> +/**
>> + * local_add_unless - add unless the number is a given value
>> + * @l: pointer of type local_t
>> + * @a: the amount to add to v...
>> + * @u: ...unless v is equal to u.
>> + *
>> + * Atomically adds @a to @l, so long as it was not @u.
>> + * Returns non-zero if @l was not @u, and zero otherwise.
>> + */
>> +static __inline__ int local_add_unless(local_t *l, long a, long u)
>> +{
>> +	long t;
>> +
>> +	__asm__ __volatile__ (
>> +"1:	crset 22\n"
>> +"2:"	PPC_LL" %0,0(%1)\n"
>> +"3:	cmpw    0,%0,%3 \n"
>> +"4:	beq-    9f \n"
>> +"5:	add     %0,%2,%0 \n"
>> +"6:"	PPC405_ERR77(0,%1)
>> +"7:"	PPC_STL" %0,0(%1) \n"
>> +"8:	subf    %0,%2,%0 \n"
>> +"9:	crclr   22\n"
>> +"10:\n"
>> +"	.section __ex_table,\"a\"\n"
>> +	PPC_LONG_ALIGN "\n"
>> +	PPC_LONG "2b,1b\n"
>> +	PPC_LONG "3b,1b\n"
>> +	PPC_LONG "4b,1b\n"
>> +	PPC_LONG "5b,1b\n"
>> +	PPC_LONG "6b,1b\n"
>> +	PPC_LONG "7b,1b\n"
>> +	PPC_LONG "8b,8b\n"
>> +	PPC_LONG "9b,9b\n"
>> +"	.previous\n"
>> +	: "=&r" (t)
>> +	: "r" (&(l->a.counter)), "r" (a), "r" (u)
>> +	: "cc", "memory");
>> +
>> +	return t != u;
>> +}
>> +
>> +#define local_inc_not_zero(l) local_add_unless((l), 1, 0)
>> +
>> +#define local_sub_and_test(a, l)	(local_sub_return((a), (l)) == 0)
>> +#define local_dec_and_test(l)		(local_dec_return((l)) == 0)
>> +
>> +/*
>> + * Atomically test *l and decrement if it is greater than 0.
>> + * The function returns the old value of *l minus 1.
>> + */
>> +static __inline__ long local_dec_if_positive(local_t *l)
>> +{
>> +	long t;
>> +
>> +	__asm__ __volatile__(
>> +"1:	crset 22\n"
>> +"2:"	PPC_LL" %0,0(%1)\n"
>> +"3:	cmpwi   %0,1\n"
>> +"4:	addi    %0,%0,-1\n"
>> +"5:	blt-    8f\n"
>> +"6:"	PPC405_ERR77(0,%1)
>> +"7:"	PPC_STL "%0,0(%1)\n"
>> +"8:	crclr   22\n"
>> +"9:\n"
>> +"	.section__ex_table,\"a\"\n"
>> +	PPC_LONG_ALIGN "\n"
>> +	PPC_LONG "2b,1b\n"
>> +	PPC_LONG "3b,1b\n"
>> +	PPC_LONG "4b,1b\n"
>> +	PPC_LONG "5b,1b\n"
>> +	PPC_LONG "6b,1b\n"
>> +	PPC_LONG "7b,1b\n"
>> +	PPC_LONG "8b,8b\n"
>> +"	.previous\n"
>> +	: "=&b" (t)
>> +	: "r" (&(l->a.counter))
>> +	: "cc", "memory");
>> +
>> +	return t;
>> +}
>> +
>> +#else
>> +
>>  #define local_read(l)	atomic_long_read(&(l)->a)
>>  #define local_set(l,i)	atomic_long_set(&(l)->a, (i))
>>  
>> @@ -162,6 +466,8 @@ static __inline__ long local_dec_if_positive(local_t *l)
>>  	return t;
>>  }
>>  
>> +#endif
>> +
>>  /* Use these for per-cpu local_t variables: on some archs they are
>>   * much more efficient than these naive implementations.  Note they take
>>   * a variable, not an address.
>> -- 
>> 1.9.1
>>
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@lists.ozlabs.org
>> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
