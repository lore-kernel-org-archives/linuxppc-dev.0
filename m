Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wkgG304T8zDqLJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Jun 2017 21:35:39 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: aneesh.kumar@linux.vnet.ibm.com, anton@samba.org, christophe.leroy@c-s.fr,
 fbarrat@linux.vnet.ibm.com, jk@ozlabs.org, leitao@debian.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 maddy@linux.vnet.ibm.com, mwb@linux.vnet.ibm.com, npiggin@gmail.com,
 vaibhav@linux.vnet.ibm.com
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.12-5 tag
Date: Fri, 09 Jun 2017 21:35:37 +1000
Message-ID: <877f0lieba.fsf@concordia.ellerman.id.au>
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

Please pull some more powerpc fixes for 4.12:

The following changes since commit a4700a26107241cc7b9ac8528b2c6714ff99983d:

  powerpc: Add PPC_FEATURE userspace bits for SCV and DARN instructions (2017-05-25 23:07:45 +1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-4.12-5

for you to fetch changes up to c6ee9619e2edd9912316f7e2eaf9ffa14fafe9f9:

  powerpc/book3s64: Move PPC_DT_CPU_FTRs and enable it by default (2017-06-08 20:42:57 +1000)

----------------------------------------------------------------
powerpc fixes for 4.12 #5

Mostly fairly minor, of note are:
 - Fix percpu allocations to be NUMA aware
 - Limit 4k page size config to 64TB virtual address space
 - Avoid needlessly restoring FP and vector registers

Thanks to:
  Aneesh Kumar K.V, Breno Leitao, Christophe Leroy, Frederic Barrat, Madhavan
  Srinivasan, Michael Bringmann, Nicholas Piggin, Vaibhav Jain.

----------------------------------------------------------------
Aneesh Kumar K.V (1):
      powerpc/mm/4k: Limit 4k page size config to 64TB virtual address space

Breno Leitao (2):
      powerpc/kernel: Fix FP and vector register restoration
      powerpc/kernel: Initialize load_tm on task creation

Christophe Leroy (1):
      powerpc/sysdev/simple_gpio: Fix oops in gpio save_regs function

Frederic Barrat (1):
      cxl: Fix error path on bad ioctl

Madhavan Srinivasan (1):
      powerpc/perf: Fix Power9 test_adder fields

Michael Bringmann (1):
      powerpc/hotplug-mem: Fix missing endian conversion of aa_index

Michael Ellerman (4):
      powerpc/spufs: Fix coredump of SPU contexts
      powerpc/64: Reclaim CPU_FTR_SUBCORE
      powerpc/numa: Fix percpu allocations to be NUMA aware
      powerpc/book3s64: Move PPC_DT_CPU_FTRs and enable it by default

Nicholas Piggin (1):
      powerpc/64s: Add dt_cpu_ftrs boot time setup option

Vaibhav Jain (1):
      cxl: Avoid double free_irq() for psl,slice interrupts

 Documentation/admin-guide/kernel-parameters.txt |  9 ++++
 arch/powerpc/Kconfig                            | 16 -------
 arch/powerpc/include/asm/book3s/64/hash-4k.h    |  2 +-
 arch/powerpc/include/asm/cputable.h             |  3 +-
 arch/powerpc/include/asm/processor.h            | 25 +++++------
 arch/powerpc/include/asm/topology.h             | 14 ++++++
 arch/powerpc/kernel/dt_cpu_ftrs.c               | 58 ++++++++++++++++++++-----
 arch/powerpc/kernel/process.c                   |  3 ++
 arch/powerpc/kernel/setup-common.c              |  2 +-
 arch/powerpc/kernel/setup_64.c                  |  4 +-
 arch/powerpc/mm/mmu_context_book3s64.c          |  2 +-
 arch/powerpc/perf/power9-pmu.c                  |  4 +-
 arch/powerpc/platforms/Kconfig                  | 11 +++++
 arch/powerpc/platforms/cell/spufs/coredump.c    |  2 +
 arch/powerpc/platforms/powernv/subcore.c        |  8 +++-
 arch/powerpc/platforms/pseries/hotplug-memory.c |  2 +
 arch/powerpc/sysdev/simple_gpio.c               |  3 +-
 drivers/misc/cxl/file.c                         |  7 +--
 drivers/misc/cxl/native.c                       | 14 ++++--
 19 files changed, 131 insertions(+), 58 deletions(-)

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJZOogJAAoJEFHr6jzI4aWA59wQALI8Eh3FkpjmdGbm31qEYT0s
i49hX5+GOrbU+qSNFXK9avyqWnT1mcf8n4/yGWr8BoIGrDje/ZLWwiA+xzJ56gpw
nyilWvxGI7KWv3egVmQI950Wy09sEd3tJ8yHlLKLypKkWmwY6REq9CgHBtOCs+sW
o30E5qFJ/oluwJEQ/Pew2Fgcx6hd4HTOaINDOgSgnmzg2gtvo27BCmYHd5R45dDR
zaPK8/Hls7H1+RN6V4rQibFBOYH5Hw7f8oU0jSssk6HMwYKk82AXq0xjivEQo6hs
xAg3UrUw+5WFSyEexu339Q7NuLk1sq3R3tgelXBOqyQht5OXLvBuxb3qvr0KybTu
2d4UYNd41j0Wwv6YMpeilYQ5dNiDDznH7Arr9HPR7f3nO1giTUFWcMsLNBISla//
5JWrzAPNZVUH7WSlkJj3FrlKvq2UgALV3biP6/LXTYZoU449fX2MB7br5HNh5xts
tfiu8pRwH72/5+334Irq/YBLgdMUTJrmJJ11fhV08RG8Acqil79q60Dku/tJRhiy
ppk2J3bRhn1xXEnlFt1GskxPJBe7o2ijwreRTEbo/z1e6YwqPFwUApUX3zJNXLNI
LNDc/AR/ifiVNHCKV81vOlVGoJ9qqQujId90R/G6HWWK4xUlxOURizTb9Wx1GH+a
IYZhWTkapimAAoD824VR
=jWY4
-----END PGP SIGNATURE-----
--=-=-=--
