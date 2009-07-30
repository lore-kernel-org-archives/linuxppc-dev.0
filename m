Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 4A6D2B7B97
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 30 Jul 2009 21:14:07 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A50AFDDD0C
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Jul 2009 21:14:06 +1000 (EST)
Subject: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain
Date: Thu, 30 Jul 2009 21:13:24 +1000
Message-Id: <1248952404.1509.84.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Linus !

Here's a bunch of defconfig updates for freescale embedded platforms
along with a handful of fixes for those from Kumar, and one important
one liner fix for a thinko/typo by myself in the embedded CPU context
management code on SMP.

The following changes since commit 658874f05d040ca96eb5ba9b1c30ce0ff287d762:
  Linus Torvalds (1):
        Merge branch 'i2c-fixes-rc4' of git://aeryn.fluff.org.uk/bjdooks/linux

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge

Anton Vorontsov (3):
      powerpc/85xx: Fix ethernet link detection on MPC8569E-MDS boards
      powerpc/85xx: Don't scan for TBI PHY addresses on MPC8569E-MDS boards
      powerpc/83xx: Fix PCI IO base address on MPC837xE-RDB boards

Kumar Gala (2):
      powerpc/mm: Fix SMP issue with MMU context handling code
      powerpc: Update defconfigs for embedded 6xx/7xxx, 8xx, 8{3,5,6}xxx

Mark Ware (1):
      cpm_uart: Don't use alloc_bootmem in cpm_uart_cpm2.c

Martyn Welch (2):
      powerpc/86xx: Update defconfig for GE Fanuc's PPC9A
      powerpc/86xx: Update GE Fanuc sbc310 default configuration

 arch/powerpc/boot/dts/mpc8377_rdb.dts             |    2 +-
 arch/powerpc/boot/dts/mpc8378_rdb.dts             |    2 +-
 arch/powerpc/boot/dts/mpc8379_rdb.dts             |    2 +-
 arch/powerpc/boot/dts/mpc8569mds.dts              |    4 +
 arch/powerpc/configs/83xx/asp8347_defconfig       |  106 +++--
 arch/powerpc/configs/83xx/kmeter1_defconfig       |  176 +++++---
 arch/powerpc/configs/83xx/mpc8313_rdb_defconfig   |  168 +++++--
 arch/powerpc/configs/83xx/mpc8315_rdb_defconfig   |  168 +++++--
 arch/powerpc/configs/83xx/mpc832x_mds_defconfig   |  111 +++--
 arch/powerpc/configs/83xx/mpc832x_rdb_defconfig   |  120 +++--
 arch/powerpc/configs/83xx/mpc834x_itx_defconfig   |  114 +++--
 arch/powerpc/configs/83xx/mpc834x_itxgp_defconfig |  114 +++--
 arch/powerpc/configs/83xx/mpc834x_mds_defconfig   |  104 +++--
 arch/powerpc/configs/83xx/mpc836x_mds_defconfig   |  111 +++--
 arch/powerpc/configs/83xx/mpc836x_rdk_defconfig   |  104 +++--
 arch/powerpc/configs/83xx/mpc837x_mds_defconfig   |  110 +++--
 arch/powerpc/configs/83xx/mpc837x_rdb_defconfig   |  162 +++++---
 arch/powerpc/configs/83xx/sbc834x_defconfig       |  103 +++--
 arch/powerpc/configs/85xx/ksi8560_defconfig       |   93 +++--
 arch/powerpc/configs/85xx/mpc8540_ads_defconfig   |   91 +++--
 arch/powerpc/configs/85xx/mpc8560_ads_defconfig   |   99 +++--
 arch/powerpc/configs/85xx/mpc85xx_cds_defconfig   |   99 +++--
 arch/powerpc/configs/85xx/sbc8548_defconfig       |   96 +++--
 arch/powerpc/configs/85xx/sbc8560_defconfig       |   91 +++--
 arch/powerpc/configs/85xx/socrates_defconfig      |  165 +++++---
 arch/powerpc/configs/85xx/stx_gp3_defconfig       |  119 +++--
 arch/powerpc/configs/85xx/tqm8540_defconfig       |  100 +++--
 arch/powerpc/configs/85xx/tqm8541_defconfig       |  101 +++--
 arch/powerpc/configs/85xx/tqm8548_defconfig       |  100 +++--
 arch/powerpc/configs/85xx/tqm8555_defconfig       |  101 +++--
 arch/powerpc/configs/85xx/tqm8560_defconfig       |  101 +++--
 arch/powerpc/configs/85xx/xes_mpc85xx_defconfig   |  118 +++--
 arch/powerpc/configs/86xx/gef_ppc9a_defconfig     |  521 ++++++++-------------
 arch/powerpc/configs/86xx/gef_sbc310_defconfig    |  216 +++++++---
 arch/powerpc/configs/86xx/gef_sbc610_defconfig    |  130 ++++--
 arch/powerpc/configs/86xx/mpc8610_hpcd_defconfig  |  118 +++--
 arch/powerpc/configs/86xx/mpc8641_hpcn_defconfig  |  186 ++++----
 arch/powerpc/configs/86xx/sbc8641d_defconfig      |  112 +++--
 arch/powerpc/configs/adder875_defconfig           |   97 +++--
 arch/powerpc/configs/c2k_defconfig                |  121 +++--
 arch/powerpc/configs/ep8248e_defconfig            |   97 +++--
 arch/powerpc/configs/ep88xc_defconfig             |   91 +++--
 arch/powerpc/configs/linkstation_defconfig        |  116 +++--
 arch/powerpc/configs/mgcoge_defconfig             |   97 +++--
 arch/powerpc/configs/mgsuvd_defconfig             |   89 ++--
 arch/powerpc/configs/mpc7448_hpc2_defconfig       |  103 +++--
 arch/powerpc/configs/mpc8272_ads_defconfig        |  104 +++--
 arch/powerpc/configs/mpc83xx_defconfig            |  162 +++++---
 arch/powerpc/configs/mpc85xx_defconfig            |  193 ++++----
 arch/powerpc/configs/mpc85xx_smp_defconfig        |  193 ++++----
 arch/powerpc/configs/mpc866_ads_defconfig         |   92 ++--
 arch/powerpc/configs/mpc86xx_defconfig            |  186 ++++----
 arch/powerpc/configs/mpc885_ads_defconfig         |   91 +++--
 arch/powerpc/configs/pq2fads_defconfig            |  110 +++--
 arch/powerpc/configs/prpmc2800_defconfig          |  158 +++++--
 arch/powerpc/configs/storcenter_defconfig         |  108 +++--
 arch/powerpc/mm/mmu_context_nohash.c              |    1 +
 arch/powerpc/platforms/85xx/mpc85xx_mds.c         |   13 +
 drivers/serial/cpm_uart/cpm_uart_cpm2.c           |    2 +-
 59 files changed, 4007 insertions(+), 2755 deletions(-)
