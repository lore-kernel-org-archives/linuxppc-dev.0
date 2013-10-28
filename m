Return-Path: <lists@nerdbynature.de>
Received: from trent.utfs.org (trent.utfs.org [94.185.90.103])
 by ozlabs.org (Postfix) with ESMTP id 3E45D2C00A4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Oct 2013 23:51:41 +1100 (EST)
Date: Mon, 28 Oct 2013 05:51:36 -0700 (PDT)
From: Christian Kujau <lists@nerdbynature.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] warning: symbol value 'm' invalid for MCU_MPC8349EMITX
Message-ID: <alpine.DEB.2.11.1310280542150.31521@trent.utfs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

during "make ppc6xx_defconfig" the following happens:

  HOSTCC  scripts/basic/fixdep
  GEN     /usr/local/src/tmp/lnx/Makefile
  HOSTCC  scripts/kconfig/conf.o
  HOSTCC  scripts/kconfig/zconf.tab.o
  HOSTLD  scripts/kconfig/conf
arch/powerpc/configs/ppc6xx_defconfig:74:warning: symbol value 'm' invalid for MCU_MPC8349EMITX


Setting CONFIG_MCU_MPC8349EMITX=y in ppc6xx_defconfig makes the warning 
go away. This too has been reported by Geert Uytterhoeven a long time ago:
https://lkml.org/lkml/2011/11/13/11  - I only came across this because I 
needed a "clean" defconfig for this Powerbook G5.

 Signed-off-by: Christian Kujau <lists@nerdbynature.de>

diff --git a/arch/powerpc/configs/ppc6xx_defconfig b/arch/powerpc/configs/ppc6xx_defconfig
index 20ebfaf..c2353bf 100644
--- a/arch/powerpc/configs/ppc6xx_defconfig
+++ b/arch/powerpc/configs/ppc6xx_defconfig
@@ -71,7 +71,7 @@ CONFIG_QUICC_ENGINE=y
 CONFIG_QE_GPIO=y
 CONFIG_PPC_BESTCOMM=y
 CONFIG_GPIO_MPC8XXX=y
-CONFIG_MCU_MPC8349EMITX=m
+CONFIG_MCU_MPC8349EMITX=y
 CONFIG_HIGHMEM=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y



Christian.
-- 
BOFH excuse #312:

incompatible bit-registration operators
