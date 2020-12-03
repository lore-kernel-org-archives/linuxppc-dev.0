Return-Path: <SRS0=jgKV=FH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F1E2C64E7C
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Dec 2020 02:44:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88E0922201
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Dec 2020 02:44:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88E0922201
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CmgCW4qCRzF20q
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Dec 2020 13:44:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=192.55.52.43; helo=mga05.intel.com;
 envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CmftT1v2HzDsNZ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Dec 2020 13:29:36 +1100 (AEDT)
IronPort-SDR: XQ58y9wl+oYaC/JcBCvp+mwGqLK3aMVW+t/MRFkej/UW9Dy2WgFFhy1/N1O8HoDk7/QhwRzADN
 qO3FGIW/O0kg==
X-IronPort-AV: E=McAfee;i="6000,8403,9823"; a="257835722"
X-IronPort-AV: E=Sophos;i="5.78,388,1599548400"; d="scan'208";a="257835722"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Dec 2020 18:29:33 -0800
IronPort-SDR: NHO5Uk7teJMY8BxUZkOJ7nFFu7L3wRBHc/XUkUjHMP7Qlw3qnYIgMQTVaVwbN11yJ2n6Sp7qu/
 8nju2yR9FGBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,388,1599548400"; d="scan'208";a="405722913"
Received: from lkp-server01.sh.intel.com (HELO 54133fc185c3) ([10.239.97.150])
 by orsmga001.jf.intel.com with ESMTP; 02 Dec 2020 18:29:32 -0800
Received: from kbuild by 54133fc185c3 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1kkeN9-0000T9-E3; Thu, 03 Dec 2020 02:29:31 +0000
Date: Thu, 03 Dec 2020 10:28:37 +0800
From: kernel test robot <lkp@intel.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [powerpc:next-test] BUILD REGRESSION
 fb003959777a635dea8910cf71109b612c7f940c
Message-ID: <5fc84d55.MXn17c30YYhBZs2F%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git  next-test
branch HEAD: fb003959777a635dea8910cf71109b612c7f940c  powerpc/44x: Don't support 47x code and non 47x code at the same time

Error/Warning reports:

https://lore.kernel.org/linuxppc-dev/202012030320.soNPcJR8-lkp@intel.com
https://lore.kernel.org/linuxppc-dev/202012030759.zuEULDQ3-lkp@intel.com

Error/Warning in current branch:

drivers/misc/lkdtm/powerpc.c:13:10: error: use of undeclared identifier 'SLB_VSID_KERNEL'
drivers/misc/lkdtm/powerpc.c:13:54: error: no member named 'sllp' in 'struct mmu_psize_def'
drivers/misc/lkdtm/powerpc.c:17:15: error: implicit declaration of function 'mk_vsid_data' [-Werror,-Wimplicit-function-declaration]
drivers/misc/lkdtm/powerpc.c:18:15: error: implicit declaration of function 'mk_esid_data' [-Werror,-Wimplicit-function-declaration]
drivers/misc/lkdtm/powerpc.c:18:38: error: use of undeclared identifier 'SLB_NUM_BOLTED'
drivers/misc/lkdtm/powerpc.c:37:37: error: use of undeclared identifier 'MMU_SEGSIZE_1T'
drivers/misc/lkdtm/powerpc.c:37:53: error: use of undeclared identifier 'mmu_vmalloc_psize'

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
`-- powerpc-randconfig-c003-20201202
    `-- arch-powerpc-kernel-firmware.c:WARNING:return-of-in-function-check_kvm_guest-with-return-type-bool

clang_recent_errors
`-- powerpc64-randconfig-r013-20201202
    |-- drivers-misc-lkdtm-powerpc.c:error:implicit-declaration-of-function-mk_esid_data-Werror-Wimplicit-function-declaration
    |-- drivers-misc-lkdtm-powerpc.c:error:implicit-declaration-of-function-mk_vsid_data-Werror-Wimplicit-function-declaration
    |-- drivers-misc-lkdtm-powerpc.c:error:no-member-named-sllp-in-struct-mmu_psize_def
    |-- drivers-misc-lkdtm-powerpc.c:error:use-of-undeclared-identifier-MMU_SEGSIZE_1T
    |-- drivers-misc-lkdtm-powerpc.c:error:use-of-undeclared-identifier-SLB_NUM_BOLTED
    |-- drivers-misc-lkdtm-powerpc.c:error:use-of-undeclared-identifier-SLB_VSID_KERNEL
    `-- drivers-misc-lkdtm-powerpc.c:error:use-of-undeclared-identifier-mmu_vmalloc_psize

