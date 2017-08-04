Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xP2YV073lzDqJC
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Aug 2017 20:03:10 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: alistair@popple.id.au, anton@samba.org, gromero@linux.vnet.ibm.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 maddy@linux.vnet.ibm.com, npiggin@gmail.com, oohall@gmail.com,
 oss@buserror.net, ruscur@russell.cc, sergei.shtylyov@cogentembedded.com
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.13-5 tag
Date: Fri, 04 Aug 2017 20:03:07 +1000
Message-ID: <871sorr6p0.fsf@concordia.ellerman.id.au>
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

Please pull some more powerpc fixes for 4.13.

I had to merge rc1 into my fixes branch, so that I had the code that
needed fixing. I don't think it should cause any problems, other than I
had to generate the diffstat by hand.

cheers

The following changes since commit 0da12a7a81f1e2255e89dc783c565e84801475a2:

  powerpc/mm/hash: Free the subpage_prot_table correctly (2017-07-27 13:05:50 +1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-4.13-5

for you to fetch changes up to 3db40c312c2c1eb2187c5731102fa8ff380e6e40:

  powerpc/64: Fix __check_irq_replay missing decrementer interrupt (2017-08-04 12:55:49 +1000)

----------------------------------------------------------------
powerpc fixes for 4.13 #5

Fixes for recently merged code:
 - a fix for the _PAGE_DEVMAP support, which was breaking KVM on Power9 radix
 - avoid a (harmless) lockdep warning in the early SMP code
 - return failure for some uses of dma_set_mask() rather than falling back to 32-bits
 - fix stack setup in watchdog soft_nmi_common() to use emergency stack
 - fix of_irq_to_resource() error check in of_fsl_spi_probe()

Two fixes going to stable:
 - fix saving of Transactional Memory SPRs in core dump
 - fix __check_irq_replay missing decrementer interrupt

And two misc:
 - fix 64-bit boot wrapper build with non-biarch compiler
 - work around a POWER9 PMU hang after state-loss idle

Thanks to:
  Alistair Popple, Aneesh Kumar K.V, Cyril Bur, Gustavo Romero, Jose Ricardo
  Ziviani, Laurent Vivier, Nicholas Piggin, Oliver O'Halloran, Sergei Shtylyov,
  Suraj Jitindar Singh, Thomas Gleixner.

----------------------------------------------------------------
Alistair Popple (1):
      powerpc/powernv/pci: Return failure for some uses of dma_set_mask()

Gustavo Romero (1):
      powerpc/tm: Fix saving of TM SPRs in core dump

Michael Ellerman (3):
      powerpc/smp: Call smp_ops->setup_cpu() directly on the boot CPU
      powerpc/boot: Fix 64-bit boot wrapper build with non-biarch compiler
      Merge tag 'v4.13-rc1' into fixes

Nicholas Piggin (3):
      powerpc/64s: Fix stack setup in watchdog soft_nmi_common()
      powerpc/perf: POWER9 PMU stops after idle workaround
      powerpc/64: Fix __check_irq_replay missing decrementer interrupt

Oliver O'Halloran (1):
      powerpc/mm: Fix pmd/pte_devmap() on non-leaf entries

Sergei Shtylyov (1):
      powerpc/83xx/mpc832x_rdb: fix of_irq_to_resource() error check

 arch/powerpc/boot/Makefile                   | 14 +++++++++++---
 arch/powerpc/include/asm/book3s/64/pgtable.h | 10 +++++++++-
 arch/powerpc/kernel/exceptions-64s.S         | 10 +++++++++-
 arch/powerpc/kernel/idle_book3s.S            |  8 +++++++-
 arch/powerpc/kernel/irq.c                    | 15 ++++++++++++++-
 arch/powerpc/kernel/ptrace.c                 | 13 ++++++++++---
 arch/powerpc/kernel/smp.c                    | 12 ++----------
 arch/powerpc/platforms/83xx/mpc832x_rdb.c    |  2 +-
 arch/powerpc/platforms/powernv/pci-ioda.c    |  8 ++++++++
 9 files changed, 71 insertions(+), 21 deletions(-)

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJZhEZcAAoJEFHr6jzI4aWAqYMP+wRkHJjSE5OfbrV/Rd52DBBX
IQXiOoe5neOoIKZ828aCAznOc/V/II74FnfuMX2R6+gorOvD+KsDJO6L68AMe9UY
x80F0hftI7iLyjzugrmZWq3q+y2q5TH8KmUqrtIj2zc23BXOclcp3o9vPVFXo7Xp
8axpeROPhiZyw2vOd+K4kF/9vHfcRN8rP4QTdjfCDbnL78K4YdMurME2bI+HOf6f
0Jkt3lnYwDw5sK3m6ohtibaTy0Ji/15h8qRMnKbXJ1zuH1lP+8Nm4BbUbjPR9VUb
iPqkeBXFaltNTP9BiauJ9s7ISEovGlb8/KULRVkng5GU/nJOa6RilR+hBSMBEOjD
pASuANqTyoJ/ljY03M18tJTX7cK1sUxe9E8oRnSOETRzvsr5vtsWDILXz7V/8JmR
n9wjQP2SQDOqxn7xz8d4P6tUv80ktvzDrYjlu59aMSTjd98IGepwllQOOD1BJlBi
/LN4iMpA10ZjYl+Nl3k+v/PMNStnz+8mA/1OUl+tmUWObJ0MqysFWpkhIJti0Uc3
dExBFfd8Z0e9oQkxyozuOjOmoqWvXZ3gfX1+isT8BmCAUwpIPg8pcYSp9AN6jfuX
+67YiaA4KeHLpYY1Y2GWSFOJz1ytbZULY0vXXq3Kc8ufFKATLQ9A/gCkOgM7RWZc
XEWKakGFBgdq+E7BT24u
=A/7q
-----END PGP SIGNATURE-----
--=-=-=--
