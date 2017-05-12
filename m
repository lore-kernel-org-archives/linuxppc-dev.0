Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wPQBj5gwMzDqFr
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 May 2017 19:47:57 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: christophe.leroy@c-s.fr, davem@davemloft.net, gwshan@linux.vnet.ibm.com,
 horia.geanta@nxp.com, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, liu.hailong6@zte.com.cn, npiggin@gmail.com,
 oss@buserror.net, pku.leo@gmail.com, robh@kernel.org, roy.pledge@nxp.com,
 valentin.longchamp@keymile.com
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.12-2 tag
Date: Fri, 12 May 2017 19:47:51 +1000
Message-ID: <87efvube48.fsf@concordia.ellerman.id.au>
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

Please pull the second batch of powerpc updates for 4.12.

The change to the Linux page table geometry was delayed for more testing wi=
th
16G pages, and there's the new CPU features stuff which just needed one more
polish before going in. Plus a few changes from Scott which came in a bit l=
ate.
And then various fixes, mostly minor.

The following changes since commit 700b7eadd5625d22b8235fb21259b3d7d564c000:

  powerpc/64s: Power9 has no LPCR[VRMASD] field so don't set it (2017-05-03=
 20:45:55 +1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powe=
rpc-4.12-2

for you to fetch changes up to 5a61ef74f269f2573f48fa53607a8911216c3326:

  powerpc/64s: Support new device tree binding for discovering CPU features=
 (2017-05-09 23:42:55 +1000)

=2D---------------------------------------------------------------
powerpc updates for 4.12 part 2

Highlights include:

 - rework the Linux page table geometry to lower memory usage on 64-bit Boo=
k3S
   (IBM chips) using the Hash MMU.

 - support for a new device tree binding for discovering CPU features on fu=
ture
   firmwares.

 - Freescale updates from Scott: "Includes a fix for a powerpc/next mm regr=
ession
   on 64e, a fix for a kernel hang on 64e when using a debugger inside a
   relocated kernel, a qman fix, and misc qe improvements."

Thanks to:
  Christophe Leroy, Gavin Shan, Horia Geant=C4=83, LiuHailong, Nicholas Pig=
gin, Roy
  Pledge, Scott Wood, Valentin Longchamp.

=2D---------------------------------------------------------------
Christophe Leroy (3):
      net: ethernet: ucc_geth: fix MEM_PART_MURAM mode
      soc/fsl/qe: get rid of immrbar_virt_to_phys()
      powerpc/8xx: Adding support of IRQ in MPC8xx GPIO

Gavin Shan (1):
      powerpc/powernv: Block PCI config access on BCM5718 during EEH recove=
ry

Horia Geant=C4=83 (1):
      powerpc: Fix distclean with Makefile.postlink

LiuHailong (1):
      powerpc/64e: Fix hang when debugging programs with relocated kernel

Michael Ellerman (2):
      powerpc/mm/book3s/64: Rework page table geometry for lower memory usa=
ge
      Merge branch 'next' of git://git.kernel.org/.../scottwood/linux into =
next

Nicholas Piggin (4):
      powerpc/64s: Fix unnecessary machine check handler relocation branch
      of/fdt: introduce of_scan_flat_dt_subnodes and of_get_flat_dt_phandle
      powerpc: Don't print cpu_spec->cpu_name if it's NULL
      powerpc/64s: Support new device tree binding for discovering CPU feat=
ures

Roy Pledge (1):
      soc/fsl/qbman: Disable IRQs for deferred QBMan work

Scott Wood (1):
      powerpc/64e: Don't place the stack beyond TASK_SIZE

