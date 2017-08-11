Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xTPSV2myCzDrM5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Aug 2017 22:28:58 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ego@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.13-6 tag
Date: Fri, 11 Aug 2017 22:28:56 +1000
Message-ID: <871soicmpj.fsf@concordia.ellerman.id.au>
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

Please pull some more powerpc fixes for 4.13:

The following changes since commit 3db40c312c2c1eb2187c5731102fa8ff380e6e40:

  powerpc/64: Fix __check_irq_replay missing decrementer interrupt (2017-08-04 12:55:49 +1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-4.13-6

for you to fetch changes up to 96ea91e7b6ee2c406598d859e7348b4829404eea:

  powerpc/watchdog: add locking around init/exit functions (2017-08-09 23:45:33 +1000)

----------------------------------------------------------------
powerpc fixes for 4.13 #6

All fixes for code that went in this cycle.

 - A revert of an optimisation to the syscall exit path, which could lead to an
   oops on either older machines or machines with > 1T of memory.
 - Disable some deep idle states if the firmware configuration for them fails.
 - Re-enable HARD/SOFT lockup detectors in defconfigs after a Kconfig change.
 - Six fairly small patches fixing bugs in our new watchdog code.

Thanks to:
  Gautham R. Shenoy, Nicholas Piggin.

----------------------------------------------------------------
Gautham R. Shenoy (1):
      powerpc/powernv/idle: Disable LOSE_FULL_CONTEXT states when stop-api fails

Michael Ellerman (2):
      Revert "powerpc/64: Avoid restore_math call if possible in syscall exit"
      powerpc/configs: Re-enable HARD/SOFT lockup detectors

Nicholas Piggin (6):
      powerpc: NMI IPI improve lock primitive
      powerpc/watchdog: Improve watchdog lock primitive
      powerpc/watchdog: Moderate touch_nmi_watchdog overhead
      powerpc/watchdog: Fix final-check recovered case
      powerpc/watchdog: Fix marking of stuck CPUs
      powerpc/watchdog: add locking around init/exit functions

 arch/powerpc/configs/powernv_defconfig |  3 +-
 arch/powerpc/configs/ppc64_defconfig   |  3 +-
 arch/powerpc/configs/pseries_defconfig |  3 +-
 arch/powerpc/kernel/entry_64.S         | 60 ++++++++++------------------------
 arch/powerpc/kernel/process.c          |  4 ---
 arch/powerpc/kernel/smp.c              |  6 ++--
 arch/powerpc/kernel/watchdog.c         | 49 +++++++++++++++++++--------
 arch/powerpc/platforms/powernv/idle.c  | 41 +++++++++++++++++++++--
 drivers/cpuidle/cpuidle-powernv.c      | 10 ++++++
 9 files changed, 111 insertions(+), 68 deletions(-)

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJZjaMJAAoJEFHr6jzI4aWA6fsP/0BiLK3GXHrKkmlJpsSeD0+4
RuLptTfMzNpRt8laemXfapnNV4iLbvOBb3Fj9KV3bOIo76tPEUV8qicYMFsuV+wq
Oh1yWGv5iPEZ/0yJOofoLCZe7YhKUpFXfSa4XDfqU1A7uU8X0KeFeAUrGK6rEhFN
RdapRMEpUBwDnKpD8598bQLEFRQpF0DBQ5zmuaeGTccwzMJDvYv6s3rIK5twC70U
6da370KE1aDmhGjmmmsi6DUoF0VM2fpN/OrWKVBb6MwING+7zdGPM1MWs6cw8wwR
9TIjidujhmz1AlrkA0PFrWez0wLpjA452UX/m4Z4SFEgUpjG67m4g3EMoM0fm/OM
9x5o23LlrpS4NLFLJMaFmMyVINWFtqiiN+cN9EQXd1jr13rjj3FiDgR7BP+tTRCg
cejm2hvC37WJJYIlDTSYA2uubrSFsOtrYb6ap4KF7uwu/n9flX1+0gY94yBOw6hr
w2nLJeAe+whF5jIScyP/7g+mlYrBgn/vUSGcGHjACMkACU9O9CAEb5eluy51Hyf4
YPhEFtic6mL694z/aGBvWHNe/8YC+H8H2by/haffCx7DcjdaVAAVuFdxX9Lz9I9h
o4TcxPJp68bRDQeavNg+8pJOpUYLSfPLBvcnjL8Q6kwDemMspkchYJhzqvp6f7Vj
DZoyYEU5/1JjxNrszN/M
=23T9
-----END PGP SIGNATURE-----
--=-=-=--
