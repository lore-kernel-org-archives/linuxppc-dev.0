Return-Path: <anton@samba.org>
Date: Mon, 29 Jul 2013 13:11:50 +1000
From: Anton Blanchard <anton@samba.org>
To: Grant Likely <grant.likely@linaro.org>
Subject: Re: [PATCH] of: Feed entire flattened device tree into the random pool
Message-ID: <20130729131150.591926c3@kryten>
In-Reply-To: <20130728044942.A58793E0A24@localhost>
References: <20130725125122.78accf44@kryten> <20130725031717.GB15673@concordia>
 <20130725143031.16af0a96@kryten>
 <20130728044942.A58793E0A24@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: devicetree@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi,

> be32_to_cpu(initial_boot_params->totalsize);

Ouch, thanks Grant.

Anton
--

We feed the entire DMI table into the random pool to provide
better random data during early boot, so do the same with the
flattened device tree.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

v3: Fix endian issues as noted by Grant

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
+				be32_to_cpu(initial_boot_params->totalsize));
+
+	return 0;
+}
+core_initcall(add_fdt_randomness);
