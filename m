Subject: [PATCH] make platform_init() weak for 8xx
From: Andreas Oberritter <obi@saftware.de>
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Content-Type: multipart/mixed; boundary="=-b8NPSJsBFC4Vg+gq4g8T"
Message-Id: <1090253615.1415.24.camel@shiva.saftware.de>
Mime-Version: 1.0
Date: Mon, 19 Jul 2004 18:13:35 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--=-b8NPSJsBFC4Vg+gq4g8T
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Tom,

this patch renames platform_init to m8xx_init in m8xx_setup.c and adds
new weak platform_init, which can be overridden by boards to allow them
to e.g. register platform_devices like redwood5.c does for 40x.

Signed-off-by: Andreas Oberritter <obi@saftware.de>

--=-b8NPSJsBFC4Vg+gq4g8T
Content-Disposition: attachment; filename=m8xx_setup.diff
Content-Type: text/x-patch; name=m8xx_setup.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

===== arch/ppc/syslib/m8xx_setup.c 1.29 vs edited =====
--- 1.29/arch/ppc/syslib/m8xx_setup.c	2004-05-28 00:37:33 +02:00
+++ edited/arch/ppc/syslib/m8xx_setup.c	2004-07-19 17:54:03 +02:00
@@ -47,6 +47,7 @@
 #include <asm/xmon.h>

 #include "ppc8xx_pic.h"
+#include "m8xx_setup.h"

 static int m8xx_set_rtc_time(unsigned long time);
 static unsigned long m8xx_get_rtc_time(void);
@@ -363,7 +364,7 @@
 }

 void __init
-platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
+m8xx_init(unsigned long r3, unsigned long r4, unsigned long r5,
 		unsigned long r6, unsigned long r7)
 {
 	parse_bootinfo(find_bootinfo());
@@ -413,3 +414,11 @@
 	m8xx_ide_init();
 #endif
 }
+
+void __init __attribute__ ((weak))
+platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
+		unsigned long r6, unsigned long r7)
+{
+	m8xx_init(r3, r4, r5, r6, r7);
+}
+
--- /dev/null	2004-07-17 13:36:50.945552208 +0200
+++ edited/arch/ppc/syslib/m8xx_setup.h	2004-07-19 17:15:37.854994064 +0200
@@ -0,0 +1,12 @@
+/*
+ * arch/ppc/syslib/m8xx_setup.h
+ */
+
+#ifndef _PPC_SYSLIB_M8XX_SETUP_H
+#define _PPC_SYSLIB_M8XX_SETUP_H
+
+void m8xx_init(unsigned long r3, unsigned long r4, unsigned long r5,
+		unsigned long r6, unsigned long r7);
+void m8xx_setup_arch(void);
+
+#endif /* _PPC_SYSLIB_M8XX_SETUP_H */

--=-b8NPSJsBFC4Vg+gq4g8T--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
