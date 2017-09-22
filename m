Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xzCVW178wzDr5G
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Sep 2017 22:30:11 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: anton@samba.org, benh@kernel.crashing.org, ego@linux.vnet.ibm.com,
 gromero@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, matthew.weber@rockwellcollins.com,
 naveen.n.rao@linux.vnet.ibm.com, oss@buserror.net,
 ravi.bangoria@linux.vnet.ibm.com, ruscur@russell.cc, tyreld@linux.vnet.ibm.com
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.14-3 tag
Date: Fri, 22 Sep 2017 22:30:09 +1000
Message-ID: <87mv5mud9q.fsf@concordia.ellerman.id.au>
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

Please pull some more powerpc fixes for 4.14.

It turns out our single-fix pull from last week was too good to be true.
I missed a few fixes in that pull that had already come in because I was
on leave, but also we hadn't found the bugs yet. So this week it's a bit
bigger, though not ridiculous. Hopefully things will settle down from
here on.

cheers


The following changes since commit 94686c3c9410403278cea071bac97ed034cf19bd:

  Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm (2017-09-19 17:05:53 -1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-4.14-3

for you to fetch changes up to b537ca6fede69a281dc524983e5e633d79a10a08:

  powerpc/pseries: Fix parent_dn reference leak in add_dt_node() (2017-09-21 19:33:16 +1000)

----------------------------------------------------------------
powerpc fixes for 4.14 #3

Four fixes for the new instruction emulation code. A fix for CPU offline on bare
metal machines when certain idle states are not supported, and a fix for a
device_node refcounting oops during CPU hotplug, caused by recent changes.

Going to stable are a fix for an oops during core dump on machines that have TM
(Transactional Memory) disabled. Reordering some EEH initialisation to avoid
trashing memory, and another device_node refcounting fix.

And a few other minor things.

Thanks to:
  Anton Blanchard, Benjamin Herrenschmidt, Cyril Bur, Gautham R. Shenoy, Gustavo
  Romero, Kamalesh Babulal, Matthew Weber, Matt Weber, Naveen N. Rao, Nicholas
  Piggin, Pavithra Prakash, Ravi Bangoria, Ronak Desai, Scott Wood, Tyrel
  Datwyler.

----------------------------------------------------------------
Anton Blanchard (3):
      powerpc/sstep: Fix issues with set_cr0()
      powerpc/sstep: Fix issues with mcrf
      powerpc/sstep: mullw should calculate a 64 bit signed result

Benjamin Herrenschmidt (1):
      powerpc/eeh: Create PHB PEs after EEH is initialized

Gautham R. Shenoy (1):
      powerpc/powernv: Clear LPCR[PECE1] via stop-api only for deep state offline

Gustavo Romero (1):
      powerpc/tm: Flush TM only if CPU has TM feature

Matt Weber (1):
      powerpc/e6500: Update machine check for L1D cache err

Michael Ellerman (2):
      powerpc/configs: Update for CONFIG_SND changes
      Merge branch 'next' of git://git.kernel.org/.../scottwood/linux into fixes

Naveen N. Rao (1):
      powerpc/kprobes: Update optprobes to use emulate_update_regs()

Ravi Bangoria (1):
      powerpc/sysrq: Fix oops whem ppmu is not registered

Tyrel Datwyler (2):
      powerpc/pseries: Fix "OF: ERROR: Bad of_node_put() on /cpus" during DLPAR
      powerpc/pseries: Fix parent_dn reference leak in add_dt_node()

 arch/powerpc/configs/g5_defconfig            |  5 +++--
 arch/powerpc/configs/gamecube_defconfig      |  5 +++--
 arch/powerpc/configs/pasemi_defconfig        |  3 ++-
 arch/powerpc/configs/pmac32_defconfig        |  7 ++++---
 arch/powerpc/configs/ppc64_defconfig         |  7 ++++---
 arch/powerpc/configs/ppc64e_defconfig        |  7 ++++---
 arch/powerpc/configs/ppc6xx_defconfig        |  7 ++++---
 arch/powerpc/configs/wii_defconfig           |  5 +++--
 arch/powerpc/kernel/eeh.c                    |  4 ++++
 arch/powerpc/kernel/eeh_dev.c                | 18 ------------------
 arch/powerpc/kernel/optprobes.c              |  4 +++-
 arch/powerpc/kernel/ptrace.c                 |  2 +-
 arch/powerpc/kernel/traps.c                  | 12 ++++++++++--
 arch/powerpc/lib/sstep.c                     | 23 ++++++++++++-----------
 arch/powerpc/perf/core-book3s.c              |  5 +++++
 arch/powerpc/platforms/powernv/idle.c        |  8 +++++++-
 arch/powerpc/platforms/pseries/dlpar.c       |  1 -
 arch/powerpc/platforms/pseries/hotplug-cpu.c |  6 +++++-
 arch/powerpc/platforms/pseries/mobility.c    |  4 +++-
 19 files changed, 77 insertions(+), 56 deletions(-)

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJZxQJSAAoJEFHr6jzI4aWAwmIP/RqGGYrRy9m+81A3pUK0d4bR
WtrrkI1+/SDay5H7c/FnJBJwv8TTnQKqm4PkLGuF/zMc0hUcmp9z/saiYMgbSjIN
kdvqgIi1Aul/a8LOHEuob2WGkMwQVw9SXFjfttBnYvbSG6LF608/ORUTRff04nJ8
poMI+uBSiNLygvBepdMe4eYHlHNTuf3C09R34AhtsUQ6BpHZlBBhyY/5IIz8sa5v
9FQoh4NJzaxi5IiOuSWavvWOhXzAUY0ObOvLjY0Yk2vOVJJGoAFh6moFZJ+U5Ewa
vt5ivGpx+WNg37wnfaRDwhem+r9SD7rx+R4ROecP1dNPe53ZMW5DZu0Q11yhIMBv
CAWAbP04Mn+VNj1jBPak+vg282mPfj/R4fcUUXFcVX9DCI3XdhM6JoRldPD9k7Na
kuZEHTzPdEGKTIjk0KH8a+7bpK1mLTrQBl5ZGsVwyWaJpyqmPuIkXirtj9J/qMD1
FDXcLDTT0mLcxS07SNweRAw0pMXS7yW/0INiVnkEwisy03uozJSWEGLGmcvlteoX
MAkpZYv+Wfgd+x1EXL+FI+3LTVP/qdT0n9ll4doRG22R42y0xEuNz84QMWhX/YXF
4L4mLF8znPPf0SJXeBlf+86nkHzz/Lajts3Vvl0wgw56Iei5/JpcleS6nhuZAuqM
7PjwGLBt6h4xIqGTWcdB
=aNXZ
-----END PGP SIGNATURE-----
--=-=-=--
