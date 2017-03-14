Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vhxcN4Z8vzDqGb
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 12:15:16 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Larry.Finger@lwfinger.net, aik@ozlabs.ru, bsingharora@gmail.com,
 cyrilbur@gmail.com, gwshan@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, maddy@linux.vnet.ibm.com, npiggin@gmail.com
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.11-4 tag
Date: Tue, 14 Mar 2017 12:15:10 +1100
Message-ID: <87tw6wirq9.fsf@concordia.ellerman.id.au>
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

Please pull some more powerpc fixes for 4.11.

The bulk of the diffstat is the Power9 Machine Check handler. It's bigger than
I'd usually send after rc2, but apparently folks are hitting them in the field,
and it's from Nick.

This also includes the fix for macio devices that was sent directly to you by
Larry Finger.

cheers


The following changes since commit f7d6a7283aa1de430c6323a9714d1a787bc2d1ea:

  Merge tag 'powerpc-4.11-3' of git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux (2017-03-07 10:46:10 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-4.11-4

for you to fetch changes up to 7b9f71f974a12740e79e918cfd58c2fce0b5b580:

  powerpc/64s: POWER9 machine check handler (2017-03-10 16:32:08 +1100)

----------------------------------------------------------------
powerpc fixes for 4.11 #4

The main item is the addition of the Power9 Machine Check handler. This was
delayed to make sure some details were correct, and is as minimal as possible.

The rest is small fixes, two for the Power9 PMU, two dealing with obscure
toolchain problems, two for the PowerNV IOMMU code (used by VFIO), and one to
fix a crash on 32-bit machines with macio devices due to missing dma_ops.

Thanks to:
  Alexey Kardashevskiy, Cyril Bur, Larry Finger, Madhavan Srinivasan, Nicholas
  Piggin.

----------------------------------------------------------------
Alexey Kardashevskiy (2):
      powerpc/powernv/ioda2: Gracefully fail if too many TCE levels requested
      powerpc/powernv/ioda2: Update iommu table base on ownership change

Cyril Bur (1):
      selftests/powerpc: Replace stxvx and lxvx with stxvd2x/lxvd2x

Larry Finger (1):
      powerpc/pmac: Fix crash in dma-mapping.h with NULL dma_ops

Madhavan Srinivasan (2):
      powerpc/perf: Fix perf_get_data_addr() for power9 DD1
      powerpc/perf: Handle sdar_mode for marked event in power9

Michael Ellerman (1):
      powerpc/boot: Fix zImage TOC alignment

Nicholas Piggin (3):
      powerpc/64s: fix handling of non-synchronous machine checks
      powerpc/64s: allow machine check handler to set severity and initiator
      powerpc/64s: POWER9 machine check handler

 arch/powerpc/boot/zImage.lds.S                    |   1 +
 arch/powerpc/include/asm/bitops.h                 |   4 +
 arch/powerpc/include/asm/mce.h                    | 108 +++++++++-
 arch/powerpc/kernel/cputable.c                    |   3 +
 arch/powerpc/kernel/mce.c                         |  88 +++++++-
 arch/powerpc/kernel/mce_power.c                   | 237 ++++++++++++++++++++++
 arch/powerpc/perf/core-book3s.c                   |   2 +
 arch/powerpc/perf/isa207-common.c                 |  43 +++-
 arch/powerpc/perf/isa207-common.h                 |   1 +
 arch/powerpc/platforms/powernv/opal.c             |  21 +-
 arch/powerpc/platforms/powernv/pci-ioda.c         |  20 +-
 drivers/macintosh/macio_asic.c                    |   1 +
 tools/testing/selftests/powerpc/include/vsx_asm.h |  48 ++---
 13 files changed, 523 insertions(+), 54 deletions(-)

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYx0QgAAoJEFHr6jzI4aWALnwP/2p4G2RLD8Fg1WceteQK484X
c7aQJankfkYxY1HSjJIDBZwVCnjJ3ioH7nfHlVQbiw75/D/gpX09LmBApppCjUKa
7sm0k+1bzIXUQkz7MNissfyPCmRBd2iJap40/V9GTrUJcW9zSGKqLN7/1zrNhKrQ
YyCgKlo513KypfKraxb1Ioe/5x6CwTgT2Uuo+VWcykoPyoSHY/Ij3uwD5+NNkBdO
Y2H5vElQCWGEgMpIsikr+OWYB88ykPpEU0x5qam7PoYokAX3td//LCuIEQdXEoWu
im/14RcZLF5l20gIETEBoCaqIIEVboZmCpJNPytZ1OsedYGzXZ2TS7I8Uvq0qzx9
QiFVPrtNV/koO1nkmWKF4fHDi7Xq2/0w0HuJKcfCKb/5OeVEMZ56eZH2AZ3MISvz
KEgHUSBxDY7gIYuX2yhtmL6jJAVOUt9A52fQyidY76q/tskSoRzgyfVX8yHlyHfE
X9QS4LnZaOAecIRJ79bTbQhKap3d34a6Nz4XpvKDFNkDXOSwYnz6AP3kA49KFo89
55mz8AKfrBWifix6+Fu0JRRBOULR4qt9faXn4PrJJ7KYmmtQeJRyK9Jd9qy7ZkOW
PoDHqrR77E7r+yNFBwzA3qlovOxIy+f0D70GNDLLs6ExdxLmOqKkvTEHuHWQ7JCh
qE9xNHq2lfhjP+GvY0vZ
=N3fw
-----END PGP SIGNATURE-----
--=-=-=--
