Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C9AE21A1D9B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2015 16:37:59 +1000 (AEST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 17 Aug 2015 16:37:58 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 77726357804F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2015 16:37:54 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7H6bih360096596
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2015 16:37:53 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7H6bKhm028495
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2015 16:37:21 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 ryabinin.a.a@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [RFC PATCH V1 0/8] KASAN ppc64 support
Date: Mon, 17 Aug 2015 12:06:32 +0530
Message-Id: <1439793400-18147-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

Aneesh Kumar K.V (8):
  powerpc/mm: Add virt_to_pfn and use this instead of opencoding
  kasan: MODULE_VADDR is not available on all archs
  kasan: Rename kasan_enabled to kasan_report_enabled
  kasan: Don't use kasan shadow pointer in generic functions
  kasan: Enable arch to hook into kasan callbacks.
  kasan: Allow arch to overrride kasan shadow offsets
  powerpc/mm: kasan: Add kasan support for ppc64
  powerpc: Disable kasan for kernel/ and mm/ directory

-aneesh

 arch/powerpc/include/asm/kasan.h         | 74 ++++++++++++++++++++++++++++++++
 arch/powerpc/include/asm/page.h          |  5 ++-
 arch/powerpc/include/asm/pgtable-ppc64.h |  1 +
 arch/powerpc/include/asm/ppc_asm.h       | 10 +++++
 arch/powerpc/include/asm/string.h        | 13 ++++++
 arch/powerpc/kernel/Makefile             |  2 +
 arch/powerpc/kernel/prom_init_check.sh   |  2 +-
 arch/powerpc/kernel/setup_64.c           |  3 ++
 arch/powerpc/lib/mem_64.S                |  6 ++-
 arch/powerpc/lib/memcpy_64.S             |  3 +-
 arch/powerpc/lib/ppc_ksyms.c             | 10 +++++
 arch/powerpc/mm/Makefile                 |  4 ++
 arch/powerpc/mm/kasan_init.c             | 44 +++++++++++++++++++
 arch/powerpc/mm/slb_low.S                |  4 ++
 arch/powerpc/platforms/Kconfig.cputype   |  1 +
 include/linux/kasan.h                    |  3 ++
 mm/kasan/kasan.c                         |  9 ++++
 mm/kasan/kasan.h                         | 20 ++++++++-
 mm/kasan/report.c                        | 19 ++++----
 19 files changed, 216 insertions(+), 17 deletions(-)
 create mode 100644 arch/powerpc/include/asm/kasan.h
 create mode 100644 arch/powerpc/mm/kasan_init.c

-- 
2.5.0
