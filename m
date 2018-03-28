Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40B73p1LsDzF28g
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Mar 2018 23:48:54 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: aneesh.kumar@linux.vnet.ibm.com, benh@kernel.crashing.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.16-6 tag
Date: Wed, 28 Mar 2018 23:48:52 +1100
Message-ID: <871sg42wnf.fsf@concordia.ellerman.id.au>
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

Please pull some more powerpc fixes for 4.16. Apologies if this is a bit
big at rc7, but they're all reasonably important fixes. None are
actually for new code, so they aren't indicative of 4.16 being in bad
shape from our point of view.

cheers


The following changes since commit b0c41b8b6e43120d7c35e4709508a3d90a09646e:

  powerpc/pseries: Fix vector5 in ibm architecture vector table (2018-03-06 23:05:38 +1100)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-4.16-6

for you to fetch changes up to 52396500f97c53860164debc7d4f759077853423:

  powerpc/64s: Fix i-side SLB miss bad address handler saving nonvolatile GPRs (2018-03-26 07:40:17 +1100)

- ----------------------------------------------------------------
powerpc fixes for 4.16 #6

These are actually all fixes for pre-4.16 code, or new hardware workarounds.

Fix missing AT_BASE_PLATFORM (in auxv) when we're using a new firmware interface
for describing CPU features.

Fix lost pending interrupts due to a race in our interrupt soft-masking code.

A workaround for a nest MMU bug with TLB invalidations on Power9.

A workaround for broadcast TLB invalidations on Power9.

Fix a bug in our instruction SLB miss handler, when handling bad addresses
(eg. >= TASK_SIZE), which could corrupt non-volatile user GPRs.

Thanks to:
  Aneesh Kumar K.V, Balbir Singh, Benjamin Herrenschmidt, Nicholas Piggin.

- ----------------------------------------------------------------
Aneesh Kumar K.V (3):
      powerpc/mm/radix: Remove unused code
      powerpc/mm/radix: Move the functions that does the actual tlbie closer
      powerpc/mm: Fixup tlbie vs store ordering issue on POWER9

Benjamin Herrenschmidt (2):
      powerpc/mm: Add tracking of the number of coprocessors using a context
      powerpc/mm: Workaround Nest MMU bug with TLB invalidations

Michael Ellerman (1):
      powerpc/64s: Fix NULL AT_BASE_PLATFORM when using DT CPU features

Nicholas Piggin (2):
      powerpc/64s: Fix lost pending interrupt due to race causing lost update to irq_happened
      powerpc/64s: Fix i-side SLB miss bad address handler saving nonvolatile GPRs

 arch/powerpc/include/asm/book3s/64/mmu.h           |   3 +
 .../powerpc/include/asm/book3s/64/tlbflush-radix.h |   3 -
 arch/powerpc/include/asm/cputable.h                |   3 +-
 arch/powerpc/include/asm/mmu_context.h             |  18 ++-
 arch/powerpc/kernel/dt_cpu_ftrs.c                  |   6 +
 arch/powerpc/kernel/exceptions-64s.S               |   2 +-
 arch/powerpc/kernel/irq.c                          |   8 +
 arch/powerpc/kvm/book3s_64_mmu_radix.c             |   3 +
 arch/powerpc/kvm/book3s_hv_rm_mmu.c                |  11 ++
 arch/powerpc/mm/hash_native_64.c                   |  16 +-
 arch/powerpc/mm/mmu_context_book3s64.c             |   1 +
 arch/powerpc/mm/pgtable_64.c                       |   1 +
 arch/powerpc/mm/tlb-radix.c                        | 169 +++++++++++----------
 13 files changed, 154 insertions(+), 90 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJau480AAoJEFHr6jzI4aWAYwIP/RBX30EIQegM7GUwEYulVVhG
E16yFb+QLvUrh3YXU9Oqyb0tj1y/gLJcPojin28TWBpt+wGejriCoSIOPjoI915E
W8jnnxrR8u/nZfzARNh+zsR6+qbNVz3MyVSAsn9BrS2jjWqiekXuvF7WLr34M22N
6xiu2BJ7B4cjvNJa2AFj1GYLCFeed4BDhERn/bNaK3jhdp3hYpnpaxG6y+od5M2J
GdQRO+GhCfBzho/ypLAX62klnprAVYCh+qnDKOOHGpE0qz0WOTHnZ3d5VVJO4sAe
zCdadR66h6YvukrGvTLmJfz1ykZv1vbrr+WbgN0kt+8EsYAqRtO1OB1wm0hjbQYK
e5hA+PccnVkxqjv0b/dg81OS/3PCA7/4xNtBRFxc4YNO3JGebU87gMYepaJAIt0A
zCySqOYOIZMznfuk9310XYY7Z+LnpnRxRLTNZFq5tvaI/O9I/5P3a5f1IUwvkJk3
PCY/EyzLuyIac8FFcMQh5UIJLqebAVVAnNC75YTZG576gf0NmJYO/jwxPz5Yep48
oO1er783SX4vojcYfEVyp+mA4KGbVKel615L1pvgX4CH9tXM4PhX5y/ODZjjP9ua
XksvQdaUlakHIBJwNboFS70gaBHoivN1OFEUINf3XtOhwZRTo51ufilONM8XZhoX
r8o+pDgD/5QCyJqMhlcr
=VKmI
-----END PGP SIGNATURE-----
