Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 942D8DE116
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jun 2008 00:53:15 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m55ErBuW024127
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Jun 2008 10:53:11 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m55ErCDO169922
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Jun 2008 10:53:12 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m55ErBVX005697
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Jun 2008 10:53:11 -0400
Received: from zod.rchland.ibm.com (wecm-9-67-183-229.wecm.ibm.com
	[9.67.183.229])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	m55ErBlr005679
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Jun 2008 10:53:11 -0400
Date: Thu, 5 Jun 2008 09:52:53 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: 4xx support in arch/ppc is going away Real Soon Now
Message-ID: <20080605095253.7df9dbe0@zod.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This commit (patch omitted due to size) is sitting in my local tree:

commit 0d7efc1e80fc262bcc507a605482c5681e3f082a
Author: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Date:   Thu Jun 5 09:46:17 2008 -0500

    ppc/4xx: Remove 4xx support from arch/ppc
    
    Remove support for PPC 403, 405, and 440 processors from arch/ppc.  The
    arch/powerpc equivalents should be used.  Boards that are not ported yet
    will need to be ported to arch/powerpc to have continued support.
    
    Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

I will push this to my -next branch in the next few days, and
ask Paul to pull it.  The diffstat is below.

josh

 arch/ppc/4xx_io/Makefile                           |    6 -
 arch/ppc/4xx_io/serial_sicc.c                      | 2005 --------------------
 arch/ppc/Kconfig                                   |   73 +-
 arch/ppc/Kconfig.debug                             |    4 +-
 arch/ppc/Makefile                                  |    5 -
 arch/ppc/boot/common/ns16550.c                     |    3 -
 arch/ppc/boot/common/util.S                        |    9 -
 arch/ppc/boot/simple/Makefile                      |   61 -
 arch/ppc/boot/simple/embed_config.c                |  221 +---
 arch/ppc/boot/simple/misc-embedded.c               |    4 +-
 arch/ppc/boot/simple/misc.c                        |   23 -
 arch/ppc/boot/simple/openbios.c                    |  128 --
 arch/ppc/boot/simple/pibs.c                        |  104 -
 arch/ppc/boot/simple/rw4/ppc_40x.h                 |  664 -------
 arch/ppc/boot/simple/rw4/rw4_init.S                |   78 -
 arch/ppc/boot/simple/rw4/rw4_init_brd.S            | 1125 -----------
 arch/ppc/boot/simple/rw4/stb.h                     |  239 ---
 arch/ppc/boot/simple/uartlite_tty.c                |    1 -
 arch/ppc/configs/bamboo_defconfig                  |  944 ---------
 arch/ppc/configs/bubinga_defconfig                 |  592 ------
 arch/ppc/configs/cpci405_defconfig                 |  631 ------
 arch/ppc/configs/ebony_defconfig                   |  585 ------
 arch/ppc/configs/ep405_defconfig                   |  572 ------
 arch/ppc/configs/luan_defconfig                    |  668 -------
 arch/ppc/configs/ml300_defconfig                   |  739 -------
 arch/ppc/configs/ml403_defconfig                   |  740 --------
 arch/ppc/configs/ocotea_defconfig                  |  599 ------
 arch/ppc/configs/redwood5_defconfig                |  557 ------
 arch/ppc/configs/redwood6_defconfig                |  535 ------
 arch/ppc/configs/sycamore_defconfig                |  663 -------
 arch/ppc/configs/taishan_defconfig                 | 1077 -----------
 arch/ppc/configs/walnut_defconfig                  |  578 ------
 arch/ppc/kernel/Makefile                           |    2 -
 arch/ppc/kernel/asm-offsets.c                      |    2 +-
 arch/ppc/kernel/entry.S                            |   64 +-
 arch/ppc/kernel/head_44x.S                         |  769 --------
 arch/ppc/kernel/head_4xx.S                         | 1021 ----------
 arch/ppc/kernel/misc.S                             |   91 -
 arch/ppc/kernel/ppc_ksyms.c                        |    3 -
 arch/ppc/kernel/traps.c                            |   56 +-
 arch/ppc/mm/44x_mmu.c                              |  101 -
 arch/ppc/mm/4xx_mmu.c                              |  135 --
 arch/ppc/mm/Makefile                               |    2 -
 arch/ppc/mm/fault.c                                |    6 +-
 arch/ppc/mm/mmu_decl.h                             |    5 -
 arch/ppc/platforms/4xx/Kconfig                     |  285 ---
 arch/ppc/platforms/4xx/Makefile                    |   31 -
 arch/ppc/platforms/4xx/bamboo.c                    |  442 -----
 arch/ppc/platforms/4xx/bamboo.h                    |  133 --
 arch/ppc/platforms/4xx/bubinga.c                   |  265 ---
 arch/ppc/platforms/4xx/bubinga.h                   |   54 -
 arch/ppc/platforms/4xx/cpci405.c                   |  201 --
 arch/ppc/platforms/4xx/cpci405.h                   |   28 -
 arch/ppc/platforms/4xx/ebony.c                     |  334 ----
 arch/ppc/platforms/4xx/ebony.h                     |   97 -
 arch/ppc/platforms/4xx/ep405.c                     |  196 --
 arch/ppc/platforms/4xx/ep405.h                     |   52 -
 arch/ppc/platforms/4xx/ibm405ep.c                  |  141 --
 arch/ppc/platforms/4xx/ibm405ep.h                  |  145 --
 arch/ppc/platforms/4xx/ibm405gp.c                  |  120 --
 arch/ppc/platforms/4xx/ibm405gp.h                  |  148 --
 arch/ppc/platforms/4xx/ibm405gpr.c                 |  115 --
 arch/ppc/platforms/4xx/ibm405gpr.h                 |  148 --
 arch/ppc/platforms/4xx/ibm440ep.c                  |  220 ---
 arch/ppc/platforms/4xx/ibm440ep.h                  |   73 -
 arch/ppc/platforms/4xx/ibm440gp.c                  |  163 --
 arch/ppc/platforms/4xx/ibm440gp.h                  |   63 -
 arch/ppc/platforms/4xx/ibm440gx.c                  |  231 ---
 arch/ppc/platforms/4xx/ibm440gx.h                  |   71 -
 arch/ppc/platforms/4xx/ibm440sp.c                  |  129 --
 arch/ppc/platforms/4xx/ibm440sp.h                  |   61 -
 arch/ppc/platforms/4xx/ibmnp405h.c                 |  170 --
 arch/ppc/platforms/4xx/ibmnp405h.h                 |  154 --
 arch/ppc/platforms/4xx/ibmstb4.c                   |  122 --
 arch/ppc/platforms/4xx/ibmstb4.h                   |  235 ---
 arch/ppc/platforms/4xx/ibmstbx25.c                 |   66 -
 arch/ppc/platforms/4xx/ibmstbx25.h                 |  258 ---
 arch/ppc/platforms/4xx/luan.c                      |  371 ----
 arch/ppc/platforms/4xx/luan.h                      |   77 -
 arch/ppc/platforms/4xx/ocotea.c                    |  350 ----
 arch/ppc/platforms/4xx/ocotea.h                    |   94 -
 arch/ppc/platforms/4xx/ppc440spe.c                 |  146 --
 arch/ppc/platforms/4xx/ppc440spe.h                 |   63 -
 arch/ppc/platforms/4xx/redwood5.c                  |  120 --
 arch/ppc/platforms/4xx/redwood5.h                  |   52 -
 arch/ppc/platforms/4xx/redwood6.c                  |  156 --
 arch/ppc/platforms/4xx/redwood6.h                  |   53 -
 arch/ppc/platforms/4xx/sycamore.c                  |  272 ---
 arch/ppc/platforms/4xx/sycamore.h                  |   49 -
 arch/ppc/platforms/4xx/taishan.c                   |  395 ----
 arch/ppc/platforms/4xx/taishan.h                   |   67 -
 arch/ppc/platforms/4xx/virtex.h                    |   35 -
 arch/ppc/platforms/4xx/walnut.c                    |  246 ---
 arch/ppc/platforms/4xx/walnut.h                    |   52 -
 arch/ppc/platforms/4xx/xilinx_ml300.c              |  118 --
 arch/ppc/platforms/4xx/xilinx_ml403.c              |  120 --
 arch/ppc/platforms/4xx/xparameters/xparameters.h   |  104 -
 .../platforms/4xx/xparameters/xparameters_ml300.h  |  310 ---
 .../platforms/4xx/xparameters/xparameters_ml403.h  |  243 ---
 arch/ppc/platforms/4xx/yucca.c                     |  393 ----
 arch/ppc/platforms/4xx/yucca.h                     |  108 --
 arch/ppc/syslib/Makefile                           |   32 -
 arch/ppc/syslib/ibm440gp_common.c                  |   73 -
 arch/ppc/syslib/ibm440gp_common.h                  |   32 -
 arch/ppc/syslib/ibm440gx_common.c                  |  294 ---
 arch/ppc/syslib/ibm440gx_common.h                  |   58 -
 arch/ppc/syslib/ibm440sp_common.c                  |   68 -
 arch/ppc/syslib/ibm440sp_common.h                  |   23 -
 arch/ppc/syslib/ibm44x_common.c                    |  235 ---
 arch/ppc/syslib/ibm44x_common.h                    |   45 -
 arch/ppc/syslib/ibm_ocp.c                          |   10 -
 arch/ppc/syslib/ppc403_pic.c                       |  125 --
 arch/ppc/syslib/ppc405_pci.c                       |  170 --
 arch/ppc/syslib/ppc440spe_pcie.c                   |  441 -----
 arch/ppc/syslib/ppc440spe_pcie.h                   |  149 --
 arch/ppc/syslib/ppc4xx_dma.c                       |  710 -------
 arch/ppc/syslib/ppc4xx_pic.c                       |  284 ---
 arch/ppc/syslib/ppc4xx_setup.c                     |  271 ---
 arch/ppc/syslib/ppc4xx_sgdma.c                     |  464 -----
 arch/ppc/syslib/virtex_devices.c                   |  276 ---
 arch/ppc/syslib/virtex_devices.h                   |   35 -
 arch/ppc/syslib/xilinx_pic.c                       |  153 --
 arch/ppc/xmon/start.c                              |   15 -
 arch/ppc/xmon/xmon.c                               |   13 +-
 include/asm-ppc/ibm403.h                           |  478 -----
 include/asm-ppc/ibm405.h                           |  299 ---
 include/asm-ppc/ibm44x.h                           |  674 -------
 include/asm-ppc/ibm4xx.h                           |  124 --
 include/asm-ppc/ibm_ocp.h                          |  204 --
 include/asm-ppc/ibm_ocp_pci.h                      |   32 -
 include/asm-ppc/io.h                               |    7 +-
 include/asm-ppc/mmu_context.h                      |    5 -
 include/asm-ppc/ppc4xx_dma.h                       |  579 ------
 include/asm-ppc/ppc4xx_pic.h                       |   52 -
 include/asm-ppc/ppcboot.h                          |   24 +-
 include/asm-ppc/reg_booke.h                        |   98 +-
 include/asm-ppc/serial.h                           |    2 -
 137 files changed, 33 insertions(+), 31956 deletions(-)
