Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vcxMV43cjzDqXg
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Mar 2017 23:50:14 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: aik@ozlabs.ru, anton@samba.org, benh@kernel.crashing.org,
 bsingharora@gmail.com, ego@linux.vnet.ibm.com, laurentiu.tudor@nxp.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com,
 paulus@ozlabs.org, ravi.bangoria@linux.vnet.ibm.com,
 sachinp@linux.vnet.ibm.com, shile.zhang@nokia.com, sjitindarsingh@gmail.com
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.11-3 tag
Date: Tue, 07 Mar 2017 23:50:08 +1100
Message-ID: <87fuipz1xb.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha1; protocol="application/pgp-signature"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--=-=-=
Content-Type: text/plain

Hi Linus,

Please pull the first set of powerpc fixes for 4.11:

The following changes since commit b286cedd473006b33d5ae076afac509e6b2c3bf4:

  Merge tag 'powerpc-4.11-2' of git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux (2017-03-01 10:10:16 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-4.11-3

for you to fetch changes up to a7d2475af7aedcb9b5c6343989a8bfadbf84429b:

  powerpc: Sort the selects under CONFIG_PPC (2017-03-06 23:05:42 +1100)

----------------------------------------------------------------
powerpc fixes for 4.11 #3

Five fairly small fixes for things that went in this cycle.

A fairly large patch to rework the CAS logic on Power9, necessitated by a late
change to the firmware API, and we can't boot without it.

Three fixes going to stable, allowing more instructions to be emulated on LE,
fixing a boot crash on 32-bit Freescale BookE machines, and the OPAL XICS
workaround.

And a patch from me to sort the selects under CONFIG PPC. Annoying churn, but
worth it in the long run, and best for it to go in now to avoid conflicts.

Thanks to:
  Alexey Kardashevskiy, Anton Blanchard, Balbir Singh, Gautham R. Shenoy,
  Laurentiu Tudor, Nicholas Piggin, Paul Mackerras, Ravi Bangoria, Sachin Sant,
  Shile Zhang, Suraj Jitindar Singh.

----------------------------------------------------------------
Alexey Kardashevskiy (1):
      powerpc/powernv: Fix opal tracepoints with JUMP_LABEL=n

Anton Blanchard (1):
      powerpc/64: Avoid panic during boot due to divide by zero in init_cache_info()

Balbir Singh (1):
      powerpc/xics: Work around limitations of OPAL XICS priority handling

Gautham R. Shenoy (1):
      powerpc/powernv: Fix bug due to labeling ambiguity in power_enter_stop

Laurentiu Tudor (1):
      powerpc/booke: Fix boot crash due to null hugepd

Michael Ellerman (2):
      powerpc/64: Fix L1D cache shape vector reporting L1I values
      powerpc: Sort the selects under CONFIG_PPC

Nicholas Piggin (1):
      powerpc: Fix compiling a BE kernel with a powerpc64le toolchain

Paul Mackerras (1):
      powerpc/64: Invalidate process table caching after setting process table

Ravi Bangoria (2):
      powerpc: Emulation support for load/store instructions on LE
      powerpc: emulate_step() tests for load/store instructions

Sachin Sant (1):
      selftest/powerpc: Fix false failures for skipped tests

Shile Zhang (1):
      powerpc/64: Fix checksum folding in csum_add()

Suraj Jitindar Singh (2):
      powerpc: Parse the command line before calling CAS
      powerpc: Update to new option-vector-5 format for CAS

 arch/powerpc/Kconfig                           | 138 ++++----
 arch/powerpc/Makefile                          |  11 +-
 arch/powerpc/include/asm/checksum.h            |   2 +-
 arch/powerpc/include/asm/cpuidle.h             |   4 +-
 arch/powerpc/include/asm/elf.h                 |   4 +-
 arch/powerpc/include/asm/nohash/pgtable.h      |   2 +-
 arch/powerpc/include/asm/ppc-opcode.h          |   7 +
 arch/powerpc/include/asm/prom.h                |  18 +-
 arch/powerpc/kernel/idle_book3s.S              |  10 +-
 arch/powerpc/kernel/prom_init.c                | 120 ++++++-
 arch/powerpc/kernel/setup_64.c                 |   5 +-
 arch/powerpc/lib/Makefile                      |   1 +
 arch/powerpc/lib/sstep.c                       |  20 --
 arch/powerpc/lib/test_emulate_step.c           | 434 +++++++++++++++++++++++++
 arch/powerpc/mm/init_64.c                      |  36 +-
 arch/powerpc/mm/pgtable-radix.c                |   4 +
 arch/powerpc/platforms/powernv/opal-wrappers.S |   4 +-
 arch/powerpc/sysdev/xics/icp-opal.c            |  10 +
 arch/powerpc/sysdev/xics/xics-common.c         |  17 +-
 tools/testing/selftests/powerpc/harness.c      |   6 +-
 20 files changed, 729 insertions(+), 124 deletions(-)
 create mode 100644 arch/powerpc/lib/test_emulate_step.c

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYvqyBAAoJEFHr6jzI4aWAUCMP/1lVb7yNTDTnpasrn08FfNA+
FCL7g9b0mfz3f7VJGJPYUZ4DyFjBohI+TqhMwp09MfltO8utOCAnajAoaQQ8HfE4
Q1pwTRBPMPrCpOKKD7Z5yyGHo0ZhfyhvilQMC2AN+Tav224HynLCwjLnmSyhhf4Q
GYWfcu23SZwnEEkhvtA3krLaEiZXSGl06PwzRblYCU0Gqln86C+I77kap9JZT5H8
jdEp1/l08R1YZylld9aSCV9i7gZ/lzYHv3YvsnQBP/Px0WWno5FWygec13IaX/3B
KQNIxuA6+5k7npBQvO2j6K+MChOtCkBLcuWyRC9PXEf3Jies5HCZYa+HsL7EK+vD
r6j6VcnrjHXQDhnDNgBqfP/MJDHQ6dVmq+6w7KR1OlJMfELRGR5Wf3oPMaIZBLWo
2qkBKMKrwiIY1w6EQKg6ctPj1bW2o1uHmMsCGxvoSs3Cfp+vny9eh9AT/LYv2lv5
KpuIstphqwhY5pjv39w67TgOnFQj5kucWnAOj+HLG0ZcFBj6guenZl3kLY8cbJnE
Bnb1GYrNLtyhoUZeTBVrurppr07XMpJCnXL0MNig6cgU7T1upGM/1Lqmi1mt2kCG
QI6pzey1dTv/SET9wiXbQr/AEUOhV2/ESsGT7XazxK/JdKWLwpJoARauAIPlxJMv
IF1LI3JTkCx4P01brFqU
=arOY
-----END PGP SIGNATURE-----
--=-=-=--
