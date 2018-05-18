Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40nTvZ3JfXzF2BD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 May 2018 23:45:30 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: fbarrat@linux.vnet.ibm.com, felix@linux.ibm.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.17-6 tag
Date: Fri, 18 May 2018 23:45:27 +1000
Message-ID: <87efi9xeko.fsf@concordia.ellerman.id.au>
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

Please pull some more powerpc fixes for 4.17:

The following changes since commit 6c0a8f6b5a45ac892a763b6299bd3c5324fc5e02:

  powerpc/pseries: Fix CONFIG_NUMA=n build (2018-05-08 14:59:56 +1000)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-4.17-6

for you to fetch changes up to c1d2a31397ec51f0370f6bd17b19b39152c263cb:

  powerpc/powernv: Fix NVRAM sleep in invalid context when crashing (2018-05-18 00:23:07 +1000)

- ----------------------------------------------------------------
powerpc fixes for 4.17 #6

Just three commits.

The two cxl ones are not fixes per se, but they modify code that was added this
cycle so that it will work with a recent firmware change.

And then a fix for a recent commit that added sleeps in the NVRAM code, which
needs to be more careful and not sleep if eg. we're called in the panic() path.

Thanks to:
  Nicholas Piggin, Philippe Bergheaud, Christophe Lombard.

- ----------------------------------------------------------------
Nicholas Piggin (1):
      powerpc/powernv: Fix NVRAM sleep in invalid context when crashing

Philippe Bergheaud (2):
      cxl: Set the PBCQ Tunnel BAR register when enabling capi mode
      cxl: Report the tunneled operations status

 Documentation/ABI/testing/sysfs-class-cxl   |  8 ++++++++
 arch/powerpc/platforms/powernv/opal-nvram.c | 14 ++++++++++++--
 drivers/misc/cxl/cxl.h                      |  1 +
 drivers/misc/cxl/pci.c                      | 12 ++++++++++++
 drivers/misc/cxl/sysfs.c                    | 10 ++++++++++
 5 files changed, 43 insertions(+), 2 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJa/tj4AAoJEFHr6jzI4aWAZBoP/2/kddNPHzMwnzcx0B5WzEfo
3JQcTLZPEqsb5n0xwaWOgb0o0u8EpHDtPZlJlZZWwPKbphlZvQ+reAJAXCQXXj6P
n6BrbfpHlJo1J2wZVeihOuVTtSiXqq82YEtCzdUCUQNa8+2rQ7bLOB56cLdnyFWx
wvK/xOM4rG/nPDi3tlH+IvhNeUdc2Y1vCB6N/RVvJVJOduCED1zCxcWj7uJYGt1x
UdFPcah4OPSF9qPemReu6CjiwesvEm3y3S9TYLLJLXBDmKvs7BDRbfczP52tY90P
XMErJN4MtnNasotCJVcZylfNhSTCyyaQ4si+G/COAM0eh8oPdcIH3C2yXnQHXVPz
pUpe7TF3N7DOoa66WHXsh9dr9G7E0DhcpBgpz30/HmYasaYSEYpDsCH6UvbmvpzO
xtyocfgtuyaF28Rz4WVYSVGkJwE/+NhdsvfQUFI6DGQXoVu08Xxx3rhOlNKVecTw
8yuaIpPSz0i1pFg3SRa1MaS0F4FqGs0T3OLFsEihjdsc3EpJeB3Vp0IiqbmhR6Pa
1rhsjPY4yS5tPJS9K4CQszgw3Ke6C7KYIttGo7BxVKPLXsp52HhTqFpp0LHDcw8y
zFjOS7kh07NCgn8tSwMLUTRUUXEDLE2fJOVWCDdvkXEzpd/LfaP15gjZ3m66OMTS
Oj72EjBAGNX4dN4yQuo7
=4xib
-----END PGP SIGNATURE-----
