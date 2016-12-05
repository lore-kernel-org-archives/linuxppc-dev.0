Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tXKzg2KDPzDvtL
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Dec 2016 21:01:51 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: andrew.donnellan@au1.ibm.com, ben@decadent.org.uk, benh@kernel.crashing.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com,
 ruscur@russell.cc
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.9-7 tag
Date: Mon, 05 Dec 2016 21:01:41 +1100
Message-ID: <874m2i66ey.fsf@concordia.ellerman.id.au>
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

Please pull what is hopefully the last batch of powerpc fixes for 4.9.

The following changes since commit 984d7a1ec67ce3a46324fa4bcb4c745bbc266cf2:

  powerpc/mm: Fixup kernel read only mapping (2016-11-25 14:18:25 +1100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-4.9-7

for you to fetch changes up to dadc4a1bb9f0095343ed9dd4f1d9f3825d7b3e45:

  powerpc/64: Fix placement of .text to be immediately following .head.text (2016-12-01 22:26:31 +1100)

----------------------------------------------------------------
powerpc fixes for 4.9 #7

Four fixes, the first for code we merged this cycle and three that are also
going to stable:

 - On 64-bit Book3E we were not placing the .text section where we said we would
   in the asm.
 - We broke building the boot wrapper on some 32-bit toolchains.
 - Lazy icache flushing was broken on pre-POWER5 machines.
 - One of the error paths in our EEH code would lead to a deadlock.

Thanks to:
  Andrew Donnellan, Ben Hutchings, Benjamin Herrenschmidt, Nicholas Piggin.

----------------------------------------------------------------
Andrew Donnellan (1):
      powerpc/eeh: Fix deadlock when PE frozen state can't be cleared

Ben Hutchings (1):
      powerpc/boot: Fix build failure in 32-bit boot wrapper

Benjamin Herrenschmidt (1):
      powerpc/mm: Fix lazy icache flush on pre-POWER5

Nicholas Piggin (1):
      powerpc/64: Fix placement of .text to be immediately following .head.text

 arch/powerpc/boot/Makefile        | 3 ++-
 arch/powerpc/boot/opal.c          | 2 +-
 arch/powerpc/kernel/eeh_driver.c  | 4 +++-
 arch/powerpc/kernel/vmlinux.lds.S | 9 +++++++++
 arch/powerpc/mm/hash64_4k.c       | 2 +-
 arch/powerpc/mm/hash64_64k.c      | 4 ++--
 6 files changed, 18 insertions(+), 6 deletions(-)

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYRTsGAAoJEFHr6jzI4aWASakP/1EH9pihRLvE8N7toqGIHIOB
K4NjWyPbtUe8Q5Glle2ShpruoGVhCpITzrdb5FsVQIUtvNuQTtCRCmJAwH2AktGs
IPHcgrNjcgswy+iElj+qWznIaxqoeSIWx7zfBaRmmWJLd+/2KEdMK9yb43+/rr3S
9XVObJSsVRbFsbzJrREHD227xl9lgIpqTSFipJLFEt1fVHqkbJpdq9vJe6ngerBp
U2qbmo46IR7XRcz0NNXD45BcT1Su8ww2slAQ3E9N9w7PlF2YS5aTMrjJJMRS61R8
YU0DnXaklr+vA1oEp2LxOOfcV3XBUx86VUziLrGpg1WM3Y+Sz349PMoiG8A+3pVB
q5BdNquf6dcUe5QyHeq+Wcy2qcHHExcX3IQYPxZdkyiL4UqUMBVA6uDf70+35TfC
Ch3gPPSJgzn3lvYe5h5sPACX4vTUBm13qdIVRVvWRQ1rw07gtFJCmCjpQRzXIWJ5
s665lL2iT4QNsu0wxiTtORvVFAjA12+PGKEwQnOGSMVIQSHtX6z9F02X99jpI6/y
YTatR6rIfjY/IG+1gnnynUxGwrBQekRzL/EzQcAwu/ZmXm1Kuys8YrUJBwwtUzkR
6/T85Y50OwxTNmy6pUe5iCiliN0Fz/63odlwe4T/9iQK3fDRaLRzTo7GeNeRCEJz
exZL6rn6uk0DjByQ21Nx
=QRy9
-----END PGP SIGNATURE-----
--=-=-=--
