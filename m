Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BAF4ADE31A
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jun 2008 03:56:00 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m5JHtv5Y030343
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jun 2008 13:55:57 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m5JHtvPC211298
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jun 2008 13:55:57 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m5JHtvU3002282
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jun 2008 13:55:57 -0400
Date: Thu, 19 Jun 2008 13:53:34 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: paulus@samba.org
Subject: Please pull 'next' branch of 4xx tree
Message-ID: <20080619135334.6f17d2e0@zod.rchland.ibm.com>
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

Hi Paul,

Please pull from:

 master.kernel.org:/pub/scm/linux/kernel/git/jwboyer/powerpc-4xx.git next

to get some more changes for 2.6.27.  A new board port, a revert, and a
few fixes.

I'll have a few more after this as well, most notably Ben's rework
patch.

josh

Giuseppe Coviello (2):
      powerpc/4xx: Sam440ep support
      powerpc/4xx: Convert Sam440ep DTS to dts-v1

Imre Kaloz (1):
      powerpc/4xx: MTD support for the AMCC Taishan Board

Josh Boyer (2):
      Revert "[POWERPC] 4xx: Fix 460GT support to not enable FPU"
      powerpc/4xx: Workaround for PPC440EPx/GRx PCI_28 Errata

Stefan Roese (1):
      powerpc/4xx: PCIe driver now detects if a port is disabled via the dev-tre

Valentine Barshak (1):
      powerpc/4xx: Fix resource issue in warp-nand.c

 arch/powerpc/boot/Makefile                  |    3 +-
 arch/powerpc/boot/cuboot-sam440ep.c         |   49 ++
 arch/powerpc/boot/dts/sam440ep.dts          |  293 +++++++
 arch/powerpc/boot/dts/taishan.dts           |   29 +-
 arch/powerpc/configs/44x/sam440ep_defconfig | 1192 +++++++++++++++++++++++++++
 arch/powerpc/configs/44x/taishan_defconfig  |   79 ++-
 arch/powerpc/kernel/cpu_setup_44x.S         |    1 +
 arch/powerpc/kernel/cputable.c              |    4 +-
 arch/powerpc/platforms/44x/Kconfig          |    9 +
 arch/powerpc/platforms/44x/Makefile         |    1 +
 arch/powerpc/platforms/44x/sam440ep.c       |   79 ++
 arch/powerpc/platforms/44x/warp-nand.c      |    3 +-
 arch/powerpc/sysdev/indirect_pci.c          |    6 +
 arch/powerpc/sysdev/ppc4xx_pci.c            |   14 +
 include/asm-powerpc/pci-bridge.h            |    3 +
 15 files changed, 1759 insertions(+), 6 deletions(-)
