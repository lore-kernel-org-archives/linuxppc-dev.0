Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8CE02B7D59
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  6 May 2010 03:11:51 +1000 (EST)
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e32.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o45H4j2J025377
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 May 2010 11:04:45 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o45HBinD147196
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 May 2010 11:11:45 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o45HBilr021996
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 May 2010 11:11:44 -0600
Date: Wed, 5 May 2010 13:11:42 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: Please pull 'next' branch of 4xx tree
Message-ID: <20100505171142.GK29593@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben,

A late pull request for -next, so my apologies in advance.  This contains the
first 7 patches of the 476 series.  I did a build/boot test on 440EPx for each
patch individually and fixed up a few minor issues.  The 440EPx seems to be
running just fine for all of them.  This also has the reset type patch from
Stefan in it, as I've tested that as well.

josh

The following changes since commit cb694769f0d0c1f6fb8c9dc806c0a68da1056055:
  Benjamin Herrenschmidt (1):
        Revert "powerpc/mm: Bump SECTION_SIZE_BITS from 16MB to 256MB"

are available in the git repository at:

  ssh://master.kernel.org/pub/scm/linux/kernel/git/jwboyer/powerpc-4xx.git next

Dave Kleikamp (5):
      powerpc/44x: break out cpu init code into stand-alone function
      powerpc/47x: Base ppc476 support
      powerpc/476: add machine check handler for 47x core
      powerpc/476: Add isync after loading mmu and debug spr's
      powerpc/47x: defconfig for 476 on the iss 4xx simulator

Stefan Roese (1):
      powerpc/4xx: Add optional "reset_type" property to control reboot via dts

Torez Smith (2):
      powerpc/booke: Add Stack Marking support to Booke Exception Prolog
      powerpc/4xx: Simple platform for the ISS 4xx simulator

 Documentation/powerpc/dts-bindings/4xx/reboot.txt |   18 +
 arch/powerpc/boot/Makefile                        |    5 +-
 arch/powerpc/boot/dts/iss4xx-mpic.dts             |  155 ++++
 arch/powerpc/boot/dts/iss4xx.dts                  |  116 +++
 arch/powerpc/boot/treeboot-iss4xx.c               |   56 ++
 arch/powerpc/boot/wrapper                         |    3 +
 arch/powerpc/configs/44x/iss476-smp_defconfig     | 1026 +++++++++++++++++++++
 arch/powerpc/include/asm/cache.h                  |    6 +-
 arch/powerpc/include/asm/cputable.h               |    5 +
 arch/powerpc/include/asm/mmu-44x.h                |   51 +-
 arch/powerpc/include/asm/mmu.h                    |    1 +
 arch/powerpc/include/asm/reg.h                    |    4 +
 arch/powerpc/include/asm/reg_booke.h              |   24 +
 arch/powerpc/kernel/cputable.c                    |   29 +
 arch/powerpc/kernel/entry_32.S                    |    5 +
 arch/powerpc/kernel/head_44x.S                    |  828 +++++++++++++----
 arch/powerpc/kernel/head_booke.h                  |    4 +
 arch/powerpc/kernel/kprobes.c                     |    3 +
 arch/powerpc/kernel/misc_32.S                     |    9 +-
 arch/powerpc/kernel/process.c                     |    3 +
 arch/powerpc/kernel/smp.c                         |    8 +
 arch/powerpc/kernel/traps.c                       |   40 +
 arch/powerpc/mm/44x_mmu.c                         |  144 +++-
 arch/powerpc/mm/mmu_context_nohash.c              |    8 +
 arch/powerpc/mm/mmu_decl.h                        |    7 +-
 arch/powerpc/mm/tlb_nohash_low.S                  |  118 +++-
 arch/powerpc/platforms/44x/Kconfig                |   20 +
 arch/powerpc/platforms/44x/Makefile               |    1 +
 arch/powerpc/platforms/44x/iss4xx.c               |  167 ++++
 arch/powerpc/platforms/Kconfig.cputype            |    5 +-
 arch/powerpc/sysdev/ppc4xx_soc.c                  |   24 +-
 31 files changed, 2690 insertions(+), 203 deletions(-)
 create mode 100644 Documentation/powerpc/dts-bindings/4xx/reboot.txt
 create mode 100644 arch/powerpc/boot/dts/iss4xx-mpic.dts
 create mode 100644 arch/powerpc/boot/dts/iss4xx.dts
 create mode 100644 arch/powerpc/boot/treeboot-iss4xx.c
 create mode 100644 arch/powerpc/configs/44x/iss476-smp_defconfig
 create mode 100644 arch/powerpc/platforms/44x/iss4xx.c
