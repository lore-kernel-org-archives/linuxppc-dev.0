Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 403p7f36jJzDqgg
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Mar 2018 16:45:18 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2I5iKVg075794
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Mar 2018 01:45:15 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gsgaatf6m-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Mar 2018 01:45:15 -0400
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sun, 18 Mar 2018 05:45:13 -0000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, benh@kernel.crashing.org,
 paulus@samba.org
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V4 1/3] powerpc/mm: Add support for handling > 512TB
 address in SLB miss
In-Reply-To: <87h8pgfryr.fsf@concordia.ellerman.id.au>
References: <20180307121440.20188-1-aneesh.kumar@linux.vnet.ibm.com>
 <20180307121440.20188-2-aneesh.kumar@linux.vnet.ibm.com>
 <87h8pgfryr.fsf@concordia.ellerman.id.au>
Date: Sun, 18 Mar 2018 11:14:05 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <878taqgcpm.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman <mpe@ellerman.id.au> writes:

> Hi Aneesh,
>
> Some comments ...
>
> "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:
>> For address above 512TB we allocate additional mmu context. To make it a=
ll
>> easy address above 512TB is handled with IR/DR=3D1 and with stack frame =
setup.
>>
>> We do the additional context allocation in SLB miss handler. If the cont=
ext is
>> not allocated, we enable interrupts and allocate the context and retry t=
he
>> access which will again result in a SLB miss.
>>
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>
> This doesn't build for g5_defconfig:
>
>   In file included from ../arch/powerpc/include/asm/mmu.h:314:0,
>                    from ../arch/powerpc/include/asm/lppaca.h:36,
>                    from ../arch/powerpc/include/asm/paca.h:21,
>                    from ../arch/powerpc/include/asm/hw_irq.h:63,
>                    from ../arch/powerpc/include/asm/irqflags.h:12,
>                    from ../include/linux/irqflags.h:16,
>                    from ../include/linux/spinlock.h:54,
>                    from ../include/linux/mmzone.h:8,
>                    from ../arch/powerpc/include/asm/pgtable.h:7,
>                    from ../arch/powerpc/mm/slb.c:17:
>   ../arch/powerpc/mm/slb.c: In function =E2=80=98handle_multi_context_slb=
_miss=E2=80=99:
>   ../arch/powerpc/include/asm/book3s/64/mmu.h:208:25: error: array subscr=
ipt is above array bounds [-Werror=3Darray-bounds]
>     return ctx->extended_id[index];
>            ~~~~~~~~~~~~~~~~^~~~~~~
>   ../arch/powerpc/mm/slb.c:417:30: error: array subscript is above array =
bounds [-Werror=3Darray-bounds]
>     if (!mm->context.extended_id[index])
>          ~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
>   ../arch/powerpc/mm/slb.c:418:26: error: array subscript is above array =
bounds [-Werror=3Darray-bounds]
>      mm->context.extended_id[index] =3D context_id;
>      ~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~

I guess gcc is getting it wrong with ARRAY_SIZE is 1. I added the below:

static inline int get_ea_context(mm_context_t *ctx, unsigned long ea)
{
	int index =3D ea >> MAX_EA_BITS_PER_CONTEXT;

	if (likely(index < ARRAY_SIZE(ctx>extended_id)))
		return ctx->extended_id[index];
	/* should never happen */
	BUG();
}


