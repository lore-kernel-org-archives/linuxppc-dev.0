Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vFDqy4jxTzDqBl
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Feb 2017 22:18:06 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: arbab@linux.vnet.ibm.com, darren@stevens-zone.net,
 gwshan@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.10-3 tag
Date: Fri, 03 Feb 2017 22:18:04 +1100
Message-ID: <87o9yja5g3.fsf@concordia.ellerman.id.au>
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

Please pull some more powerpc fixes for 4.10:

The following changes since commit 178f358208ceb8b38e5cff3f815e0db4a6a70a07:

  powerpc: Ignore reserved field in DCSR and PVR reads and writes (2017-01-20 15:21:35 +1100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-4.10-3

for you to fetch changes up to a0615a16f7d0ceb5804d295203c302d496d8ee91:

  powerpc/mm: Use the correct pointer when setting a 2MB pte (2017-01-30 15:35:13 +1100)

----------------------------------------------------------------
powerpc fixes for 4.10 #3

The main change is we're reverting the initial stack protector support we
merged this cycle. It turns out to not work on toolchains built with libc
support, and fixing it will be need to wait for another release.

And the rest are all fairly minor:
 - Some pasemi machines were not booting due to a missing error check in
   prom_find_boot_cpu().
 - In EEH we were checking a pointer rather than the bool it pointed to.
 - The clang build was broken by a BUILD_BUG_ON() we added.
 - The radix (Power9 only) version of map_kernel_page() was broken if our
   memory size was a multiple of 2MB, which it generally isn't.

Thanks to:
  Darren Stevens, Gavin Shan, Reza Arbab.

----------------------------------------------------------------
Darren Stevens (1):
      powerpc: Add missing error check to prom_find_boot_cpu()

Gavin Shan (1):
      powerpc/eeh: Fix wrong flag passed to eeh_unfreeze_pe()

Michael Ellerman (2):
      powerpc: Revert the initial stack protector support
      powerpc: Fix build failure with clang due to BUILD_BUG_ON()

Reza Arbab (1):
      powerpc/mm: Use the correct pointer when setting a 2MB pte

 arch/powerpc/Kconfig                       |  1 -
 arch/powerpc/include/asm/cpu_has_feature.h |  2 ++
 arch/powerpc/include/asm/mmu.h             |  2 ++
 arch/powerpc/include/asm/stackprotector.h  | 40 ------------------------------
 arch/powerpc/kernel/Makefile               |  4 ---
 arch/powerpc/kernel/asm-offsets.c          |  3 ---
 arch/powerpc/kernel/eeh_driver.c           |  2 +-
 arch/powerpc/kernel/entry_32.S             |  6 +----
 arch/powerpc/kernel/process.c              |  6 -----
 arch/powerpc/kernel/prom_init.c            |  3 +++
 arch/powerpc/mm/pgtable-radix.c            |  4 +--
 11 files changed, 11 insertions(+), 62 deletions(-)
 delete mode 100644 arch/powerpc/include/asm/stackprotector.h

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYlGbtAAoJEFHr6jzI4aWA7kYQAIaaDSlCr1d+KfN+ckCFl+j/
SVeXo2bb/Av9YGeYdxbQwAsNpP4gGtBD080lcvmM2fAZUdSz0yHCxVf8ddkPLYMi
2DFxkqeHbyc0paiyHijlJJRig34UH1TZuPw9+V1gIYnGvanJQ7LKWYlZCrHT/7pD
5Op+LEw6SswM3xwXFeBeCDlfHeqv1cKq8Mgqza0JcWWQV7biAiBWFTFkbEP+0KjJ
qvbrvvR6PIddpzX2BI/Pvp9RAVnS5UVMyeypCbqm85VstozHnXKuV3iqiCHPBTiT
X7fd2aC2kgLWIBRCsa9xbD9Kk+4uuEGbIO/n/SqHfLX3LShUazSxI2mZnCsbenZH
XueRHb9XxFqOsbB+GaTsfNZP5hIoF8nPD3UB3IULgnR4mnOwYwC5F+ILmabIkHfg
Oh+9OlW3Q/dlwHz2AKByuTBkSPqiXZn4ODfb41lqWctdnLuZ+Y4no19eqnYb+YPu
xI61uZr4AMdZXVVIdC8PqVRUu84Yh8HhutZbzb4FA0rQZR8a9clxr0mn/3ikjhhQ
xJO7mY/yJ3XqOai3wXbOQsoE2Omg2Y3dEubckp9P4OXyLwn0JtUpyOG5VjJSmOpO
hjyWUmJwGwL6QeSrZYCe/t7sCms2vRPCd/U8rDPoJsaKT6L4jx3Aee6AI74sLzP6
3XHcBMxjRaIOWJ4sHehY
=Nlnj
-----END PGP SIGNATURE-----
--=-=-=--
