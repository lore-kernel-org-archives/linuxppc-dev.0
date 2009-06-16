Return-Path: <Geoff.Thorpe@freescale.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id D99DDB7191
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Jun 2009 00:28:49 +1000 (EST)
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 609A1DDD04
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jun 2009 00:28:47 +1000 (EST)
Message-ID: <4A37AC09.1020200@freescale.com>
Date: Tue, 16 Jun 2009 10:28:25 -0400
From: Geoff Thorpe <Geoff.Thorpe@freescale.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] RFC: powerpc: expose the multi-bit ops that underlie
	single-bit ops.
References: <1243361946-6771-1-git-send-email-Geoff.Thorpe@freescale.com>
	<1245124418.12400.67.camel@pasglop>
In-Reply-To: <1245124418.12400.67.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thanks for taking the time to look at this Ben, comments inline.

Benjamin Herrenschmidt wrote:
> On Tue, 2009-05-26 at 14:19 -0400, Geoff Thorpe wrote:
>> NOT FOR COMMIT, THIS IS A REQUEST FOR FEEDBACK.
>>
>> The bitops.h functions that operate on a single bit in a bitfield are
>> implemented by operating on the corresponding word location. In all cases
>> the inner logic appears to be valid if the mask being applied has more
>> than one bit set, so this patch exposes those inner operations. Indeed,
>> set_bits() was already available, but it duplicated code from set_bit()
>> (rather than making the latter a wrapper) - it was also missing the
>> PPC405_ERR77() workaround and the "volatile" address qualifier present in
>> other APIs. This corrects that, and exposes the other multi-bit
>> equivalents.
>>
>> One advantage of these multi-bit forms is that they allow word-sized
>> variables to essentially be their own spinlocks.
> 
> Hi ! Sorry for the delay, that was on my "have a look one of these days,
> low priority" list for a bit too long :-)

NP, optimal throughput often requires a compromise in latency :-)

> 
>> NB, the same factoring is possible in asm-generic/bitops/[non-]atomic.h.
>> I would be happy to provide corresponding patches if this approach is
>> deemed appropriate. Feedback would be most welcome.
>>
>> Signed-off-by: Geoff Thorpe <Geoff.Thorpe@freescale.com>
>> ---
>>  arch/powerpc/include/asm/bitops.h |  111 +++++++++++++++++++++++--------------
>>  1 files changed, 69 insertions(+), 42 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/bitops.h b/arch/powerpc/include/asm/bitops.h
>> index 897eade..72de28c 100644
>> --- a/arch/powerpc/include/asm/bitops.h
>> +++ b/arch/powerpc/include/asm/bitops.h
>> @@ -56,11 +56,10 @@
>>  #define BITOP_WORD(nr)		((nr) / BITS_PER_LONG)
>>  #define BITOP_LE_SWIZZLE	((BITS_PER_LONG-1) & ~0x7)
>>  
>> -static __inline__ void set_bit(int nr, volatile unsigned long *addr)
>> +static __inline__ void set_bits(unsigned long mask, volatile unsigned long *_p)
>>  {
>>  	unsigned long old;
>> -	unsigned long mask = BITOP_MASK(nr);
>> -	unsigned long *p = ((unsigned long *)addr) + BITOP_WORD(nr);
>> +	unsigned long *p = (unsigned long *)_p;
>>  
>>  	__asm__ __volatile__(
>>  "1:"	PPC_LLARX "%0,0,%3	# set_bit\n"
>> @@ -73,11 +72,16 @@ static __inline__ void set_bit(int nr, volatile unsigned long *addr)
>>  	: "cc" );
>>  }
>>  
>> -static __inline__ void clear_bit(int nr, volatile unsigned long *addr)
>> +static __inline__ void set_bit(int nr, volatile unsigned long *addr)
>> +{
>> +	set_bits(BITOP_MASK(nr), addr + BITOP_WORD(nr));
>> +}
> 
> No objection with the above.
> 
>> +static __inline__ void clear_bits(unsigned long mask,
>> +				volatile unsigned long *_p)
>>  {
>>  	unsigned long old;
>> -	unsigned long mask = BITOP_MASK(nr);
>> -	unsigned long *p = ((unsigned long *)addr) + BITOP_WORD(nr);
>> +	unsigned long *p = (unsigned long *)_p;
>>  
>>  	__asm__ __volatile__(
>>  "1:"	PPC_LLARX "%0,0,%3	# clear_bit\n"
>> @@ -90,11 +94,16 @@ static __inline__ void clear_bit(int nr, volatile unsigned long *addr)
>>  	: "cc" );
>>  }
>>  
>> -static __inline__ void clear_bit_unlock(int nr, volatile unsigned long *addr)
>> +static __inline__ void clear_bit(int nr, volatile unsigned long *addr)
>> +{
>> +	clear_bits(BITOP_MASK(nr), addr + BITOP_WORD(nr));
>> +}
> 
> Looks good too.
> 
>> +static __inline__ void clear_bits_unlock(unsigned long mask,
>> +					volatile unsigned long *_p)
>>  {
>>  	unsigned long old;
>> -	unsigned long mask = BITOP_MASK(nr);
>> -	unsigned long *p = ((unsigned long *)addr) + BITOP_WORD(nr);
>> +	unsigned long *p = (unsigned long *)_p;
>>  
>>  	__asm__ __volatile__(
>>  	LWSYNC_ON_SMP
>> @@ -108,11 +117,16 @@ static __inline__ void clear_bit_unlock(int nr, volatile unsigned long *addr)
>>  	: "cc", "memory");
>>  }
>>  
>> -static __inline__ void change_bit(int nr, volatile unsigned long *addr)
>> +static __inline__ void clear_bit_unlock(int nr, volatile unsigned long *addr)
>> +{
>> +	clear_bits_unlock(BITOP_MASK(nr), addr + BITOP_WORD(nr));
>> +}
> 
> I'm not sure it's useful to provide a multi-bit variant of the
> "lock" and "unlock" primitives. Do other archs do ?

