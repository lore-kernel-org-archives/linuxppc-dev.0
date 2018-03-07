Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zx9KL0w3wzF1Y4
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Mar 2018 21:45:42 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 10/10] powerpc/mm/slice: use the dynamic high slice
 size to limit bitmap operations
In-Reply-To: <20180307132232.4fe41c3b@roar.ozlabs.ibm.com>
References: <20180307013718.13749-1-npiggin@gmail.com>
 <20180307013718.13749-11-npiggin@gmail.com>
 <20180307132232.4fe41c3b@roar.ozlabs.ibm.com>
Date: Wed, 07 Mar 2018 21:45:37 +1100
Message-ID: <87po4gduzy.fsf@concordia.ellerman.id.au>
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

Nicholas Piggin <npiggin@gmail.com> writes:
> On Wed,  7 Mar 2018 11:37:18 +1000
> Nicholas Piggin <npiggin@gmail.com> wrote:
>
>> The number of high slices a process might use now depends on its
>> address space size, and what allocation address it has requested.
>> 
>> This patch uses that limit throughout call chains where possible,
>> rather than use the fixed SLICE_NUM_HIGH for bitmap operations.
>> This saves some cost for processes that don't use very large address
>> spaces.
>> 
>> Perormance numbers aren't changed significantly, this may change
>> with larger address spaces or different mmap access patterns that
>> require more slice mask building.
>
>
> Ignore this patch in the series. I didn't intend to send it.

Oops :D

I'll drop it and rebuild.

cheers

