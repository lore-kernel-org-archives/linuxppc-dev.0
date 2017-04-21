Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w8Nbz5rWbzDqJx
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Apr 2017 14:51:11 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 npiggin@gmail.com, ravi.bangoria@linux.vnet.ibm.com
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.11-8 tag
Date: Fri, 21 Apr 2017 14:51:09 +1000
Message-ID: <87a87a4b42.fsf@concordia.ellerman.id.au>
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

Please pull two final powerpc fixes for 4.11:

The following changes since commit 4749228f022893faf54a3dbc70796f78b7d4f342:

  powerpc/crypto/crc32c-vpmsum: Fix missing preempt_disable() (2017-04-07 21:12:58 +1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-4.11-8

for you to fetch changes up to be5c5e843c4afa1c8397cb740b6032bd4142f32d:

  powerpc/64: Fix HMI exception on LE with CONFIG_RELOCATABLE=y (2017-04-18 20:19:52 +1000)

----------------------------------------------------------------
powerpc fixes for 4.11 #8

Just two fixes. The first fixes kprobing a stdu, and is marked for stable as
it's been broken for ~ever. In hindsight this could have gone in next.

The other is a fix for a change we merged this cycle, where if we take a certain
exception when the kernel is running relocated (currently only used for kdump),
we checkstop the box.

Thanks to:
  Ravi Bangoria.

----------------------------------------------------------------
Michael Ellerman (1):
      powerpc/64: Fix HMI exception on LE with CONFIG_RELOCATABLE=y

Ravi Bangoria (1):
      powerpc/kprobe: Fix oops when kprobed on 'stdu' instruction

 arch/powerpc/include/asm/exception-64s.h | 8 ++++----
 arch/powerpc/kernel/entry_64.S           | 6 +++---
 arch/powerpc/kernel/exceptions-64s.S     | 2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJY+Y+/AAoJEFHr6jzI4aWA19kP/RxMLmnYDtPSbrZU9cWej4kb
kKG8brmGpn9JSMiA2vRED7gFiT44mu57ILC7Epc7W+yK8WwD/+jsBelrxqgBu6HC
MWe4aX0o2DCzfmmVQNfExKCJmBYo0ASxUI1XC+oDJbBwo+P0Ya726Q8wNsjhdGT2
9KAfkSzWs3I3aceVG/pW813L7Rq9IPhXqoe9HW+TIOjJywN+hBEShq347BalXfjE
ZYVI8x7S4nBNVjXHwo43dF7cZSzkTs0KA77CkUM2UMHTvWkBl/mCG7H5XQXMrsLe
dBE5w6xHZx94769SRkciFiC6yzfQwMOGKn6o08YELgacEa3wiONRxuGhps88CSw4
q1IZQ9MBInCB753VRJcD9jvfDoO9/Z5AWJ6tfND2zKTynQ+eAdbfW9zQ7kBkPRg4
4XXd4LvSg0xiw9h4tjvc4MHYx/uSX8IU9l4G29pcgST4hljjEcCoCm6kTg7MF/+a
XuM1DvT+OLlZj2M7btT9i2+cC8FplYZ4y74qklL7NOWT7ngfPKJxnA1l4pJaXwTM
vOGrqQDrP8TNZzc3qE1pfbwYGmm4JqsbeOiuLu8Sdl9s1FA9BYbQLfMsA7f/uNDE
Rn23QUj/2uAIWB+0vfyG+09qHz1P1C+Cl2Aa+flHnD5sEyLt6MsFasgakv20iWlx
JBHTyuHVJUclZdq7g7LU
=X481
-----END PGP SIGNATURE-----
--=-=-=--
