Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Nqnn0WyRzDrJw
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Apr 2018 08:58:53 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: aneesh.kumar@linux.ibm.com, khandual@linux.vnet.ibm.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.17-2 tag
Date: Sun, 15 Apr 2018 08:58:51 +1000
Message-ID: <87zi25iedw.fsf@concordia.ellerman.id.au>
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

Please pull some powerpc fixes for 4.17-rc1 if you can:

The following changes since commit 49a695ba723224875df50e327bd7b0b65dd9a56b:

  Merge tag 'powerpc-4.17-1' of git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux (2018-04-07 12:08:19 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-4.17-2

for you to fetch changes up to 81b654c273914704a4bdf580f28d67aaba1094e4:

  powerpc/64s: Fix CPU_FTRS_ALWAYS vs DT CPU features (2018-04-13 23:51:44 +1000)

- ----------------------------------------------------------------
powerpc fixes for 4.17 #2

 - Fix crashes when loading modules built with a different CONFIG_RELOCATABLE
   value by adding CONFIG_RELOCATABLE to vermagic.

 - Fix busy loops in the OPAL NVRAM driver if we get certain error conditions
   from firmware.

 - Remove tlbie trace points from KVM code that's called in real mode, because
   it causes crashes.

 - Fix checkstops caused by invalid tlbiel on Power9 Radix.

 - Ensure the set of CPU features we "know" are always enabled is actually the
   minimal set when we build with support for firmware supplied CPU features.

Thanks to:
  Aneesh Kumar K.V, Anshuman Khandual, Nicholas Piggin.

- ----------------------------------------------------------------
Aneesh Kumar K.V (1):
      powerpc/8xx: Fix build with hugetlbfs enabled

Anshuman Khandual (1):
      powerpc/fscr: Enable interrupts earlier before calling get_user()

Michael Ellerman (4):
      powerpc/modules: Fix crashes by adding CONFIG_RELOCATABLE to vermagic
      powerpc/64s: Fix section mismatch warnings from setup_rfi_flush()
      powerpc/mm/radix: Fix checkstops caused by invalid tlbiel
      powerpc/64s: Fix CPU_FTRS_ALWAYS vs DT CPU features

Nicholas Piggin (3):
      powerpc/powernv: define a standard delay for OPAL_BUSY type retry loops
      powerpc/powernv: Fix OPAL NVRAM driver OPAL_BUSY loops
      KVM: PPC: Book3S HV: trace_tlbie must not be called in realmode

 arch/powerpc/include/asm/cputable.h         | 23 +++++++++++++++++++--
 arch/powerpc/include/asm/module.h           | 12 ++++++++++-
 arch/powerpc/include/asm/opal.h             |  3 +++
 arch/powerpc/kernel/dt_cpu_ftrs.c           | 14 +------------
 arch/powerpc/kernel/setup_64.c              |  2 +-
 arch/powerpc/kernel/traps.c                 | 32 +++++++++++++++--------------
 arch/powerpc/kvm/book3s_hv_rm_mmu.c         |  4 ----
 arch/powerpc/mm/slice.c                     |  1 +
 arch/powerpc/mm/tlb-radix.c                 |  5 ++---
 arch/powerpc/platforms/powernv/opal-nvram.c |  7 ++++++-
 10 files changed, 63 insertions(+), 40 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJa0oerAAoJEFHr6jzI4aWAvCIP/iG5Fv1b3MoslwQkCsAcMtTy
zO/Ga7H54Kpiopr9F5T4JTKVOMVBb4urs8mP9RXGUzqf9iuNy3ZWGJfbHn1VXw4r
wKFx5MfZYKNkoi8tGZHmbxhcSzFKsGHdCAEfC/SiNZCZZnbnt4NjWlUV4/QRts4a
/LEyvrWPGzGCZF1y+LpFREAJakhJ1uklJNbqwMvRtlXmoJoqODNCRPk1Tmy8fQ8E
eYLtAYGcN0x9w0YRo/1cTkJM/cksLPzJjZZn/6GR1vWRS544+iTSs6xT81RC7/yB
2QVsKD+V7D3iJ3iQ4DhCNkpMHNZjLqDNymMLjcYM1H/mPobvsegwZuGDm1jr7++D
3XBZa9wO6/dAOflu+nMlVNd323BMsdhGcI2WiZzsdkBh+aWU6hkQrgEG1uY3XV90
8zlOk6Cmiq+aYkcemEzMCvV1gYSpiauZx2q8Y/GKww2BVekRUKpsBTgcZvvKbBUX
XBJtAkRo5hR2o2qLAUwSXiJuGcfrlZBuZT0qCb1SYd9XRxIevvb1iQz2Yngxr6PI
n9reO01c6a25CJQqNLH07iy+eZcsWUNcrzEjaeHaHWPl+zcl0AWEuGj3Q80/SM6Y
rqOBMn3YSANpFjmat90c6CSWC/Bdf2nORMEtIHQ5mKsnL4rBv6X+pvMf3/TSwDNa
QzAeCp1gwX940ngqW3H7
=VzIU
-----END PGP SIGNATURE-----
