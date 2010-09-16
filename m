Return-Path: <msm@freescale.com>
Received: from VA3EHSOBE004.bigfish.com (va3ehsobe004.messaging.microsoft.com
	[216.32.180.14]) by ozlabs.org (Postfix) with ESMTP id C4E6010C76A
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Sep 2010 09:04:24 +1000 (EST)
Received: from mail25-va3 (localhost.localdomain [127.0.0.1])	by
	mail25-va3-R.bigfish.com (Postfix) with ESMTP id 4F0905080AE	for
	<linuxppc-dev@ozlabs.org>; Thu, 16 Sep 2010 22:49:18 +0000 (UTC)
Received: from VA3EHSMHS031.bigfish.com (unknown [10.7.14.241])	by
	mail25-va3.bigfish.com (Postfix) with ESMTP id E72DF1500054	for
	<linuxppc-dev@ozlabs.org>; Thu, 16 Sep 2010 22:49:17 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
	[10.64.34.199])	by de01egw01.freescale.net (8.14.3/8.14.3) with ESMTP
	id o8GMnGqt002210	for <linuxppc-dev@ozlabs.org>;
	Thu, 16 Sep 2010 15:49:17 -0700 (MST)
From: Matthew McClintock <msm@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 4/4] powerpc/85xx: flush dcache before resetting cores
Date: Thu, 16 Sep 2010 17:58:26 -0500
Message-ID: <1284677906-23787-4-git-send-email-msm@freescale.com>
In-Reply-To: <1284677906-23787-1-git-send-email-msm@freescale.com>
References: <1284677906-23787-1-git-send-email-msm@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Matthew McClintock <msm@freescale.com>, kumar.gala@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When we do an mpic_reset_core we need to make sure the dcache
is flushed

Signed-off-by: Matthew McClintock <msm@freescale.com>
---
 arch/powerpc/platforms/85xx/smp.c |   50 +++++++++++++++++++++++++++++++++++++
 1 files changed, 50 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platforms/85xx/smp.c
index 29416a9..c89a370 100644
--- a/arch/powerpc/platforms/85xx/smp.c
+++ b/arch/powerpc/platforms/85xx/smp.c
@@ -16,6 +16,7 @@
 #include <linux/delay.h>
 #include <linux/of.h>
 #include <linux/kexec.h>
+#include <linux/highmem.h>
 
 #include <asm/machdep.h>
 #include <asm/pgtable.h>
@@ -133,11 +134,60 @@ static void mpc85xx_smp_kexec_down(void *arg)
 		ppc_md.kexec_cpu_down(0,1);
 }
 
+static void map_and_flush(unsigned long paddr)
+{
+	struct page *page = pfn_to_page(paddr >> PAGE_SHIFT);
+	unsigned long kaddr  = (unsigned long)kmap(page);
+
+	flush_dcache_range(kaddr, kaddr + PAGE_SIZE);
+	kunmap(page);
+}
+
+/**
+ * Before we reset the other cores, we need to flush relevant cache
+ * out to memory so we don't get anything corrupted, some of these flushes
+ * are performed out of an overabundance of caution as interrupts are not
+ * disabled yet and we can switch cores
+ */
+static void mpc85xx_smp_flush_dcache_kexec(struct kimage *image)
+{
+	kimage_entry_t *ptr, entry;
+	unsigned long paddr;
+	int i;
+
+	if (image->type == KEXEC_TYPE_DEFAULT) {
+		/* normal kexec images are stored in temporary pages */
+		for (ptr = &image->head; (entry = *ptr) && !(entry & IND_DONE);
+		     ptr = (entry & IND_INDIRECTION) ?
+				phys_to_virt(entry & PAGE_MASK) : ptr + 1) {
+			if (!(entry & IND_DESTINATION)) {
+				map_and_flush(entry);
+			}
+		}
+		/* flush out last IND_DONE page */
+		map_and_flush(entry);
+	} else {
+		/* crash type kexec images are copied to the crash region */
+		for (i = 0; i < image->nr_segments; i++) {
+			struct kexec_segment *seg = &image->segment[i];
+			for (paddr = seg->mem; paddr < seg->mem + seg->memsz;
+			     paddr += PAGE_SIZE) {
+				map_and_flush(paddr);
+			}
+		}
+	}
+
+	/* also flush the kimage struct to be passed in as well */
+	flush_dcache_range((unsigned long)image,
+			   (unsigned long)image + sizeof(*image));
+}
+
 static void mpc85xx_smp_machine_kexec(struct kimage *image)
 {
 	int timeout = INT_MAX;
 	int i, num_cpus = num_present_cpus();
 
+	mpc85xx_smp_flush_dcache_kexec(image);
 
 	if (image->type == KEXEC_TYPE_DEFAULT)
 		smp_call_function(mpc85xx_smp_kexec_down, NULL, 0);
-- 
1.6.6.1
