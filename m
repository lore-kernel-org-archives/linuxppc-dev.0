Return-Path: <darwish.07@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.168])
	by ozlabs.org (Postfix) with ESMTP id 3698ADDE28
	for <linuxppc-dev@ozlabs.org>; Mon,  5 Feb 2007 13:43:29 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so1053533ugf
	for <linuxppc-dev@ozlabs.org>; Sun, 04 Feb 2007 18:43:29 -0800 (PST)
Date: Mon, 5 Feb 2007 04:43:16 +0200
To: paulus@samba.org, linuxppc-dev@ozlabs.org
Subject: [PATCH 2.6.20] arch PPC: user ARRAY_SIZE macro when appropriate
Message-ID: <20070205024316.GN18118@Ahmed>
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

diff --git a/arch/ppc/lib/rheap.c b/arch/ppc/lib/rheap.c
index 31e5118..d407007 100644
--- a/arch/ppc/lib/rheap.c
+++ b/arch/ppc/lib/rheap.c
@@ -14,6 +14,7 @@
  */
 #include <linux/types.h>
 #include <linux/errno.h>
+#include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
 
@@ -654,7 +655,7 @@ void rh_dump(rh_info_t * info)
 	int maxnr;
 	int i, nr;
 
-	maxnr = sizeof(st) / sizeof(st[0]);
+	maxnr = ARRAY_SIZE(st);
 
 	printk(KERN_INFO
 	       "info @0x%p (%d slots empty / %d max)\n",
diff --git a/arch/ppc/syslib/m8xx_setup.c b/arch/ppc/syslib/m8xx_setup.c
index d8d299b..01e48d8 100644
--- a/arch/ppc/syslib/m8xx_setup.c
+++ b/arch/ppc/syslib/m8xx_setup.c
@@ -77,7 +77,7 @@ static struct mtd_partition mpc8xxads_partitions[] = {
 	}
 };
 
-#define mpc8xxads_part_num (sizeof (mpc8xxads_partitions) / sizeof (mpc8xxads_partitions[0]))
+#define mpc8xxads_part_num ARRAY_SIZE(mpc8xxads_partitions)
 
 #endif
 
diff --git a/arch/ppc/xmon/ppc-opc.c b/arch/ppc/xmon/ppc-opc.c
index 533a6c9..034313c 100644
--- a/arch/ppc/xmon/ppc-opc.c
+++ b/arch/ppc/xmon/ppc-opc.c
@@ -19,6 +19,7 @@ along with this file; see the file COPYING.  If not, write to the Free
 Software Foundation, 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.  */
 
 #include <linux/posix_types.h>
+#include <linux/kernel.h>
 #include "ansidecl.h"
 #include "ppc.h"
 
@@ -2669,8 +2670,7 @@ const struct powerpc_opcode powerpc_opcodes[] = {
 
 };
 
-const int powerpc_num_opcodes =
-  sizeof (powerpc_opcodes) / sizeof (powerpc_opcodes[0]);
+const int powerpc_num_opcodes = ARRAY_SIZE(powerpc_opcodes);
 
 /* The macro table.  This is only used by the assembler.  */
 
@@ -2717,5 +2717,4 @@ const struct powerpc_macro powerpc_macros[] = {
 
 };
 
-const int powerpc_num_macros =
-  sizeof (powerpc_macros) / sizeof (powerpc_macros[0]);
+const int powerpc_num_macros = ARRAY_SIZE(powerpc_macros);

-- 
Ahmed S. Darwish
http://darwish-07.blogspot.com
