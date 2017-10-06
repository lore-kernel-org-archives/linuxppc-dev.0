Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y7n1C6TKXzDqhg
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Oct 2017 22:07:59 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: andrew.donnellan@au1.ibm.com, anton@samba.org, bsingharora@gmail.com,
 chunkeey@gmail.com, clg@kaod.org, clombard@linux.vnet.ibm.com,
 fbarrat@linux.vnet.ibm.com, jk@ozlabs.org, linux-kernel@vger.kernel.org,
 linux@roeck-us.net, linuxppc-dev@lists.ozlabs.org, mikey@neuling.org
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.14-4 tag
Date: Fri, 06 Oct 2017 22:07:58 +1100
Message-ID: <87h8vc4jqp.fsf@concordia.ellerman.id.au>
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
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull some more powerpc fixes for 4.14.

This is two weeks worth of fixes, and the diffstat is reasonably small,
so I think we're on track.

The following changes since commit e19b205be43d11bff638cad4487008c48d21c103:

  Linux 4.14-rc2 (2017-09-24 16:38:56 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powe=
rpc-4.14-4

for you to fetch changes up to 53ecde0b9126ff140abe3aefd7f0ec64d6fa36b0:

  powerpc/powernv: Increase memory block size to 1GB on radix (2017-10-06 1=
5:50:45 +1100)

=2D---------------------------------------------------------------
powerpc fixes for 4.14 #4

Nine small fixes, really nothing that stands out.

A work around for a spurious MCE on Power9. A CXL fault handling fix, some =
fixes
to the new XIVE code, and a fix to the new 32-bit STRICT_KERNEL_RWX code.

Fixes for old code/stable: an fix to an incorrect TLB flush on boot but not=
 on
any current machines, a compile error on 4xx and a fix to memory hotplug wh=
en
using radix (Power9).

Thanks to:
  Anton Blanchard, C=C3=A9dric Le Goater, Christian Lamparter, Christophe L=
eroy,
  Christophe Lombard, Guenter Roeck, Jeremy Kerr, Michael Neuling, Nicholas
  Piggin.

=2D---------------------------------------------------------------
Anton Blanchard (1):
      powerpc/powernv: Increase memory block size to 1GB on radix

Christian Lamparter (1):
      powerpc/4xx: Fix compile error with 64K pages on 40x, 44x

Christophe Lombard (1):
      cxl: Fix memory page not handled

C=C3=A9dric Le Goater (2):
      powerpc/xive: Fix IPI reset
      powerpc/xive: Clear XIVE internal structures when a CPU is removed

Guenter Roeck (1):
      powerpc/mm: Call flush_tlb_kernel_range with interrupts enabled

Jeremy Kerr (1):
      powerpc: Fix action argument for cpufeatures-based TLB flush

Michael Neuling (2):
      powerpc: Handle MCE on POWER9 with only DSISR bit 30 set
      powerpc: Fix workaround for spurious MCE on POWER9

 arch/powerpc/kernel/dt_cpu_ftrs.c      |  4 ++--
 arch/powerpc/kernel/mce_power.c        | 13 +++++++++++++
 arch/powerpc/kernel/setup-common.c     |  3 ---
 arch/powerpc/mm/pgtable_32.c           |  2 +-
 arch/powerpc/platforms/powernv/setup.c | 10 +++++++++-
 arch/powerpc/sysdev/xive/common.c      |  8 ++++++++
 arch/powerpc/sysdev/xive/spapr.c       |  4 ++++
 drivers/misc/cxl/cxllib.c              | 13 +++++++++++--
 8 files changed, 48 insertions(+), 9 deletions(-)

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJZ12QOAAoJEFHr6jzI4aWAKhsP/inASbtd2q+RmI3MQ87aoBdS
BX/UswkdTpic4/42OBvDVdHI68Z8hWlUvA2l0QZ4mfDAskv1w4aRO6ipTQ3y4LH4
2em6P64kd/PSIaMCmTxUrR2aCdDvDR5fIbkFA7I3BuaSRCzqkya20Y/MugrdOW85
4y2BBRKIEz1JHaBM1Xj33yfOXT8fKcHBtU32MUxpjSakDxkkCZzUd4UTuha9ghSI
VR3gbLxWfU0a77sMhqXEE6Yr8fsM36f5HqCUfCJNRgOkBBi70EJQd0f5CcS394cj
zGNCWxO5s6MXkkaKxv/iAz2iOA9/TnVMpvirxJJ0UoYJi9UGJ0Fj5GI5acd/co9m
4j6aKVh/o5SgA1CGJn0t/Glg/xHvCe8cK0IRYhBYAXSFyHLp4u6ObvU9KOWFHwQE
nL5N6cvrhzkNjWNmXu4nNFju+dQfltrJrENIoupjGJqi2KCjFSL1djLyMTs7ooNd
kjyOC0zGsyJDfQk707lVj9spNTp26U8+FTyVtPSpU95nAJhM+HUamqIXx9xTpfx1
7fBUYvXVrwbH1arOHxDI9nHa+O2v8uYLXJfDZWe2Dcdbz5ZGPEkCrWLXv7cKTIqd
2XcPSmHJQmhKIx933CEH4LnarvXDcIV2TAcV0SMC+4FbcnEUKACDGdtv+xoJ3Y3F
Ys1JeR5N+ONKJEZYi8ky
=QavF
-----END PGP SIGNATURE-----
--=-=-=--
