Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 087171A2D9E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2015 20:08:35 +1000 (AEST)
Message-ID: <1442570904.5528.6.camel@ellerman.id.au>
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.3-2 tag
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: andrew.donnellan@au1.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 benh@kernel.crashing.org, bharata@linux.vnet.ibm.com,
 christophe.leroy@c-s.fr,  dja@axtens.net, imunsie@au1.ibm.com,
 linux-kernel@vger.kernel.org,  linuxppc-dev@lists.ozlabs.org,
 nacc@linux.vnet.ibm.com, paulus@ozlabs.org
Date: Fri, 18 Sep 2015 20:08:24 +1000
Content-Type: multipart/signed; micalg="pgp-sha256";
 protocol="application/pgp-signature"; boundary="=-/LMov8L/+ir10M/wkzIj"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-/LMov8L/+ir10M/wkzIj
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull powerpc fixes for 4.3:

The following changes since commit 7d9071a095023cd1db8fa18fa0d648dc1a5210e0=
:

  Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git=
/viro/vfs (2015-09-05 20:34:28 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powe=
rpc-4.3-2

for you to fetch changes up to 400c47d81ca383fc87d5a3937b234e23e26909fb:

  powerpc32: memset: only use dcbz once cache is enabled (2015-09-17 10:36:=
53 +1000)

----------------------------------------------------------------
powerpc fixes for 4.3

 - Fix 32-bit TCE table init in kdump kernel from Nish
 - Fix kdump with non-power-of-2 crashkernel=3D from Nish
 - Abort cxl_pci_enable_device_hook() if PCI channel is offline from Andrew
 - Fix to release DRC when configure_connector() fails from Bharata
 - Wire up sys_userfaultfd()
 - Fix race condition in tearing down MSI interrupts from Paul
 - Fix unbalanced pci_dev_get() in cxl_probe() from Daniel
 - Fix cxl build failure due to -Wunused-variable gcc behaviour change from=
 Ian
 - Tell the toolchain to use ABI v2 when building an LE boot wrapper from B=
enh
 - Fix THP to recompute hash value after a failed update from Aneesh
 - 32-bit memcpy/memset: only use dcbz once cache is enabled from Christoph=
e

----------------------------------------------------------------
Andrew Donnellan (1):
      cxl: abort cxl_pci_enable_device_hook() if PCI channel is offline

Aneesh Kumar K.V (1):
      powerpc/mm: Recompute hash value after a failed update

Benjamin Herrenschmidt (1):
      powerpc/boot: Specify ABI v2 when building an LE boot wrapper

Bharata B Rao (1):
      powerpc/pseries: Release DRC when configure_connector fails

Daniel Axtens (1):
      cxl: Fix unbalanced pci_dev_get in cxl_probe

Ian Munsie (1):
      cxl: Fix build failure due to -Wunused-variable behaviour change

LEROY Christophe (2):
      powerpc32: memcpy: only use dcbz once cache is enabled
      powerpc32: memset: only use dcbz once cache is enabled

Michael Ellerman (1):
      powerpc: Wire up sys_userfaultfd()

Nishanth Aravamudan (2):
      powerpc/powernv/pci-ioda: fix 32-bit TCE table init in kdump kernel
      powerpc/powernv/pci-ioda: fix kdump with non-power-of-2 crashkernel=
=3D

Paul Mackerras (1):
      powerpc/MSI: Fix race condition in tearing down MSI interrupts

 arch/powerpc/boot/Makefile                |  3 +++
 arch/powerpc/include/asm/systbl.h         |  1 +
 arch/powerpc/include/asm/unistd.h         |  2 +-
 arch/powerpc/include/uapi/asm/unistd.h    |  1 +
 arch/powerpc/kernel/setup_32.c            |  6 ++++++
 arch/powerpc/lib/copy_32.S                | 11 +++++++++++
 arch/powerpc/mm/hugepage-hash64.c         |  3 ++-
 arch/powerpc/platforms/pasemi/msi.c       |  5 +++--
 arch/powerpc/platforms/powernv/pci-ioda.c | 16 +++++++++++++++-
 arch/powerpc/platforms/powernv/pci.c      |  5 +++--
 arch/powerpc/platforms/pseries/dlpar.c    |  4 +++-
 arch/powerpc/sysdev/fsl_msi.c             |  5 +++--
 arch/powerpc/sysdev/mpic_u3msi.c          |  5 +++--
 arch/powerpc/sysdev/ppc4xx_msi.c          |  5 +++--
 drivers/misc/cxl/Makefile                 |  2 +-
 drivers/misc/cxl/pci.c                    |  2 --
 drivers/misc/cxl/vphb.c                   |  6 ++++++
 17 files changed, 65 insertions(+), 17 deletions(-)



--=-/LMov8L/+ir10M/wkzIj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJV++KhAAoJEFHr6jzI4aWATfYQAID/+jw2tO8J+VTN4qfKh5Pz
lyMYS/wFIvAAefA9vuh5Qg2MWa5MCRVh/9rzkaDDGVtEwlkXTYNcH8YXHovw06ki
mpyzw/ZgMTOsAhHkoZaKOITq7j8R5BfPPj24v8PL68+QX/l7CaL6aODycrYKCOSD
MVcXynit7xU5gDBSiRLtnw4pXvfV+1vUAbMsW9RAdAFf7oueWPq6SKkNtxvOlivy
5rLTayt6zF2F9ri5ZqF+SuEGTsimdC60njmak5NUN9rDdNe492efE6YM7H0pxdPa
JKWsWI7q6F8lJ+QvolnP+FHkiGhytidZcqU9hxAUgClo7ryZB+6D0H3VJwZq9FMb
zeDsF+42UeM8K7Pm1aj0K8S2qfKjS53Z2zMkAff6eQbl/6xSWldkCydlsjs6lm6K
PWCOKr+CcxVyN5skE6EMWJlJHJcPyB0H3cOPryF+5GSI5BQalR52aPTDBkKXGwtY
GQFkrIIjncheiRZry3JjRPIKMJEyfeNEL+or6gHaFgn38tYl0/a8p9yMCzpFCMW5
H31xYK2Ai64LHRYB4R6fyVkiZGQP2N2HmkBz3E+7Bnw5z0bGWsIELs66rOKGuPXR
IWXfbIyZ6fEQDImM0LY+1ieQCG0u/N7O8hhXyIHws6L0yk+Qp7IJv9OriDCrgWjU
dQpbC6Iwf6k4v4xwTFUT
=k0Kr
-----END PGP SIGNATURE-----

--=-/LMov8L/+ir10M/wkzIj--