>
>
>> diff --git a/arch/powerpc/include/asm/book3s/64/hash-4k.h b/arch/powerpc=
/include/asm/book3s/64/hash-4k.h
>> index 67c5475311ee..af2ba9875f18 100644
>> --- a/arch/powerpc/include/asm/book3s/64/hash-4k.h
>> +++ b/arch/powerpc/include/asm/book3s/64/hash-4k.h
>> @@ -11,6 +11,12 @@
>>  #define H_PUD_INDEX_SIZE  9
>>  #define H_PGD_INDEX_SIZE  9
>>=20=20
>> +/*
>> + * No of address bits below which we use the default context
>
> Can we use "Number", "No" means no, to mean number you need "No." but
> that's ugly.
>
>> + * for slb allocation. For 4k this is 64TB.
>> + */
>> +#define H_BITS_FIRST_CONTEXT	46
>
> It's actually the number of address bits *per* context right?
>
> "Context" is also a bit of a overloaded term, eg. context !=3D
> mm_context_t, maybe "context id" would be clearer?
>
> So maybe H_BITS_PER_CONTEXT_ID?
>
>
> This values is essentially VA_BITS - CONTEXT_BITS right?
>
> Except VA_BITS is actually 65 in this case, but that's not clear at all
> from the code :/
>
> It'd be really nice if this was calculated, or if the other values
> (VA_BITS/CONTEXT_BITS) were calculated based on it.

How about=20
/*
 * Each context is 512TB. But on 4k we restrict our max TASK size to 64TB
 * Hence also limit max EA bits to 64TB.
 */
#define MAX_EA_BITS_PER_CONTEXT		46

The VA bits is a bit complex with different platforms having different
restrictions. With 4k page size we still use VA bits as 68. We limit the
task size to 64TB there because of performance issue w.r.t to supporting
largere task size with 4K linux page size.

Now on p4 and p5 we do have hardware restrictions on VA bits. We default
there to 65.

IMHO we should keep the above #define independent of VA bits. It is an
indication of size of the address space context, which can possibily
smaller than what the EA and context bits combination can support as in
4K.


>
>> diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerp=
c/include/asm/book3s/64/hash-64k.h
>> index 3bcf269f8f55..0ee0fc1ad675 100644
>> --- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
>> +++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
>> @@ -6,6 +6,11 @@
>>  #define H_PMD_INDEX_SIZE  10
>>  #define H_PUD_INDEX_SIZE  7
>>  #define H_PGD_INDEX_SIZE  8
>
> Can we get some newlines between code?
>
>> +/*
>> + * No of address bits below which we use the default context
>> + * for slb allocation. For 64k this is 512TB.
>> + */
>> +#define H_BITS_FIRST_CONTEXT	49

The coding style I was following here and other parts of code was
for multi block comments.
a =3D 10;
/*
 * Comment here
 */

and for single line comment
a =3D 10;

/* Comment here */

The idea was the first line of the multiblock comment introduced the
blank line needed. I have switched to what you suggested. Let me know if
you have any preferences w.r.t the above two styles.

>
> This really is =3D=3D VA_BITS - CONTEXT_BITS.
>
>> diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerp=
c/include/asm/book3s/64/mmu-hash.h
>> index 50ed64fba4ae..8ee83f6e9c84 100644
>> --- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
>> +++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
>> @@ -691,8 +691,8 @@ static inline int user_segment_size(unsigned long ad=
dr)
>>  	return MMU_SEGSIZE_256M;
>>  }
>>=20=20
>> -static inline unsigned long get_vsid(unsigned long context, unsigned lo=
ng ea,
>> -				     int ssize)
>> +static inline unsigned long __get_vsid(unsigned long context, unsigned =
long ea,
>> +				       int ssize)
>
> If you're going to realign it the 'i' in int should line up with the 'u'
> in unsigned.
>
> Why did this become __get_vsid()? We don't have a get_vsid() that I can s=
ee?

switched to get_vsid()


