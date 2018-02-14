Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zhL5h5Tz0zF1G3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Feb 2018 00:36:08 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: aik@ozlabs.ru, andrew.donnellan@au1.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 colin.king@canonical.com, fbarrat@linux.vnet.ibm.com,
 harish@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, linux@roeck-us.net,
 linuxppc-dev@lists.ozlabs.org, maddy@linux.vnet.ibm.com,
 nfont@linux.vnet.ibm.com, npiggin@gmail.com, sam.bobroff@au1.ibm.com
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.16-2 tag
Date: Thu, 15 Feb 2018 00:36:02 +1100
Message-ID: <878tbvr8vx.fsf@concordia.ellerman.id.au>
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

Please pull some powerpc fixes for 4.16:

The following changes since commit 581e400ff935d34d95811258586128bf11baef15:

  Merge tag 'modules-for-v4.16' of git://git.kernel.org/pub/scm/linux/kernel/git/jeyu/linux (2018-02-07 14:29:34 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-4.16-2

for you to fetch changes up to ecdf06e1ea5376bba03c155751f6869d3dfaa210:

  selftests/powerpc: Fix to use ucontext_t instead of struct ucontext (2018-02-13 22:44:18 +1100)

----------------------------------------------------------------
powerpc fixes for 4.16 #2

A larger batch of fixes than we'd like. Roughly 1/3 fixes for new code, 1/3
fixes for stable and 1/3 minor things.

There's four commits fixing bugs when using 16GB huge pages on hash, caused by
some of the preparatory changes for pkeys.

Two fixes for bugs in the enhanced IRQ soft masking for local_t, one of which
broke KVM in some circumstances.

Four fixes for Power9. The most bizarre being a bug where futexes stopped
working because a NULL pointer dereference didn't trap during early boot (it
aliased the kernel mapping). A fix for memory hotplug when using the Radix MMU,
and a fix for live migration of guests using the Radix MMU.

Two fixes for hotplug on pseries machines. One where we weren't correctly
updating NUMA info when CPUs are added and removed. And the other fixes
crashes/hangs seen when doing memory hot remove during boot, which is apparently
a thing people do.

Finally a handful of build fixes for obscure configs and other minor fixes.

Thanks to:
  Alexey Kardashevskiy, Aneesh Kumar K.V, Balbir Singh, Colin Ian King, Daniel
  Henrique Barboza, Florian Weimer, Guenter Roeck, Harish, Laurent Vivier,
  Madhavan Srinivasan, Mauricio Faria de Oliveira, Nathan Fontenot, Nicholas
  Piggin, Sam Bobroff.

----------------------------------------------------------------
Alexey Kardashevskiy (1):
      powerpc/mm: Flush radix process translations when setting MMU type

Aneesh Kumar K.V (4):
      powerpc/mm: Fix crashes with 16G huge pages
      powerpc/mm/hash64: Allocate larger PMD table if hugetlb config is enabled
      powerpc/mm/hash64: Store the slot information at the right offset for hugetlb
      powerpc/mm/hash64: Zero PGD pages on allocation

Balbir Singh (1):
      powerpc/mm/radix: Split linear mapping on hot-unplug

Colin Ian King (1):
      ocxl: fix signed comparison with less than zero

Guenter Roeck (2):
      powerpc/pseries: Fix build break for SPLPAR=n and CPU hotplug
      powerpc/kdump: Fix powernv build break when KEXEC_CORE=n

Harish (1):
      selftests/powerpc: Fix to use ucontext_t instead of struct ucontext

Madhavan Srinivasan (1):
      powerpc/64s: Fix MASKABLE_RELON_EXCEPTION_HV_OOL macro

Nathan Fontenot (1):
      powerpc/numa: Invalidate numa_cpu_lookup_table on cpu remove

Nicholas Piggin (3):
      powerpc/64s: Fix may_hard_irq_enable() for PMI soft masking
      powerpc/64s/radix: Boot-time NULL pointer protection using a guard-PID
      powerpc/vas: Don't set uses_vas for kernel windows

