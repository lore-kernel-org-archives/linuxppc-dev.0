Return-Path: <haokexin@gmail.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4A01A2C014C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jul 2013 21:58:04 +1000 (EST)
From: Kevin Hao <haokexin@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Scott Wood
 <scottwood@freescale.com>
Subject: [PATCH 0/2] powerpc: split the match emulation into two parts
Date: Tue, 16 Jul 2013 19:57:14 +0800
Message-ID: <1373975836-11928-1-git-send-email-haokexin@gmail.com>
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

On some FSL BookE cores (such as e500mc, e5500 and e6500) there does have
a FPU. But some floating point instructions are not supported by the FPU.
Introduce a kernel option so we can make the kernel only support to
emulate these unimplemented instructions. This will definitely reduce
the footprint of the kernel. And it also trim down the kernel build time
a little as predicted by Scott.

Before the patch:
  Name          Size     
  .text         00618948

After the patch:
  Name          Size     
  .text         00605328 


The kernel build time(I have reboot the build server before each kernel build)
Before the patch:
  real    2m29.653s
  user    10m21.776s
  sys     0m32.832s

After the patch:
  real    2m27.767s
  user    10m11.808s
  sys     0m32.717s

Kevin Hao (2):
  powerpc: split the math emulation into two parts
  powerpc/mpc85xx: only emulate the unimplemented FP instructions on    
    corenet64

 arch/powerpc/Kconfig                         | 20 ++++++++++++++++++++
 arch/powerpc/configs/corenet64_smp_defconfig |  1 +
 arch/powerpc/math-emu/Makefile               | 24 ++++++++++++------------
 arch/powerpc/math-emu/math.c                 | 20 ++++++++++++++------
 4 files changed, 47 insertions(+), 18 deletions(-)

-- 
1.8.1.4