Valentin Longchamp (3):
      soc/fsl/qe: round brg_freq to 1kHz granularity
      soc/fsl/qe: only apply QE_General4 workaround on affected SoCs
      soc/fsl/qe: add EXPORT_SYMBOL for the 2 qe_tdm functions

 .../bindings/powerpc/ibm,powerpc-cpu-features.txt  |  248 +++++
 .../devicetree/bindings/soc/fsl/cpm_qe/gpio.txt    |   21 +-
 arch/powerpc/Kconfig                               |   16 +
 arch/powerpc/Makefile.postlink                     |    2 +-
 arch/powerpc/include/asm/book3s/64/hash-64k.h      |    6 +-
 arch/powerpc/include/asm/cpm1.h                    |    2 +
 arch/powerpc/include/asm/cpu_has_feature.h         |    6 +-
 arch/powerpc/include/asm/cputable.h                |    2 +
 arch/powerpc/include/asm/dt_cpu_ftrs.h             |   26 +
 arch/powerpc/include/asm/processor.h               |    5 +
 arch/powerpc/include/asm/reg.h                     |    1 +
 arch/powerpc/include/uapi/asm/cputable.h           |    7 +
 arch/powerpc/kernel/Makefile                       |    1 +
 arch/powerpc/kernel/cputable.c                     |   37 +-
 arch/powerpc/kernel/dt_cpu_ftrs.c                  | 1031 ++++++++++++++++=
++++
 arch/powerpc/kernel/exceptions-64e.S               |   12 +
 arch/powerpc/kernel/exceptions-64s.S               |    4 +-
 arch/powerpc/kernel/prom.c                         |   29 +-
 arch/powerpc/kernel/setup-common.c                 |    2 +-
 arch/powerpc/kernel/setup_64.c                     |   10 +-
 arch/powerpc/platforms/powernv/eeh-powernv.c       |    3 +
 arch/powerpc/sysdev/cpm1.c                         |   25 +
 drivers/net/ethernet/freescale/ucc_geth.c          |    8 +-
 drivers/of/fdt.c                                   |   38 +
 drivers/soc/fsl/qbman/qman.c                       |    5 +
 drivers/soc/fsl/qe/qe.c                            |   25 +-
 drivers/soc/fsl/qe/qe_tdm.c                        |    2 +
 include/linux/of_fdt.h                             |    6 +
 include/soc/fsl/qe/immap_qe.h                      |   19 -
 include/soc/fsl/qe/qe.h                            |    1 +
 30 files changed, 1546 insertions(+), 54 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/powerpc/ibm,powerpc-c=
pu-features.txt
 create mode 100644 arch/powerpc/include/asm/dt_cpu_ftrs.h
 create mode 100644 arch/powerpc/kernel/dt_cpu_ftrs.c

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJZFYTIAAoJEFHr6jzI4aWA1CAQALlDaqabTFSUHKe6Fv/Vx+PX
/eaGFZd6bTYxDi0hTgZdTMoyQp/D3mWM0EoZ86P9TYVuuPzZN5tYusIclS9UBvVd
yqWRiEjWfNYEpPtOPr+IO3X4Dpbsd3CsfegM7SNKtMIz/A/kLlfjanMYkluA6utE
UFwrMwhZwGQssGvSnNpenyRIabU7hpgkP/xKYaJzqGggVdtaARm0xW5U1ISZv24J
2M7qVrP/IKgUhPcO12RfCm4psSonuIKPIvOg8eizDFz/wiqeTINv1ucrMrq/R+ze
BSYkxLyAVmJGKli7GmKOcuNx3CMXARlaTWgrJk6ESG3HyhuQR0RH7qiFZfjKmoZI
qLZknsiD20jCoEDO1dO/CJ+/2Csxqlhkk6IsikLKnRm0QF1biOcAFFIw9EdTv97f
WxSbY3o1XToafruV9OH/LTTK4oj23Mhtj5qWJNxaSs+57RS5DDOlKe2oV7Ayqinl
Vvpiw7L0kUWnzoLZyVSDYvqBK4beEZwVr6Yp1QlV9DHT/Tm9q8Jwn8gd7BsUoouw
JUJqw0y3sYcOkLWB0Ekzq4d8nhprRs4WyoIjMHkBy3Rg2lBG4zqyUsimwAhzJ87M
vly0oqj9GmTooHGcV27uBLKldQCxDtJJbsuJzMLWUfQG3DYvOp8/A3Vpr9btHR2z
btwfiYEqKzXYMh+xqkCU
=ANNC
-----END PGP SIGNATURE-----
--=-=-=--
