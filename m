Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40KX1S6nW0zDrpY
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Apr 2018 23:57:32 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w39Du5eu103005
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Apr 2018 09:57:29 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2h87x2d70j-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Apr 2018 09:57:28 -0400
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Mon, 9 Apr 2018 14:57:20 +0100
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
 linux-doc@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, Jerome Glisse <jglisse@redhat.com>,
 mhocko@kernel.org, aneesh.kumar@linux.vnet.ibm.com,
 akpm@linux-foundation.org, mpe@ellerman.id.au,
 benh@kernel.crashing.org, paulus@samba.org,
 Jonathan Corbet <corbet@lwn.net>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 "David S . Miller" <davem@davemloft.net>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Vineet Gupta <vgupta@synopsys.com>, Palmer Dabbelt <palmer@sifive.com>,
 Albert Ou <albert@sifive.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH 0/3] move __HAVE_ARCH_PTE_SPECIAL in Kconfig
Date: Mon,  9 Apr 2018 15:57:06 +0200
Message-Id: <1523282229-20731-1-git-send-email-ldufour@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The per architecture __HAVE_ARCH_PTE_SPECIAL is defined statically in the
per architecture header files. This doesn't allow to make other
configuration dependent on it.

This series is moving the __HAVE_ARCH_PTE_SPECIAL into the Kconfig files,
setting it automatically when architectures was already setting it in
header file.

There is no functional change introduced by this series.

Laurent Dufour (3):
  mm: introduce ARCH_HAS_PTE_SPECIAL
  mm: replace __HAVE_ARCH_PTE_SPECIAL
  mm: remove __HAVE_ARCH_PTE_SPECIAL

 Documentation/features/vm/pte_special/arch-support.txt | 2 +-
 arch/arc/Kconfig                                       | 1 +
 arch/arc/include/asm/pgtable.h                         | 2 --
 arch/arm/Kconfig                                       | 1 +
 arch/arm/include/asm/pgtable-3level.h                  | 1 -
 arch/arm64/Kconfig                                     | 1 +
 arch/arm64/include/asm/pgtable.h                       | 2 --
 arch/powerpc/Kconfig                                   | 1 +
 arch/powerpc/include/asm/book3s/64/pgtable.h           | 3 ---
 arch/powerpc/include/asm/pte-common.h                  | 3 ---
 arch/riscv/Kconfig                                     | 1 +
 arch/s390/Kconfig                                      | 1 +
 arch/s390/include/asm/pgtable.h                        | 1 -
 arch/sh/Kconfig                                        | 1 +
 arch/sh/include/asm/pgtable.h                          | 2 --
 arch/sparc/Kconfig                                     | 1 +
 arch/sparc/include/asm/pgtable_64.h                    | 3 ---
 arch/x86/Kconfig                                       | 1 +
 arch/x86/include/asm/pgtable_types.h                   | 1 -
 include/linux/pfn_t.h                                  | 4 ++--
 mm/Kconfig                                             | 3 +++
 mm/gup.c                                               | 4 ++--
 mm/memory.c                                            | 2 +-
 23 files changed, 18 insertions(+), 24 deletions(-)

-- 
2.7.4
