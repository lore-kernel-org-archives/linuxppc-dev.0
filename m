Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5297CCCA47F
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Jun 2022 10:15:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LDzKV5NS7z3byT
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Jun 2022 20:15:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=anshuman.khandual@arm.com; receiver=<UNKNOWN>)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LDzK24bXHz3bl4
	for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Jun 2022 20:15:00 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CCFAE1063;
	Fri,  3 Jun 2022 03:14:27 -0700 (PDT)
Received: from a077893.blr.arm.com (unknown [10.162.42.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CDDE03F766;
	Fri,  3 Jun 2022 03:14:18 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-mm@kvack.org
Subject: [PATCH 0/6] mm/mmap: Enable more platforms with ARCH_HAS_VM_GET_PAGE_PROT
Date: Fri,  3 Jun 2022 15:44:05 +0530
Message-Id: <20220603101411.488970-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
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
Cc: Catalin Marinas <catalin.marinas@arm.com>, linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org, Will Deacon <will@kernel.org>, Jonas Bonn <jonas@southpole.se>, linux-s390@vger.kernel.org, x86@kernel.org, linux-csky@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Vasily Gorbik <gor@linux.ibm.com>, Anshuman Khandual <anshuman.khandual@arm.com>, Heiko Carstens <hca@linux.ibm.com>, openrisc@lists.librecores.org, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-mips@vger.kernel.org, Dinh Nguyen <dinguyen@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From the last discussion [1], some more platforms (s390, mips, csky, nios2,
openrisc) were willing to enable ARCH_HAS_VM_GET_PAGE_PROT and also provide
custom vm_get_page_prot() via switch case statement implementation without
any objection. All those platform specific patches have already been acked.

This series makes protection_map[] array private on platforms which define
their own vm_get_page_prot() via ARCH_HAS_VM_GET_PAGE_PROT, and also drops
off their __PXXX/__SXXX macros. This also enables new platforms as in this
series, to drop off their __PXXX/__SXXX macros as generic protection_map[]
is no longer visible to them.

[1] https://lore.kernel.org/all/1646045273-9343-2-git-send-email-anshuman.khandual@arm.com/

This series applies on current mainline and also has been build tested on
multiple platforms.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Dinh Nguyen <dinguyen@kernel.org>
Cc: Jonas Bonn <jonas@southpole.se>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: x86@kernel.org
Cc: openrisc@lists.librecores.org
Cc: linux-csky@vger.kernel.org
Cc: linux-mips@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: sparclinux@vger.kernel.org
Cc: linux-s390@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org

Anshuman Khandual (6):
  mm/mmap: Restrict generic protection_map[] array visibility
  s390/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  mips/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  csky/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  nios2/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  openrisc/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT

 arch/arm64/include/asm/pgtable-prot.h | 18 --------
 arch/arm64/mm/mmap.c                  | 21 ++++++++++
 arch/csky/Kconfig                     |  1 +
 arch/csky/include/asm/pgtable.h       | 18 --------
 arch/csky/mm/init.c                   | 32 ++++++++++++++
 arch/mips/Kconfig                     |  1 +
 arch/mips/include/asm/pgtable.h       | 22 ----------
 arch/mips/mm/cache.c                  | 60 ++++++++++++++++-----------
 arch/nios2/Kconfig                    |  1 +
 arch/nios2/include/asm/pgtable.h      | 24 -----------
 arch/nios2/mm/init.c                  | 47 +++++++++++++++++++++
 arch/openrisc/Kconfig                 |  1 +
 arch/openrisc/include/asm/pgtable.h   | 18 --------
 arch/openrisc/mm/init.c               | 41 ++++++++++++++++++
 arch/powerpc/include/asm/pgtable.h    |  2 +
 arch/powerpc/mm/book3s64/pgtable.c    | 20 +++++++++
 arch/s390/Kconfig                     |  1 +
 arch/s390/include/asm/pgtable.h       | 17 --------
 arch/s390/mm/mmap.c                   | 33 +++++++++++++++
 arch/sparc/include/asm/pgtable_32.h   |  2 +
 arch/sparc/include/asm/pgtable_64.h   | 19 ---------
 arch/sparc/mm/init_64.c               | 20 +++++++++
 arch/x86/include/asm/pgtable_types.h  | 19 ---------
 arch/x86/mm/pgprot.c                  | 19 +++++++++
 include/linux/mm.h                    |  2 +
 mm/mmap.c                             |  2 +-
 26 files changed, 280 insertions(+), 181 deletions(-)

-- 
2.25.1

