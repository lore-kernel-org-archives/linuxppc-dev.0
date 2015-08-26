Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 12D851A077B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Aug 2015 18:26:53 +1000 (AEST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 26 Aug 2015 13:56:50 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 70962125805E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Aug 2015 13:56:10 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7Q8QejU3604664
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Aug 2015 13:56:41 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7Q8QdV4025119
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Aug 2015 13:56:39 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 ryabinin.a.a@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V2 00/10] KASan ppc64 support
Date: Wed, 26 Aug 2015 13:56:08 +0530
Message-Id: <1440577578-15813-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

This patchset implements kernel address sanitizer for ppc64.
Since ppc64 virtual address range is divided into different regions,
we can't have one contigous area for the kasan shadow range. Hence
we don't support the INLINE kasan instrumentation. With Outline
instrumentation, we override the shadow_to_mem and mem_to_shadow
callbacks, so that we map only the kernel linear range (ie,
region with ID 0xc). For region with ID 0xd and 0xf (vmalloc
and vmemmap ) we return the address of the zero page. This
works because kasan doesn't track both vmemmap and vmalloc address.

Known issues:
* Kasan is not yet enabled for arch/powerpc/kvm
* kexec hang
* outline stack and global support

Once we fix the kexec hang, we can look at merging ppc64 patch.
IMHO kasan changes can be reviewed/merged earlier 

Aneesh Kumar K.V (10):
  powerpc/mm: Add virt_to_pfn and use this instead of opencoding
  kasan: MODULE_VADDR is not available on all archs
  kasan: Rename kasan_enabled to kasan_report_enabled
  kasan: Don't use kasan shadow pointer in generic functions
  kasan: Enable arch to hook into kasan callbacks.
  kasan: Allow arch to overrride kasan shadow offsets
  kasan: Make INLINE KASan support arch selectable
  kasan: Update feature support file
  kasan: Prevent deadlock in kasan reporting
  powerpc/mm: kasan: Add kasan support for ppc64

 .../debug/KASAN/KASAN_INLINE/arch-support.txt      | 40 ++++++++++++
 .../KASAN/{ => KASAN_OUTLINE}/arch-support.txt     |  0
 arch/powerpc/include/asm/kasan.h                   | 74 ++++++++++++++++++++++
 arch/powerpc/include/asm/page.h                    |  5 +-
 arch/powerpc/include/asm/pgtable-ppc64.h           |  1 +
 arch/powerpc/include/asm/ppc_asm.h                 | 10 +++
 arch/powerpc/include/asm/string.h                  | 13 ++++
 arch/powerpc/kernel/Makefile                       |  5 ++
 arch/powerpc/kernel/prom_init_check.sh             |  2 +-
 arch/powerpc/kernel/setup_64.c                     |  3 +
 arch/powerpc/kvm/Makefile                          |  1 +
 arch/powerpc/lib/mem_64.S                          |  6 +-
 arch/powerpc/lib/memcpy_64.S                       |  3 +-
 arch/powerpc/lib/ppc_ksyms.c                       | 10 +++
 arch/powerpc/mm/Makefile                           |  7 ++
 arch/powerpc/mm/kasan_init.c                       | 44 +++++++++++++
 arch/powerpc/mm/slb_low.S                          |  4 ++
 arch/powerpc/platforms/Kconfig.cputype             |  1 +
 arch/x86/Kconfig                                   |  1 +
 include/linux/kasan.h                              |  3 +
 lib/Kconfig.kasan                                  |  2 +
 mm/kasan/kasan.c                                   |  9 +++
 mm/kasan/kasan.h                                   | 20 +++++-
 mm/kasan/report.c                                  | 29 ++++++---
 scripts/Makefile.kasan                             | 28 ++++----
 25 files changed, 290 insertions(+), 31 deletions(-)
 create mode 100644 Documentation/features/debug/KASAN/KASAN_INLINE/arch-support.txt
 rename Documentation/features/debug/KASAN/{ => KASAN_OUTLINE}/arch-support.txt (100%)
 create mode 100644 arch/powerpc/include/asm/kasan.h
 create mode 100644 arch/powerpc/mm/kasan_init.c

-- 
2.5.0
