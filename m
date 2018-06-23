Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41CbBY0QYHzF13h
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Jun 2018 23:00:05 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: aneesh.kumar@linux.ibm.com, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, mjeanson@efficios.com, npiggin@gmail.com
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.18-2 tag
Date: Sat, 23 Jun 2018 22:59:54 +1000
Message-ID: <87o9g1ejzp.fsf@concordia.ellerman.id.au>
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

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Linus,

Please pull powerpc fixes for 4.18:

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-4.18-2

for you to fetch changes up to fadd03c615922d8521a2e76d4ba2335891cb2790:

  powerpc/mm/hash/4k: Free hugetlb page table caches correctly. (2018-06-20 09:13:25 +1000)

- ------------------------------------------------------------------
powerpc fixes for 4.18 #2

 - A fix for hugetlb with 4K pages, broken by our recent changes for split PMD PTL.

 - Set the correct assembler machine type on e500mc, needed since binutils 2.26
   introduced two forms for the "wait" instruction.

 - A fix for potential missed TLB flushes with MADV_[FREE|DONTNEED] etc. and THP
   on Power9 Radix.

 - Three fixes to try and make our panic handling more robust by hard disabling
   interrupts, and not marking stopped CPUs as offline because they haven't been
   properly offlined.

 - Three other minor fixes.

Thanks to:
  Aneesh Kumar K.V, Michael Jeanson, Nicholas Piggin.

- ------------------------------------------------------------------
Aneesh Kumar K.V (1):
      powerpc/mm/hash/4k: Free hugetlb page table caches correctly.

Michael Ellerman (2):
      powerpc/64s: Fix DT CPU features Power9 DD2.1 logic
      powerpc/64s: Fix build failures with CONFIG_NMI_IPI=n

Michael Jeanson (1):
      powerpc/e500mc: Set assembler machine type to e500mc

Nicholas Piggin (5):
      powerpc/64s/radix: Fix MADV_[FREE|DONTNEED] TLB flush miss problem with THP
      powerpc/64: hard disable irqs in panic_smp_self_stop
      powerpc: smp_send_stop do not offline stopped CPUs
      powerpc/64: hard disable irqs on the panic()ing CPU
      powerpc/64s/radix: Fix radix_kvm_prefetch_workaround paca access of not possible CPU


 arch/powerpc/Makefile                            |  1 +
 arch/powerpc/include/asm/book3s/32/pgalloc.h     |  1 +
 arch/powerpc/include/asm/book3s/64/pgtable-4k.h  | 21 +++++
 arch/powerpc/include/asm/book3s/64/pgtable-64k.h |  9 +++
 arch/powerpc/include/asm/book3s/64/pgtable.h     |  5 ++
 arch/powerpc/include/asm/nmi.h                   |  2 +-
 arch/powerpc/include/asm/nohash/32/pgalloc.h     |  1 +
 arch/powerpc/include/asm/nohash/64/pgalloc.h     |  1 +
 arch/powerpc/kernel/dt_cpu_ftrs.c                |  3 +-
 arch/powerpc/kernel/setup-common.c               | 12 ++-
 arch/powerpc/kernel/setup_64.c                   |  8 ++
 arch/powerpc/kernel/smp.c                        |  6 --
 arch/powerpc/kernel/stacktrace.c                 |  4 +-
 arch/powerpc/mm/hugetlbpage.c                    |  3 +-
 arch/powerpc/mm/pgtable-book3s64.c               | 12 +++
 arch/powerpc/mm/tlb-radix.c                      | 98 +++++++++++++++++++-----
 16 files changed, 153 insertions(+), 34 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJbLkOQAAoJEFHr6jzI4aWA9j0QALRcw9WPmiuhCdy0Jfjn3NnL
B5Y5CBceaemGT/KCp/UrGCpA8WAOJq1PHayAFnFtuVP5ccVdQUFDVUnuSsnuIPP4
+i9OU08NAuItp68fVVO/BahbOudltDRCJg6+yAacBhEQ8PCqVUI7Hj9r1WQRWf6X
dFLHQqv5AJEnbm0u7yGTk+rnj9wkLej2nTs2HlT7bWjJKCG5KP8EV8PyeS7v0bXP
cGvWJ5wyL417vgguPX5YBLnY0qybElsmGzANaDi8tjsdduMNkLrvmoea+udebMFI
pn3f1tnQeFDYZuRn0ZIKeHJlcyp4CJkVAPSIdoUNW7sLcOB5RlMr8d6Ie1ry0seH
6TX+Ij5rK8pPg1K9ZfJzLEEb1ddc+me9sh7Lq5J/fJR8UMwjrws/9uNvTrjhy68m
tgN8I9dYo2vC1BZ7doh4OdbLOJcHvbBAS5y2fnXcvYdnSTvVsFUJTctGBtE8Om1d
8jYBZQ92/dF2O5pwd59A6eZ5alLDQJ5UVt5ecaLuuIuL82rtW4x1OiQTXJ/A4GB8
P3wvJdiPubhLlNuRz3TZPr3Pckb52OKgL/MAG6T4WFRtDL3GweWfe1MYRipQJatO
V7T6QL1/KYSP7XTLqIdE2dYnkpi9jvZV3RSmgvfZrugTzlm3tI5G5cSt55q0D28c
ArL790E2Wz+0dVZYfXPP
=UQLt
-----END PGP SIGNATURE-----
