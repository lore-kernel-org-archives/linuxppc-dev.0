Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rR0rw151FzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jun 2016 21:52:00 +1000 (AEST)
Message-ID: <1465559513.32231.2.camel@ellerman.id.au>
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.7-3 tag
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: aneesh.kumar@linux.vnet.ibm.com, gwshan@linux.vnet.ibm.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 olof@lixom.net,  paulus@ozlabs.org, raj.khem@gmail.com, ruscur@russell.cc,
 thuth@redhat.com,  wsa@the-dreams.de
Date: Fri, 10 Jun 2016 21:51:53 +1000
Content-Type: multipart/signed; micalg="pgp-sha1";
 protocol="application/pgp-signature";
 boundary="=-PFzAmv8v8L+0BJe9kq/U"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-PFzAmv8v8L+0BJe9kq/U
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull some more powerpc fixes for 4.7:

The following changes since commit 1a695a905c18548062509178b98bc91e67510864=
:

  Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powe=
rpc-4.7-3

for you to fetch changes up to 8017ea35d33f9e0950d369773ab48bcb1efb9ba0:

  powerpc/nohash: Fix build break with 64K pages (2016-06-10 13:24:56 +1000=
)

----------------------------------------------------------------
powerpc fixes for 4.7 #2

 - ptrace: Fix out of bounds array access warning from Khem Raj
 - pseries: Fix PCI config address for DDW from Gavin Shan
 - pseries: Fix IBM_ARCH_VEC_NRCORES_OFFSET since POWER8NVL was added from =
Michael Ellerman
 - of: fix autoloading due to broken modalias with no 'compatible' from Wol=
fram Sang
 - radix: Fix always false comparison against MMU_NO_CONTEXT from Aneesh Ku=
mar K.V
 - hash: Compute the segment size correctly for ISA 3.0 from Aneesh Kumar K=
.V
 - nohash: Fix build break with 64K pages from Michael Ellerman

----------------------------------------------------------------
Aneesh Kumar K.V (5):
      powerpc/mm/radix: Update LPCR only if it is powernv
      powerpc/mm/hash: Fix the reference bit update when handling hash faul=
t
      powerpc/mm/radix: Add missing tlb flush
      powerpc/mm/radix: Fix always false comparison against MMU_NO_CONTEXT
      powerpc/mm/hash: Compute the segment size correctly for ISA 3.0

Gavin Shan (1):
      powerpc/pseries: Fix PCI config address for DDW

Khem Raj (1):
      powerpc/ptrace: Fix out of bounds array access warning

Michael Ellerman (2):
      powerpc/pseries: Fix IBM_ARCH_VEC_NRCORES_OFFSET since POWER8NVL was =
added
      powerpc/nohash: Fix build break with 64K pages

Russell Currey (2):
      powerpc/pseries/eeh: Handle RTAS delay requests in configure_bridge
      powerpc/pseries/eeh: Refactor the configure_bridge RTAS tokens

Thomas Huth (3):
      powerpc: Fix definition of SIAR and SDAR registers
      powerpc: Use privileged SPR number for MMCR2
      powerpc/pseries: Add POWER8NVL support to ibm,client-architecture-sup=
port call

Wolfram Sang (1):
      of: fix autoloading due to broken modalias with no 'compatible'

 arch/powerpc/include/asm/nohash/64/pgalloc.h |  2 +-
 arch/powerpc/include/asm/reg.h               |  6 ++--
 arch/powerpc/kernel/prom_init.c              |  3 +-
 arch/powerpc/kernel/ptrace.c                 |  4 +--
 arch/powerpc/mm/hash_native_64.c             |  6 +++-
 arch/powerpc/mm/hash_utils_64.c              | 22 +++++++++++--
 arch/powerpc/mm/pgtable-book3s64.c           |  5 +--
 arch/powerpc/mm/pgtable-radix.c              | 23 ++++++-------
 arch/powerpc/mm/tlb-radix.c                  |  8 ++---
 arch/powerpc/platforms/pseries/eeh_pseries.c | 49 +++++++++++++++++++-----=
----
 arch/powerpc/platforms/pseries/iommu.c       |  4 +--
 scripts/mod/file2alias.c                     |  2 +-
 12 files changed, 84 insertions(+), 50 deletions(-)

--=-PFzAmv8v8L+0BJe9kq/U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABAgAGBQJXWqnZAAoJEFHr6jzI4aWAumwP/jCSwnjXBnED75QuEWru1NRY
fYKeYajBhSI8iNT4JjsPF73MXTjL3Kq+Qy9J9pcNsvoTWA7tfJuqr+YZy5ned7qp
8ivg2YzW8F9kD6gzLOO3nxyScTMrQQ+VIJlvgmCtgVu7PB8YLQoeY2+gGxKpGJQe
uViKPCH3+I3SA9W139P5YtuYyGjoa7emiWSq738dGZ/5lGUAp7QRwQQ4tdkjZFYd
GNI72vf9gSqydQYTSxxaq0v45BvD2fdmLLyKVOZILR/+tNSeIxN90zeBmTya9Ic6
xqPLpg28xKyXFaeU77cWncJNInpUQb4L9xs7EmerXLZf+YVURkkf6N9ITl9O+TF/
VlUry8pdL8fMVF0/nyqjcOFcIc/TJMU1OCTEt7oHeZRlOBYTUJmdb8YXyVZzZm9o
4JQk1Z1zrjnlpS1S8DHWtMnfk4UjbXLNAg6nASQg3NHBLjwcqjuI/82NzfPt3sTg
gbeu1YWRs8EawOX2pUOaTUD9op71ktdnsg4eRHSgMvblUW4jMJ9CQkmxcMtu8yNp
l7BcAeHIrflmutSSXAqiUkGX0REYEACxrLT4InKJlcLNNQkgJsElSJZ3QhSvCvWc
3bhm6ugNmoRfP5+JO+gNdfohoun+Ldv6Ln7HpsuU7D34VGjyYjvme0wRrUUENtwd
7/1jzqOFEwbqxtq5oOix
=Jw3c
-----END PGP SIGNATURE-----

--=-PFzAmv8v8L+0BJe9kq/U--
