Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yLnmh60j0zDqZ3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Oct 2017 20:20:20 +1100 (AEDT)
From: Michael Neuling <mikey@neuling.org>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, mikey@neuling.org, benh@kernel.crashing.org,
 anton@ozlabs.org, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Vipin K Parashar <vipin@linux.vnet.ibm.com>
Subject: [PATCH] powernv: Avoid checkstop on HMI and MCE
Date: Tue, 24 Oct 2017 20:20:05 +1100
Message-Id: <20171024092005.3861-1-mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On an unrecoverable HMI or MCE only generate an checkstop (via
PLATFORM ERROR opal reboot call) when panic_on_oops is set.

We currently generate an checkstop as an attempt for the FSP to grab a
dump and then reboot us. Unfortunately this never works and no one
I've talked to has ever seen a resulting dump, let alone got useful
information from it.

Even worse, the checkstop gets in the way of debugging real
problems. If we hit a software bug that results in this, we get no
opportunity to debug it live. Similarly if the bug is due to hardware
that is not in the dump (say PCI or NVLINK GPU), we get no information
in the dump about that hardware.

So let's remove it unless someone sets panic_on_oops.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/platforms/powernv/opal-hmi.c | 6 ++++++
 arch/powerpc/platforms/powernv/opal.c     | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/opal-hmi.c b/arch/powerpc/platforms/powernv/opal-hmi.c
index c9e1a4ff29..23780970d0 100644
--- a/arch/powerpc/platforms/powernv/opal-hmi.c
+++ b/arch/powerpc/platforms/powernv/opal-hmi.c
@@ -29,6 +29,7 @@
 #include <asm/opal.h>
 #include <asm/cputable.h>
 #include <asm/machdep.h>
+#include <asm/bug.h>
 
 #include "powernv.h"
 
@@ -284,6 +285,11 @@ static void hmi_event_handler(struct work_struct *work)
 			print_hmi_event_info(hmi_evt);
 		}
 
+		if (!panic_on_oops) {
+			die("Unrecoverable HMI exception", NULL, SIGBUS);
+			return;
+		}
+
 		pnv_platform_error_reboot(NULL, "Unrecoverable HMI exception");
 	}
 }
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 65c79ecf5a..f208f222e4 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -523,6 +523,10 @@ int opal_machine_check(struct pt_regs *regs)
 	if (opal_recover_mce(regs, &evt))
 		return 1;
 
+	if (!panic_on_oops) {
+		die("Unrecoverable Machine check", regs, SIGBUS);
+		return 0;
+	}
 	pnv_platform_error_reboot(regs, "Unrecoverable Machine Check exception");
 }
 
-- 
2.14.1
