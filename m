Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yjtlK6pv0zDrnp
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Nov 2017 22:10:21 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: aneesh.kumar@linux.vnet.ibm.com, christophe.leroy@c-s.fr,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 maddy@linux.vnet.ibm.com, sukadev@linux.vnet.ibm.com
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.15-2 tag
Date: Fri, 24 Nov 2017 22:10:13 +1100
Message-ID: <87fu940w6i.fsf@concordia.ellerman.id.au>
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

Please pull some powerpc fixes for 4.15.

These would be nice to have in rc1, but none of them are actually that
crucial. So they can wait until Monday if you're busy eating pumpkin
pie.

cheers


The following changes since commit 3ffa9d9e2a7c10127d8cbf91ea2be15390b450ed:

  powerpc/64s: Fix Power9 DD2.0 workarounds by adding DD2.1 feature (2017-11-15 14:25:42 +1100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git powerpc-4.15-2

for you to fetch changes up to 4d6c51b107cc73b15a377224549aa5593f90df89:

  powerpc/64s: Fix Power9 DD2.1 logic in DT CPU features (2017-11-22 23:17:01 +1100)

----------------------------------------------------------------
powerpc fixes for 4.15 #2

A small batch of fixes, about 50% tagged for stable and the rest for recently
merged code.

There's one more fix for the >128T handling on hash. Once a process had
requested a single mmap above 128T we would then always search above 128T. The
correct behaviour is to consider the hint address in isolation for each mmap
request.

Then a couple of fixes for the IMC PMU, a missing EXPORT_SYMBOL in VAS, a fix
for STRICT_KERNEL_RWX on 32-bit, and a fix to correctly identify P9 DD2.1 but in
code that is currently not used by default.

Thanks to:
  Aneesh Kumar K.V, Christophe Leroy, Madhavan Srinivasan, Sukadev Bhattiprolu.

----------------------------------------------------------------
Aneesh Kumar K.V (1):
      powerpc/64s/slice: Use addr limit when computing slice mask

Christophe Leroy (1):
      powerpc: Fix boot on BOOK3S_32 with CONFIG_STRICT_KERNEL_RWX

Madhavan Srinivasan (2):
      powerpc/perf: Fix pmu_count to count only nest imc pmus
      powerpc/perf: Fix IMC_MAX_PMU macro

Michael Ellerman (2):
      powerpc/perf/imc: Use cpu_to_node() not topology_physical_package_id()
      powerpc/64s: Fix Power9 DD2.1 logic in DT CPU features

Sukadev Bhattiprolu (1):
      powerpc/vas: Export chip_to_vas_id()

 arch/powerpc/include/asm/imc-pmu.h        |  6 +-----
 arch/powerpc/kernel/dt_cpu_ftrs.c         |  4 ++--
 arch/powerpc/lib/code-patching.c          |  6 ++----
 arch/powerpc/mm/slice.c                   | 34 ++++++++++++++++++++-----------
 arch/powerpc/perf/imc-pmu.c               | 27 ++++++++++++++++--------
 arch/powerpc/platforms/powernv/opal-imc.c | 22 ++++++++++++++++++--
 arch/powerpc/platforms/powernv/vas.c      |  1 +
 7 files changed, 66 insertions(+), 34 deletions(-)

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJaF/4WAAoJEFHr6jzI4aWATMkQAKywQv5M+Zy+QU3GWh3+TQt7
n8FGm5GNcaGNxc5sLY4HEvqLbt7MoZAr5+hIxqAE71febbyCoFWwuZGTg56fmVSc
5T9xxu6RFqz9iv7QHRZnpFC4lQP8rOB9y5i7lOAmk5sSMG2HJ7jz0XTBUcHQqQLD
PSCYYOnlMT2smcyxi8ViGCJmqADXSe3hfPM9I2xKMAwE7ogBbRGxtoM6vM7N9Q/o
1TtWDFghmPWEzYvQF+T7bNzcKskSXzqSGGu5yu+uLUHrKysbo/1r6XrTdDOosA1i
B5p7EXHpHF1qj7kI4xD3Uo1KnwSoO5zJvwlg3EPVRz8+u4PRl12uXlaYplOYZdtM
FNFb4NkQfceloF0/72ShcaWDu+i8U2cIaAQHnkNk3i/9XaAsNl9LCGLzXjc+v7Xu
xLB/umRjUE7FMMjJkU/km3GLwhDEovsh8rKD/EWXDQYr7jONhtqb2Z8QTU+Wl7vm
J53nxJV36rMThMBpFcWFE/IIxGGKeuRUu9pRPiY31s8SxMvKHRp7zud5zRsxXBo3
bCQvTd9DuBkrAOpPMR96GwNBXyzO+sgxoywJsCg3VSzF7JTmE37A+XJdvO595BTa
BAXAC+fTi6Kd+WMDWb6BmfwDqmfmgWRnM2L/djbO9t9UI4K4z5PaINxKr473FAiA
AuNNVH82iW9YPHpvPYby
=Ndqk
-----END PGP SIGNATURE-----
--=-=-=--
