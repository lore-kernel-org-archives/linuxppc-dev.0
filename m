Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 26A1EDE31F
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jul 2008 04:16:39 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m69IGZtT007520
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jul 2008 14:16:35 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m69IGZgF226158
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jul 2008 14:16:35 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m69IGZqV001036
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jul 2008 14:16:35 -0400
Date: Wed, 9 Jul 2008 14:13:12 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: Please pull 'next' branch of 4xx tree
Message-ID: <20080709141312.39319672@zod.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Ben and Paul,

Please pull from:

 master.kernel.org:/pub/scm/linux/kernel/git/jwboyer/powerpc-4xx.git next

to get some more changes for .27.  These include the TLB rework patch,
support for the Virtex5 platform, some bootwrapper documentation and
patches, and various other fixes.

josh

Benjamin Herrenschmidt (1):
      powerpc: rework 4xx PTE access and TLB miss

Grant Likely (4):
      powerpc/bootwrapper: Add documentation of boot wrapper targets
      powerpc/bootwrapper: add missing bit of simpleImage target
      powerpc/bootwrapper: Allow user to specify additional default targets
      powerpc/440: Convert Virtex ML507 device tree to dts-v1

John Linn (5):
      powerpc/virtex: add dts file for ML507 reference design
      powerpc/virtex: Fix booting of Xilinx FPGAs with 16550 for 405 and 440
      powerpc/virtex: add Xilinx Virtex 5 ppc440 platform support
      powerpc/virtex: add Xilinx 440 cpu to the cputable
      powerpc/virtex: add defconfig for virtex 5 platforms

Josh Boyer (2):
      Merge branch 'virtex-for-2.6.27' of git://git.secretlab.ca/git/linux-2.6-v
      powerpc/44x: Update ppc44x_defconfig

Sean MacLennan (1):
      powerpc/44x: Support NAND boot for Rev A Warp boards

Stefan Roese (1):
      powerpc: Fix problems with 32bit PPC's running with >= 4GB of RAM

 Documentation/powerpc/bootwrapper.txt      |  141 ++++
 arch/powerpc/Kconfig                       |   13 +
 arch/powerpc/Makefile                      |   15 +-
 arch/powerpc/boot/Makefile                 |    5 +-
 arch/powerpc/boot/dts/virtex440-ml507.dts  |  296 ++++++++
 arch/powerpc/boot/simpleboot.c             |    6 +
 arch/powerpc/boot/virtex.c                 |  100 +++
 arch/powerpc/boot/wrapper                  |   10 +-
 arch/powerpc/configs/44x/virtex5_defconfig | 1107 ++++++++++++++++++++++++++++
 arch/powerpc/configs/ppc44x_defconfig      |  149 +++--
 arch/powerpc/kernel/cputable.c             |   10 +
 arch/powerpc/kernel/head_44x.S             |  286 +++-----
 arch/powerpc/kernel/head_booke.h           |    8 +
 arch/powerpc/mm/44x_mmu.c                  |   29 +-
 arch/powerpc/mm/fault.c                    |    3 +-
 arch/powerpc/mm/init_32.c                  |    4 +-
 arch/powerpc/mm/mem.c                      |    8 +-
 arch/powerpc/mm/mmu_decl.h                 |    4 +-
 arch/powerpc/platforms/44x/Kconfig         |   26 +
 arch/powerpc/platforms/44x/Makefile        |    1 +
 arch/powerpc/platforms/44x/virtex.c        |   60 ++
 arch/powerpc/platforms/44x/warp-nand.c     |    9 +-
 include/asm-powerpc/pgtable-ppc32.h        |   61 ++-
 23 files changed, 2086 insertions(+), 265 deletions(-)