Sam Bobroff (1):
      powerpc/pseries: Enable RAS hotplug events later

 arch/powerpc/include/asm/book3s/32/pgtable.h       |   1 +
 arch/powerpc/include/asm/book3s/64/hash-4k.h       |   3 +-
 arch/powerpc/include/asm/book3s/64/hash-64k.h      |  16 ++-
 arch/powerpc/include/asm/book3s/64/hash.h          |  13 ++-
 arch/powerpc/include/asm/book3s/64/pgalloc.h       |  16 ++-
 arch/powerpc/include/asm/book3s/64/pgtable.h       |   4 +-
 arch/powerpc/include/asm/exception-64s.h           |   2 +-
 arch/powerpc/include/asm/hw_irq.h                  |  12 ++-
 arch/powerpc/include/asm/kexec.h                   |   6 ++
 arch/powerpc/include/asm/nohash/32/pgtable.h       |   1 +
 arch/powerpc/include/asm/nohash/64/pgtable.h       |   1 +
 arch/powerpc/include/asm/topology.h                |  10 ++
 arch/powerpc/kernel/exceptions-64e.S               |   2 +
 arch/powerpc/kernel/exceptions-64s.S               |   6 +-
 arch/powerpc/mm/hash64_4k.c                        |   4 +-
 arch/powerpc/mm/hash64_64k.c                       |   8 +-
 arch/powerpc/mm/hash_utils_64.c                    |   1 +
 arch/powerpc/mm/hugetlbpage-hash64.c               |  10 +-
 arch/powerpc/mm/init-common.c                      |   4 +-
 arch/powerpc/mm/numa.c                             |   5 -
 arch/powerpc/mm/pgtable-radix.c                    | 117 +++++++++++++++++----
 arch/powerpc/mm/pgtable_64.c                       |   4 +
 arch/powerpc/mm/tlb_hash64.c                       |   9 +-
 arch/powerpc/platforms/powernv/vas-window.c        |  16 +--
 arch/powerpc/platforms/pseries/hotplug-cpu.c       |   4 +-
 arch/powerpc/platforms/pseries/ras.c               |  31 ++++--
 drivers/misc/ocxl/file.c                           |   2 +-
 .../powerpc/alignment/alignment_handler.c          |   2 +-	# tools/testing/selftests/
 28 files changed, 231 insertions(+), 79 deletions(-)

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJahDtCAAoJEFHr6jzI4aWAYTIP/0+n4WDZpQxKCOqQVabuR44Q
R6DhKbqH5zy95wgW/QMeiP6oPmQyG0O+uq7VZ+cVbXWjNocI8+sqHmPHuouXLed+
VeXYSu+fMpTwdiT+dr5I6eH/eSQFsK+VrNJAY1DU0mCNhm0rUQiF3DFOnODnroR0
uC7aCTTqHMDQCTHM0TkPwSvS9O1WzOvHhNGic+8eMCM2RqXGVEUbMu5c78/02JKm
ReKNAyIssDkrGoEkBb8PItjrixc0SX0VC1Kbw1Hx844AAvIXxbpZUsWn+6Munidk
wHsLXUgeToWyoR+J4aiXMnlzpPOAPYxIfPoTKBgFu7HkyMYw2M6QdZYfMt9R3v4r
+9AZGRe1ZHdgzzd3s8dZMmGka+mM+T/4iZosrW/nl2KbY3cyU7MSNyIy9mwmONOZ
uN9Wo3KyrgXgT+cQ4PQ108LcOkvIJikEA4TkOIngkXfCfX2Ep6DiRNBpjQND+tsT
TFRLW6KhcLTPzNXjjdI2peIfuns5JL1j5XTQ2eRDXLNbi5lglYFRDyvWfxznCKIW
fLS3yTb7hmQvLy75iv1BkJkrrqSsRfHDYJ9WlFiJ89dy4v2NdrVREBR/3Ab8NZfm
tLn5YgHnsi/6P9+b31QL6k2QNrfPiCMlsP93B7IKIVKSurbZsJgGBnOJICkA3I44
JXi9ynfakDGUxRby8aZD
=6IPG
-----END PGP SIGNATURE-----
--=-=-=--
