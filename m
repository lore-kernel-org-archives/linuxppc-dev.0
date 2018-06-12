Return-Path: <bhe@redhat.com>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 414b401yWHzF45g
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jun 2018 13:30:08 +1000 (AEST)
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 robh+dt@kernel.org, dan.j.williams@intel.com, nicolas.pitre@linaro.org,
 josh@joshtriplett.org, fengguang.wu@intel.com, bp@suse.de
Cc: patrik.r.jakobsson@gmail.com, airlied@linux.ie, kys@microsoft.com,
 haiyangz@microsoft.com, sthemmin@microsoft.com, dmitry.torokhov@gmail.com,
 frowand.list@gmail.com, keith.busch@intel.com, jonathan.derrick@intel.com,
 lorenzo.pieralisi@arm.com, bhelgaas@google.com, tglx@linutronix.de,
 brijesh.singh@amd.com, jglisse@redhat.com, thomas.lendacky@amd.com,
 gregkh@linuxfoundation.org, baiyaowei@cmss.chinamobile.com,
 richard.weiyang@gmail.com, devel@linuxdriverproject.org,
 linux-input@vger.kernel.org, linux-nvdimm@lists.01.org,
 devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
 ebiederm@xmission.com, vgoyal@redhat.com, dyoung@redhat.com,
 yinghai@kernel.org, kexec@lists.infradead.org, monstr@monstr.eu,
 davem@davemloft.net, chris@zankel.net, jcmvbkbc@gmail.com,
 gustavo@padovan.org, maarten.lankhorst@linux.intel.com,
 seanpaul@chromium.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Baoquan He <bhe@redhat.com>
Subject: [PATCH v5 3/4] resource: add walk_system_ram_res_rev()
Date: Tue, 12 Jun 2018 11:28:30 +0800
Message-Id: <20180612032831.29747-4-bhe@redhat.com>
In-Reply-To: <20180612032831.29747-1-bhe@redhat.com>
References: <20180612032831.29747-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This function, being a variant of walk_system_ram_res() introduced in
commit 8c86e70acead ("resource: provide new functions to walk through
resources"), walks through a list of all the resources of System RAM
in reversed order, i.e., from higher to lower.

It will be used in kexec_file code.

Signed-off-by: Baoquan He <bhe@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Brijesh Singh <brijesh.singh@amd.com>
Cc: "Jérôme Glisse" <jglisse@redhat.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Wei Yang <richard.weiyang@gmail.com>
---
 include/linux/ioport.h |  3 +++
 kernel/resource.c      | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index b7456ae889dd..066cc263e2cc 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -279,6 +279,9 @@ extern int
 walk_system_ram_res(u64 start, u64 end, void *arg,
 		    int (*func)(struct resource *, void *));
 extern int
+walk_system_ram_res_rev(u64 start, u64 end, void *arg,
+			int (*func)(struct resource *, void *));
+extern int
 walk_iomem_res_desc(unsigned long desc, unsigned long flags, u64 start, u64 end,
 		    void *arg, int (*func)(struct resource *, void *));
 
diff --git a/kernel/resource.c b/kernel/resource.c
index ef9a20b75234..3128ac938f38 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -23,6 +23,8 @@
 #include <linux/pfn.h>
 #include <linux/mm.h>
 #include <linux/resource_ext.h>
+#include <linux/string.h>
+#include <linux/vmalloc.h>
 #include <asm/io.h>
 
 
@@ -443,6 +445,44 @@ int walk_system_ram_res(u64 start, u64 end, void *arg,
 }
 
 /*
+ * This function, being a variant of walk_system_ram_res(), calls the @func
+ * callback against all memory ranges of type System RAM which are marked as
+ * IORESOURCE_SYSTEM_RAM and IORESOUCE_BUSY in reversed order, i.e., from
+ * higher to lower.
+ */
+int walk_system_ram_res_rev(u64 start, u64 end, void *arg,
+				int (*func)(struct resource *, void *))
+{
+	unsigned long flags;
+	struct resource *res;
+	int ret = -1;
+
+	flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
+
+	read_lock(&resource_lock);
+	list_for_each_entry_reverse(res, &iomem_resource.child, sibling) {
+		if (start >= end)
+			break;
+		if ((res->flags & flags) != flags)
+			continue;
+		if (res->desc != IORES_DESC_NONE)
+			continue;
+		if (res->end < start)
+			break;
+
+		if ((res->end >= start) && (res->start < end)) {
+			ret = (*func)(res, arg);
+			if (ret)
+				break;
+		}
+		end = res->start - 1;
+
+	}
+	read_unlock(&resource_lock);
+	return ret;
+}
+
+/*
  * This function calls the @func callback against all memory ranges, which
  * are ranges marked as IORESOURCE_MEM and IORESOUCE_BUSY.
  */
-- 
2.13.6
