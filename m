Return-Path: <SRS0=CfD8=BM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EAEBC433DF
	for <linuxppc-dev@archiver.kernel.org>; Sun,  2 Aug 2020 16:41:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA2D220738
	for <linuxppc-dev@archiver.kernel.org>; Sun,  2 Aug 2020 16:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LIo4s4fR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA2D220738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BKRc05HJNzDqM0
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2020 02:41:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=rppt@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=default header.b=LIo4s4fR; dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BKRVB4YDnzDqPy
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Aug 2020 02:36:18 +1000 (AEST)
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A84AE20738;
 Sun,  2 Aug 2020 16:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1596386176;
 bh=wmlXgD0X96/wIUhcM0J0CaJw2U1ECwrd3G0AsFvEO4Y=;
 h=From:To:Cc:Subject:Date:From;
 b=LIo4s4fRmWHT6ME6g/ZjvzQ7HJRSuVu2NYrDbrd0chKpt6+b3ohxjDTyat5mFYLn4
 aeP921+3zEtXOmJIAFZ0JgLAmKkmGOMoKwCqYXkOSHVuvR6uN6W8dMclI8JjGsPtcE
 w3N+AA1SHOYg14yG/yF0pyqesAV5aB4w9VaQvzZA=
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 00/17] memblock: seasonal cleaning^w cleanup
Date: Sun,  2 Aug 2020 19:35:44 +0300
Message-Id: <20200802163601.8189-1-rppt@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Emil Renner Berthing <kernel@esmil.dk>, linux-sh@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, linux-mips@vger.kernel.org,
 Max Filippov <jcmvbkbc@gmail.com>, Paul Mackerras <paulus@samba.org>,
 sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org,
 Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>, linux-arch@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-c6x-dev@linux-c6x.org,
 Baoquan He <bhe@redhat.com>, x86@kernel.org,
 Russell King <linux@armlinux.org.uk>, Mike Rapoport <rppt@linux.ibm.com>,
 clang-built-linux@googlegroups.com, Ingo Molnar <mingo@redhat.com>,
 linux-arm-kernel@lists.infradead.org,
 Catalin Marinas <catalin.marinas@arm.com>,
 uclinux-h8-devel@lists.sourceforge.jp, linux-xtensa@linux-xtensa.org,
 openrisc@lists.librecores.org, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Stafford Horne <shorne@gmail.com>, Hari Bathini <hbathini@linux.ibm.com>,
 Michal Simek <monstr@monstr.eu>, Yoshinori Sato <ysato@users.sourceforge.jp>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Palmer Dabbelt <palmer@dabbelt.com>,
 linuxppc-dev@lists.ozlabs.org, Mike Rapoport <rppt@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Mike Rapoport <rppt@linux.ibm.com>

Hi,

These patches simplify several uses of memblock iterators and hide some of
the memblock implementation details from the rest of the system.

The patches are on top of v5.8-rc7 + cherry-pick of "mm/sparse: cleanup the
code surrounding memory_present()" [1] from mmotm tree.

v2 changes:
* replace for_each_memblock() with two versions, one for memblock.memory
  and another one for memblock.reserved
* fix overzealous cleanup of powerpc fadamp: keep the traversal over the
  memblocks, but use better suited iterators
* don't remove traversal over memblock.reserved in x86 numa cleanup but
  replace for_each_memblock() with new for_each_reserved_mem_region()
* simplify ramdisk and crash kernel allocations on x86
* drop more redundant and unused code: __next_reserved_mem_region() and
  memblock_mem_size()
* add description of numa initialization fix on arm64 (thanks Jonathan)
* add Acked and Reviewed tags

[1] http://lkml.kernel.org/r/20200712083130.22919-1-rppt@kernel.org 

