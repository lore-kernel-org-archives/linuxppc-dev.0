Return-Path: <anton@samba.org>
Date: Thu, 25 Jul 2013 14:30:31 +1000
From: Anton Blanchard <anton@samba.org>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH] of: Feed entire flattened device tree into the random pool
Message-ID: <20130725143031.16af0a96@kryten>
In-Reply-To: <20130725031717.GB15673@concordia>
References: <20130725125122.78accf44@kryten> <20130725031717.GB15673@concordia>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: devicetree@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>,
 Paul Mackerras <paulus@samba.org>, Grant Likely <grant.likely@linaro.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi Michael,

> But why not put the initcall in drivers/of/fdt.c, that way it's not
> early but it's still common ?

Good idea! How does this look? So long as it happens before
module_init(rand_initialize) we should be good.

Anton
--

We feed the entire DMI table into the random pool to provide
better random data during early boot, so do the same with the
flattened device tree.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

v2: move to drivers/of/fdt.c as suggested by Michael Ellerman

Index: b/drivers/of/fdt.c
===================================================================
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -17,6 +17,7 @@
 #include <linux/string.h>
 #include <linux/errno.h>
 #include <linux/slab.h>
+#include <linux/random.h>
 
 #include <asm/setup.h>  /* for COMMAND_LINE_SIZE */
 #ifdef CONFIG_PPC
@@ -714,3 +715,14 @@ void __init unflatten_device_tree(void)
 }
 
 #endif /* CONFIG_OF_EARLY_FLATTREE */
+
+/* Feed entire flattened device tree into the random pool */
+static int __init add_fdt_randomness(void)
+{
+	if (initial_boot_params)
+		add_device_randomness(initial_boot_params,
+				      initial_boot_params->totalsize);
+
+	return 0;
+}
+core_initcall(add_fdt_randomness);