kisskb: Failed 206/268
http://kisskb.ellerman.id.au/kisskb/head/82bc47f26969f6ed290cda529b9893941923c0f4/
  Failed: powerpc-next/pseries_le_defconfig+NO_NUMA/ppc64le		(http://kisskb.ellerman.id.au/kisskb/buildresult/13296349/log/)
    /kisskb/src/arch/powerpc/mm/slice.c:81:2: error: #error XXX: bitmap_zero with non-const size? Good code?
    /kisskb/src/arch/powerpc/mm/slice.c:660:2: error: #error XXX: are we sure high_slices is > 0 here when SLICE_NUM_HIGH? Perhaps not for 32-bit tasks on 64?
  Failed: powerpc-next/pseries_le_defconfig+NO_SPLPAR/ppc64le		(http://kisskb.ellerman.id.au/kisskb/buildresult/13296347/log/)
    /kisskb/src/arch/powerpc/mm/slice.c:81:2: error: #error XXX: bitmap_zero with non-const size? Good code?
    /kisskb/src/arch/powerpc/mm/slice.c:660:2: error: #error XXX: are we sure high_slices is > 0 here when SLICE_NUM_HIGH? Perhaps not for 32-bit tasks on 64?
  Failed: powerpc-next/pseries_defconfig+NO_SPLPAR/powerpc-5.3		(http://kisskb.ellerman.id.au/kisskb/buildresult/13296346/log/)
    /kisskb/src/arch/powerpc/mm/slice.c:81:2: error: #error XXX: bitmap_zero with non-const size? Good code?
    /kisskb/src/arch/powerpc/mm/slice.c:660:2: error: #error XXX: are we sure high_slices is > 0 here when SLICE_NUM_HIGH? Perhaps not for 32-bit tasks on 64?
  Failed: powerpc-next/pseries_defconfig+NO_SPLPAR/powerpc		(http://kisskb.ellerman.id.au/kisskb/buildresult/13296345/log/)
    /kisskb/src/arch/powerpc/mm/slice.c:81:2: error: #error XXX: bitmap_zero with non-const size? Good code?
    /kisskb/src/arch/powerpc/mm/slice.c:660:2: error: #error XXX: are we sure high_slices is > 0 here when SLICE_NUM_HIGH? Perhaps not for 32-bit tasks on 64?
  Failed: powerpc-next/pmac32_defconfig+KVM/powerpc		(http://kisskb.ellerman.id.au/kisskb/buildresult/13296343/log/)
    /kisskb/src/arch/powerpc/kvm/powerpc.c:1361:2: error: 'emulated' may be used uninitialized in this function [-Werror=uninitialized]
  Failed: powerpc-next/allmodconfig+64K_PAGES/powerpc-5.3		(http://kisskb.ellerman.id.au/kisskb/buildresult/13296342/log/)
    /kisskb/src/arch/powerpc/mm/slice.c:81:2: error: #error XXX: bitmap_zero with non-const size? Good code?
    /kisskb/src/arch/powerpc/mm/slice.c:660:2: error: #error XXX: are we sure high_slices is > 0 here when SLICE_NUM_HIGH? Perhaps not for 32-bit tasks on 64?
  Failed: powerpc-next/allmodconfig+64K_PAGES/powerpc		(http://kisskb.ellerman.id.au/kisskb/buildresult/13296341/log/)
    /kisskb/src/arch/powerpc/mm/slice.c:81:2: error: #error XXX: bitmap_zero with non-const size? Good code?
    /kisskb/src/arch/powerpc/mm/slice.c:660:2: error: #error XXX: are we sure high_slices is > 0 here when SLICE_NUM_HIGH? Perhaps not for 32-bit tasks on 64?
  Failed: powerpc-next/skiroot_defconfig/ppc64le		(http://kisskb.ellerman.id.au/kisskb/buildresult/13296339/log/)
    /kisskb/src/arch/powerpc/mm/slice.c:81:2: error: #error XXX: bitmap_zero with non-const size? Good code?
    /kisskb/src/arch/powerpc/mm/slice.c:660:2: error: #error XXX: are we sure high_slices is > 0 here when SLICE_NUM_HIGH? Perhaps not for 32-bit tasks on 64?
  Failed: powerpc-next/powernv_defconfig+NO_NUMA/ppc64le		(http://kisskb.ellerman.id.au/kisskb/buildresult/13296338/log/)
    /kisskb/src/arch/powerpc/mm/slice.c:81:2: error: #error XXX: bitmap_zero with non-const size? Good code?
    /kisskb/src/arch/powerpc/mm/slice.c:660:2: error: #error XXX: are we sure high_slices is > 0 here when SLICE_NUM_HIGH? Perhaps not for 32-bit tasks on 64?
  Failed: powerpc-next/powernv_defconfig+STRICT_RWX/ppc64le		(http://kisskb.ellerman.id.au/kisskb/buildresult/13296337/log/)
    /kisskb/src/arch/powerpc/mm/slice.c:81:2: error: #error XXX: bitmap_zero with non-const size? Good code?
    /kisskb/src/arch/powerpc/mm/slice.c:660:2: error: #error XXX: are we sure high_slices is > 0 here when SLICE_NUM_HIGH? Perhaps not for 32-bit tasks on 64?
  Failed: powerpc-next/corenet64_smp_defconfig/powerpc-5.3		(http://kisskb.ellerman.id.au/kisskb/buildresult/13296332/log/)
    /kisskb/src/arch/powerpc/include/asm/hugetlb.h:101:10: error: implicit declaration of function 'slice_is_hugepage_only_range' [-Werror=implicit-function-declaration]
  Failed: powerpc-next/corenet32_smp_defconfig/powerpc-5.3		(http://kisskb.ellerman.id.au/kisskb/buildresult/13296331/log/)
    /kisskb/src/arch/powerpc/include/asm/hugetlb.h:101:10: error: implicit declaration of function 'slice_is_hugepage_only_range' [-Werror=implicit-function-declaration]
  Failed: powerpc-next/ppc64_defconfig+NO_HUGETLB/powerpc-5.3		(http://kisskb.ellerman.id.au/kisskb/buildresult/13296322/log/)
    /kisskb/src/arch/powerpc/mm/slice.c:81:2: error: #error XXX: bitmap_zero with non-const size? Good code?
    /kisskb/src/arch/powerpc/mm/slice.c:660:2: error: #error XXX: are we sure high_slices is > 0 here when SLICE_NUM_HIGH? Perhaps not for 32-bit tasks on 64?
  Failed: powerpc-next/ppc64_defconfig+NO_KVM/powerpc-5.3		(http://kisskb.ellerman.id.au/kisskb/buildresult/13296321/log/)
    /kisskb/src/arch/powerpc/mm/slice.c:81:2: error: #error XXX: bitmap_zero with non-const size? Good code?
    /kisskb/src/arch/powerpc/mm/slice.c:660:2: error: #error XXX: are we sure high_slices is > 0 here when SLICE_NUM_HIGH? Perhaps not for 32-bit tasks on 64?
  Failed: powerpc-next/pseries_defconfig+NO_MEMORY_HOTPLUG/powerpc-5.3		(http://kisskb.ellerman.id.au/kisskb/buildresult/13296319/log/)
    /kisskb/src/arch/powerpc/mm/slice.c:81:2: error: #error XXX: bitmap_zero with non-const size? Good code?
    /kisskb/src/arch/powerpc/mm/slice.c:660:2: error: #error XXX: are we sure high_slices is > 0 here when SLICE_NUM_HIGH? Perhaps not for 32-bit tasks on 64?
  Failed: powerpc-next/powerpc-randconfig/powerpc-5.3		(http://kisskb.ellerman.id.au/kisskb/buildresult/13296317/log/)
    /kisskb/src/arch/powerpc/kernel/watchdog.c:168:3: error: implicit declaration of function 'smp_flush_nmi_ipi' [-Werror=implicit-function-declaration]
    /kisskb/src/arch/powerpc/mm/slice.c:81:2: error: #error XXX: bitmap_zero with non-const size? Good code?
    /kisskb/src/arch/powerpc/kernel/watchdog.c:166:4: error: implicit declaration of function 'smp_send_nmi_ipi' [-Werror=implicit-function-declaration]
    /kisskb/src/arch/powerpc/mm/slice.c:660:2: error: #error XXX: are we sure high_slices is > 0 here when SLICE_NUM_HIGH? Perhaps not for 32-bit tasks on 64?
  Failed: powerpc-next/ppc64_defconfig+NO_TM/powerpc-5.3		(http://kisskb.ellerman.id.au/kisskb/buildresult/13296316/log/)
    /kisskb/src/arch/powerpc/mm/slice.c:81:2: error: #error XXX: bitmap_zero with non-const size? Good code?
    /kisskb/src/arch/powerpc/mm/slice.c:660:2: error: #error XXX: are we sure high_slices is > 0 here when SLICE_NUM_HIGH? Perhaps not for 32-bit tasks on 64?
  Failed: powerpc-next/pseries_defconfig+NO_MEMORY_HOTREMOVE/powerpc		(http://kisskb.ellerman.id.au/kisskb/buildresult/13296292/log/)
    /kisskb/src/arch/powerpc/mm/slice.c:81:2: error: #error XXX: bitmap_zero with non-const size? Good code?
    /kisskb/src/arch/powerpc/mm/slice.c:660:2: error: #error XXX: are we sure high_slices is > 0 here when SLICE_NUM_HIGH? Perhaps not for 32-bit tasks on 64?
  Failed: powerpc-next/mpc85xx_smp_defconfig/powerpc-5.3		(http://kisskb.ellerman.id.au/kisskb/buildresult/13296256/log/)
    /kisskb/src/arch/powerpc/include/asm/hugetlb.h:101:10: error: implicit declaration of function 'slice_is_hugepage_only_range' [-Werror=implicit-function-declaration]
  Failed: powerpc-next/ppc64_defconfig+UP/powerpc-5.3		(http://kisskb.ellerman.id.au/kisskb/buildresult/13296248/log/)
    /kisskb/src/arch/powerpc/mm/slice.c:81:2: error: #error XXX: bitmap_zero with non-const size? Good code?
    /kisskb/src/arch/powerpc/mm/slice.c:660:2: error: #error XXX: are we sure high_slices is > 0 here when SLICE_NUM_HIGH? Perhaps not for 32-bit tasks on 64?
  Failed: powerpc-next/ppc64_defconfig+NO_ALTIVEC/powerpc-5.3		(http://kisskb.ellerman.id.au/kisskb/buildresult/13296247/log/)
    /kisskb/src/arch/powerpc/mm/slice.c:81:2: error: #error XXX: bitmap_zero with non-const size? Good code?
    /kisskb/src/arch/powerpc/mm/slice.c:660:2: error: #error XXX: are we sure high_slices is > 0 here when SLICE_NUM_HIGH? Perhaps not for 32-bit tasks on 64?
  Failed: powerpc-next/powerpc-allyesconfig/powerpc-5.3		(http://kisskb.ellerman.id.au/kisskb/buildresult/13296246/log/)
    /kisskb/src/arch/powerpc/mm/slice.c:81:2: error: #error XXX: bitmap_zero with non-const size? Good code?
    /kisskb/src/arch/powerpc/mm/slice.c:660:2: error: #error XXX: are we sure high_slices is > 0 here when SLICE_NUM_HIGH? Perhaps not for 32-bit tasks on 64?
  Failed: powerpc-next/powerpc-allmodconfig/powerpc-5.3		(http://kisskb.ellerman.id.au/kisskb/buildresult/13296243/log/)
    /kisskb/src/arch/powerpc/mm/slice.c:81:2: error: #error XXX: bitmap_zero with non-const size? Good code?
    /kisskb/src/arch/powerpc/mm/slice.c:660:2: error: #error XXX: are we sure high_slices is > 0 here when SLICE_NUM_HIGH? Perhaps not for 32-bit tasks on 64?
  Failed: powerpc-next/ppc64_defconfig/powerpc-5.3		(http://kisskb.ellerman.id.au/kisskb/buildresult/13296239/log/)
    /kisskb/src/arch/powerpc/mm/slice.c:81:2: error: #error XXX: bitmap_zero with non-const size? Good code?
    /kisskb/src/arch/powerpc/mm/slice.c:660:2: error: #error XXX: are we sure high_slices is > 0 here when SLICE_NUM_HIGH? Perhaps not for 32-bit tasks on 64?
  Failed: powerpc-next/mpc85xx_defconfig/powerpc-5.3		(http://kisskb.ellerman.id.au/kisskb/buildresult/13296233/log/)
    /kisskb/src/arch/powerpc/include/asm/hugetlb.h:101:10: error: implicit declaration of function 'slice_is_hugepage_only_range' [-Werror=implicit-function-declaration]
  Failed: powerpc-next/pasemi_defconfig/powerpc-5.3		(http://kisskb.ellerman.id.au/kisskb/buildresult/13296230/log/)
    /kisskb/src/arch/powerpc/mm/slice.c:81:2: error: #error XXX: bitmap_zero with non-const size? Good code?
    /kisskb/src/arch/powerpc/mm/slice.c:660:2: error: #error XXX: are we sure high_slices is > 0 here when SLICE_NUM_HIGH? Perhaps not for 32-bit tasks on 64?
  Failed: powerpc-next/ps3_defconfig/powerpc-5.3		(http://kisskb.ellerman.id.au/kisskb/buildresult/13296229/log/)
    /kisskb/src/arch/powerpc/mm/slice.c:81:2: error: #error XXX: bitmap_zero with non-const size? Good code?
    /kisskb/src/arch/powerpc/mm/slice.c:660:2: error: #error XXX: are we sure high_slices is > 0 here when SLICE_NUM_HIGH? Perhaps not for 32-bit tasks on 64?
  Failed: powerpc-next/maple_defconfig/powerpc-5.3		(http://kisskb.ellerman.id.au/kisskb/buildresult/13296228/log/)
    /kisskb/src/arch/powerpc/mm/slice.c:81:2: error: #error XXX: bitmap_zero with non-const size? Good code?
    /kisskb/src/arch/powerpc/mm/slice.c:660:2: error: #error XXX: are we sure high_slices is > 0 here when SLICE_NUM_HIGH? Perhaps not for 32-bit tasks on 64?
  Failed: powerpc-next/g5_defconfig/powerpc-5.3		(http://kisskb.ellerman.id.au/kisskb/buildresult/13296227/log/)
    /kisskb/src/arch/powerpc/mm/slice.c:81:2: error: #error XXX: bitmap_zero with non-const size? Good code?
    /kisskb/src/arch/powerpc/mm/slice.c:660:2: error: #error XXX: are we sure high_slices is > 0 here when SLICE_NUM_HIGH? Perhaps not for 32-bit tasks on 64?
  Failed: powerpc-next/cell_defconfig/powerpc-5.3		(http://kisskb.ellerman.id.au/kisskb/buildresult/13296225/log/)
    /kisskb/src/arch/powerpc/mm/slice.c:81:2: error: #error XXX: bitmap_zero with non-const size? Good code?
    /kisskb/src/arch/powerpc/mm/slice.c:660:2: error: #error XXX: are we sure high_slices is > 0 here when SLICE_NUM_HIGH? Perhaps not for 32-bit tasks on 64?
  Failed: powerpc-next/pseries_defconfig/powerpc-5.3		(http://kisskb.ellerman.id.au/kisskb/buildresult/13296222/log/)
    /kisskb/src/arch/powerpc/mm/slice.c:81:2: error: #error XXX: bitmap_zero with non-const size? Good code?
    /kisskb/src/arch/powerpc/mm/slice.c:660:2: error: #error XXX: are we sure high_slices is > 0 here when SLICE_NUM_HIGH? Perhaps not for 32-bit tasks on 64?
  Failed: powerpc-next/powernv_defconfig/ppc64le		(http://kisskb.ellerman.id.au/kisskb/buildresult/13296221/log/)
    /kisskb/src/arch/powerpc/mm/slice.c:81:2: error: #error XXX: bitmap_zero with non-const size? Good code?
    /kisskb/src/arch/powerpc/mm/slice.c:660:2: error: #error XXX: are we sure high_slices is > 0 here when SLICE_NUM_HIGH? Perhaps not for 32-bit tasks on 64?
  Failed: powerpc-next/ppc64_defconfig+NO_ALTIVEC/powerpc		(http://kisskb.ellerman.id.au/kisskb/buildresult/13296219/log/)
    /kisskb/src/arch/powerpc/mm/slice.c:81:2: error: #error XXX: bitmap_zero with non-const size? Good code?
    /kisskb/src/arch/powerpc/mm/slice.c:660:2: error: #error XXX: are we sure high_slices is > 0 here when SLICE_NUM_HIGH? Perhaps not for 32-bit tasks on 64?
    /kisskb/src/arch/powerpc/kvm/powerpc.c:1611:1: error: label 'out' defined but not used [-Werror=unused-label]
  Failed: powerpc-next/corenet64_smp_defconfig/powerpc		(http://kisskb.ellerman.id.au/kisskb/buildresult/13296213/log/)
    /kisskb/src/arch/powerpc/include/asm/hugetlb.h:101:3: error: implicit declaration of function 'slice_is_hugepage_only_range' [-Werror=implicit-function-declaration]
  Failed: powerpc-next/corenet32_smp_defconfig/powerpc		(http://kisskb.ellerman.id.au/kisskb/buildresult/13296212/log/)
    /kisskb/src/arch/powerpc/include/asm/hugetlb.h:101:3: error: implicit declaration of function 'slice_is_hugepage_only_range' [-Werror=implicit-function-declaration]
  Failed: powerpc-next/pseries_defconfig+FA_DUMP/powerpc-5.3		(http://kisskb.ellerman.id.au/kisskb/buildresult/13296201/log/)
    /kisskb/src/arch/powerpc/mm/slice.c:81:2: error: #error XXX: bitmap_zero with non-const size? Good code?
    /kisskb/src/arch/powerpc/mm/slice.c:660:2: error: #error XXX: are we sure high_slices is > 0 here when SLICE_NUM_HIGH? Perhaps not for 32-bit tasks on 64?
  Failed: powerpc-next/ppc64_defconfig+NO_HUGETLB/powerpc		(http://kisskb.ellerman.id.au/kisskb/buildresult/13296200/log/)
    /kisskb/src/arch/powerpc/kvm/powerpc.c:1361:2: error: 'emulated' may be used uninitialized in this function [-Werror=uninitialized]
    /kisskb/src/arch/powerpc/mm/slice.c:81:2: error: #error XXX: bitmap_zero with non-const size? Good code?
    /kisskb/src/arch/powerpc/mm/slice.c:660:2: error: #error XXX: are we sure high_slices is > 0 here when SLICE_NUM_HIGH? Perhaps not for 32-bit tasks on 64?
  Failed: powerpc-next/allmodconfig+ppc64le/ppc64le		(http://kisskb.ellerman.id.au/kisskb/buildresult/13296199/log/)
    /kisskb/src/arch/powerpc/mm/slice.c:81:2: error: #error XXX: bitmap_zero with non-const size? Good code?
    /kisskb/src/arch/powerpc/mm/slice.c:660:2: error: #error XXX: are we sure high_slices is > 0 here when SLICE_NUM_HIGH? Perhaps not for 32-bit tasks on 64?
  Failed: powerpc-next/pseries_defconfig+FA_DUMP/powerpc		(http://kisskb.ellerman.id.au/kisskb/buildresult/13296198/log/)
    /kisskb/src/arch/powerpc/kvm/powerpc.c:1361:2: error: 'emulated' may be used uninitialized in this function [-Werror=uninitialized]
    /kisskb/src/arch/powerpc/mm/slice.c:81:2: error: #error XXX: bitmap_zero with non-const size? Good code?
    /kisskb/src/arch/powerpc/mm/slice.c:660:2: error: #error XXX: are we sure high_slices is > 0 here when SLICE_NUM_HIGH? Perhaps not for 32-bit tasks on 64?
  Failed: powerpc-next/ppc64le_defconfig+NO_KVM/ppc64le		(http://kisskb.ellerman.id.au/kisskb/buildresult/13296197/log/)
    /kisskb/src/arch/powerpc/mm/slice.c:81:2: error: #error XXX: bitmap_zero with non-const size? Good code?
    /kisskb/src/arch/powerpc/mm/slice.c:660:2: error: #error XXX: are we sure high_slices is > 0 here when SLICE_NUM_HIGH? Perhaps not for 32-bit tasks on 64?
  Failed: powerpc-next/ppc64_defconfig+NO_KVM/powerpc		(http://kisskb.ellerman.id.au/kisskb/buildresult/13296196/log/)
    /kisskb/src/arch/powerpc/mm/slice.c:81:2: error: #error XXX: bitmap_zero with non-const size? Good code?
    /kisskb/src/arch/powerpc/mm/slice.c:660:2: error: #error XXX: are we sure high_slices is > 0 here when SLICE_NUM_HIGH? Perhaps not for 32-bit tasks on 64?
  Failed: powerpc-next/pseries_le_defconfig/ppc64le		(http://kisskb.ellerman.id.au/kisskb/buildresult/13296195/log/)
    /kisskb/src/arch/powerpc/mm/slice.c:81:2: error: #error XXX: bitmap_zero with non-const size? Good code?
    /kisskb/src/arch/powerpc/mm/slice.c:660:2: error: #error XXX: are we sure high_slices is > 0 here when SLICE_NUM_HIGH? Perhaps not for 32-bit tasks on 64?
  Failed: powerpc-next/ppc64le_defconfig/ppc64le		(http://kisskb.ellerman.id.au/kisskb/buildresult/13296194/log/)
    /kisskb/src/arch/powerpc/mm/slice.c:81:2: error: #error XXX: bitmap_zero with non-const size? Good code?
    /kisskb/src/arch/powerpc/mm/slice.c:660:2: error: #error XXX: are we sure high_slices is > 0 here when SLICE_NUM_HIGH? Perhaps not for 32-bit tasks on 64?
  Failed: powerpc-next/ppc64_defconfig+NO_TM/powerpc		(http://kisskb.ellerman.id.au/kisskb/buildresult/13296193/log/)
    /kisskb/src/arch/powerpc/kvm/powerpc.c:1361:2: error: 'emulated' may be used uninitialized in this function [-Werror=uninitialized]
    /kisskb/src/arch/powerpc/mm/slice.c:81:2: error: #error XXX: bitmap_zero with non-const size? Good code?
    /kisskb/src/arch/powerpc/mm/slice.c:660:2: error: #error XXX: are we sure high_slices is > 0 here when SLICE_NUM_HIGH? Perhaps not for 32-bit tasks on 64?
  Failed: powerpc-next/ppc64_defconfig+UP/powerpc		(http://kisskb.ellerman.id.au/kisskb/buildresult/13296181/log/)
    /kisskb/src/arch/powerpc/kvm/powerpc.c:1361:2: error: 'emulated' may be used uninitialized in this function [-Werror=uninitialized]
    /kisskb/src/arch/powerpc/mm/slice.c:81:2: error: #error XXX: bitmap_zero with non-const size? Good code?
    /kisskb/src/arch/powerpc/mm/slice.c:660:2: error: #error XXX: are we sure high_slices is > 0 here when SLICE_NUM_HIGH? Perhaps not for 32-bit tasks on 64?
  Failed: powerpc-next/ppc64_defconfig+NO_RADIX/powerpc		(http://kisskb.ellerman.id.au/kisskb/buildresult/13296177/log/)
    /kisskb/src/arch/powerpc/kvm/powerpc.c:1361:2: error: 'emulated' may be used uninitialized in this function [-Werror=uninitialized]
    /kisskb/src/arch/powerpc/mm/slice.c:81:2: error: #error XXX: bitmap_zero with non-const size? Good code?
    /kisskb/src/arch/powerpc/mm/slice.c:660:2: error: #error XXX: are we sure high_slices is > 0 here when SLICE_NUM_HIGH? Perhaps not for 32-bit tasks on 64?
  Failed: powerpc-next/pseries_defconfig+NO_MEMORY_HOTPLUG/powerpc		(http://kisskb.ellerman.id.au/kisskb/buildresult/13296175/log/)
    /kisskb/src/arch/powerpc/kvm/powerpc.c:1361:2: error: 'emulated' may be used uninitialized in this function [-Werror=uninitialized]
    /kisskb/src/arch/powerpc/mm/slice.c:81:2: error: #error XXX: bitmap_zero with non-const size? Good code?
    /kisskb/src/arch/powerpc/mm/slice.c:660:2: error: #error XXX: are we sure high_slices is > 0 here when SLICE_NUM_HIGH? Perhaps not for 32-bit tasks on 64?
  Failed: powerpc-next/powernv_defconfig+NO_RADIX/ppc64le		(http://kisskb.ellerman.id.au/kisskb/buildresult/13296173/log/)
    /kisskb/src/arch/powerpc/mm/slice.c:81:2: error: #error XXX: bitmap_zero with non-const size? Good code?
    /kisskb/src/arch/powerpc/mm/slice.c:660:2: error: #error XXX: are we sure high_slices is > 0 here when SLICE_NUM_HIGH? Perhaps not for 32-bit tasks on 64?
  Failed: powerpc-next/maple_defconfig/powerpc		(http://kisskb.ellerman.id.au/kisskb/buildresult/13296170/log/)
    /kisskb/src/arch/powerpc/mm/slice.c:81:2: error: #error XXX: bitmap_zero with non-const size? Good code?
    /kisskb/src/arch/powerpc/mm/slice.c:660:2: error: #error XXX: are we sure high_slices is > 0 here when SLICE_NUM_HIGH? Perhaps not for 32-bit tasks on 64?
  Failed: powerpc-next/mpc85xx_smp_defconfig/powerpc		(http://kisskb.ellerman.id.au/kisskb/buildresult/13296120/log/)
    /kisskb/src/arch/powerpc/include/asm/hugetlb.h:101:3: error: implicit declaration of function 'slice_is_hugepage_only_range' [-Werror=implicit-function-declaration]
  Failed: powerpc-next/powerpc-randconfig/powerpc		(http://kisskb.ellerman.id.au/kisskb/buildresult/13296110/log/)
    /kisskb/src/arch/powerpc/mm/slice.c:81:2: error: #error XXX: bitmap_zero with non-const size? Good code?
    /kisskb/src/arch/powerpc/mm/slice.c:660:2: error: #error XXX: are we sure high_slices is > 0 here when SLICE_NUM_HIGH? Perhaps not for 32-bit tasks on 64?
  Failed: powerpc-next/mpc85xx_defconfig/powerpc		(http://kisskb.ellerman.id.au/kisskb/buildresult/13296105/log/)
    /kisskb/src/arch/powerpc/include/asm/hugetlb.h:101:3: error: implicit declaration of function 'slice_is_hugepage_only_range' [-Werror=implicit-function-declaration]
  Failed: powerpc-next/powerpc-allyesconfig/powerpc		(http://kisskb.ellerman.id.au/kisskb/buildresult/13296104/log/)
    /kisskb/src/arch/powerpc/mm/slice.c:81:2: error: #error XXX: bitmap_zero with non-const size? Good code?
    /kisskb/src/arch/powerpc/mm/slice.c:660:2: error: #error XXX: are we sure high_slices is > 0 here when SLICE_NUM_HIGH? Perhaps not for 32-bit tasks on 64?
  Failed: powerpc-next/powerpc-allmodconfig/powerpc		(http://kisskb.ellerman.id.au/kisskb/buildresult/13296103/log/)
    /kisskb/src/arch/powerpc/mm/slice.c:81:2: error: #error XXX: bitmap_zero with non-const size? Good code?
    /kisskb/src/arch/powerpc/mm/slice.c:660:2: error: #error XXX: are we sure high_slices is > 0 here when SLICE_NUM_HIGH? Perhaps not for 32-bit tasks on 64?
  Failed: powerpc-next/pasemi_defconfig/powerpc		(http://kisskb.ellerman.id.au/kisskb/buildresult/13296101/log/)
    /kisskb/src/arch/powerpc/mm/slice.c:81:2: error: #error XXX: bitmap_zero with non-const size? Good code?
    /kisskb/src/arch/powerpc/mm/slice.c:660:2: error: #error XXX: are we sure high_slices is > 0 here when SLICE_NUM_HIGH? Perhaps not for 32-bit tasks on 64?
  Failed: powerpc-next/ppc64_defconfig/powerpc		(http://kisskb.ellerman.id.au/kisskb/buildresult/13296100/log/)
    /kisskb/src/arch/powerpc/mm/slice.c:81:2: error: #error XXX: bitmap_zero with non-const size? Good code?
    /kisskb/src/arch/powerpc/mm/slice.c:660:2: error: #error XXX: are we sure high_slices is > 0 here when SLICE_NUM_HIGH? Perhaps not for 32-bit tasks on 64?
  Failed: powerpc-next/ps3_defconfig/powerpc		(http://kisskb.ellerman.id.au/kisskb/buildresult/13296096/log/)
    /kisskb/src/arch/powerpc/mm/slice.c:81:2: error: #error XXX: bitmap_zero with non-const size? Good code?
    /kisskb/src/arch/powerpc/mm/slice.c:660:2: error: #error XXX: are we sure high_slices is > 0 here when SLICE_NUM_HIGH? Perhaps not for 32-bit tasks on 64?
  Failed: powerpc-next/g5_defconfig/powerpc		(http://kisskb.ellerman.id.au/kisskb/buildresult/13296095/log/)
    /kisskb/src/arch/powerpc/mm/slice.c:81:2: error: #error XXX: bitmap_zero with non-const size? Good code?
    /kisskb/src/arch/powerpc/mm/slice.c:660:2: error: #error XXX: are we sure high_slices is > 0 here when SLICE_NUM_HIGH? Perhaps not for 32-bit tasks on 64?
  Failed: powerpc-next/cell_defconfig/powerpc		(http://kisskb.ellerman.id.au/kisskb/buildresult/13296093/log/)
    /kisskb/src/arch/powerpc/mm/slice.c:81:2: error: #error XXX: bitmap_zero with non-const size? Good code?
    /kisskb/src/arch/powerpc/mm/slice.c:660:2: error: #error XXX: are we sure high_slices is > 0 here when SLICE_NUM_HIGH? Perhaps not for 32-bit tasks on 64?
  Failed: powerpc-next/pseries_defconfig/powerpc		(http://kisskb.ellerman.id.au/kisskb/buildresult/13296091/log/)
    /kisskb/src/arch/powerpc/kvm/powerpc.c:1361:2: error: 'emulated' may be used uninitialized in this function [-Werror=uninitialized]
    /kisskb/src/arch/powerpc/mm/slice.c:81:2: error: #error XXX: bitmap_zero with non-const size? Good code?
    /kisskb/src/arch/powerpc/mm/slice.c:660:2: error: #error XXX: are we sure high_slices is > 0 here when SLICE_NUM_HIGH? Perhaps not for 32-bit tasks on 64?