Mike Rapoport (17):
  KVM: PPC: Book3S HV: simplify kvm_cma_reserve()
  dma-contiguous: simplify cma_early_percent_memory()
  arm, xtensa: simplify initialization of high memory pages
  arm64: numa: simplify dummy_numa_init()
  h8300, nds32, openrisc: simplify detection of memory extents
  riscv: drop unneeded node initialization
  mircoblaze: drop unneeded NUMA and sparsemem initializations
  memblock: make for_each_memblock_type() iterator private
  memblock: make memblock_debug and related functionality private
  memblock: reduce number of parameters in for_each_mem_range()
  arch, mm: replace for_each_memblock() with for_each_mem_pfn_range()
  arch, drivers: replace for_each_membock() with for_each_mem_range()
  x86/setup: simplify initrd relocation and reservation
  x86/setup: simplify reserve_crashkernel()
  memblock: remove unused memblock_mem_size()
  memblock: implement for_each_reserved_mem_region() using __next_mem_region()
  memblock: use separate iterators for memory and reserved regions

 .clang-format                            |  4 +-
 arch/arm/kernel/setup.c                  | 18 +++--
 arch/arm/mm/init.c                       | 59 ++++------------
 arch/arm/mm/mmu.c                        | 39 ++++-------
 arch/arm/mm/pmsa-v7.c                    | 20 +++---
 arch/arm/mm/pmsa-v8.c                    | 17 +++--
 arch/arm/xen/mm.c                        |  7 +-
 arch/arm64/kernel/machine_kexec_file.c   |  6 +-
 arch/arm64/kernel/setup.c                |  4 +-
 arch/arm64/mm/init.c                     | 11 ++-
 arch/arm64/mm/kasan_init.c               | 10 +--
 arch/arm64/mm/mmu.c                      | 11 +--
 arch/arm64/mm/numa.c                     | 15 ++---
 arch/c6x/kernel/setup.c                  |  9 +--
 arch/h8300/kernel/setup.c                |  8 +--
 arch/microblaze/mm/init.c                | 24 ++-----
 arch/mips/cavium-octeon/dma-octeon.c     | 12 ++--
 arch/mips/kernel/setup.c                 | 31 +++++----
 arch/mips/netlogic/xlp/setup.c           |  2 +-
 arch/nds32/kernel/setup.c                |  8 +--
 arch/openrisc/kernel/setup.c             |  9 +--
 arch/openrisc/mm/init.c                  |  8 ++-
 arch/powerpc/kernel/fadump.c             | 57 ++++++++--------
 arch/powerpc/kvm/book3s_hv_builtin.c     | 11 +--
 arch/powerpc/mm/book3s64/hash_utils.c    | 16 ++---
 arch/powerpc/mm/book3s64/radix_pgtable.c | 11 ++-
 arch/powerpc/mm/kasan/kasan_init_32.c    |  8 +--
 arch/powerpc/mm/mem.c                    | 33 +++++----
 arch/powerpc/mm/numa.c                   |  7 +-
 arch/powerpc/mm/pgtable_32.c             |  8 +--
 arch/riscv/mm/init.c                     | 34 +++-------
 arch/riscv/mm/kasan_init.c               | 10 +--
 arch/s390/kernel/crash_dump.c            |  8 +--
 arch/s390/kernel/setup.c                 | 31 +++++----
 arch/s390/mm/page-states.c               |  6 +-
 arch/s390/mm/vmem.c                      | 16 +++--
 arch/sh/mm/init.c                        |  9 +--
 arch/sparc/mm/init_64.c                  | 12 ++--
 arch/x86/kernel/setup.c                  | 56 +++++-----------
 arch/x86/mm/numa.c                       |  2 +-
 arch/xtensa/mm/init.c                    | 55 +++------------
 drivers/bus/mvebu-mbus.c                 | 12 ++--
 drivers/irqchip/irq-gic-v3-its.c         |  2 +-
 drivers/s390/char/zcore.c                |  9 +--
 include/linux/memblock.h                 | 65 +++++++++---------
 kernel/dma/contiguous.c                  | 11 +--
 mm/memblock.c                            | 85 ++++++++----------------
 mm/page_alloc.c                          | 11 ++-
 mm/sparse.c                              | 10 ++-
 49 files changed, 366 insertions(+), 561 deletions(-)

-- 
2.26.2

