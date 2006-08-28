Return-Path: <mgreer@mvista.com>
Date: Mon, 28 Aug 2006 13:05:17 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [CFT:PATCH] Removing possible wrong asm/serial.h inclusions
Message-ID: <20060828200517.GD21522@mag.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

All,

This was sent to linuxppc-embedded by Russel King.  In case you missed it,
I'm forwarding it here:

Mark
--

http://ozlabs.org/pipermail/linuxppc-embedded/2006-August/024178.html

--

asm/serial.h is supposed to contain the definitions for the architecture
specific 8250 ports for the 8250 driver.  It may also define BASE_BAUD,
but this is the base baud for the architecture specific ports _only_.

Therefore, nothing other than the 8250 driver should be including this
header file.  In order to move towards this goal, here is a patch which
removes some of the more obvious incorrect includes of the file.

MIPS and PPC has rather a lot of stuff in asm/serial.h, some of it looks
related to non-8250 ports.  Hence, it's not trivial to conclude that
these includes are indeed unnecessary, so can mips and ppc people please
test this patch carefully.

Thanks.

diff --git a/arch/frv/kernel/setup.c b/arch/frv/kernel/setup.c
--- a/arch/frv/kernel/setup.c
+++ b/arch/frv/kernel/setup.c
@@ -31,7 +31,6 @@
 #include <linux/serial_reg.h>
 
 #include <asm/setup.h>
-#include <asm/serial.h>
 #include <asm/irq.h>
 #include <asm/sections.h>
 #include <asm/pgalloc.h>
diff --git a/arch/ia64/kernel/setup.c b/arch/ia64/kernel/setup.c
--- a/arch/ia64/kernel/setup.c
+++ b/arch/ia64/kernel/setup.c
@@ -54,7 +54,6 @@
 #include <asm/processor.h>
 #include <asm/sal.h>
 #include <asm/sections.h>
-#include <asm/serial.h>
 #include <asm/setup.h>
 #include <asm/smp.h>
 #include <asm/system.h>
diff --git a/arch/mips/cobalt/setup.c b/arch/mips/cobalt/setup.c
--- a/arch/mips/cobalt/setup.c
+++ b/arch/mips/cobalt/setup.c
@@ -23,7 +23,6 @@
 #include <asm/processor.h>
 #include <asm/reboot.h>
 #include <asm/gt64120.h>
-#include <asm/serial.h>
 
 #include <asm/mach-cobalt/cobalt.h>
 
diff --git a/arch/mips/lasat/setup.c b/arch/mips/lasat/setup.c
--- a/arch/mips/lasat/setup.c
+++ b/arch/mips/lasat/setup.c
@@ -34,7 +34,6 @@
 #include <asm/cpu.h>
 #include <asm/bootinfo.h>
 #include <asm/irq.h>
-#include <asm/serial.h>
 #include <asm/lasat/lasat.h>
 #include <asm/lasat/serial.h>
 
diff --git a/arch/powerpc/kernel/setup-common.c
b/arch/powerpc/kernel/setup-common.c
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -51,7 +51,6 @@
 #include <asm/system.h>
 #include <asm/rtas.h>
 #include <asm/iommu.h>
-#include <asm/serial.h>
 #include <asm/cache.h>
 #include <asm/page.h>
 #include <asm/mmu.h>
diff --git a/arch/powerpc/kernel/setup_32.c
b/arch/powerpc/kernel/setup_32.c
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -38,7 +38,6 @@
 #include <asm/nvram.h>
 #include <asm/xmon.h>
 #include <asm/time.h>
-#include <asm/serial.h>
 #include <asm/udbg.h>
 
 #include "setup.h"
diff --git a/arch/powerpc/kernel/setup_64.c
b/arch/powerpc/kernel/setup_64.c
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -51,7 +51,6 @@
 #include <asm/system.h>
 #include <asm/rtas.h>
 #include <asm/iommu.h>
-#include <asm/serial.h>
 #include <asm/cache.h>
 #include <asm/page.h>
 #include <asm/mmu.h>
diff --git a/drivers/char/pcmcia/synclink_cs.c
b/drivers/char/pcmcia/synclink_cs.c
--- a/drivers/char/pcmcia/synclink_cs.c
+++ b/drivers/char/pcmcia/synclink_cs.c
@@ -57,7 +57,6 @@
 #include <linux/netdevice.h>
 #include <linux/vmalloc.h>
 #include <linux/init.h>
-#include <asm/serial.h>
 #include <linux/delay.h>
 #include <linux/ioctl.h>
 
diff --git a/drivers/char/synclink.c b/drivers/char/synclink.c
--- a/drivers/char/synclink.c
+++ b/drivers/char/synclink.c
@@ -87,7 +87,6 @@
 
 #include <linux/vmalloc.h>
 #include <linux/init.h>
-#include <asm/serial.h>
 
 #include <linux/delay.h>
 #include <linux/ioctl.h>
diff --git a/drivers/serial/m32r_sio.c b/drivers/serial/m32r_sio.c
--- a/drivers/serial/m32r_sio.c
+++ b/drivers/serial/m32r_sio.c
@@ -76,17 +76,16 @@
  */
 #define is_real_interrupt(irq)	((irq) != 0)
 
-#include <asm/serial.h>
+#define BASE_BAUD	115200
 
 /* Standard COM flags */
 #define STD_COM_FLAGS (UPF_BOOT_AUTOCONF | UPF_SKIP_TEST)
 
 /*
  * SERIAL_PORT_DFNS tells us about built-in ports that have no
  * standard enumeration mechanism.   Platforms that can find all
  * serial ports via mechanisms like ACPI or PCI need not supply it.
  */
-#undef SERIAL_PORT_DFNS
 #if defined(CONFIG_PLAT_USRV)
 
 #define SERIAL_PORT_DFNS
\
@@ -109,7 +108,7 @@
 #endif /* !CONFIG_PLAT_USRV */
 
 static struct old_serial_port old_serial_port[] = {
-	SERIAL_PORT_DFNS	/* defined in asm/serial.h */
+	SERIAL_PORT_DFNS
 };
 
 #define UART_NR	ARRAY_SIZE(old_serial_port)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
