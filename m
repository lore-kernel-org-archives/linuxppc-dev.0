Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v5G2d634BzDqWl
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Jan 2017 22:44:41 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dave.Martin@arm.com, aneesh.kumar@linux.vnet.ibm.com, anton@samba.org,
 arbab@linux.vnet.ibm.com, benh@kernel.crashing.org, bsingharora@gmail.com,
 gwshan@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, maddy@linux.vnet.ibm.com, mikey@neuling.org,
 npiggin@gmail.com, ruscur@russell.cc
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.10-2 tag
Date: Sat, 21 Jan 2017 22:44:35 +1100
Message-ID: <87pojgmycc.fsf@concordia.ellerman.id.au>
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

Please pull the belated first batch of powerpc fixes for 4.10:

The following changes since commit 49def1853334396f948dcb4cedb9347abb318df5:

  Linux 4.10-rc4 (2017-01-15 16:21:59 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-4.10-2

for you to fetch changes up to 178f358208ceb8b38e5cff3f815e0db4a6a70a07:

  powerpc: Ignore reserved field in DCSR and PVR reads and writes (2017-01-20 15:21:35 +1100)

----------------------------------------------------------------
powerpc fixes for 4.10 #2

Two fixes for fallout from the hugetlb changes we merged this cycle.

Ten other fixes, four only affect Power9, and the rest are a bit of a mixture
though nothing terrible.

Thanks to:
  Aneesh Kumar K.V, Anton Blanchard, Benjamin Herrenschmidt, Dave Martin, Gavin
  Shan, Madhavan Srinivasan, Nicholas Piggin, Reza Arbab.

----------------------------------------------------------------
Aneesh Kumar K.V (2):
      powerpc/mm/hugetlb: Don't panic when we don't find the default huge page size
      powerpc/mm: Fix little-endian 4K hugetlb

Anton Blanchard (1):
      powerpc: Ignore reserved field in DCSR and PVR reads and writes

Benjamin Herrenschmidt (1):
      powerpc/icp-opal: Fix missing KVM case and harden replay

Dave Martin (2):
      powerpc/ptrace: Preserve previous fprs/vsrs on short regset write
      powerpc/ptrace: Preserve previous TM fprs/vsrs on short regset write

Gavin Shan (1):
      powerpc/eeh: Enable IO path on permanent error

Madhavan Srinivasan (3):
      powerpc/perf: Fix PM_BRU_CMPL event code for power9
      selftest/powerpc: Wrong PMC initialized in pmc56_overflow test
      powerpc/perf: Use MSR to report privilege level on P9 DD1

Nicholas Piggin (1):
      powerpc: Fix pgtable pmd cache init

Reza Arbab (1):
      powerpc/mm: Fix memory hotplug BUG() on radix

 arch/powerpc/include/asm/book3s/64/hash-4k.h       |  5 ++--
 arch/powerpc/include/asm/book3s/64/hash.h          |  4 +++
 arch/powerpc/include/asm/hugetlb.h                 | 14 +++++-----
 arch/powerpc/include/asm/nohash/pgtable.h          |  5 ++--
 arch/powerpc/include/asm/page.h                    |  3 ---
 arch/powerpc/include/asm/perf_event_server.h       |  1 +
 arch/powerpc/include/asm/pgtable-be-types.h        |  8 ++++++
 arch/powerpc/include/asm/pgtable-types.h           |  7 +++++
 arch/powerpc/include/asm/ppc-opcode.h              | 10 +++----
 arch/powerpc/kernel/eeh.c                          | 10 ++++++-
 arch/powerpc/kernel/ptrace.c                       | 14 ++++++++++
 arch/powerpc/mm/hash_utils_64.c                    |  4 +--
 arch/powerpc/mm/hugetlbpage-hash64.c               |  5 +++-
 arch/powerpc/mm/hugetlbpage.c                      | 31 +++++++++-------------
 arch/powerpc/mm/init-common.c                      | 13 ++++-----
 arch/powerpc/mm/pgtable-book3s64.c                 | 18 +++++++++++++
 arch/powerpc/perf/core-book3s.c                    |  2 ++
 arch/powerpc/perf/power9-events-list.h             |  2 +-
 arch/powerpc/perf/power9-pmu.c                     |  2 +-
 arch/powerpc/sysdev/xics/icp-opal.c                | 31 +++++++++++++++++-----
 .../powerpc/pmu/ebb/pmc56_overflow_test.c          |  2 +-
 21 files changed, 132 insertions(+), 59 deletions(-)

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYg0mkAAoJEFHr6jzI4aWAPxAP+wd7dE8yD4MAi0R+yxN2Nwkz
ktsBkM0K1K8ylusJwePhbNnRjFITyoLix3dttA6mEXadRfg5mczvNaeeCXM4xp8m
u3VZ4m69jFYCZFjuWXsXvnDPigKNvZVn9XTDYyEp2GXX1726Bn4FOooCctrBaAvL
RUtH2/EI9aPreZ17+TnhbKeFW8KOraUoBN8xWAtH/3vkhDpOsLwjA4mj1Ow7ujjH
px/og3Qhvq3pFQ9/+yOqBX6B0J9wStwu8BIVDwOiSG4XYlPBVK5yHHxvLtrz50ag
s2LUUIW27dTZx8PeqmB0C4Mld+QjP8/9Ax7/70GOd5+p4I2EQ0+eH4uJjAL1Om0g
JqjuDyOzsxCR8DLudG8UhJxespuzISe+ALMW/uYTtDSpebgXmTk3IyOab+svZTpX
HSoYYCuZKTruS3hP39KHkkorXp+KcBvSQOmOAYkfCvfm5o3BYDXpcfuxQtnap0UC
3bnva/IVRrS/xofc66q/tvpy/2RLol9U6v4RH9QTHsP0Ez14umeCIx2mmmwg82v5
yphxjLp68G/1tnzhl5FOWJhnTRh/YtUaBoNVCPBq02q1ZIzexDQPsdlZe4GTv4lc
zSIgn+btcV+A+udfNK0ylf9fZ0BuVNSESjvBkpbLbgBHoQb1FPwsBe2yuy8hsnV/
b8tt4GZybm8cBRyOU03U
=ZO6n
-----END PGP SIGNATURE-----
--=-=-=--
