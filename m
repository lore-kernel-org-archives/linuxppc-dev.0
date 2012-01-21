Return-Path: <paul.gortmaker@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9A5E91007D1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Jan 2012 01:52:27 +1100 (EST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: galak@kernel.crashing.org
Subject: [PATCH] powerpc/85xx: fix build failure from p1022 in SMP defconfig
Date: Sat, 21 Jan 2012 09:52:08 -0500
Message-Id: <1327157528-12312-1-git-send-email-paul.gortmaker@windriver.com>
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 Paul Gortmaker <paul.gortmaker@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Using the configs/mpc85xx_smp_defconfig shows this build error:

arch/powerpc/platforms/85xx/p1022_ds.c:341: error: 'udbg_progress' undeclared here (not in a function)

Adding in the obvious missing header <asm/udbg.h> fixes it.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

diff --git a/arch/powerpc/platforms/85xx/p1022_ds.c b/arch/powerpc/platforms/85xx/p1022_ds.c
index bb3d84f..aa4022e 100644
--- a/arch/powerpc/platforms/85xx/p1022_ds.c
+++ b/arch/powerpc/platforms/85xx/p1022_ds.c
@@ -26,6 +26,7 @@
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
 #include <asm/fsl_guts.h>
+#include <asm/udbg.h>
 #include "smp.h"
 
 #include "mpc85xx.h"
-- 
1.7.7.2
