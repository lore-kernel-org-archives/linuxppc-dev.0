Subject: [PATCH] fix build of ibmstb4 and ibmstbx25
From: Andreas Oberritter <obi@saftware.de>
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
Content-Type: multipart/mixed; boundary="=-53uRH2ybS5gAh1/Rfy0/"
Message-Id: <1064372689.822.13.camel@shiva.eth.saftware.de>
Mime-Version: 1.0
Date: 24 Sep 2003 05:04:49 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--=-53uRH2ybS5gAh1/Rfy0/
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Tom,

config.in.diff adds two missing '$' for config variables in
arch/ppc/config.in and the two other patches update the ocp definitions
for the stb4xxx and stbx25xx CPUs, so they can be built again. I used
linuxppc_2_4_devel, but they are needed for linuxppc-2.4, too.

Any idea why my changes to config.in were visible with bk difftool but
not with bk diffs? It's the first time I tried to use bk for creating
patches and I really don't like it. :)

Regards,
Andreas

--=-53uRH2ybS5gAh1/Rfy0/
Content-Disposition: attachment; filename=config.in.diff
Content-Type: text/plain; name=config.in.diff; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

--- linuxppc_2_4_devel/arch/ppc/config.in.orig	2003-09-24 04:55:03.000000000 +0200
+++ linuxppc_2_4_devel/arch/ppc/config.in	2003-09-24 04:53:03.000000000 +0200
@@ -386,8 +386,8 @@
 #
   if [ "$CONFIG_405GP" = "y" -o "$CONFIG_405EP" = "y" -o \
        "$CONFIG_NP405H" = "y" -o "$CONFIG_NP405L" = "y" -o \
-       "$CONFIG_NP405GS" = "y" -o "CONFIG_STB03xxx" = "y" -o \
-       "$CONFIG_405LP" = "y" -o "CONFIG_405GPR" = "y" ]; then
+       "$CONFIG_NP405GS" = "y" -o "$CONFIG_STB03xxx" = "y" -o \
+       "$CONFIG_405LP" = "y" -o "$CONFIG_405GPR" = "y" ]; then
     define_bool CONFIG_IBM_OCP y
     define_bool CONFIG_405 y
   fi

--=-53uRH2ybS5gAh1/Rfy0/
Content-Disposition: attachment; filename=ibmstb4.c.diff
Content-Type: text/plain; name=ibmstb4.c.diff; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

===== ibmstb4.c 1.6 vs edited =====
--- 1.6/arch/ppc/platforms/ibmstb4.c	Wed Aug  7 21:18:05 2002
+++ edited/ibmstb4.c	Wed Sep 24 04:41:33 2003
@@ -40,20 +40,62 @@
  *
  */

-#include <linux/config.h>
-#include <linux/module.h>
+#include <linux/init.h>
 #include <platforms/ibmstb4.h>
 #include <asm/ocp.h>

