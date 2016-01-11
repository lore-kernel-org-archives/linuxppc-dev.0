Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8D2D51A0AC6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jan 2016 16:51:41 +1100 (AEDT)
From: David Gibson <david@gibson.dropbear.id.au>
To: paulus@samba.org, benh@kernel.crashing.org, michael@ellerman.id.au,
 bharata@linux.vnet.ibm.com
Cc: thuth@redhat.com, lvivier@redhat.com, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
Subject: [RFCv2 3/4] pseries: debugfs hook to trigger a hash page table resize
Date: Mon, 11 Jan 2016 16:52:32 +1100
Message-Id: <1452491553-26153-4-git-send-email-david@gibson.dropbear.id.au>
In-Reply-To: <1452491553-26153-1-git-send-email-david@gibson.dropbear.id.au>
References: <1452491553-26153-1-git-send-email-david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds a special file /sys/kernel/debug/powerpc/pft-size
which can be used to view the current size of the hash page table (as
a bit shift) and to trigger a resize of the hash table on PAPR guests.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 arch/powerpc/platforms/pseries/lpar.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index f6e7af5..dba9644 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -29,6 +29,7 @@
 #include <linux/jump_label.h>
 #include <linux/delay.h>
 #include <linux/stop_machine.h>
+#include <linux/debugfs.h>
 #include <asm/processor.h>
 #include <asm/mmu.h>
 #include <asm/page.h>
@@ -903,3 +904,28 @@ int pseries_lpar_resize_hpt(unsigned long shift)
 
 	return 0;
 }
+
+static int ppc64_pft_size_get(void *data, u64 *val)
+{
+	*val = ppc64_pft_size;
+	return 0;
+}
+
+static int ppc64_pft_size_set(void *data, u64 val)
+{
+	return  pseries_lpar_resize_hpt(val);
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(fops_ppc64_pft_size,
+			ppc64_pft_size_get, ppc64_pft_size_set,	"%llu\n");
+
+static int __init pseries_lpar_debugfs(void)
+{
+	if (!debugfs_create_file("pft-size", 0600, powerpc_debugfs_root,
+				 NULL, &fops_ppc64_pft_size)) {
+		pr_err("lpar: unable to create ppc64_pft_size debugsfs file\n");
+	}
+
+	return 0;
+}
+machine_device_initcall(pseries, pseries_lpar_debugfs);
-- 
2.5.0
