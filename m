Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xRXx80ynNzDqpW
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Aug 2017 21:58:52 +1000 (AEST)
Message-Id: <b61cc801a3cfe23ccfe8f66249ef129ba178bbda.1502191399.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1502191399.git.christophe.leroy@c-s.fr>
References: <cover.1502191399.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 05/12] powerpc/8xx: Move mpc8xx_pic.c from sysdev to
 platform/8xx
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue,  8 Aug 2017 13:58:48 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

mpc8xx_pic.c is dedicated to the 8xx, so move it to platform/8xx

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/platforms/8xx/Makefile                       | 2 +-
 arch/powerpc/platforms/8xx/m8xx_setup.c                   | 2 +-
 arch/powerpc/{sysdev/mpc8xx_pic.c => platforms/8xx/pic.c} | 2 +-
 arch/powerpc/{sysdev/mpc8xx_pic.h => platforms/8xx/pic.h} | 0
 arch/powerpc/sysdev/Makefile                              | 1 -
 5 files changed, 3 insertions(+), 4 deletions(-)
 rename arch/powerpc/{sysdev/mpc8xx_pic.c => platforms/8xx/pic.c} (99%)
 rename arch/powerpc/{sysdev/mpc8xx_pic.h => platforms/8xx/pic.h} (100%)

diff --git a/arch/powerpc/platforms/8xx/Makefile b/arch/powerpc/platforms/8xx/Makefile
index 756be8345868..f9af3218bd9c 100644
--- a/arch/powerpc/platforms/8xx/Makefile
+++ b/arch/powerpc/platforms/8xx/Makefile
@@ -1,7 +1,7 @@
 #
 # Makefile for the PowerPC 8xx linux kernel.
 #
-obj-y			+= m8xx_setup.o machine_check.o
+obj-y			+= m8xx_setup.o machine_check.o pic.o
 obj-$(CONFIG_MPC885ADS)   += mpc885ads_setup.o
 obj-$(CONFIG_MPC86XADS)   += mpc86xads_setup.o
 obj-$(CONFIG_PPC_EP88XC)  += ep88xc.o
diff --git a/arch/powerpc/platforms/8xx/m8xx_setup.c b/arch/powerpc/platforms/8xx/m8xx_setup.c
index f81069f79a94..1917d69f84df 100644
--- a/arch/powerpc/platforms/8xx/m8xx_setup.c
+++ b/arch/powerpc/platforms/8xx/m8xx_setup.c
@@ -23,7 +23,7 @@
 #include <asm/fs_pd.h>
 #include <mm/mmu_decl.h>
 
-#include <sysdev/mpc8xx_pic.h>
+#include "pic.h"
 
 #include "mpc8xx.h"
 
diff --git a/arch/powerpc/sysdev/mpc8xx_pic.c b/arch/powerpc/platforms/8xx/pic.c
similarity index 99%
rename from arch/powerpc/sysdev/mpc8xx_pic.c
rename to arch/powerpc/platforms/8xx/pic.c
index 2842f9d63d21..8d5a25d43ef3 100644
--- a/arch/powerpc/sysdev/mpc8xx_pic.c
+++ b/arch/powerpc/platforms/8xx/pic.c
@@ -9,7 +9,7 @@
 #include <asm/io.h>
 #include <asm/8xx_immap.h>
 
-#include "mpc8xx_pic.h"
+#include "pic.h"
 
 
 #define PIC_VEC_SPURRIOUS      15
diff --git a/arch/powerpc/sysdev/mpc8xx_pic.h b/arch/powerpc/platforms/8xx/pic.h
similarity index 100%
rename from arch/powerpc/sysdev/mpc8xx_pic.h
rename to arch/powerpc/platforms/8xx/pic.h
diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index ff80780a2568..79416fa2e3ba 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -45,7 +45,6 @@ obj-$(CONFIG_CPM1)		+= cpm1.o
 obj-$(CONFIG_CPM2)		+= cpm2.o cpm2_pic.o
 obj-$(CONFIG_QUICC_ENGINE)	+= cpm_common.o
 obj-$(CONFIG_PPC_DCR)		+= dcr.o
-obj-$(CONFIG_PPC_8xx)		+= mpc8xx_pic.o
 obj-$(CONFIG_UCODE_PATCH)	+= micropatch.o
 
 obj-$(CONFIG_PPC_MPC512x)	+= mpc5xxx_clocks.o
-- 
2.13.3
