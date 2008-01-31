Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A5827DDED8
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Feb 2008 05:17:32 +1100 (EST)
Date: Thu, 31 Jan 2008 11:36:56 -0600
From: Scott Wood <scottwood@freescale.com>
To: galak@kernel.crashing.org
Subject: [PATCH] adder875, ep88xc: fix to match recent 8xx cleanups.
Message-ID: <20080131173656.GA10385@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

asm/commproc.h was renamed to asm/cpm1.h
sysdev/commproc.h was renamed to platforms/8xx/mpc8xx.h
m8xx_pic_init was renamed to mpc8xx_pics_init

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/platforms/8xx/adder875.c |    6 +++---
 arch/powerpc/platforms/8xx/ep88xc.c   |    1 -
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/8xx/adder875.c b/arch/powerpc/platforms/8xx/adder875.c
index c6bc078..82363e9 100644
--- a/arch/powerpc/platforms/8xx/adder875.c
+++ b/arch/powerpc/platforms/8xx/adder875.c
@@ -15,12 +15,12 @@
 
 #include <asm/time.h>
 #include <asm/machdep.h>
-#include <asm/commproc.h>
+#include <asm/cpm1.h>
 #include <asm/fs_pd.h>
 #include <asm/udbg.h>
 #include <asm/prom.h>
 
-#include <sysdev/commproc.h>
+#include "mpc8xx.h"
 
 struct cpm_pin {
 	int port, pin, flags;
@@ -108,7 +108,7 @@ define_machine(adder875) {
 	.name = "Adder MPC875",
 	.probe = adder875_probe,
 	.setup_arch = adder875_setup,
-	.init_IRQ = m8xx_pic_init,
+	.init_IRQ = mpc8xx_pics_init,
 	.get_irq = mpc8xx_get_irq,
 	.restart = mpc8xx_restart,
 	.calibrate_decr = generic_calibrate_decr,
diff --git a/arch/powerpc/platforms/8xx/ep88xc.c b/arch/powerpc/platforms/8xx/ep88xc.c
index a8dffa0..7d9ac60 100644
--- a/arch/powerpc/platforms/8xx/ep88xc.c
+++ b/arch/powerpc/platforms/8xx/ep88xc.c
@@ -15,7 +15,6 @@
 #include <asm/machdep.h>
 #include <asm/io.h>
 #include <asm/udbg.h>
-#include <asm/commproc.h>
 #include <asm/cpm1.h>
 
 #include "mpc8xx.h"
-- 
1.5.3.8
