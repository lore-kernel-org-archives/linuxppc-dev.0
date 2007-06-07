Return-Path: <mgreer@mvista.com>
Date: Wed, 6 Jun 2007 17:38:00 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: linuxppc-dev <Linuxppc-dev@ozlabs.org>
Subject: [PATCH 1/2] powerpc: call add_preferred_console when mpsc is console
Message-ID: <20070607003800.GA4301@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

When a Marvell MPSC (serial controller) port is the specified
/chosen/stdout-path device, call 'add_preferred_console()' so the user
doesn't have to specify a 'console=ttyMMx' cmdline argument.

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
Acked-by: Dale Farnsworth <dale@farnsworth.org>
---
 arch/powerpc/sysdev/mv64x60_dev.c |   28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/powerpc/sysdev/mv64x60_dev.c b/arch/powerpc/sysdev/mv64x60_dev.c
index 4b0a9c8..b618fa6 100644
--- a/arch/powerpc/sysdev/mv64x60_dev.c
+++ b/arch/powerpc/sysdev/mv64x60_dev.c
@@ -12,6 +12,7 @@
 #include <linux/stddef.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/console.h>
 #include <linux/mv643xx.h>
 #include <linux/platform_device.h>
 
@@ -420,3 +421,30 @@ error:
 	return err;
 }
 arch_initcall(mv64x60_device_setup);
+
+static int __init mv64x60_add_mpsc_console(void)
+{
+	struct device_node *np = NULL;
+	const char *prop;
+
+	prop = of_get_property(of_chosen, "linux,stdout-path", NULL);
+	if (prop == NULL)
+		goto not_mpsc;
+
+	np = of_find_node_by_path(prop);
+	if (!np)
+		goto not_mpsc;
+
+	if (!of_device_is_compatible(np, "marvell,mpsc"))
+		goto not_mpsc;
+
+	prop = of_get_property(np, "block-index", NULL);
+	if (!prop)
+		goto not_mpsc;
+
+	add_preferred_console("ttyMM", *(int *)prop, NULL);
+
+not_mpsc:
+	return 0;
+}
+console_initcall(mv64x60_add_mpsc_console);
