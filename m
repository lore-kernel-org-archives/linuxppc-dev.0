Return-Path: <B04825@freescale.com>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe005.messaging.microsoft.com [213.199.154.143])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A03F8B6F13
 for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2012 09:41:18 +1100 (EST)
From: Timur Tabi <timur@freescale.com>
To: <galak@kernel.crashing.org>, <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc/epapr: add "memory" as a clobber to all hypercalls
Date: Thu, 15 Mar 2012 17:41:02 -0500
Message-ID: <1331851262-1806-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The "memory" clobber tells the compiler to ensure that all writes to memory
are committed before the hypercall is made.

"memory" is only necessary for hcalls where the Hypervisor will read or
write guest memory. However, we add it to all hcalls because the impact is
minimal, and we want to ensure that it's present for the hcalls that need it.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 arch/powerpc/include/asm/epapr_hcalls.h |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/epapr_hcalls.h b/arch/powerpc/include/asm/epapr_hcalls.h
index f3b0c2c..976835d 100644
--- a/arch/powerpc/include/asm/epapr_hcalls.h
+++ b/arch/powerpc/include/asm/epapr_hcalls.h
@@ -134,10 +134,15 @@
  * whether they will be clobbered.
  *
  * Note that r11 can be used as an output parameter.
+ *
+ * The "memory" clobber is only necessary for hcalls where the Hypervisor
+ * will read or write guest memory. However, we add it to all hcalls because
+ * the impact is minimal, and we want to ensure that it's present for the
+ * hcalls that need it.
 */
 
 /* List of common clobbered registers.  Do not use this macro. */
-#define EV_HCALL_CLOBBERS "r0", "r12", "xer", "ctr", "lr", "cc"
+#define EV_HCALL_CLOBBERS "r0", "r12", "xer", "ctr", "lr", "cc", "memory"
 
 #define EV_HCALL_CLOBBERS8 EV_HCALL_CLOBBERS
 #define EV_HCALL_CLOBBERS7 EV_HCALL_CLOBBERS8, "r10"
-- 
1.7.3.4
