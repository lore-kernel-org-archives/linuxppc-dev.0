Return-Path: <shaggy@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 76421B712D
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 27 Jan 2011 08:51:25 +1100 (EST)
Received: from d01dlp01.pok.ibm.com (d01dlp01.pok.ibm.com [9.56.224.56])
	by e1.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p0QLftrw009707
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jan 2011 16:42:17 -0500
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by d01dlp01.pok.ibm.com (Postfix) with ESMTP id D0AEE728051
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 26 Jan 2011 16:51:21 -0500 (EST)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p0QLpLoQ1781946
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jan 2011 16:51:21 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p0QLpJrD022420
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jan 2011 19:51:20 -0200
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 0/5] powerpc: AMP support for 47x
Date: Wed, 26 Jan 2011 15:51:11 -0600
Message-Id: <1296078676-13940-1-git-send-email-shaggy@linux.vnet.ibm.com>
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

Dave Kleikamp (5):
  powerpc: Move udbg_early_init() after early_init_devtree()
  powerpc/44x: allow override to hard-coded uart address
  powerpc/47x: allow kernel to be loaded in higher physical memory
  powerpc/44x: don't use tlbivax on AMP systems
  powerpc/476: Create a dts files for two 476 AMP instances under ISS

 arch/powerpc/Kconfig                          |    2 +-
 arch/powerpc/boot/Makefile                    |    9 ++-
 arch/powerpc/boot/dts/iss476-amp1.dts         |  119 ++++++++++++++++++++++++
 arch/powerpc/boot/dts/iss476-amp2.dts         |  123 +++++++++++++++++++++++++
 arch/powerpc/boot/treeboot-iss4xx-hi.c        |   65 +++++++++++++
 arch/powerpc/boot/wrapper                     |    7 ++
 arch/powerpc/configs/44x/iss476-smp_defconfig |    6 +-
 arch/powerpc/include/asm/mmu.h                |    2 +-
 arch/powerpc/kernel/head_44x.S                |   42 +++++++--
 arch/powerpc/kernel/setup_32.c                |    6 +-
 arch/powerpc/kernel/udbg_16550.c              |   17 +++-
 arch/powerpc/mm/44x_mmu.c                     |   13 ++-
 arch/powerpc/mm/tlb_nohash.c                  |   21 ++++-
 13 files changed, 408 insertions(+), 24 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/iss476-amp1.dts
 create mode 100644 arch/powerpc/boot/dts/iss476-amp2.dts
 create mode 100644 arch/powerpc/boot/treeboot-iss4xx-hi.c

-- 
1.7.3.4