>
>> diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/inc=
lude/asm/book3s/64/mmu.h
>> index 777778579305..a70adbb7ec56 100644
>> --- a/arch/powerpc/include/asm/book3s/64/mmu.h
>> +++ b/arch/powerpc/include/asm/book3s/64/mmu.h
>> @@ -91,7 +91,15 @@ struct slice_mask {
>>  };
>>=20=20
>>  typedef struct {
>> -	mm_context_id_t id;
>> +	union {
>> +		/*
>> +		 * One context for each 512TB.
>> +		 * First 512TB context is saved in id and is also used
>> +		 * as PIDR.
>> +		 */

	union {
		/*
		 * We use id as the PIDR content for radix. On hash we can use
		 * more than one id. The extended ids are used when we start
		 * having address above 512TB. We allocate one extended id
		 * for each 512TB. The new id is then used with the 49 bit
		 * EA to build a new VA. We always use ESID_BITS_1T_MASK bits
		 * from EA and new context ids to build the new VAs.
		 */
		mm_context_id_t id;
		mm_context_id_t extended_id[TASK_SIZE_USER64/TASK_CONTEXT_SIZE];
	};


>
> Can you make it clearer how this is used on hash vs radix.
>
>> +		mm_context_id_t id;
>> +		mm_context_id_t extended_id[TASK_SIZE_USER64/TASK_CONTEXT_SIZE];
>
> If my math is right this is typically 4PB / 512T =3D=3D 8 =3D=3D 64 bytes.
>
> Which is small enough to not worry about, but would be good to mention
> in the change log at least.
>
>> +	};
>>  	u16 user_psize;		/* page size index */
>>=20=20
>>  	/* Number of bits in the mm_cpumask */
>> @@ -193,5 +201,21 @@ extern void radix_init_pseries(void);
>>  static inline void radix_init_pseries(void) { };
>>  #endif
>>=20=20
>> +static inline int get_esid_context(mm_context_t *ctx, unsigned long ea)
>> +{
>> +	int index =3D ea >> H_BITS_FIRST_CONTEXT;
>
> Using "esid" in the name is a bit confusing, because the value is an EA,
> not an ESID. So change the name or what's passed?
>
> I think change the name, the callers both have an EA so it makes sense
> to pass that.

changed to get_ea_context()

>
>> +
>
> I know we check ea elsewhere, but a:
>
>   VM_BUG_ON(index >=3D ARRAY_SIZE(extened_id))
>
> Would make me feel better I think, and index being unsigned.
>
>> diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include=
/asm/processor.h
>> index 01299cdc9806..70d65b482504 100644
>> --- a/arch/powerpc/include/asm/processor.h
>> +++ b/arch/powerpc/include/asm/processor.h
>> @@ -119,9 +119,16 @@ void release_thread(struct task_struct *);
>>   */
>>  #define TASK_SIZE_USER64		TASK_SIZE_512TB
>>  #define DEFAULT_MAP_WINDOW_USER64	TASK_SIZE_128TB
>> +#define TASK_CONTEXT_SIZE		TASK_SIZE_512TB
>>  #else
>>  #define TASK_SIZE_USER64		TASK_SIZE_64TB
>>  #define DEFAULT_MAP_WINDOW_USER64	TASK_SIZE_64TB
>> +/*
>> + * We don't need allocate extended context id for 4K
>> + * page size. We limit max address on this config to
>> + * 64TB.
>> + */
>
> /*
>  * We don't need to allocate extended context ids for 4K page size, becau=
se
>  * we limit the max effective address on this config to 64TB.
>  */
>
> ???
>
>> diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/=
exceptions-64s.S
>> index 3ac87e53b3da..166b8c0f1830 100644
>> --- a/arch/powerpc/kernel/exceptions-64s.S
>> +++ b/arch/powerpc/kernel/exceptions-64s.S
>> @@ -620,8 +620,12 @@ END_MMU_FTR_SECTION_IFCLR(MMU_FTR_TYPE_RADIX)
>>  	ld	r10,PACA_EXSLB+EX_LR(r13)
>>  	lwz	r9,PACA_EXSLB+EX_CCR(r13)	/* get saved CR */
>>  	mtlr	r10
>
> Blank line would be nice.
>
>> +	/*
>> +	 * Large address, check whether we have to allocate new
>> +	 * contexts.
>> +	 */
>
> That doesn't need to wrap.
>
> 	/* Large address, check whether we need to allocate new contexts. */
>
>> +	beq-	8f
>>=20=20
>> -	beq-	8f		/* if bad address, make full stack frame */
>
> And we ended up with two blank lines here which is probably overkill.
>=20=20
>> @@ -710,7 +714,7 @@ EXC_COMMON_BEGIN(bad_addr_slb)
>>  	std	r10, _TRAP(r1)
>>  2:	bl	save_nvgprs
>>  	addi	r3, r1, STACK_FRAME_OVERHEAD
>> -	bl	slb_miss_bad_addr
>
> You removed the only call to this but didn't remove the function or its
> prototype AFAICS.
>
>> diff --git a/arch/powerpc/mm/mmu_context_book3s64.c b/arch/powerpc/mm/mm=
u_context_book3s64.c
>> index 80acad52b006..ccc88fa7c35c 100644
>> --- a/arch/powerpc/mm/mmu_context_book3s64.c
>> +++ b/arch/powerpc/mm/mmu_context_book3s64.c
>> @@ -178,6 +178,19 @@ void __destroy_context(int context_id)
>>  }
>>  EXPORT_SYMBOL_GPL(__destroy_context);
>>=20=20
>> +static void destroy_contexts(mm_context_t *ctx)
>> +{
>> +	int index, context_id;
>> +
>> +	spin_lock(&mmu_context_lock);
>> +	for (index =3D 0; index < (TASK_SIZE_USER64/TASK_CONTEXT_SIZE); index+=
+) {
>
> ARRAY_SIZE(ctx->extended_id) ?
>
>> diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
>> index 13cfe413b40d..a93887ee9b22 100644
>> --- a/arch/powerpc/mm/slb.c
>> +++ b/arch/powerpc/mm/slb.c
>> @@ -23,6 +23,7 @@
>>  #include <asm/smp.h>
>>  #include <linux/compiler.h>
>>  #include <linux/mm_types.h>
>> +#include <linux/context_tracking.h>
>
> Our includes are generally not well sorted, but can you try to keep them
> alphabetical. So after compiler.h.
>
>> @@ -340,3 +341,156 @@ void slb_initialize(void)
>>=20=20
>>  	asm volatile("isync":::"memory");
>>  }
>> +
>> +/*
>> + * Only handle insert of 1TB slb entries.
>
> What if we don't have them (enabled) ?
>
>> + */
>> +static void insert_slb_entry(unsigned long vsid, unsigned long ea,
>> +			     int bpsize, int ssize)
>
> Parameter alignment again.
>
>> +{
>> +	int slb_cache_index;
>> +	unsigned long flags;
>> +	enum slb_index index;
>> +	unsigned long vsid_data, esid_data;
>
> Can you clean those up:
>
> 	unsigned long vsid_data, esid_data, flags;
> 	enum slb_index index;
> 	int slb_cache_index;

The style I was following here and other parts of the code was

int a;
int ab;
int abc;

instead of
int abc;
int ab;
int a;

I like the former. If you have strong preference I will switch to the later

>
>> +
>> +	/*
>> +	 * We are irq disabled, hence should be safe
>> +	 * to access PACA.
>
> Doesn't need to wrap.
>
>> +	 */
>> +	index =3D  get_paca()->stab_rr;
>                 ^
> Unneeded extra space there
>
> Blank line please.
>
>> +	/*
>> +	 * simple round roubin replacement of slb.
>
> "Simple round-robin"
>
> Although it's not really, it's round-robin but not starting at zero,
> starting at SLB_NUM_BOLTED.
>
>> +	 */
>> +	if (index < mmu_slb_size)
>> +		index++;
>> +	else
>> +		index =3D SLB_NUM_BOLTED;
>
> Blank line.
>
>> +	get_paca()->stab_rr =3D index;
>> +
>> +	flags =3D SLB_VSID_USER | mmu_psize_defs[bpsize].sllp;
>> +	vsid_data =3D  (vsid << SLB_VSID_SHIFT_1T) | flags |
>> +		((unsigned long) ssize << SLB_VSID_SSIZE_SHIFT);
>
> 	vsid_data =3D (vsid << SLB_VSID_SHIFT_1T) | flags |
>         	    ((unsigned long) ssize << SLB_VSID_SSIZE_SHIFT);
>
>> +	esid_data =3D mk_esid_data(ea, mmu_highuser_ssize, index);
>> +
>> +	asm volatile("slbmte %0, %1" : : "r" (vsid_data), "r" (esid_data)
>> +		     : "memory");
> Blank line.
>> +	/*
>> +	 * Now update slb cache entries
>> +	 */
>> +	slb_cache_index =3D get_paca()->slb_cache_ptr;
>> +	if (slb_cache_index < SLB_CACHE_ENTRIES) {
>> +		/*
>> +		 * We have space in slb cache for optimized switch_slb().
>> +		 * Top 36 bits from esid_data as per ISA
>> +		 */
>> +		get_paca()->slb_cache[slb_cache_index++] =3D esid_data >> 28;
>> +	}
> Blank line.
>> +	/*
>> +	 * if we are full, just increment and return.
>> +	 */
>> +	get_paca()->slb_cache_ptr++;
>> +}
>> +
>> +static void alloc_extended_context(struct mm_struct *mm, unsigned long =
ea)
>> +{
>> +	int context_id;
>> +
>> +	int index =3D ea >> H_BITS_FIRST_CONTEXT;
>> +
>> +	/*
>> +	 * we need to do locking only here. If this value was not set before
>> +	 * we will have taken an SLB miss and will reach here. The value will
>> +	 * be either 0 or a valid extended context. We need to make sure two
>> +	 * parallel SLB miss don't end up allocating extended_context for the
>> +	 * same range. The locking below ensures that. For now we take the
>> +	 * heavy mmap_sem. But can be changed to per mm_context_t custom lock
>> +	 * if needed.
>> +	 */
>> +	down_read(&mm->mmap_sem);
>
>> +	context_id =3D hash__alloc_context_id();
>> +	if (context_id < 0) {
>> +		up_read(&mm->mmap_sem);
>> +		pagefault_out_of_memory();
>> +		return;
>> +	}
>
>> +	/* Check for parallel allocation after holding lock */
>> +	if (!mm->context.extended_id[index])
>> +		mm->context.extended_id[index] =3D context_id;
>> +	else
>> +		__destroy_context(context_id);
>
>> +	up_read(&mm->mmap_sem);
>> +}
>> +
>> +static void __handle_multi_context_slb_miss(struct pt_regs *regs,
>> +					    unsigned long ea)
>> +{
>> +	int context, bpsize;
>> +	unsigned long vsid;
>> +	struct mm_struct *mm =3D current->mm;
>> +
>> +	context =3D get_esid_context(&mm->context, ea);
>> +	if (!context) {
>> +		/*
>> +		 * haven't allocated context yet for this range.
>> +		 * Enable irq and allo context and return. We will
>> +		 * take an slb miss on this again and come here with
>> +		 * allocated context.
>> +		 */
>> +		/* We restore the interrupt state now */
>> +		if (!arch_irq_disabled_regs(regs))
>> +			local_irq_enable();
>> +		return alloc_extended_context(mm, ea);
>
> I guess I thought we'd do this somewhere in the slice code, when an
> address above the limit is first used?
>
> Doing it this way means a stray access to >=3D 512TB will get a lot
> further, ie. we'll come in here allocate a context etc, install an SLB
> entry and only then realise there's nothing mapped when we look in the
> hash. I'd prefer we caught it earlier if possible.

Good. I moved this to slice_get_unmapped_area. So in the final part of
slice code we now do

return_addr:
	if (need_extra_context(mm, newaddr)) {
		if (alloc_extended_context(mm, newaddr) < 0)
			return -ENOMEM;
	}
	return newaddr;



>
>> +	}
>> +	/*
>> +	 * We are always above 1TB, hence use high user segment size.
>> +	 */
>> +	vsid =3D __get_vsid(context, ea, mmu_highuser_ssize);
>> +	bpsize =3D get_slice_psize(mm, ea);
>> +
>> +	insert_slb_entry(vsid, ea, bpsize, mmu_highuser_ssize);
>> +}
>> +
>> +/*
>> + * exception_enter() handling? FIXME!!
>
> ???

stale comment removed
>
>> + */
>> +void handle_multi_context_slb_miss(struct pt_regs *regs)
>
> I don't love this name, maybe slb_miss_large_addr()?
>
> That would also free-up the non-underscore name for the actual core of
> the handler above.

Done, byt we still have asm code as multi_context_slb. I think you would
want that also changed? Any suggestion?
>
>> +{
>> +	enum ctx_state prev_state =3D exception_enter();
>> +	unsigned long ea =3D regs->dar;
>> +
>> +	/*
>> +	 * Kernel always runs with single context. Hence
>> +	 * anything that request for multi context is
>> +	 * considered bad slb request.
>> +	 */
>> +	if (!user_mode(regs))
>> +		return bad_page_fault(regs, ea, SIGSEGV);
>
> Can't copy/to_from_user() hit this case?

Thanks for catching this. What i really wanted there was to
differentiate between how we handle access from kernel and user.
It should essentially in the slb_bad_addr: hunk.

slb_bad_addr:
	if (user_mode(regs))
		_exception(SIGSEGV, regs, SEGV_BNDERR, ea);
	else
		bad_page_fault(regs, ea, SIGSEGV);
	exception_exit(prev_state);



>
>> +	if (REGION_ID(ea) !=3D USER_REGION_ID)
>> +		goto slb_bad_addr;
>
> Blank line please :)
>
>> +	/*
>> +	 * Are we beyound what the page table layout support ?
>
> "supports" ?
>
>> +	 */
>> +	if ((ea & ~REGION_MASK) >=3D H_PGTABLE_RANGE)
>> +		goto slb_bad_addr;
>> +
>> +#ifdef CONFIG_PPC_MM_SLICES
>
> That can only ever be true in this file, right?

yes.=20

>
>> +	/*
>> +	 * consider this as bad slb if we take an slb miss
>> +	 * on an address above addr limit.
>
> It's a bad "access" not a "bad slb".
>
> We should probably spell slb SLB in the comments too.
>
>> +	 */
>> +	if (ea >=3D current->mm->context.slb_addr_limit)
>> +		goto slb_bad_addr;
>> +#endif
>
> Blank ..
>
>> +	/* Lower address should be handled by asm code */
>
> "should have been handled"
>
>> +	if (ea < (1UL << H_BITS_FIRST_CONTEXT))
>> +		goto slb_bad_addr;
>> +
>> +	__handle_multi_context_slb_miss(regs, ea);
>> +	exception_exit(prev_state);
>> +	return;
>> +
>> +slb_bad_addr:
>> +	_exception(SIGSEGV, regs, SEGV_BNDERR, ea);
>> +	exception_exit(prev_state);
>> +}
>
> I think this would work better if we had:
>
> void slb_bad_addr(regs, ea)
> {
> 	_exception(SIGSEGV, regs, SEGV_BNDERR, ea);
> }
>
> ...
> void handle_multi_context_slb_miss(struct pt_regs *regs)
> {
> ...
> 	if (ea < (1UL << H_BITS_FIRST_CONTEXT)) {
> 		slb_bad_addr(regs, ea);
>                 goto out;
>         }

that would mean i will have a multi line if() in that code. All the
error path essentially does goto slb_bad_addr(). Any specific reason you
wanted that as a function? To avoid the two return paths ?


> ...
> 	__handle_multi_context_slb_miss(regs, ea);
> out:
> 	exception_exit(prev_state);
> }
>
>> diff --git a/arch/powerpc/mm/slb_low.S b/arch/powerpc/mm/slb_low.S
>> index 2c7c717fd2ea..c66cb06e73a1 100644
>> --- a/arch/powerpc/mm/slb_low.S
>> +++ b/arch/powerpc/mm/slb_low.S
>> @@ -75,10 +75,12 @@ ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_68_BIT_VA)
>>   */
>>  _GLOBAL(slb_allocate)
>>  	/*
>> -	 * check for bad kernel/user address
>> +	 * Check for address range for which we need to handle multi context. =
For
>> +         * the default context we allocate the slb via the fast path. F=
or large
>> +         * address we branch out to C-code and look at additional conte=
xt allocated.
>
> Leading white space is fubar.
>
>
> cheers
