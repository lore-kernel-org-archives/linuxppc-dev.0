Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id BF1FEDDE1C
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Oct 2007 13:32:49 +1000 (EST)
Date: Fri, 19 Oct 2007 22:39:26 -0500
From: Olof Johansson <olof@lixom.net>
To: galak@kernel.crashing.org
Subject: [PATCH] fix build break in arch/ppc/syslib/m8260_setup.c
Message-ID: <20071020033926.GA21952@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Fix build break and warnings in current mainline git:

arch/ppc/syslib/m8260_setup.c: In function 'm8260_setup_arch':
arch/ppc/syslib/m8260_setup.c:63: error: implicit declaration of function 'identify_ppc_sys_by_name_and_id'
arch/ppc/syslib/m8260_setup.c:64: warning: passing argument 1 of 'in_be32' makes pointer from integer without a cast
arch/ppc/syslib/m8260_setup.c: In function 'm8260_show_cpuinfo':
arch/ppc/syslib/m8260_setup.c:158: warning: format '%08x' expects type 'unsigned int', but argument 5 has type 'long unsigned int'
arch/ppc/syslib/m8260_setup.c:158: warning: format '%d' expects type 'int', but argument 6 has type 'long unsigned int'
arch/ppc/syslib/m8260_setup.c:158: warning: format '%u' expects type 'unsigned int', but argument 7 has type 'long unsigned int'
arch/ppc/syslib/m8260_setup.c:158: warning: format '%u' expects type 'unsigned int', but argument 8 has type 'long unsigned int'
arch/ppc/syslib/m8260_setup.c:158: warning: format '%u' expects type 'unsigned int', but argument 9 has type 'long unsigned int'
make[1]: *** [arch/ppc/syslib/m8260_setup.o] Error 1
make[1]: *** Waiting for unfinished jobs....


Signed-off-by: Olof Johansson <olof@lixom.net>


diff --git a/arch/ppc/syslib/m8260_setup.c b/arch/ppc/syslib/m8260_setup.c
index 15f0d73..46588fa 100644
--- a/arch/ppc/syslib/m8260_setup.c
+++ b/arch/ppc/syslib/m8260_setup.c
@@ -25,6 +25,7 @@
 #include <asm/machdep.h>
 #include <asm/bootinfo.h>
 #include <asm/time.h>
+#include <asm/ppc_sys.h>
 
 #include "cpm2_pic.h"
 
@@ -61,7 +62,7 @@ m8260_setup_arch(void)
 #endif
 
 	identify_ppc_sys_by_name_and_id(BOARD_CHIP_NAME,
-				in_be32(CPM_MAP_ADDR + CPM_IMMR_OFFSET));
+			in_be32((void *)CPM_MAP_ADDR + CPM_IMMR_OFFSET));
 
 	m82xx_board_setup();
 }
@@ -147,12 +148,12 @@ m8260_show_cpuinfo(struct seq_file *m)
 	seq_printf(m, "vendor\t\t: %s\n"
 		   "machine\t\t: %s\n"
 		   "\n"
-		   "mem size\t\t: 0x%08x\n"
-		   "console baud\t\t: %d\n"
+		   "mem size\t\t: 0x%08lx\n"
+		   "console baud\t\t: %ld\n"
 		   "\n"
-		   "core clock\t: %u MHz\n"
-		   "CPM  clock\t: %u MHz\n"
-		   "bus  clock\t: %u MHz\n",
+		   "core clock\t: %lu MHz\n"
+		   "CPM  clock\t: %lu MHz\n"
+		   "bus  clock\t: %lu MHz\n",
 		   CPUINFO_VENDOR, CPUINFO_MACHINE, bp->bi_memsize,
 		   bp->bi_baudrate, bp->bi_intfreq / 1000000,
 		   bp->bi_cpmfreq / 1000000, bp->bi_busfreq / 1000000);
