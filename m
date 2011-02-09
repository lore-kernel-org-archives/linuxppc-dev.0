Return-Path: <shaggy@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A86D7B70EB
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Feb 2011 10:08:21 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p19Muvbo027852
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Feb 2011 15:56:57 -0700
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	p19N8G2x237476
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Feb 2011 16:08:16 -0700
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p19N8GRH001866
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Feb 2011 16:08:16 -0700
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH v3 0/6] powerpc: AMP support for 47x
Date: Wed,  9 Feb 2011 17:08:07 -0600
Message-Id: <1297292893-30241-1-git-send-email-shaggy@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Dave Kleikamp <shaggy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These patches add Asynchonous MultiProcessing support for the 47x chipset.
This allows independent OS instances to run on separate cores.
v3:
 1. switched from using compatible string to boolean "cooperative-partition"
 2. fixed missing type in boot wrapper
 3. fixed check for unspecified memory range in boot wrapper
 4. Cleaned up the dts files

v2:
 1. Replace ugly hack in boot wrapper with generic solution

Dave Kleikamp (6):
  powerpc: Move udbg_early_init() after early_init_devtree()
  powerpc/44x: allow override to hard-coded uart address
  powerpc/47x: allow kernel to be loaded in higher physical memory
  powerpc/44x: don't use tlbivax on AMP systems
  powerpc/44x: boot wrapper: allow kernel to load into non-zero address
  powerpc/476: Create a dts files for two 476 AMP instances under ISS

 arch/powerpc/Kconfig                          |    2 +-
 arch/powerpc/boot/Makefile                    |    6 +-
 arch/powerpc/boot/dts/iss476-amp1.dts         |  119 ++++++++++++++++++++++++
 arch/powerpc/boot/dts/iss476-amp2.dts         |  120 +++++++++++++++++++++++++
 arch/powerpc/boot/treeboot-iss4xx.c           |   22 +++++-
 arch/powerpc/boot/wrapper                     |    7 ++
 arch/powerpc/configs/44x/iss476-smp_defconfig |    6 +-
 arch/powerpc/include/asm/mmu.h                |    2 +-
 arch/powerpc/kernel/head_44x.S                |   42 +++++++--
 arch/powerpc/kernel/setup_32.c                |    6 +-
 arch/powerpc/kernel/udbg_16550.c              |   17 +++-
 arch/powerpc/mm/44x_mmu.c                     |   13 ++-
 arch/powerpc/mm/tlb_nohash.c                  |   23 +++++-
 13 files changed, 361 insertions(+), 24 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/iss476-amp1.dts
 create mode 100644 arch/powerpc/boot/dts/iss476-amp2.dts

-- 
1.7.3.4
