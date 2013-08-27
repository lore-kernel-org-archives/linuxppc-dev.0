Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 8A0442C0204
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Aug 2013 16:41:12 +1000 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id r7R6f7kO024600
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Aug 2013 01:41:08 -0500
Message-ID: <1377585665.3819.109.camel@pasglop>
Subject: [PATCH] powerpc: Don't Oops when accessing /proc/powerpc/lparcfg
 without hypervisor
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Tue, 27 Aug 2013 16:41:05 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

/proc/powerpc/lparcfg is an ancient facility (though still actively used)
which allows access to some informations relative to the partition when
running underneath a PAPR compliant hypervisor.

It makes no sense on non-pseries machines. However, currently, not only
can it be created on these if the kernel has pseries support, but accessing
it on such a machine will crash due to trying to do hypervisor calls.

In fact, it should also not do HV calls on older pseries that didn't have
an hypervisor either.

Finally, it has the plumbing to be a module but is a "bool" Kconfig option.

This fixes the whole lot by turning it into a machine_device_initcall
that is only created on pseries, and adding the necessary hypervisor
check before calling the H_GET_EM_PARMS hypercall

CC: <stable@vger.kernel.org>
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Next I'll move it to arch/powerpc/platforms/pseries but in a separate
patch.

 arch/powerpc/kernel/lparcfg.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/kernel/lparcfg.c b/arch/powerpc/kernel/lparcfg.c
index d92f387..e2a0a16 100644
--- a/arch/powerpc/kernel/lparcfg.c
+++ b/arch/powerpc/kernel/lparcfg.c
@@ -35,7 +35,13 @@
 #include <asm/vdso_datapage.h>
 #include <asm/vio.h>
 #include <asm/mmu.h>
+#include <asm/machdep.h>
 
+
+/*
+ * This isn't a module but we expose that to userspace
+ * via /proc so leave the definitions here
+ */
 #define MODULE_VERS "1.9"
 #define MODULE_NAME "lparcfg"
 
@@ -418,7 +424,8 @@ static void parse_em_data(struct seq_file *m)
 {
 	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
 
-	if (plpar_hcall(H_GET_EM_PARMS, retbuf) == H_SUCCESS)
+	if (firmware_has_feature(FW_FEATURE_LPAR) &&
+	    plpar_hcall(H_GET_EM_PARMS, retbuf) == H_SUCCESS)
 		seq_printf(m, "power_mode_data=%016lx\n", retbuf[0]);
 }
 
@@ -677,7 +684,6 @@ static int lparcfg_open(struct inode *inode, struct file *file)
 }
 
 static const struct file_operations lparcfg_fops = {
-	.owner		= THIS_MODULE,
 	.read		= seq_read,
 	.write		= lparcfg_write,
 	.open		= lparcfg_open,
@@ -699,14 +705,4 @@ static int __init lparcfg_init(void)
 	}
 	return 0;
 }
-
-static void __exit lparcfg_cleanup(void)
-{
-	remove_proc_subtree("powerpc/lparcfg", NULL);
-}
-
-module_init(lparcfg_init);
-module_exit(lparcfg_cleanup);
-MODULE_DESCRIPTION("Interface for LPAR configuration data");
-MODULE_AUTHOR("Dave Engebretsen");
-MODULE_LICENSE("GPL");
+machine_device_initcall(pseries, lparcfg_init);
