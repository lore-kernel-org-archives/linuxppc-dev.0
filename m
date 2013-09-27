Return-Path: <gsi@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 9E4752C019C
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Sep 2013 01:29:05 +1000 (EST)
From: Gerhard Sittig <gsi@denx.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1] powerpc/mpc512x: silence build warning upon disabled DIU
Date: Fri, 27 Sep 2013 17:28:38 +0200
Message-Id: <1380295718-10700-1-git-send-email-gsi@denx.de>
Cc: Gerhard Sittig <gsi@denx.de>, Anatolij Gustschin <agust@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

a disabled Kconfig option results in a reference to a not implemented
routine when the IS_ENABLED() macro is used for both conditional
implementation of the routine as well as a C language source code test
at the call site -- the "if (0) func();" construct only gets eliminated
later by the optimizer, while the compiler already has emitted its
warning about "func()" being undeclared

provide an empty implementation for the mpc512x_setup_diu() and
mpc512x_init_diu() routines in case of the disabled option, to avoid the
compiler warning which is considered fatal and breaks compilation

the bug appeared with commit 2abbbb63c90ab55ca3f054772c2e5ba7df810c48
"powerpc/mpc512x: move common code to shared.c file", how to reproduce:

  make mpc512x_defconfig
  echo CONFIG_FB_FSL_DIU=n >> .config && make olddefconfig
  make

    CC      arch/powerpc/platforms/512x/mpc512x_shared.o
  .../arch/powerpc/platforms/512x/mpc512x_shared.c: In function 'mpc512x_init_early':
  .../arch/powerpc/platforms/512x/mpc512x_shared.c:456:3: error: implicit declaration of function 'mpc512x_init_diu' [-Werror=implicit-function-declaration]
  .../arch/powerpc/platforms/512x/mpc512x_shared.c: In function 'mpc512x_setup_arch':
  .../arch/powerpc/platforms/512x/mpc512x_shared.c:469:3: error: implicit declaration of function 'mpc512x_setup_diu' [-Werror=implicit-function-declaration]
  cc1: all warnings being treated as errors
  make[4]: *** [arch/powerpc/platforms/512x/mpc512x_shared.o] Error 1

Signed-off-by: Gerhard Sittig <gsi@denx.de>
CC: <stable@vger.kernel.org> # v3.11
---
 arch/powerpc/platforms/512x/mpc512x_shared.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/platforms/512x/mpc512x_shared.c b/arch/powerpc/platforms/512x/mpc512x_shared.c
index a82a41b..1a7b1d0 100644
--- a/arch/powerpc/platforms/512x/mpc512x_shared.c
+++ b/arch/powerpc/platforms/512x/mpc512x_shared.c
@@ -303,6 +303,9 @@ void __init mpc512x_setup_diu(void)
 	diu_ops.release_bootmem		= mpc512x_release_bootmem;
 }
 
+#else
+void __init mpc512x_setup_diu(void) { /* EMPTY */ }
+void __init mpc512x_init_diu(void) { /* EMPTY */ }
 #endif
 
 void __init mpc512x_init_IRQ(void)
-- 
1.7.10.4
