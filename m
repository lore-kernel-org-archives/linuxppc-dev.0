Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41xhPp4q3ZzDqj4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Aug 2018 23:06:54 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: aneesh.kumar@linux.ibm.com, benh@kernel.crashing.org,
 christophe.leroy@c-s.fr, hbathini@linux.ibm.com, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, luke@dashjr.org, mahesh@linux.vnet.ibm.com,
 naveen.n.rao@linux.vnet.ibm.com, npiggin@gmail.com, paulus@ozlabs.org,
 srikar@linux.vnet.ibm.com
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.19-2 tag
Date: Fri, 24 Aug 2018 23:06:49 +1000
Message-ID: <87o9drkj6e.fsf@concordia.ellerman.id.au>
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
Hash: SHA512

Hi Linus,

Please pull powerpc fixes for 4.19:

The following changes since commit a2dc009afa9ae8b92305be7728676562a104cb40:

  powerpc/mm/book3s/radix: Add mapping statistics (2018-08-13 16:35:05 +1000)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-4.19-2

for you to fetch changes up to 0f52b3a00c789569d7ed822b5a6b30f59a8d4393:

  powerpc/mce: Fix SLB rebolting during MCE recovery path. (2018-08-23 23:40:10 +1000)

- ------------------------------------------------------------------
powerpc fixes for 4.19 #2

 - An implementation for the newly added hv_ops->flush() for the OPAL hvc
   console driver backends, I forgot to apply this after merging the hvc driver
   changes before the merge window.

 - Enable all PCI bridges at boot on powernv, to avoid races when multiple
   children of a bridge try to enable it simultaneously. This is a workaround
   until the PCI core can be enhanced to fix the races.

 - A fix to query PowerVM for the correct system topology at boot before
   initialising sched domains, seen in some configurations to cause broken
   scheduling etc.

 - A fix for pte_access_permitted() on "nohash" platforms.

 - Two commits to fix SIGBUS when using remap_pfn_range() seen on Power9 due to
   a workaround when using the nest MMU (GPUs, accelerators).

 - Another fix to the VFIO code used by KVM, the previous fix had some bugs
   which caused guests to not start in some configurations.

 - A handful of other minor fixes.

Thanks to:
  Aneesh Kumar K.V, Benjamin Herrenschmidt, Christophe Leroy, Hari Bathini, Luke
  Dashjr, Mahesh Salgaonkar, Nicholas Piggin, Paul Mackerras, Srikar Dronamraju.

- ------------------------------------------------------------------
Aneesh Kumar K.V (2):
      powerpc/mm/books3s: Add new pte bit to mark pte temporarily invalid.
      powerpc/mm/radix: Only need the Nest MMU workaround for R -> RW transition

Benjamin Herrenschmidt (1):
      powerpc/powernv/pci: Work around races in PCI bridge enabling

Christophe Leroy (1):
      powerpc/nohash: fix pte_access_permitted()

Hari Bathini (1):
      powerpc/fadump: cleanup crash memory ranges support

Luke Dashjr (1):
      powerpc64/ftrace: Include ftrace.h needed for enable/disable calls

Mahesh Salgaonkar (1):
      powerpc/mce: Fix SLB rebolting during MCE recovery path.

Michael Ellerman (1):
      powerpc/traps: Avoid rate limit messages from show unhandled signals

Nicholas Piggin (2):
      powerpc/64s: Fix PACA_IRQ_HARD_DIS accounting in idle_power4()
      powerpc/powernv: provide a console flush operation for opal hvc driver

Paul Mackerras (1):
      KVM: PPC: Book3S: Fix guest DMA when guest partially backed by THP pages

Srikar Dronamraju (1):
      powerpc/topology: Get topology for shared processors at boot


 arch/powerpc/include/asm/book3s/64/pgtable.h | 18 +++++-
 arch/powerpc/include/asm/nohash/pgtable.h    |  9 +--
 arch/powerpc/include/asm/opal.h              |  1 +
 arch/powerpc/include/asm/topology.h          |  5 ++
 arch/powerpc/kernel/fadump.c                 |  8 +--
 arch/powerpc/kernel/idle_power4.S            | 16 +++++-
 arch/powerpc/kernel/smp.c                    |  5 ++
 arch/powerpc/kernel/traps.c                  | 13 ++---
 arch/powerpc/kvm/book3s_hv.c                 |  1 +
 arch/powerpc/mm/mmu_context_iommu.c          | 17 +++---
 arch/powerpc/mm/numa.c                       | 20 +++----
 arch/powerpc/mm/pgtable-radix.c              |  8 ++-
 arch/powerpc/mm/slb.c                        |  2 +-
 arch/powerpc/platforms/powernv/opal.c        | 83 +++++++++++++++++-----------
 arch/powerpc/platforms/powernv/pci-ioda.c    | 37 +++++++++++++
 drivers/tty/hvc/hvc_opal.c                   |  2 +
 16 files changed, 170 insertions(+), 75 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEJFGtCPCthwEv2Y/bUevqPMjhpYAFAluAAlEACgkQUevqPMjh
pYAueQ//Zd7kQQjarCi9Je008GtEEFXL+8GgXnIuyXxKnBgJaueTgN9gg0hCIV05
bQazC5Mzg4jY2QJVh1Kft4bxdB01RDAh7G5E0Gbi16/E4UcqvIS+7s+hZds9RI45
exH5qjj/V5pejL2+7Ct5F5eBjysoYxZ0Jn5gyQICjOgaK57Z/q5x9lvUhOfdpJk/
VxT6Uu62a/wwlVsaRmXS3c3byufJgNLTwBtJ1q/5+El2NR3F0nSzGxG99IupSWrw
dWcSZbsNKvXjGh9U46WNnJTMJLp2IH4l/INX2tg4PR2m+ZsIFKAgmqej39YIv8gk
4Md2kje/3/Y6mqy8sA1Eh8Wc3+VM2QEhMhJ27T7Ooivk0ljooR9AtMMwkrj1TrCK
zh4lWBxfaaRfTQH/cmafz6yfgpXAAMig/4XI1gOb53mPfYkByzFsZcFUC6ytic72
6q0gNDGtgdFD99rI4qUDc6QxrdDSKUin4hRaLoh8sL4mCyT6tdsATwL3Jn1kY2e3
rhaCHUw3V6evbkd+OiW5V7KBO4vvd3sIEYiWGiqIIevls8DeS6hhwpL4zVQBah+L
m9juSb9FvdHs/+jIDOIdyDncDh9rRoctQoXHyRQ3ocduM4b2CJu+tja4ZilJ2KpW
lZEwwF4v3v5OZ/qMqh3sZp5dp+py61mH+a4OAIe123qTXgiv1SA=
=GMLT
-----END PGP SIGNATURE-----
