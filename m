Return-Path: <suzuki@in.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp04.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D82842C0084
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Jul 2012 21:49:36 +1000 (EST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <suzuki@in.ibm.com>;
 Mon, 2 Jul 2012 17:19:28 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q62BnOXf55377950
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 2 Jul 2012 17:19:25 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q62HJwXc009740
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 Jul 2012 03:19:58 +1000
From: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Subject: [PATCH] [powerpc] Export memory limit via device tree
To: benh@kernel.crashing.org
Date: Mon, 02 Jul 2012 17:19:00 +0530
Message-ID: <20120702114855.22333.95335.stgit@suzukikp.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: mahesh@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The powerpc kernel doesn't export the memory limit enforced by 'mem='
kernel parameter. This is required for building the ELF header in
kexec-tools to limit the vmcore to capture only the used memory. On
powerpc the kexec-tools depends on the device-tree for memory related
information, unlike /proc/iomem on the x86.

Without this information, the kexec-tools assumes the entire System
RAM and vmcore creates an unnecessarily larger dump.

This patch exports the memory limit, if present, via chosen/linux,memory-limit
property, so that the vmcore can be limited to the memory limit.

The prom_init seems to export this value in the same node. But doesn't really
appear there.  Also the memory_limit gets adjusted with the processing of
crashkernel= parameter. This patch makes sure we get the actual limit.

The kexec-tools will use the value to limit the 'end' of the memory
regions.

Tested this patch on ppc64 and ppc32(ppc440) with a kexec-tools
patch by Mahesh.

Signed-off-by: Suzuki K. Poulose <suzuki@in.ibm.com>
Tested-by: Mahesh J. Salgaonkar <mahesh@linux.vnet.ibm.com>
---

 arch/powerpc/kernel/machine_kexec.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/machine_kexec.c b/arch/powerpc/kernel/machine_kexec.c
index c957b12..0c9695d 100644
--- a/arch/powerpc/kernel/machine_kexec.c
+++ b/arch/powerpc/kernel/machine_kexec.c
@@ -207,6 +207,12 @@ static struct property crashk_size_prop = {
 	.value = &crashk_size,
 };
 
+static struct property memory_limit_prop = {
+	.name = "linux,memory-limit",
+	.length = sizeof(phys_addr_t),
+	.value = &memory_limit,
+};
+
 static void __init export_crashk_values(struct device_node *node)
 {
 	struct property *prop;
@@ -226,6 +232,15 @@ static void __init export_crashk_values(struct device_node *node)
 		crashk_size = resource_size(&crashk_res);
 		prom_add_property(node, &crashk_size_prop);
 	}
+
+	/* memory-limit is needed for constructing the crash regions */
+	prop = of_find_property(node, memory_limit_prop.name, NULL);
+	if (prop)
+		prom_remove_property(node, prop);
+
+	if (memory_limit)
+		prom_add_property(node, &memory_limit_prop);
+
 }
 
 static int __init kexec_setup(void)
