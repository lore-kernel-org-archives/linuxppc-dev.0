Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zsxZg3VYtzF1lr
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Mar 2018 15:46:03 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Alexander.Levin@microsoft.com
Cc: stable@vger.kernel.org,
	linuxppc-dev@ozlabs.org,
	npiggin@gmail.com
Subject: [PATCH v4.1 backport 12/15] powerpc/64s: Allow control of RFI flush
 via debugfs
Date: Fri,  2 Mar 2018 15:45:46 +1100
Message-Id: <20180302044549.14930-13-mpe@ellerman.id.au>
In-Reply-To: <20180302044549.14930-1-mpe@ellerman.id.au>
References: <20180302044549.14930-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

commit 236003e6b5443c45c18e613d2b0d776a9f87540e upstream.

Expose the state of the RFI flush (enabled/disabled) via debugfs, and
allow it to be enabled/disabled at runtime.

eg: $ cat /sys/kernel/debug/powerpc/rfi_flush
    1
    $ echo 0 > /sys/kernel/debug/powerpc/rfi_flush
    $ cat /sys/kernel/debug/powerpc/rfi_flush
    0

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/kernel/setup_64.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 55d8da909db5..ec01a98a5978 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -38,6 +38,7 @@
 #include <linux/hugetlb.h>
 #include <linux/memory.h>
 #include <linux/nmi.h>
+#include <linux/debugfs.h>
 
 #include <asm/io.h>
 #include <asm/kdump.h>
@@ -896,5 +897,34 @@ void __init setup_rfi_flush(enum l1d_flush_type types, bool enable)
 	if (!no_rfi_flush)
 		rfi_flush_enable(enable);
 }
+
+#ifdef CONFIG_DEBUG_FS
+static int rfi_flush_set(void *data, u64 val)
+{
+	if (val == 1)
+		rfi_flush_enable(true);
+	else if (val == 0)
+		rfi_flush_enable(false);
+	else
+		return -EINVAL;
+
+	return 0;
+}
+
+static int rfi_flush_get(void *data, u64 *val)
+{
+	*val = rfi_flush ? 1 : 0;
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(fops_rfi_flush, rfi_flush_get, rfi_flush_set, "%llu\n");
+
+static __init int rfi_flush_debugfs_init(void)
+{
+	debugfs_create_file("rfi_flush", 0600, powerpc_debugfs_root, NULL, &fops_rfi_flush);
+	return 0;
+}
+device_initcall(rfi_flush_debugfs_init);
+#endif
 #endif /* CONFIG_PPC_BOOK3S_64 */
 #endif
-- 
2.14.1
