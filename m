Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w0X9F2Vn1zDqHq
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Apr 2017 20:04:17 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: benh@kernel.crashing.org, fbarrat@linux.vnet.ibm.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, oohall@gmail.com,
 paulus@ozlabs.org
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.11-7 tag
Date: Sat, 08 Apr 2017 20:04:14 +1000
Message-ID: <877f2vgqqp.fsf@concordia.ellerman.id.au>
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

Please pull some more powerpc fixes for 4.11:

The following changes since commit cc638a488a5205713b51eabd047be6ea641cc328:

  gcc-plugins: update architecture list in documentation (2017-03-21 22:20:05 +1100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-4.11-7

for you to fetch changes up to 4749228f022893faf54a3dbc70796f78b7d4f342:

  powerpc/crypto/crc32c-vpmsum: Fix missing preempt_disable() (2017-04-07 21:12:58 +1000)

----------------------------------------------------------------
powerpc fixes for 4.11 #7

Headed to stable:
 - disable HFSCR[TM] if TM is not supported, fixes a potential host kernel crash
   triggered by a hostile guest, but only in configurations that no one uses
 - don't try to fix up misaligned load-with-reservation instructions
 - fix flush_(d|i)cache_range() called from modules on little endian kernels
 - add missing global TLB invalidate if cxl is active
 - fix missing preempt_disable() in crc32c-vpmsum

And a fix for selftests build changes that went in this release:
 - selftests/powerpc: Fix standalone powerpc build

Thanks to:
  Benjamin Herrenschmidt, Frederic Barrat, Oliver O'Halloran, Paul Mackerras.

----------------------------------------------------------------
Benjamin Herrenschmidt (1):
      powerpc: Disable HFSCR[TM] if TM is not supported

Frederic Barrat (1):
      powerpc/mm: Add missing global TLB invalidate if cxl is active

Michael Ellerman (2):
      selftests/powerpc: Fix standalone powerpc build
      powerpc/crypto/crc32c-vpmsum: Fix missing preempt_disable()

Oliver O'Halloran (1):
      powerpc/64: Fix flush_(d|i)cache_range() called from modules

Paul Mackerras (1):
      powerpc: Don't try to fix up misaligned load-with-reservation instructions

 arch/powerpc/crypto/crc32c-vpmsum_glue.c |  3 +++
 arch/powerpc/kernel/align.c              | 27 +++++++++++++++++++--------
 arch/powerpc/kernel/misc_64.S            |  4 ++--
 arch/powerpc/kernel/setup_64.c           |  9 +++++++++
 arch/powerpc/mm/hash_native_64.c         |  7 +++++--
 tools/testing/selftests/powerpc/Makefile | 10 +++++-----
 6 files changed, 43 insertions(+), 17 deletions(-)

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJY6LWfAAoJEFHr6jzI4aWAmtMQAKYCjY5l2f8/CrNwYuRuS9xo
MeuvMHB4GQN2txBu+pMQPTbZFOWJlX3TVNlMINLiRoyr4yNypaAuJv+YxgNDm7AI
b5QwgQz8V5aPycbhyh+4QcVxXRcAT0vCDSu1UQOEbdmZNImwkfZd9oO2MO8vHNle
sTubfzXDElMGXsqxQ0IvKeo0cx/gCd+k1dqYII59ZTigsaDyV3cXnXBsBzztk2Sp
9gLQ9TcSUQwl0UNSWObT970iTQwExi4KbNkDWfRAcO3ieRr8UOTCxrdATwVZpGOw
VSqTlSfKEjMRVHz9h73BrHTsxMFUGRa2cdcZxecc90v+aInxsy49XEp4JUPtdLfd
MURP9qm3B/+8tDnsceaMss2mdXu3/jy5hT5xOx02VotV7iMHwPhYSMOKJbaeG8KK
X38WyH31uSe+j53gf989x+QufDTNg4Mte5nuIEdA4CDVlTq/zcAO1mVP0sj2uwZZ
vnqRuSQhyDIKzUmUIsZ3FWnaTIItizEqyQyUeBa4VGvpqHWv8zEEbKmI08AywEGL
5gcMvxcuUX22PwxLHbZ8YgpNree+m57cHYbOsWL1HzcfwbSxgnr8wDlv21mkW/jV
EBJU+00YgQzbHuhHRkvvDPIf0NCvZOjdvAl3TQoGPsGCTAetOTNp38YB77324tA4
cLNfdjvtjy7uPrSYv73A
=jlhk
-----END PGP SIGNATURE-----
--=-=-=--
