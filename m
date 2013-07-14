Return-Path: <haokexin@gmail.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4217B2C00F3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Jul 2013 19:07:29 +1000 (EST)
From: Kevin Hao <haokexin@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 0/4] powerpc: several cleanup patches for the FPU
Date: Sun, 14 Jul 2013 17:02:02 +0800
Message-ID: <1373792526-16241-1-git-send-email-haokexin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

All these patches passed the build test for the following configurations:
	ppc40x_defconfig
        ppc64e_defconfig
        ppc64_defconfig
	mpc85xx_defconfig
	mpc85xx_smp_defconfig
        corenet32_smp_defconfig
        corenet64_smp_defconfig
        ppc44x_defconfig
	mpc885_ads_defconfig
        pseries_defconfig

Also passed the boot test on a t4240qds board.

Kevin Hao (4):
  powerpc: remove the unused function disable_kernel_fp()
  powerpc: remove the redundant flush_fp_to_thread() in
    setup_sigcontext()
  powerpc: make flush_fp_to_thread() nop when CONFIG_PPC_FPU is disabled
  powerpc: remove the empty giveup_fpu() function on 32bit kernel

 arch/powerpc/include/asm/switch_to.h | 11 ++++++++---
 arch/powerpc/kernel/head_40x.S       |  8 --------
 arch/powerpc/kernel/head_44x.S       | 10 ----------
 arch/powerpc/kernel/head_8xx.S       |  4 ----
 arch/powerpc/kernel/head_fsl_booke.S | 10 ----------
 arch/powerpc/kernel/misc_64.S        | 13 -------------
 arch/powerpc/kernel/ppc_ksyms.c      |  2 ++
 arch/powerpc/kernel/process.c        |  2 ++
 arch/powerpc/kernel/signal_64.c      |  2 --
 arch/powerpc/math-emu/math.c         |  3 +--
 10 files changed, 13 insertions(+), 52 deletions(-)

-- 
1.8.1.4
