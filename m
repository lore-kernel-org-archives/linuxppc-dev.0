Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3FD0AB7154
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 28 Sep 2010 23:10:33 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o8SDA8SS022830
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Sep 2010 09:10:08 -0400
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o8SD9tQa110176
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Sep 2010 09:09:56 -0400
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o8SD9tXO025174
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Sep 2010 07:09:55 -0600
Date: Tue, 28 Sep 2010 09:09:41 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: Please pull 'next' branch of 4xx tree
Message-ID: <20100928130941.GA31993@zod.rchland.ibm.com>
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

A few small updates for the next branch.  A new board/SoC from AMCC, and
some 476 changes from Shaggy.  Please pull.

josh

The following changes since commit 9f5f9ffe50e90ed73040d2100db8bfc341cee352:

  powerpc/perf: Fix sampling enable for PPC970 (2010-09-23 17:03:56 +1000)

are available in the git repository at:

  ssh://master.kernel.org/pub/scm/linux/kernel/git/jwboyer/powerpc-4xx.git next

Dave Kleikamp (2):
      powerpc/476: Set CCR2[DSTI] to prevent isync from flushing shadow TLB
      powerpc/476: lazy flush_tlb_mm for nohash architectures

Josh Boyer (1):
      powerpc/44x: Update ppc44x_defconfig

Tirumala Marri (1):
      powerpc/44x: Add support for the AMCC APM821xx SoC

 arch/powerpc/boot/dts/bluestone.dts          |  254 ++++++++++++++++++++++++++
 arch/powerpc/configs/44x/bluestone_defconfig |   68 +++++++
 arch/powerpc/configs/ppc44x_defconfig        |    9 +-
 arch/powerpc/include/asm/reg_booke.h         |    4 +
 arch/powerpc/kernel/cpu_setup_44x.S          |    1 +
 arch/powerpc/kernel/cputable.c               |   15 ++
 arch/powerpc/kernel/head_44x.S               |   25 +++
 arch/powerpc/mm/mmu_context_nohash.c         |  154 ++++++++++++++--
 arch/powerpc/mm/mmu_decl.h                   |    8 +
 arch/powerpc/mm/tlb_nohash.c                 |   28 +++-
 arch/powerpc/mm/tlb_nohash_low.S             |   14 ++-
 arch/powerpc/platforms/44x/Kconfig           |   16 ++
 arch/powerpc/platforms/44x/misc_44x.S        |   26 +++
 arch/powerpc/platforms/44x/ppc44x_simple.c   |    1 +
 14 files changed, 602 insertions(+), 21 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/bluestone.dts
 create mode 100644 arch/powerpc/configs/44x/bluestone_defconfig