For clear_bit_unlock(), no they don't appear to. There is a fallback in
include/asm-generic though, and I notice that it's used in a few places,
eg. drivers/rtc/rtc-dev. OTOH some other archs appear to provide their
own test_and_set_bit_lock(), and there's a fallback in
includes/asm-generic for that too.

Do you see a reason to isolate either of these and not factor out the
inner word-based logic?

> 
>> +static __inline__ void change_bits(unsigned long mask,
>> +				volatile unsigned long *_p)
>>  {
>>  	unsigned long old;
>> -	unsigned long mask = BITOP_MASK(nr);
>> -	unsigned long *p = ((unsigned long *)addr) + BITOP_WORD(nr);
>> +	unsigned long *p = (unsigned long *)_p;
>>  
>>  	__asm__ __volatile__(
>>  "1:"	PPC_LLARX "%0,0,%3	# change_bit\n"
>> @@ -125,12 +139,16 @@ static __inline__ void change_bit(int nr, volatile unsigned long *addr)
>>  	: "cc" );
>>  }
>>  
>> -static __inline__ int test_and_set_bit(unsigned long nr,
>> -				       volatile unsigned long *addr)
>> +static __inline__ void change_bit(int nr, volatile unsigned long *addr)
>> +{
>> +	change_bits(BITOP_MASK(nr), addr + BITOP_WORD(nr));
>> +}
> 
> Ah, patch is getting confused between change_bit and
> test_and_set_bit :-)

The diff machinery off-by-one'd the entire file, which makes the patch a
little more difficult to review. But I didn't feel like (further)
massacring the code in order to improve the diff. :-)

> 
> Now, you know what I'm thinking is ... Those are all the same except
> for:
> 
>  - Barriers for lock and unlock variants
>  - Barriers for "return" (aka test_and_set) variants
>  - Actual op done on the mask

Yup, believe it or not, I saw this coming but didn't have the guts to
try proposing something like it up-front (in particular, I was wary of
botching some subtleties in the assembly).

> 
> Maybe we can shrink that file significantly (and avoid the risk for
> typos etc...) by generating them all from a macro.
> 
> Something like (typed directly into the mailer :-)
> 
> #define DEFINE_BITOP(op, prefix, postfix) \
> 	asm volatile (			  \
> 	prefix				  \
> "1:"    PPC_LLARX "%0,0,%3\n"		  \
> 	__stringify(op) "%1,%0,%2\n"	  \
> 	PPC405_ERR77(0,%3)		  \
> 	PPC_STLCX "%1,0,%3\n"		  \
> 	"bne- 1b\n"			  \
> 	postfix				  \
> 	 : "=&r" (old), "=&r" (t)
> 	 : "r" (mask), "r" (p)
> 	 : "cc", "memory")
> 
> and so:
> 
> static inline void set_bits(unsigned long mask, volatile unsigned long *addr)
> {
> 	unsigned long old, t;
> 
> 	DEFINE_BITOP(or, "", "");
> }
> 
> static inline void test_and_set_bits(unsigned long mask, volatile unsigned long *addr)
> {
> 	unsigned long old, t;
> 
> 	DEFINE_BITOP(or, LWSYNC_ON_SMP, ISYNC_ON_SMP);
> 
> 	return (old & mask) != 0;
> }
> 
> etc...


Sounds good, I'll try working this up and I'll send a new patch shortly.

So can I assume implicitly that changing the set_bits() function to add
the 'volatile' qualifier to the prototype (and the missing
PPC405_ERR77() workaround) was OK?

Also - any opinion on whether the same re-factoring of the asm-generic
versions should be undertaken? I'm not looking to bite off more than I
can chew, but I don't know if it's frowned upon to make powerpc-only
extensions to the API. And if you think an asm-generic patch makes
sense, could that be taken via linuxppc-dev too or does it need to go
elsewhere?

Thanks again,
Geoff