-struct ocp_def core_ocp[] = {
-	{UART, UART0_IO_BASE, UART0_INT,IBM_CPM_UART0},
-	{UART, UART1_IO_BASE, UART1_INT, IBM_CPM_UART1},
-	{UART, UART2_IO_BASE, UART2_INT, IBM_CPM_UART2},
-	{IIC, IIC0_BASE, IIC0_IRQ, IBM_CPM_IIC0},
-	{IIC, IIC1_BASE, IIC1_IRQ, IBM_CPM_IIC1},
-	{GPIO, GPIO0_BASE, OCP_IRQ_NA, IBM_CPM_GPIO0},
-	{IDE, IDE0_BASE, IDE0_IRQ, OCP_CPM_NA},
-	{USB, USB0_BASE, USB0_IRQ, IBM_CPM_USB0},
-	{OCP_NULL_TYPE, 0x0, OCP_IRQ_NA, OCP_CPM_NA},
-
+struct ocp_def core_ocp[] __initdata = {
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_16550,
+	  .index	= 0,
+	  .paddr	= UART0_IO_BASE,
+	  .irq		= UART0_INT,
+	  .pm		= IBM_CPM_UART0,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_16550,
+	  .index	= 1,
+	  .paddr	= UART1_IO_BASE,
+	  .irq		= UART1_INT,
+	  .pm		= IBM_CPM_UART2,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_16550,
+	  .index	= 2,
+	  .paddr	= UART2_IO_BASE,
+	  .irq		= UART2_INT,
+	  .pm		= IBM_CPM_UART2,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_IIC,
+	  .paddr	= IIC0_BASE,
+	  .irq		= IIC0_IRQ,
+	  .pm		= IBM_CPM_IIC0,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_IIC,
+	  .paddr	= IIC1_BASE,
+	  .irq		= IIC1_IRQ,
+	  .pm		= IBM_CPM_IIC1,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_GPIO,
+	  .paddr	= GPIO0_BASE,
+	  .irq		= OCP_IRQ_NA,
+	  .pm		= IBM_CPM_GPIO0,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_IDE,
+	  .paddr	= IDE0_BASE,
+	  .irq		= IDE0_IRQ,
+	  .pm		= OCP_CPM_NA,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_USB,
+	  .paddr	= USB0_BASE,
+	  .irq		= USB0_IRQ,
+	  .pm		= OCP_CPM_NA,
+	},
+	{ .vendor	= OCP_VENDOR_INVALID,
+	}
 };

--=-53uRH2ybS5gAh1/Rfy0/
Content-Disposition: attachment; filename=ibmstbx25.c.diff
Content-Type: text/plain; name=ibmstbx25.c.diff; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

===== ibmstbx25.c 1.2 vs edited =====
--- 1.2/arch/ppc/platforms/ibmstbx25.c	Wed Aug  7 21:18:06 2002
+++ edited/ibmstbx25.c	Wed Sep 24 04:42:50 2003
@@ -34,17 +34,44 @@
  *
  */

-#include <linux/config.h>
-#include <linux/module.h>
+#include <linux/init.h>
 #include <platforms/ibmstbx25.h>
 #include <asm/ocp.h>

-struct ocp_def core_ocp[] = {
-	{UART, UART0_IO_BASE, UART0_INT,IBM_CPM_UART0},
-	{UART, UART1_IO_BASE, UART1_INT, IBM_CPM_UART1},
-	{UART, UART2_IO_BASE, UART2_INT, IBM_CPM_UART2},
-	{IIC, IIC0_BASE, IIC0_IRQ, IBM_CPM_IIC0},
-	{GPIO, GPIO0_BASE, OCP_IRQ_NA, IBM_CPM_GPIO0},
-	{OCP_NULL_TYPE, 0x0, OCP_IRQ_NA, OCP_CPM_NA},
-
+struct ocp_def core_ocp[] __initdata = {
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_16550,
+	  .index        = 0,
+	  .paddr	= UART0_IO_BASE,
+	  .irq		= UART0_INT,
+	  .pm		= IBM_CPM_UART0,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_16550,
+	  .index	= 1,
+	  .paddr	= UART1_IO_BASE,
+	  .irq		= UART1_INT,
+	  .pm		= IBM_CPM_UART1,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_16550,
+	  .index	= 2,
+	  .paddr	= UART2_IO_BASE,
+	  .irq		= UART2_INT,
+	  .pm		= IBM_CPM_UART2,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_IIC,
+	  .paddr	= IIC0_BASE,
+	  .irq		= IIC0_IRQ,
+	  .pm		= IBM_CPM_IIC0,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_GPIO,
+	  .paddr	= GPIO0_BASE,
+	  .irq		= OCP_IRQ_NA,
+	  .pm		= IBM_CPM_GPIO0,
+	},
+	{ .vendor	= OCP_VENDOR_INVALID
+	}
 };

--=-53uRH2ybS5gAh1/Rfy0/--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
