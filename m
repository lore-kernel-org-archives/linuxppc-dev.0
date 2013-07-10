Return-Path: <haokexin@gmail.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BA9202C008E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jul 2013 11:51:37 +1000 (EST)
From: Kevin Hao <haokexin@gmail.com>
To: Kumar Gala <galak@kernel.crashing.org>, Scott Wood
 <scottwood@freescale.com>
Subject: [PATCH] powerpc/85xx: enable the math emulation for the
 corenet64_smp_defconfig
Date: Wed, 10 Jul 2013 09:49:52 +0800
Message-ID: <1373420992-25167-1-git-send-email-haokexin@gmail.com>
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

I got the following error on my t4240qds board.
  ntpd[2713]: unhandled signal 4 at 0fd5b448 nip 0fd5b448 lr 0fd5b424 code 30001

The root cause is that the float point instruction 'fsqrt' is used.
But this instruction is not implemented on e6500 core. Even this
does seem a gcc bug, I would like to enable the math emulation
in the kernel to workaround this kind of issue.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 arch/powerpc/configs/corenet64_smp_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/configs/corenet64_smp_defconfig b/arch/powerpc/configs/corenet64_smp_defconfig
index 6c8b020..b5408dc 100644
--- a/arch/powerpc/configs/corenet64_smp_defconfig
+++ b/arch/powerpc/configs/corenet64_smp_defconfig
@@ -27,6 +27,7 @@ CONFIG_P5040_DS=y
 CONFIG_T4240_QDS=y
 # CONFIG_PPC_OF_BOOT_TRAMPOLINE is not set
 CONFIG_BINFMT_MISC=m
+CONFIG_MATH_EMULATION=y
 CONFIG_FSL_IFC=y
 CONFIG_PCIEPORTBUS=y
 CONFIG_PCI_MSI=y
-- 
1.8.1.4
