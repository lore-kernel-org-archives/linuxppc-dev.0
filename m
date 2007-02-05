Return-Path: <darwish.07@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.168])
	by ozlabs.org (Postfix) with ESMTP id 05142DDE28
	for <linuxppc-dev@ozlabs.org>; Mon,  5 Feb 2007 13:43:13 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so1053533ugf
	for <linuxppc-dev@ozlabs.org>; Sun, 04 Feb 2007 18:43:11 -0800 (PST)
Date: Mon, 5 Feb 2007 04:42:58 +0200
To: paulus@samba.org, linuxppc-dev@ozlabs.org
Subject: [PATCH 2.6.20] arch PowerPC: user ARRAY_SIZE macro when appropriate
Message-ID: <20070205024258.GM18118@Ahmed>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070205023935.GG18118@Ahmed>
From: "Ahmed S. Darwish" <darwish.07@gmail.com>
Cc: linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,

A patch to use ARRAY_SIZE macro already defined in linux/kernel.h

Signed-off-by: Ahmed S. Darwish <darwish.07@gmail.com>
---
Patch isn't compile checked cause I have no PowerPC machine at hand.
Thanks,

diff --git a/arch/powerpc/lib/rheap.c b/arch/powerpc/lib/rheap.c
index 57bf991..54b7b2b 100644
--- a/arch/powerpc/lib/rheap.c
+++ b/arch/powerpc/lib/rheap.c
@@ -14,6 +14,7 @@
  */
 #include <linux/types.h>
 #include <linux/errno.h>
+#include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
 
@@ -670,7 +671,7 @@ void rh_dump(rh_info_t * info)
 	int maxnr;
 	int i, nr;
 
-	maxnr = sizeof(st) / sizeof(st[0]);
+	maxnr = ARRAY_SIZE(st);
 
 	printk(KERN_INFO
 	       "info @0x%p (%d slots empty / %d max)\n",
diff --git a/arch/powerpc/xmon/ppc-opc.c b/arch/powerpc/xmon/ppc-opc.c
index 5d841f4..af3780e 100644
--- a/arch/powerpc/xmon/ppc-opc.c
+++ b/arch/powerpc/xmon/ppc-opc.c
@@ -21,6 +21,7 @@
    02110-1301, USA.  */
 
 #include <linux/stddef.h>
+#include <linux/kernel.h>
 #include "nonstdio.h"
 #include "ppc.h"
 
@@ -4932,8 +4933,7 @@ const struct powerpc_opcode powerpc_opcodes[] = {
 
 };
 
-const int powerpc_num_opcodes =
-  sizeof (powerpc_opcodes) / sizeof (powerpc_opcodes[0]);
+const int powerpc_num_opcodes = ARRAY_SIZE(powerpc_opcodes);
 
 /* The macro table.  This is only used by the assembler.  */
 
@@ -4989,5 +4989,4 @@ const struct powerpc_macro powerpc_macros[] = {
 { "clrlslwi.",4,  PPCCOM,	"rlwinm. %0,%1,%3,(%2)-(%3),31-(%3)" },
 };
 
-const int powerpc_num_macros =
-  sizeof (powerpc_macros) / sizeof (powerpc_macros[0]);
+const int powerpc_num_macros = ARRAY_SIZE(powerpc_macros);
diff --git a/arch/powerpc/xmon/spu-opc.c b/arch/powerpc/xmon/spu-opc.c
index efffde9..530df3d 100644
--- a/arch/powerpc/xmon/spu-opc.c
+++ b/arch/powerpc/xmon/spu-opc.c
@@ -18,6 +18,7 @@
    with this program; if not, write to the Free Software Foundation, Inc.,
    51 Franklin Street - Fifth Floor, Boston, MA 02110-1301, USA.  */
 
+#include <linux/kernel.h>
 #include "spu.h"
 
 /* This file holds the Spu opcode table */
@@ -40,5 +41,4 @@ const struct spu_opcode spu_opcodes[] = {
 #undef APUOPFB
 };
 
-const int spu_num_opcodes =
-  sizeof (spu_opcodes) / sizeof (spu_opcodes[0]);
+const int spu_num_opcodes = ARRAY_SIZE(spu_opcodes);


-- 
Ahmed S. Darwish
http://darwish-07.blogspot.com
