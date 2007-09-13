Return-Path: <bwalle@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 12555DDF78
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2007 02:14:36 +1000 (EST)
Message-Id: <20070913161430.028741111@strauss.suse.de>
References: <20070913161428.343951643@strauss.suse.de>
Date: Thu, 13 Sep 2007 18:14:33 +0200
From: Bernhard Walle <bwalle@suse.de>
To: kexec@lists.infradead.org
Subject: [patch 5/7] Use extended crashkernel command line on ppc64
Cc: linux-arch@vger.kernel.org, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adapts the ppc64 code to use the generic parse_crashkernel()
function introduced in the generic patch of that series.


Signed-off-by: Bernhard Walle <bwalle@suse.de>

---
 arch/powerpc/kernel/machine_kexec.c |   52 ++++++++++++++++++------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

--- a/arch/powerpc/kernel/machine_kexec.c
+++ b/arch/powerpc/kernel/machine_kexec.c
@@ -61,45 +61,39 @@ NORET_TYPE void machine_kexec(struct kim
 	for(;;);
 }
 
-static int __init early_parse_crashk(char *p)
+void __init reserve_crashkernel(void)
 {
-	unsigned long size;
-
-	if (!p)
-		return 1;
-
-	size = memparse(p, &p);
+	unsigned long long crash_size = 0, crash_base;
+	int ret;
 
-	if (*p == '@')
-		crashk_res.start = memparse(p + 1, &p);
-	else
-		crashk_res.start = KDUMP_KERNELBASE;
-
-	crashk_res.end = crashk_res.start + size - 1;
-
-	return 0;
-}
-early_param("crashkernel", early_parse_crashk);
+	/* this is necessary because of lmb_phys_mem_size() */
+	lmb_analyze();
 
-void __init reserve_crashkernel(void)
-{
-	unsigned long size;
+	/* use common parsing */
+	ret = parse_crashkernel(boot_command_line, lmb_phys_mem_size(),
+			&crash_size, &crash_base);
+	if (ret == 0 && crash_size > 0) {
+		if (crash_base == 0)
+			crash_base = KDUMP_KERNELBASE;
+		crashk_res.start = crash_base;
+	} else {
+		/* handle the device tree */
+		crash_size = crashk_res.end - crashk_res.start + 1;
+	}
 
-	if (crashk_res.start == 0)
+	if (crash_size == 0)
 		return;
 
 	/* We might have got these values via the command line or the
 	 * device tree, either way sanitise them now. */
 
-	size = crashk_res.end - crashk_res.start + 1;
-
 	if (crashk_res.start != KDUMP_KERNELBASE)
 		printk("Crash kernel location must be 0x%x\n",
 				KDUMP_KERNELBASE);
 
 	crashk_res.start = KDUMP_KERNELBASE;
-	size = PAGE_ALIGN(size);
-	crashk_res.end = crashk_res.start + size - 1;
+	crash_size = PAGE_ALIGN(crash_size);
+	crashk_res.end = crashk_res.start + crash_size - 1;
 
 	/* Crash kernel trumps memory limit */
 	if (memory_limit && memory_limit <= crashk_res.end) {
@@ -108,7 +102,13 @@ void __init reserve_crashkernel(void)
 				memory_limit);
 	}
 
-	lmb_reserve(crashk_res.start, size);
+	printk(KERN_INFO "Reserving %ldMB of memory at %ldMB "
+			"for crashkernel (System RAM: %ldMB)\n",
+			(unsigned long)(crash_size >> 20),
+			(unsigned long)(crashk_res.start >> 20),
+			(unsigned long)(lmb_phys_mem_size() >> 20));
+
+	lmb_reserve(crashk_res.start, crash_size);
 }
 
 int overlaps_crashkernel(unsigned long start, unsigned long size)

-- 
