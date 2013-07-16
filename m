Return-Path: <haokexin@gmail.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4A0582C0173
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jul 2013 21:58:04 +1000 (EST)
From: Kevin Hao <haokexin@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Scott Wood
 <scottwood@freescale.com>
Subject: [PATCH 2/2] powerpc/mpc85xx: only emulate the unimplemented FP
 instructions on corenet64
Date: Tue, 16 Jul 2013 19:57:16 +0800
Message-ID: <1373975836-11928-3-git-send-email-haokexin@gmail.com>
In-Reply-To: <1373975836-11928-1-git-send-email-haokexin@gmail.com>
References: <1373975836-11928-1-git-send-email-haokexin@gmail.com>
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

We have split the math emulation into two parts. This makes it
possible to just emulate the unimplemented floating point instructions
on these boards.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 arch/powerpc/configs/corenet64_smp_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/configs/corenet64_smp_defconfig b/arch/powerpc/configs/corenet64_smp_defconfig
index b5408dc..39843ef 100644
--- a/arch/powerpc/configs/corenet64_smp_defconfig
+++ b/arch/powerpc/configs/corenet64_smp_defconfig
@@ -28,6 +28,7 @@ CONFIG_T4240_QDS=y
 # CONFIG_PPC_OF_BOOT_TRAMPOLINE is not set
 CONFIG_BINFMT_MISC=m
 CONFIG_MATH_EMULATION=y
+CONFIG_MATH_EMULATION_HW_UNIMPLEMENTED=y
 CONFIG_FSL_IFC=y
 CONFIG_PCIEPORTBUS=y
 CONFIG_PCI_MSI=y
-- 
1.8.1.4
