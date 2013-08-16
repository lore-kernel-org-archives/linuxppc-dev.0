Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 019E42C01B3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Aug 2013 10:05:52 +1000 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id r7G05me3020617
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Aug 2013 19:05:49 -0500
Message-ID: <1376611546.4255.120.camel@pasglop>
Subject: [PATCH] powerpc/powernv: Return secondary CPUs to firmware on kexec
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Fri, 16 Aug 2013 10:05:46 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With OPAL v3 we can return secondary CPUs to firmware on kexec. This
allows firmware to do various cleanups making things generally more
reliable, and will enable the "new" kernel to call OPAL to perform
some reconfiguration tasks early on that can only be done while
all the CPUs are in firmware.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index d4459bf..b59a1da 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -31,6 +31,7 @@
 #include <asm/xics.h>
 #include <asm/rtas.h>
 #include <asm/opal.h>
+#include <asm/kexec.h>
 
 #include "powernv.h"
 
@@ -143,6 +144,16 @@ static void pnv_shutdown(void)
 static void pnv_kexec_cpu_down(int crash_shutdown, int secondary)
 {
 	xics_kexec_teardown_cpu(secondary);
+
+	/* Return secondary CPUs to firmware on OPAL v3 */
+	if (firmware_has_feature(FW_FEATURE_OPALv3) && secondary) {
+		mb();
+		get_paca()->kexec_state = KEXEC_STATE_REAL_MODE;
+		mb();
+
+		/* Return the CPU to OPAL */
+		opal_return_cpu();
+	}
 }
 #endif /* CONFIG_KEXEC */
 
