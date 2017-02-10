Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vKSmK5rxgzDqBn
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Feb 2017 19:29:37 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: benh@kernel.crashing.org, bsingharora@gmail.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.10-4 tag
Date: Fri, 10 Feb 2017 19:29:31 +1100
Message-ID: <87o9yazbx0.fsf@concordia.ellerman.id.au>
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

Apologies for the late pull request, but Ben has been busy finding bugs.

Please pull a final set of powerpc fixes for 4.10:

The following changes since commit a0615a16f7d0ceb5804d295203c302d496d8ee91:

  powerpc/mm: Use the correct pointer when setting a 2MB pte (2017-01-30 15:35:13 +1100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-4.10-4

for you to fetch changes up to f83e6862047e1e371bdc5d512dd6cabe8a3965b8:

  powerpc/powernv: Properly set "host-ipi" on IPIs (2017-02-09 15:51:21 +1100)

----------------------------------------------------------------
powerpc fixes for 4.10 #4

Four fixes from Ben:

 - Userspace was semi-randomly segfaulting on radix due to us incorrectly
   handling a fault triggered by autonuma, caused by a patch we merged earlier
   in v4.10 to prevent the kernel executing userspace.
 - We weren't marking host IPIs properly for KVM in the OPAL ICP backend.
 - The ERAT flushing on radix was missing an isync and was incorrectly marked
   as DD1 only.
 - The powernv CPU hotplug code was missing a wakeup type and failing to flush
   the interrupt correctly when using OPAL ICP.

Thanks to:
  Benjamin Herrenschmidt.

----------------------------------------------------------------
Benjamin Herrenschmidt (4):
      powerpc/mm: Fix spurrious segfaults on radix with autonuma
      powerpc/mm/radix: Update ERAT flushes when invalidating TLB
      powerpc/powernv: Fix CPU hotplug to handle waking on HVI
      powerpc/powernv: Properly set "host-ipi" on IPIs

 arch/powerpc/include/asm/reg.h       |  3 ++-
 arch/powerpc/include/asm/xics.h      |  1 +
 arch/powerpc/mm/fault.c              | 21 +++++----------------
 arch/powerpc/mm/tlb-radix.c          |  6 +-----
 arch/powerpc/platforms/powernv/smp.c | 12 ++++++++++--
 arch/powerpc/sysdev/xics/icp-opal.c  | 35 +++++++++++++++++++++++++++++++++--
 6 files changed, 52 insertions(+), 26 deletions(-)

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYnXnrAAoJEFHr6jzI4aWAKcsQAIGRqvtuNeXTj0TnTIHKfjpQ
QGFznuGr4EKYB9pwMkXj+Yzoy8JaljbpQ+sEIAKw0EAw7v0fW7W7rHkS8PDWYY6S
aaqKjweUoPiSwGdS/E7HUn4PQ9Y7Ct/1BkDFI6OeCnVXtBWmk4z3D5TTrJCA/yX2
8XPfF5mm+3Ou7sB4iZu+HW48yWia9Q/ZkN70DyuRMjTzxvyIdqx+XEeCRn/cEcLe
FcBVbwwryrUGbZx3S12w1RK7Wb67d+D4YDPUaOmwx287aMa2bXt5n2D8VVz5/mm3
wLCo7269WG0KCZNB6oWXnKFqO3f90gsjg6wCEkkqJqT6DP3kXf1CyfyCJDCPELBE
18xajRh5y2l7Gh3sLgYG14aAFKlYIX0CRwCEsFjGRnGc/u5dkP56Z8pPzn4UTGAn
ohgf3ntzvuQb8AV4wQg1jx1BojnRCB6GX5FYv4Dq50EiU+L30JjBRvuqEa1tWJW2
+c5bFiBo3Ujpil78KmbfJd+scN8kYaKkFt1aFWxLh2XsPlEK9jgiGpgcHGqJG7AF
eN5q5xhghk19tJGx+3PSEkWh9n8m8meT7G4X9Kizlw8aYMOqOqyv18uQBT99ICTi
nu4NnLDbK0pRZGBclwSMU7poGSGjQn/yCAEqA73h0LSUTnA4tm7MNm7jz4hscKRq
AcBRlJIAIg3V9iPoILK7
=Juyy
-----END PGP SIGNATURE-----
--=-=-=--
