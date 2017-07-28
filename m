Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xJpqC5mHyzDrRh
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jul 2017 23:00:23 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: aneesh.kumar@linux.vnet.ibm.com, benh@kernel.crashing.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 lvivier@redhat.com
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.13-4 tag
Date: Fri, 28 Jul 2017 23:00:18 +1000
Message-ID: <87inicemxp.fsf@concordia.ellerman.id.au>
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

Please pull some more powerpc fixes for 4.13:

The following changes since commit 029d9252b116fa52a95150819e62af1f6e420fe5:

  powerpc/mm: Mark __init memory no-execute when STRICT_KERNEL_RWX=y (2017-07-18 19:54:24 +1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-4.13-4

for you to fetch changes up to 0da12a7a81f1e2255e89dc783c565e84801475a2:

  powerpc/mm/hash: Free the subpage_prot_table correctly (2017-07-27 13:05:50 +1000)

----------------------------------------------------------------
powerpc fixes for 4.13 #4

The highlight is Ben's patch to work around a host killing bug when running KVM
guests with the Radix MMU on Power9. See the long change log of that commit for
more detail.

And then three fairly minor fixes:
 - Fix of_node_put() underflow during reconfig remove, using old DLPAR tools.
 - Fix recently introduced ld version check with 64-bit LE-only toolchain.
 - Free the subpage_prot_table correctly, avoiding a memory leak.

Thanks to:
  Aneesh Kumar K.V, Benjamin Herrenschmidt, Laurent Vivier.

----------------------------------------------------------------
Aneesh Kumar K.V (1):
      powerpc/mm/hash: Free the subpage_prot_table correctly

Benjamin Herrenschmidt (1):
      powerpc/mm/radix: Workaround prefetch issue with KVM

Laurent Vivier (1):
      powerpc/pseries: Fix of_node_put() underflow during reconfig remove

Michael Ellerman (1):
      powerpc/Makefile: Fix ld version check with 64-bit LE-only toolchain

 arch/powerpc/Makefile                     | 25 ++++++-------
 arch/powerpc/include/asm/book3s/64/mmu.h  | 15 ++++----
 arch/powerpc/include/asm/mmu_context.h    | 18 ++++++++--
 arch/powerpc/kvm/book3s_hv_rmhandlers.S   | 59 ++++++++++++++++++++++++++-----
 arch/powerpc/mm/mmu_context_book3s64.c    |  5 +--
 arch/powerpc/mm/pgtable-radix.c           | 34 +++++++++++++++++-
 arch/powerpc/mm/subpage-prot.c            |  2 +-
 arch/powerpc/mm/tlb-radix.c               | 45 +++++++++++++++++++++--
 arch/powerpc/platforms/pseries/reconfig.c |  1 -
 9 files changed, 168 insertions(+), 36 deletions(-)

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJZezVjAAoJEFHr6jzI4aWArEkP/3CSmvqbMsdVlf/2tbulhGA9
KrCpM/AQsMireqP3gng3uTIfxT6Ge1SAiPWmiWEurpufuMwVb4wotUdtBhMHOntG
iijYUyj8pa+PMtyHVQ7IroPiUMu2LO1V6o81KgrLZQbj3s/X6rybnY1kV5GOACr3
Go5xfJ6DY8BuW1wJv3b0Xo9UxwXg0z7U/CyRw6eJOCHKFZ6PP+JNTs4a6nj314nW
bjIkTA4409Y1QQN90pyE4yEaZ0kbnCqmQSEGei0RxATruNNxdfx+mGth6LYFmGn0
lGzWv4ICA/sR/zLbwnur7cR2/17ASUgH7nejzkSNoy4tJuICYFzahfgCSWPNSdeV
c0IkSG5bMC4i0J3QRT9tIv5rbkIYRGwPWTEdCLbCCkDbKWlwNq1F8c9B+nNjL1V/
AGtUnK7tI+TA26U2mzvUj6lESUXXxUsSYY3rRFxMuEJedni3Bw4pDhgKW3VkbfyC
Te3XWau32sINrXzkgQnY1+QkbWsp38k7qwIh9lr2GkiKWFXqAaqmUlSis8PgSgvu
wrM7iZsy3iSmT3mfMF2jorQP+b9AH/4QgU+QBEIYF0F08DjhHEvKmxIkmLkekZwZ
aWL4KPMVP0Yo3PJxhJQPZmm2iZiEqpuzcifZpVGkyRgGuvISi3xheDgHB0Z5UW0p
YG6ROyFxFjpIn98++7M2
=cE70
-----END PGP SIGNATURE-----
--=-=-=--