elapsed time: 733m

configs tested: 141
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                        clps711x_defconfig
arm                        shmobile_defconfig
powerpc64                        alldefconfig
mips                 decstation_r4k_defconfig
nios2                         3c120_defconfig
mips                         bigsur_defconfig
mips                malta_qemu_32r6_defconfig
mips                         mpc30x_defconfig
microblaze                      mmu_defconfig
sh                     sh7710voipgw_defconfig
powerpc                     redwood_defconfig
parisc                           alldefconfig
mips                      pic32mzda_defconfig
powerpc                     skiroot_defconfig
sh                          rsk7264_defconfig
powerpc                        fsp2_defconfig
sh                             shx3_defconfig
sh                        sh7785lcr_defconfig
sh                            titan_defconfig
csky                             alldefconfig
m68k                          sun3x_defconfig
arm                          ep93xx_defconfig
sh                           se7724_defconfig
powerpc                     powernv_defconfig
powerpc                      walnut_defconfig
arm                         s3c6400_defconfig
arm                       aspeed_g5_defconfig
sparc                       sparc32_defconfig
mips                         tb0287_defconfig
m68k                          hp300_defconfig
mips                     cu1830-neo_defconfig
sh                           se7343_defconfig
arm                            u300_defconfig
m68k                             alldefconfig
arm                        spear6xx_defconfig
arm                         assabet_defconfig
sh                              ul2_defconfig
xtensa                  nommu_kc705_defconfig
nds32                             allnoconfig
arm                       versatile_defconfig
sh                            hp6xx_defconfig
arm                           sunxi_defconfig
powerpc                     mpc5200_defconfig
powerpc                 mpc8272_ads_defconfig
openrisc                            defconfig
powerpc                       holly_defconfig
arm                          prima2_defconfig
arc                           tb10x_defconfig
m68k                                defconfig
arm                        keystone_defconfig
mips                        nlm_xlr_defconfig
xtensa                              defconfig
powerpc                     stx_gp3_defconfig
arm                       cns3420vb_defconfig
arm                           omap1_defconfig
mips                       rbtx49xx_defconfig
arm                         s3c2410_defconfig
arm                         nhk8815_defconfig
mips                        maltaup_defconfig
mips                           ip32_defconfig
h8300                    h8300h-sim_defconfig
arm                           corgi_defconfig
powerpc                     ep8248e_defconfig
sh                   sh7770_generic_defconfig
powerpc                 mpc85xx_cds_defconfig
sh                          landisk_defconfig
mips                     cu1000-neo_defconfig
arm                        mvebu_v5_defconfig
m68k                       m5275evb_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20201202
x86_64               randconfig-a006-20201202
x86_64               randconfig-a001-20201202
x86_64               randconfig-a002-20201202
x86_64               randconfig-a005-20201202
x86_64               randconfig-a003-20201202
i386                 randconfig-a004-20201202
i386                 randconfig-a005-20201202
i386                 randconfig-a001-20201202
i386                 randconfig-a002-20201202
i386                 randconfig-a006-20201202
i386                 randconfig-a003-20201202
i386                 randconfig-a014-20201202
i386                 randconfig-a013-20201202
i386                 randconfig-a011-20201202
i386                 randconfig-a015-20201202
i386                 randconfig-a012-20201202
i386                 randconfig-a016-20201202
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a016-20201202
x86_64               randconfig-a012-20201202
x86_64               randconfig-a014-20201202
x86_64               randconfig-a013-20201202
x86_64               randconfig-a015-20201202
x86_64               randconfig-a011-20201202

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
