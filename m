Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wTjcY2R5szDqdr
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 May 2017 19:36:45 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: bsingharora@gmail.com, ego@linux.vnet.ibm.com, jeyu@redhat.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, mikey@neuling.org,
 naveen.n.rao@linux.vnet.ibm.com
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.12-3 tag
Date: Fri, 19 May 2017 19:36:42 +1000
Message-ID: <87bmqp6vdh.fsf@concordia.ellerman.id.au>
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

Please pull some powerpc fixes for 4.12:

The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-4.12-3

for you to fetch changes up to e41e53cd4fe331d0d1f06f8e4ed7e2cc63ee2c34:

  powerpc/mm: Fix virt_addr_valid() etc. on 64-bit hash (2017-05-19 13:04:35 +1000)

----------------------------------------------------------------
powerpc fixes for 4.12 #3

The headline is a fix for FP/VMX register corruption when using transactional
memory, and a new selftest to go with it.

Then there's the virt_addr_valid() fix, currently HARDENDED_USERCOPY is tripping
on that causing some machines to crash.

A few other fairly minor fixes for long tail things, and a couple of fixes for
code we just merged.

Thanks to:
  Breno Leitao, Gautham R. Shenoy, Michael Neuling, Naveen N. Rao. Nicholas
  Piggin, Paul Mackerras.

----------------------------------------------------------------
Gautham R. Shenoy (1):
      powerpc/powernv: Set NAPSTATELOST after recovering paca on P9 DD1

Michael Ellerman (3):
      powerpc/modules: If mprofile-kernel is enabled add it to vermagic
      powerpc/mm: Fix crash in page table dump with huge pages
      powerpc/mm: Fix virt_addr_valid() etc. on 64-bit hash

Michael Neuling (2):
      powerpc/tm: Fix FP and VMX register corruption
      selftests/powerpc: Test TM and VMX register state

Naveen N. Rao (1):
      powerpc/kprobes: Fix handling of instruction emulation on probe re-entry

 arch/powerpc/include/asm/module.h                  |   4 +
 arch/powerpc/include/asm/page.h                    |  12 +++
 arch/powerpc/kernel/idle_book3s.S                  |   2 +-
 arch/powerpc/kernel/kprobes.c                      |   3 +-
 arch/powerpc/kernel/process.c                      |  19 ++++
 arch/powerpc/mm/dump_linuxpagetables.c             |   7 +-
 tools/testing/selftests/powerpc/tm/.gitignore      |   1 +
 tools/testing/selftests/powerpc/tm/Makefile        |   4 +-
 .../testing/selftests/powerpc/tm/tm-vmx-unavail.c  | 118 +++++++++++++++++++++
 9 files changed, 164 insertions(+), 6 deletions(-)
 create mode 100644 tools/testing/selftests/powerpc/tm/tm-vmx-unavail.c

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJZHryqAAoJEFHr6jzI4aWAeX0QAIdWkao59zyzxGGrIOcxsP1Y
ukT+i0WeAxUK1egNy6JK2U/OTYTz7BueutMShfsHz6nxyBRJKVZyhjWlbF4WRnFM
UlWWV5vsoe/VC+vk9IZFUkWWs3znXiccG27St0QcyEIbnC66fhAnbgUCGOtLZu8F
z6LxzxfyM5NmmW8oSiL6zDGLQ6iOErnKPWUj3TaPDGlpV7v2zTL9mpKEY5S5vB6r
EKAD0BlhpkrmvFtrnC0G3efg0JSLNkq6F3cGnuS0vHYLimYC4CGeQEaQ9MQX2Fe0
GejOTnx/DkdhVg8vRnqax630iX6pGfMiRfCUcuOmqsT0SyAY2JVagfap9h/I/c0/
O8xvFcIVJTeirxbtcDbqU55cHmKzb+eVskGnWNnmIGsLqbVmkOppNzmcta3DHvtu
GyUBYeYaLWHQvMf45g/DqeiKybha/0GlqOqI6NAwLTnSXk7eNZ5PZGz6/UPWHpPN
HKIJUd+ndYOnK1v06OCkdSnRFDndsw8JinVnLnspDp9B1CSeYgolz3xvaD3ecN72
cRaBlnUtETmApt7sfVUGm0+lNM2lSyZT3+1OGZQx7DkYqopOwVaDghqBCVxoDDs7
Sgx1n3Rzt/EXU0PFQ6Twsybtq21ZWmW1553zRRMsGQSiLaMNmO2ylbBtuHwe2qlt
939sOHFrtqV9DJ2wKmzk
=r/F8
-----END PGP SIGNATURE-----
--=-=-=--
