Message-ID: <3BA77FA8.E317D5B8@mvista.com>
Date: Tue, 18 Sep 2001 10:08:56 -0700
From: Armin Kuster <akuster@mvista.com>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Got Time
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


 here is a patch that returns the ability to enable the realtime clock
on the 4xx

Summary:
arch/ppc/config.in			<- changed logic to allow RTC when 4xx
arch/ppc/kernel/ppc4xx_setup.c		<- removed ds1743.h header , again


patch.

diff -ruN linuxppc_2_4_devel/arch/ppc/config.in
linuxppc_2_4_devel_dev/arch/ppc/config.in
--- linuxppc_2_4_devel/arch/ppc/config.in	Tue Sep 18 07:44:32 2001
+++ linuxppc_2_4_devel_dev/arch/ppc/config.in	Tue Sep 18 09:41:17 2001
@@ -279,7 +279,7 @@

 source drivers/parport/Config.in

-if [ "$CONFIG_4xx" != "y" -a "$CONFIG_PPC_ISERIES" != "y" ]; then
+if [ "$CONFIG_4xx" = "y" -a "$CONFIG_PPC_ISERIES" != "y" ]; then
   if [ "$CONFIG_APUS" != "y" ]; then
     tristate 'Support for /dev/rtc' CONFIG_PPC_RTC
   else
diff -ruN linuxppc_2_4_devel/arch/ppc/kernel/ppc4xx_setup.c
linuxppc_2_4_devel_dev/arch/ppc/kernel/ppc4xx_setup.c
--- linuxppc_2_4_devel/arch/ppc/kernel/ppc4xx_setup.c	Tue Sep 18
07:45:37 2001
+++ linuxppc_2_4_devel_dev/arch/ppc/kernel/ppc4xx_setup.c	Tue Sep 18
09:47:42 2001
@@ -46,7 +46,6 @@
 #include <asm/time.h>

 #ifdef CONFIG_PPC_RTC
-#include <asm/ds1743.h>
 #include "todc.h"
 #endif


-- armin

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
