Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xDSpD07QPzDqx8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Jul 2017 21:14:28 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 maddy@linux.vnet.ibm.com, npiggin@gmail.com
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.13-3 tag
Date: Fri, 21 Jul 2017 21:14:20 +1000
Message-ID: <87h8y6dotv.fsf@concordia.ellerman.id.au>
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

The following changes since commit 01e6a61aceb82e13bec29502a8eb70d9574f97ad:

  powerpc/64: Fix atomic64_inc_not_zero() to return an int (2017-07-12 21:49:55 +1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-4.13-3

for you to fetch changes up to 029d9252b116fa52a95150819e62af1f6e420fe5:

  powerpc/mm: Mark __init memory no-execute when STRICT_KERNEL_RWX=y (2017-07-18 19:54:24 +1000)

----------------------------------------------------------------
powerpc fixes for 4.13 #3

A handful of fixes, mostly for new code.

Some reworking of the new STRICT_KERNEL_RWX support to make sure we also remove
executable permission from __init memory before it's freed.

A fix to some recent optimisations to the hypercall entry where we were
clobbering r12, this was breaking nested guests (PR KVM).

A fix for the recent patch to opal_configure_cores(). This could break booting
on bare metal Power8 boxes if the kernel was built without
CONFIG_JUMP_LABEL_FEATURE_CHECK_DEBUG.

And finally a workaround for spurious PMU interrupts on Power9 DD2.

Thanks to:
  Nicholas Piggin, Anton Blanchard, Balbir Singh.

----------------------------------------------------------------
Michael Ellerman (4):
      powerpc/powernv: Fix boot on Power8 bare metal due to opal_configure_cores()
      powerpc/mm/radix: Refactor radix__mark_rodata_ro()
      powerpc/mm/hash: Refactor hash__mark_rodata_ro()
      powerpc/mm: Mark __init memory no-execute when STRICT_KERNEL_RWX=y

Nicholas Piggin (2):
      powerpc/perf: Avoid spurious PMU interrupts after idle
      powerpc/64s: Fix hypercall entry clobbering r12 input

 arch/powerpc/include/asm/book3s/64/hash.h    |  1 +
 arch/powerpc/include/asm/book3s/64/pgtable.h |  1 +
 arch/powerpc/include/asm/book3s/64/radix.h   |  1 +
 arch/powerpc/include/asm/pgtable.h           |  7 +++++
 arch/powerpc/kernel/exceptions-64s.S         | 28 +++++++++---------
 arch/powerpc/kernel/idle_book3s.S            | 15 +++++++++-
 arch/powerpc/mm/mem.c                        |  1 +
 arch/powerpc/mm/pgtable-hash64.c             | 44 ++++++++++++++++++++--------
 arch/powerpc/mm/pgtable-radix.c              | 28 ++++++++++++++----
 arch/powerpc/mm/pgtable_64.c                 |  8 +++++
 arch/powerpc/platforms/powernv/opal.c        |  2 +-
 11 files changed, 102 insertions(+), 34 deletions(-)

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJZceINAAoJEFHr6jzI4aWA5MsP/2sLS9WrKb6dSqn8RSjPOROk
yX+r9+Qj5vk9+fQAPlEuaHe/EzfqDDMHv5aZG/IZGtkHHW6KBC1HGqmHs/wGjlAI
yYV1jZrjARj2LjcXu8xsuQfzIt7IbkiyygQVFN2rgF/Acr+DT/wYwFvhi5MHdZ30
+4OJNpyLYpKM+bkpHqvs8P2UGF9OsMWdNSG72rzRIFeVa5RNSfYVCZpj0B9blFlT
+f8CcU/8/L4YV51S4R9LEZx02UouiBUks1CWm6MRFJ48MM8adNZCM1gtuwG4XpN+
WiZxnudqq9R+aUAcVNFTHxDvIspSlPgEnCLWOmBnV2/aXIQY4ctFOFgodsT5+N4g
82waboKCQsUnljI90v806saERHuzjKM57x/lZ4HopR+1LI4iA9245omjZlrC9t5F
4kCj7N2FZddZ8EDC6PUZ2LWenxg/zHAY6M1iB1c0tDjG+aJDXXQaxiguI7At9A9d
INjXetLDtqI9Wn/rlUq7u8p/ezESQOfCfN0an54i3PDGxTExHUodL3ff50GhqIeG
jff1BEg4gVY6+DKUUoH55FVdQL1Krg8G9MpEoCWVbsYTSjEP0ZRZIdM+cUeBKQSG
8e0HnN4/oHh2TbDz7gzh3DttJHa9WIB598Rt5+zpY8dq5eifRncrBGZlU9yxIOZA
VN9l3DZf/6v1CEY/bpQA
=fZpz
-----END PGP SIGNATURE-----
--=-=-=--
