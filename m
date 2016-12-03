Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tW7Hb0MJgzDvwd
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Dec 2016 21:56:27 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Balbir Singh <bsingharora@gmail.com>,
 Alistair Popple <alistair@popple.id.au>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH v2] powerpc/powernv: Initialise nest mmu
In-Reply-To: <CAKTCnzkAaKNtcTOGuyO=kkjFGFSObGeEf+Dy0qvTM7xXit5dJg@mail.gmail.com>
References: <1480656588-25504-1-git-send-email-alistair@popple.id.au>
 <CAKTCnzkAaKNtcTOGuyO=kkjFGFSObGeEf+Dy0qvTM7xXit5dJg@mail.gmail.com>
Date: Sat, 03 Dec 2016 21:56:22 +1100
Message-ID: <87twalxovd.fsf@concordia.ellerman.id.au>
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

Balbir Singh <bsingharora@gmail.com> writes:

> <snip>
>
>>  static void __init radix_init_partition_table(void)
>>  {
>> -       unsigned long rts_field;
>> +       unsigned long rts_field, ptcr;
>
> I think these functions have changed, check for conflicts against
> http://git.kernel.org/cgit/linux/kernel/git/paulus/powerpc.git/commit/?h=kvm-ppc-next&id=9d66195807ac6cb8a14231fd055ff755977c5fca

They did, I ended up with:

https://github.com/linuxppc/linux/commit/fb7314c5d6b00dbaaac14c28a52a87dee7e726df

modified   arch/powerpc/mm/pgtable_64.c
@@ -44,6 +44,7 @@
 #include <asm/mmu_context.h>
 #include <asm/pgtable.h>
 #include <asm/mmu.h>
+#include <asm/opal.h>
 #include <asm/smp.h>
 #include <asm/machdep.h>
 #include <asm/tlb.h>
@@ -435,7 +436,7 @@ void pgtable_free_tlb(struct mmu_gather *tlb, void *table, int shift)
 #ifdef CONFIG_PPC_BOOK3S_64
 void __init mmu_partition_table_init(void)
 {
-	unsigned long patb_size = 1UL << PATB_SIZE_SHIFT;
+	unsigned long ptcr, patb_size = 1UL << PATB_SIZE_SHIFT;
 
 	BUILD_BUG_ON_MSG((PATB_SIZE_SHIFT > 36), "Partition table size too large.");
 	partition_tb = __va(memblock_alloc_base(patb_size, patb_size,
@@ -448,7 +449,9 @@ void __init mmu_partition_table_init(void)
 	 * update partition table control register,
 	 * 64 K size.
 	 */
-	mtspr(SPRN_PTCR, __pa(partition_tb) | (PATB_SIZE_SHIFT - 12));
+	ptcr = __pa(partition_tb) | (PATB_SIZE_SHIFT - 12);
+	mtspr(SPRN_PTCR, ptcr);
+	powernv_set_ptcr(ptcr);
 }
 
 void mmu_partition_table_set_entry(unsigned int lpid, unsigned long dw0,


cheers
