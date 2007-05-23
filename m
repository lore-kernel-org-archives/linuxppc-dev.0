Return-Path: <mgreer@mvista.com>
Date: Wed, 23 May 2007 14:57:35 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: linuxppc-dev <Linuxppc-dev@ozlabs.org>
Subject: Re: powerpc_flash_init(), wtf!?
Message-ID: <20070523215735.GA16140@mag.az.mvista.com>
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

Sorry, I've lost the thread in my inbox so I can't reply to it directly.

Is something like this what everyone agreed upon?

Mark
--

diff --git a/arch/powerpc/platforms/embedded6xx/prpmc2800.c b/arch/powerpc/platforms/embedded6xx/prpmc2800.c
index d9db135..44c3144 100644
--- a/arch/powerpc/platforms/embedded6xx/prpmc2800.c
+++ b/arch/powerpc/platforms/embedded6xx/prpmc2800.c
@@ -20,6 +20,7 @@
 #include <asm/system.h>
 #include <asm/time.h>
 #include <asm/kexec.h>
+#include <asm/of_platform.h>
 
 #include <mm/mmu_decl.h>
 
@@ -134,6 +135,18 @@ void prpmc2800_show_cpuinfo(struct seq_file *m)
 }
 
 /*
+ * Register a platform device for MTD.
+ */
+static int __init prpmc2800_register_mtd(void)
+{
+	struct device_node *np;
+
+	np = of_find_compatible_node(NULL, "rom", "direct-mapped");
+	of_platform_device_create(np, np->name, NULL);
+}
+arch_initcall(prpmc2800_register_mtd);
+
+/*
  * Called very early, device-tree isn't unflattened
  */
 static int __init prpmc2800_probe(void)
