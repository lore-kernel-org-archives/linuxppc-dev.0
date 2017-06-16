Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wpzBw55b1zDq88
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jun 2017 21:47:52 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: aik@ozlabs.ru, alistair@popple.id.au, benh@kernel.crashing.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.12-6 tag
Date: Fri, 16 Jun 2017 21:47:50 +1000
Message-ID: <87wp8cupax.fsf@concordia.ellerman.id.au>
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

Please pull some more powerpc fixes for 4.12:

The following changes since commit c6ee9619e2edd9912316f7e2eaf9ffa14fafe9f9:

  powerpc/book3s64: Move PPC_DT_CPU_FTRs and enable it by default (2017-06-08 20:42:57 +1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-4.12-6

for you to fetch changes up to a093c92dc7f96a15de98ec8cfe38e6f7610a5969:

  powerpc/debug: Add missing warn flag to WARN_ON's non-builtin path (2017-06-16 16:10:37 +1000)

----------------------------------------------------------------
powerpc fixes for 4.12 #6

Three small fixes for recently merged code:

 - remove a spurious WARN_ON when a PCI device has no of_node, it's allowed in
   some circumstances for there to be no of_node.

 - fix the offset for store EOI MMIOs in the XIVE interrupt controller.

 - fix non-const WARN_ONs which were becoming BUGs due to them losing
   BUGFLAG_WARNING in a recent cleanup patch.

Thanks to:
  Alexey Kardashevskiy, Alistair Popple, Benjamin Herrenschmidt.

----------------------------------------------------------------
Alexey Kardashevskiy (1):
      powerpc/debug: Add missing warn flag to WARN_ON's non-builtin path

Alistair Popple (1):
      powerpc/npu-dma: Remove spurious WARN_ON when a PCI device has no of_node

Benjamin Herrenschmidt (1):
      powerpc/xive: Fix offset for store EOI MMIOs

 arch/powerpc/include/asm/bug.h           |  2 +-
 arch/powerpc/include/asm/xive.h          | 12 +++++++-----
 arch/powerpc/kvm/book3s_xive_template.c  |  4 ++--
 arch/powerpc/platforms/powernv/npu-dma.c |  3 ++-
 arch/powerpc/sysdev/xive/common.c        |  2 +-
 5 files changed, 13 insertions(+), 10 deletions(-)

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJZQ8VnAAoJEFHr6jzI4aWAgHYP/15ZsjYnblvJe1eaDOK+xoGE
t9hvtUflq9UnoeBrmLPefo3wTnyYyoZrT5L6j1EDZZJIoBrRimPuc4SEVjGbtQun
kOB2nuWsSE1IM5R4HaXEaXpJJ2xTWjjq5inGs4/LQ9ZaeGcmcwj+xk2CaDQpbkGf
/n5cJgnp3UHFNcEfYKkx+5x67CrifOuhKoB1fI9OheDf3mt+rsFOGaqzp6hkJ5kW
ybMeEVnJAhFU4JXKg6UYpLN26EZuhOtC/5hNhRWGgL4RSDSKE1EbC5cN/zz+5UD4
9Tae1/kzwWpTg31xX0zR+zoPQHIejO1zwM7ue+BbdRsZLv7Z5jXBLnVUle6biFev
Ih0wZtdwjPu23Q2gvtdqGlpBlwTdsR+uRO/RxKGlWhery0LL7/I0wp5zi/r8adbI
r+cdzy9kXZal/gsqPvQ0hqaqvO8ZHmEBgIxo8TV7OS+Vf4hSkFCnnKrODV2XcgOb
cp9srApHN6I00yKyGam0QGNMYZjmMzPn7fxPOUMto01o9201H12A/9v7Qv/Q6aqU
0Gva92+5dlc+1LtmptgEoQXxorgpQB1zD77/h5IIa5Egv3sG52jCknWtqhrcHxwo
sGGyQuY4pIOq9XfMJiEYraP2Ip0UuS+s4HVQbpFh29p+ld7tI3CN76Md8lYae+wV
aGFI8gbWpro95amJXr6A
=brxe
-----END PGP SIGNATURE-----
--=-=-=--
