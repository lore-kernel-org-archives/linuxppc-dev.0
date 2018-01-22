Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zQ3ZP5MFdzF0Wb
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jan 2018 18:53:00 +1100 (AEDT)
Subject: Re: [PATCH v2 1/5] powerpc/mm: Enhance 'slice' for supporting PPC32
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <49148d07955d3e5f963cedf9adcfcc37c3e03ef4.1516179904.git.christophe.leroy@c-s.fr>
 <87vafyz265.fsf@linux.vnet.ibm.com>
 <84dc1df4-db2f-be11-c1f3-5dddd1e44983@c-s.fr>
 <b4d8f01b-9ee1-ec34-aa0d-5a353064438c@linux.vnet.ibm.com>
 <28c3ba39-ef31-5ff3-7672-3e9d1942be94@c-s.fr>
 <c9ab9a1b-4c77-fdfc-50d1-974388cc3b10@linux.vnet.ibm.com>
 <e2f36c99-1b5d-acf5-12c8-b2b48701011a@c-s.fr>
 <36e8d873-4021-4266-bf5f-287f396ba9e1@c-s.fr>
 <20180120175655.GY21977@gate.crashing.org>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <52c000dd-1625-a205-8ad1-04376beed2ab@c-s.fr>
Date: Mon, 22 Jan 2018 08:52:53 +0100
MIME-Version: 1.0
In-Reply-To: <20180120175655.GY21977@gate.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 20/01/2018 à 18:56, Segher Boessenkool a écrit :
> Hi!
> 
> On Sat, Jan 20, 2018 at 09:22:50AM +0100, christophe leroy wrote:
>>>>>>>>> On PPC32, the address space is limited to 4Gbytes, hence only the
>>>>>>>>> low
>>>>>>>>> slices will be used. As of today, the code uses
>>>>>>>>> SLICE_LOW_TOP (0x100000000ul) and compares it with addr to determine
>>>>>>>>> if addr refers to low or high space.
>>>>>>>>> On PPC32, such a (addr < SLICE_LOW_TOP) test is always false because
>>>>>>>>> 0x100000000ul degrades to 0. Therefore, the patch modifies
>>>>>>>>> SLICE_LOW_TOP to (0xfffffffful) and modifies the tests to
>>>>>>>>> (addr <= SLICE_LOW_TOP) which will then always be true on PPC32
>>>>>>>>> as addr has type 'unsigned long' while not modifying the PPC64
>>>>>>>>> behaviour.
> 
> It should work to define SLICE_LOW_TOP as 0x100000000ull and keep
> everything else the same, no?

great, yes it works indeed.

> 
>>> I don't think so. When I had the missing prototype, the compilation goes
>>> ok, including the final link. Which means at the end the code is not
>>> included since radix_enabled() evaluates to 0.
>>>
>>> Many many parts of the kernel are based on this assumption.
>>
>> Segher, what is your opinion on the above ? Can we consider that a ' if
>> (nbits)' will always be compiled out when nbits is a #define constant,
>> or should we duplicate the macros as suggested in order to avoid
>> unneccessary 'if' test on platforms where 'nbits' is always not null by
>> definition ?
> 
> Doing things like
> 
> 	if (nbits)
> 		some_undeclared_function();
> 
> will likely work in practice if the condition evaluates to false at
> compile time, but a) it will warn; b) it is just yuck; and c) it will
> not always work (for example, you get the wrong prototype in this case,
> not lethal here with most ABIs, but ugh).
> 
> Just make sure to declare all functions, or define it to some empty
> thing, or #ifdeffery if you have to.  There are many options, it is
> not hard, and if it means you have to pull code further apart that is
> not so bad: you get cleaner, clearer code.

Ok, if I understand well, your comment applies to the following indeed, 
so you confirm the #ifdef is necessary.

--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -553,9 +553,11 @@ unsigned long hugetlb_get_unmapped_area(struct file 
*file, unsigned long addr,
  	struct hstate *hstate = hstate_file(file);
  	int mmu_psize = shift_to_mmu_psize(huge_page_shift(hstate));

+#ifdef CONFIG_PPC_RADIX_MMU
  	if (radix_enabled())
  		return radix__hugetlb_get_unmapped_area(file, addr, len,
  						       pgoff, flags);
+#endif
  	return slice_get_unmapped_area(addr, len, flags, mmu_psize, 1);
  }
  #endif


However, my question was related to another part of the current 
patchset, where the functions are always refined:


On PPC32 we set:

+#define SLICE_LOW_SHIFT		28
+#define SLICE_HIGH_SHIFT	0

On PPC64 we set:

  #define SLICE_LOW_SHIFT		28
  #define SLICE_HIGH_SHIFT	40

We define:

+#define slice_bitmap_zero(dst, nbits) \
+	do { if (nbits) bitmap_zero(dst, nbits); } while (0)


We have a function with:
{
	slice_bitmap_zero(ret->low_slices, SLICE_NUM_LOW);
  	slice_bitmap_zero(ret->high_slices, SLICE_NUM_HIGH);
}

So the question is to find the better approach. Is the above approach 
correct, including performance wise ?
Or should we define two sets of the macro slice_bitmap_zero(), one for 
CONFIG_PPC32 with the 'if (nbits)' test and one for CONFIG_PPC64 without 
the unnecessary test ?

Or should we avoid this macro entirely and instead do something like:

{
	bitmap_zero(ret->low_slices, SLICE_NUM_LOW);
#if SLICE_NUM_HIGH != 0
  	bitmap_zero(ret->high_slices, SLICE_NUM_HIGH);
#endif
}

And if we say the 'macro' approach is OK, should it be better the use a 
static inline function instead ?

Thanks,
Christophe
