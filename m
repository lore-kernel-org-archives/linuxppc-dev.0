Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ytXDt381hzDrTj
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Dec 2017 23:47:26 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: david@gibson.dropbear.id.au, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com,
 ravi.bangoria@linux.vnet.ibm.com
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.15-4 tag
Date: Fri, 08 Dec 2017 23:47:21 +1100
Message-ID: <87zi6tfkti.fsf@concordia.ellerman.id.au>
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

The following changes since commit ae64f9bd1d3621b5e60d7363bc20afb46aede215:

  Linux 4.15-rc2 (2017-12-03 11:01:47 -0500)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-4.15-4

for you to fetch changes up to d8104182087319fd753d6d8e0afcd95d84c2aa2f:

  powerpc/xmon: Don't print hashed pointers in xmon (2017-12-07 00:27:01 +1100)

----------------------------------------------------------------
powerpc fixes for 4.15 #4

One notable fix for kexec on Power9, where we were not clearing MMU PID properly
which sometimes leads to hangs. Finally debugged to a root cause by Nick.

A revert of a patch which tried to rework our panic handling to get more output
on the console, but inadvertently broke reporting the panic to the hypervisor,
which apparently people care about.

Then a fix for an oops in the PMU code, and finally some s/%p/%px/ in xmon.

Thanks to:
  David Gibson, Nicholas Piggin, Ravi Bangoria.

----------------------------------------------------------------
David Gibson (1):
      Revert "powerpc: Do not call ppc_md.panic in fadump panic notifier"

Michael Ellerman (1):
      powerpc/xmon: Don't print hashed pointers in xmon

Nicholas Piggin (1):
      powerpc/64s: Initialize ISAv3 MMU registers before setting partition table

Ravi Bangoria (1):
      powerpc/perf: Fix oops when grouping different pmu events

 arch/powerpc/include/asm/machdep.h     |  1 +
 arch/powerpc/include/asm/setup.h       |  1 +
 arch/powerpc/kernel/cpu_setup_power.S  |  2 ++
 arch/powerpc/kernel/fadump.c           | 22 ----------------------
 arch/powerpc/kernel/setup-common.c     | 27 +++++++++++++++++++++++++++
 arch/powerpc/perf/core-book3s.c        |  4 ++--
 arch/powerpc/platforms/ps3/setup.c     | 15 +++++++++++++++
 arch/powerpc/platforms/pseries/setup.c |  1 +
 arch/powerpc/xmon/xmon.c               | 10 +++++-----
 9 files changed, 54 insertions(+), 29 deletions(-)

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJaKonaAAoJEFHr6jzI4aWAzKgP/0OywTLJO0SYoyQ6JOiY5ZMF
6UPC+TZYGxF04GGzeRgvhjTIrw/5nbOVQBSQ5QSfTsZ1/z+awkQAxT5cHPppykYd
taP0h+Z4FGR/IY4ij6lxAW4DllBPHo2TmqSyoDlcC0HNuN9RAqghgwOaAq8FwBLW
b3GP9kIRzrlnDjLe4zpBn06fn1yyzSLeMkAzTqm1pi2QqIsKkyQKaxuttr7iAcTI
0I4P6AYG78yNR7Icw2uN+FlYPUD+r4YRHVyw+Hw++4y0T5ZudfZHUB6Y0TAShwI4
efRREXXTEH7qNnD0u/gLn9tQdeQ9U0gjMaMqBwyoPhXqOhRvBQ0s5nNTqTPrrv5w
dvk1UPxHdwUU/Wb+GMhRHOcisDh+36WnnQZR9+7Gx/9+47X8oW/9OyHjsZB56GZa
jYjvYAyEbEUyWGoSZE8qT/rEE4+dxYxeF38jliQRinSU2cTD9lLEchmmCDNxBc+j
MC/LDmkOGR+DCEZarnDMhCI3X1mE8B30odt80o8CVjPHS64WnWs17rqfElX+zChR
LAgQB3EqUwuLFZkr2Yp5601xV8VYI8hZnMtt3DFmZJkbiHfpxBh4a2AJ5QEYkvEt
wCMb1XFjJzftlEnOIOdQxqhaXMw32wiMmm3MbJTwp61ioW/XrX31rMnn2wTln947
QE7SBj/MCIg9mocAUvOF
=9UnR
-----END PGP SIGNATURE-----
--=-=-=--
