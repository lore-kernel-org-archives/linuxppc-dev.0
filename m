Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zKWMw0VpczF0bj
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jan 2018 09:28:12 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 mikey@neuling.org, npiggin@gmail.com, oohall@gmail.com
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.15-7 tag
Date: Mon, 15 Jan 2018 09:27:50 +1100
Message-ID: <87k1wkaxeh.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
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

Please pull some more powerpc fixes for 4.15, sorry these are so late.

The following changes since commit ecb101aed86156ec7cd71e5dca668e09146e6994:

  powerpc/mm: Fix SEGV on mapped region to return SEGV_ACCERR (2018-01-02 21:12:33 +1100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-4.15-7

for you to fetch changes up to 6e032b350cd1fdb830f18f8320ef0e13b4e24094:

  powerpc/powernv: Check device-tree for RFI flush settings (2018-01-10 21:27:16 +1100)

----------------------------------------------------------------
powerpc fixes for 4.15 #7

One fix for an oops at boot if we take a hotplug interrupt before we are ready
to handle it.

The bulk is patches to implement mitigation for Meltdown, see the change logs
for more details.

Thanks to:
  Nicholas Piggin, Michael Neuling, Oliver O'Halloran, Jon Masters, Jose Ricardo
  Ziviani, David Gibson.

----------------------------------------------------------------
Michael Ellerman (4):
      powerpc/pseries: Make RAS IRQ explicitly dependent on DLPAR WQ
      Merge branch 'topic/ppc-kvm' into fixes
      powerpc/64s: Add support for RFI flush of L1-D cache
      powerpc/64s: Support disabling RFI flush with no_rfi_flush and nopti

Michael Neuling (2):
      powerpc/pseries: Add H_GET_CPU_CHARACTERISTICS flags & wrapper
      powerpc/pseries: Query hypervisor for RFI flush settings

Nicholas Piggin (5):
      powerpc/64: Add macros for annotating the destination of rfid/hrfid
      powerpc/64s: Simple RFI macro conversions
      powerpc/64: Convert the syscall exit path to use RFI_TO_USER/KERNEL
      powerpc/64: Convert fast_exception_return to use RFI_TO_USER/KERNEL
      powerpc/64s: Convert slb_miss_common to use RFI_TO_USER/KERNEL

Oliver O'Halloran (1):
      powerpc/powernv: Check device-tree for RFI flush settings

 arch/powerpc/include/asm/exception-64e.h  |   6 ++
 arch/powerpc/include/asm/exception-64s.h  |  57 ++++++++++++-
 arch/powerpc/include/asm/feature-fixups.h |  13 +++
 arch/powerpc/include/asm/hvcall.h         |  17 ++++
 arch/powerpc/include/asm/paca.h           |  10 +++
 arch/powerpc/include/asm/plpar_wrappers.h |  14 +++
 arch/powerpc/include/asm/setup.h          |  13 +++
 arch/powerpc/kernel/asm-offsets.c         |   5 ++
 arch/powerpc/kernel/entry_64.S            |  44 ++++++++--
 arch/powerpc/kernel/exceptions-64s.S      | 137 +++++++++++++++++++++++++++---
 arch/powerpc/kernel/setup_64.c            | 101 ++++++++++++++++++++++
 arch/powerpc/kernel/vmlinux.lds.S         |   9 ++
 arch/powerpc/kvm/book3s_hv_rmhandlers.S   |   9 +-
 arch/powerpc/kvm/book3s_rmhandlers.S      |   7 +-
 arch/powerpc/kvm/book3s_segment.S         |   4 +-
 arch/powerpc/lib/feature-fixups.c         |  41 +++++++++
 arch/powerpc/platforms/powernv/setup.c    |  49 +++++++++++
 arch/powerpc/platforms/pseries/dlpar.c    |  21 ++++-
 arch/powerpc/platforms/pseries/pseries.h  |   2 +
 arch/powerpc/platforms/pseries/ras.c      |   3 +-
 arch/powerpc/platforms/pseries/setup.c    |  35 ++++++++
 21 files changed, 561 insertions(+), 36 deletions(-)

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJaW9lmAAoJEFHr6jzI4aWAa2kP/ROsMmvasgd3+IBLLf3RPLEu
fLFwGQ0D7Yyy9a1mo78tG0uaLW3uUDePnvcD3mRl+joeNr2zdJBbnujJIfX096IU
06nARnBnv87bAxvT8WRacac0Ry9nVQFAhepA0srejnAHCHSdTTTus7YWuSZ6YsdH
aotEt7PbhIqgrTKhCqkQCffMZHen0NML2U7L4n3qnb9HSUyIvU/fzuHxWLNzIQPU
UM2U1hna5D+gJeMILPWawH8z7CI70F4/PP1orM4hukvkvodBw5n8CfS2JColEBJ+
STfB9CwDli5/GFGkuI5dM9V5IHmQc324Rvs8sbX1JRNIczjNjILlpulmHrIOqiL/
54HYeHzOOZ4uPbUa26M7eYwDP4Bj/g4NfGN+9amvkYCF43ul6LR7rU9fx8AdA/Od
UfVOsscnot+qSUVG4K553CP/97gFYTbEFqArPxiowivY/tNQDn+OgzFpLDpngoXE
7nhdrPls3yRGVNKwqBfTQvTuuWuuAXAyAX2VsWjaOiaU5zu/1JvvtfT2QnXiljNg
H0rJGAd8FbubwBLZCr85fCzSwu1zMNciOEHJnDwI8fWpEla+zJBb4xmnvcI1diuF
0q++vULwRIEGl/bPP2syf6cHpm6wWwSIOanHLcUHfOjN4QPdWtZMMu/CKXyyghcr
72WyvM0XRSPvICHtwJs2
=L/5b
-----END PGP SIGNATURE-----
--=-=-=--
