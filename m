To: linuxppc-dev@lists.linuxppc.org
Subject: PATCH: small 2.4-benh SMP fix
From: Lars Brinkhoff <lars.spam@nocrew.org>
Date: 10 Apr 2001 03:07:24 +0200
In-Reply-To: <20010409232808.8FEE62EFAF@apollo.valhalla.net>
Message-ID: <85y9t9sgtv.fsf@junk.nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Suggest following patch against linux-2.4-benh to fix errors
(BEGIN/END_FTR_SECTION undefined) and warnings (CONFIG_PPC601_SYNC_FIX
redefined) when compilning an SMP kernel:

--- arch/ppc/kernel/ppc_asm.h~	Tue Apr 10 02:59:04 2001
+++ arch/ppc/kernel/ppc_asm.h	Tue Apr 10 03:00:04 2001
@@ -12,6 +12,7 @@
  */

 #include <linux/config.h>
+#include <asm/cputable.h>

 #include "ppc_asm.tmpl"
 #include "ppc_defs.h"
@@ -66,7 +67,9 @@
 #define REST_16VR(n,b,base)	REST_8VR(n,b,base); REST_8VR(n+8,b,base)
 #define REST_32VR(n,b,base)	REST_16VR(n,b,base); REST_16VR(n+16,b,base)

+#ifndef CONFIG_PPC601_SYNC_FIX
 #define CONFIG_PPC601_SYNC_FIX
+#endif
 #ifdef CONFIG_PPC601_SYNC_FIX
 #define SYNC BEGIN_FTR_SECTION()  \
 	sync; \

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
