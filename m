Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zNJPD5cskzF10r
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jan 2018 22:24:00 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: benh@kernel.crashing.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, msuchanek@suse.de
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.15-8 tag
Date: Fri, 19 Jan 2018 22:23:44 +1100
Message-ID: <878tcuay7z.fsf@concordia.ellerman.id.au>
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

Please pull some more powerpc fixes for 4.15:

The following changes since commit 6e032b350cd1fdb830f18f8320ef0e13b4e24094:

  powerpc/powernv: Check device-tree for RFI flush settings (2018-01-10 21:27:16 +1100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-4.15-8

for you to fetch changes up to 1b689a95ce7427075f9ac9fb4aea1af530742b7f:

  powerpc/pseries: include linux/types.h in asm/hvcall.h (2018-01-17 23:30:46 +1100)

----------------------------------------------------------------
powerpc fixes for 4.15 #8

More than we'd like after rc8, but nothing very alarming either, just tying up
loose ends before the release:

Since we changed powernv to use cpufreq_get() from show_cpuinfo(), we see
warnings with PREEMPT enabled. But the preempt_disable() in show_cpuinfo()
doesn't actually prevent CPU hotplug as it suggests, so remove it.

Two updates to the recently merged RFI flush code. Wire up the generic sysfs
file to report the status, and add a debugfs file to allow enabling/disabling it
at runtime.

Two updates to xmon, one to add the RFI flush related fields to the paca dump,
and another to not use hashed pointers in the paca dump.

And one minor fix to add a missing include of linux/types.h in asm/hvcall.h, not
seen to break the build in upstream, but correct anyway.

Thanks to:
  Benjamin Herrenschmidt, Michal Suchanek, Nicholas Piggin.

----------------------------------------------------------------
Benjamin Herrenschmidt (1):
      powerpc: Don't preempt_disable() in show_cpuinfo()

Michael Ellerman (4):
      powerpc/xmon: Add RFI flush related fields to paca dump
      powerpc/xmon: Don't print hashed pointers in paca dump
      powerpc/64s: Wire up cpu_show_meltdown()
      powerpc/64s: Allow control of RFI flush via debugfs

Michal Suchanek (1):
      powerpc/pseries: include linux/types.h in asm/hvcall.h

 arch/powerpc/Kconfig               |  1 +
 arch/powerpc/include/asm/hvcall.h  |  1 +
 arch/powerpc/kernel/setup-common.c | 11 -----------
 arch/powerpc/kernel/setup_64.c     | 38 ++++++++++++++++++++++++++++++++++++++
 arch/powerpc/xmon/xmon.c           | 26 +++++++++++++++-----------
 5 files changed, 55 insertions(+), 22 deletions(-)

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJaYdVAAAoJEFHr6jzI4aWAxCkP/1rIfA6atmtSEFjPDiWLsyZR
u2fTJZftNwcV14PrUxJOSW7HGD6bQhfCgdawwWZYRfIMYPwB2Yvnipy5IOS6vfAX
yScGDKQxd+vaTqphUZi4+AB7ouK+i+5XcxNf9mzz0iREz4zBRGBogrAZaaJE0aiZ
fGjwkvxd/ezMt2ENahx6c8qcfkUZw3TVZUTHDOb9TuaEmuMcBPYwAXUCKXiLLFpx
VUIJK98YOduuSJBrlHmzbTlPUtS2st/PQIfC6UwocFREHVgstgGWYLPKM64VVN/C
f4+VEcez+6UeZV6pIObT6xFNGifWWAhBKhX/sviUtx+IKvco0Hva4UVDBRfHBgiC
O83jEXsDVRSKKeMcnUCkVlGTBzzEKYmTXYoW1/UiM5jqjQaRfV0szT8LaL9dn38B
oJ0Ql6JNWjv5LSgRGepXyRHH+epztEDcRbC6pL+3qfzdC1T3a4dA11/alAnKWkBG
rDcQojbOBctpUXrWeNSP9ObdsB/hTGirvCcLLvTEtFxw+NGj/Y+3gs72vpT+99UU
bnESVcLHOVXajNUsBBlK7f6DFM09+DBmcEPs+LbN4ZXEFZtGuoXtpLNzTb/lpbEO
S2xIcGnRZpNXbSCXH9c1bp4kixnk1hhCk7cvRG684WleG8NhuFiZ8wm6vPEamrQE
XylR8ZR1YZFybx9ztIke
=H+Wq
-----END PGP SIGNATURE-----
--=-=-=--
