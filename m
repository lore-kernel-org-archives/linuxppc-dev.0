Return-Path: <travis@sgi.com>
Received: from relay.sgi.com (netops-testserver-4-out.sgi.com [192.48.171.29])
	by ozlabs.org (Postfix) with ESMTP id D1834DDDDB
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 11:56:49 +1000 (EST)
Message-Id: <20070912015646.938985912@sgi.com>
References: <20070912015644.927677070@sgi.com>
Date: Tue, 11 Sep 2007 18:56:51 -0700
From: travis@sgi.com
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 07/10] x86: acpi-use-cpu_physical_id (v3)
Cc: linux-mm@kvack.org, Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, sparclinux@vger.kernel.org,
	Christoph Lameter <clameter@sgi.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is from an earlier message from Christoph Lameter:

    processor_core.c currently tries to determine the apicid by special casing
    for IA64 and x86. The desired information is readily available via

	    cpu_physical_id()

    on IA64, i386 and x86_64.

    Signed-off-by: Christoph Lameter <clameter@sgi.com>

Additionally, boot_cpu_id needed to be exported to fix compile errors in
dma code when !CONFIG_SMP.

Signed-off-by: Mike Travis <travis@sgi.com>
---
 arch/x86_64/kernel/mpparse.c  |    2 ++
 drivers/acpi/processor_core.c |    8 +-------
 2 files changed, 3 insertions(+), 7 deletions(-)

--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -419,12 +419,6 @@
 	return 0;
 }
 
-#ifdef CONFIG_IA64
-#define arch_cpu_to_apicid 	ia64_cpu_to_sapicid
-#else
-#define arch_cpu_to_apicid 	x86_cpu_to_apicid
-#endif
-
 static int map_madt_entry(u32 acpi_id)
 {
 	unsigned long madt_end, entry;
@@ -498,7 +492,7 @@
 		return apic_id;
 
 	for (i = 0; i < NR_CPUS; ++i) {
-		if (arch_cpu_to_apicid[i] == apic_id)
+		if (cpu_physical_id(i) == apic_id)
 			return i;
 	}
 	return -1;
--- a/arch/x86_64/kernel/mpparse.c
+++ b/arch/x86_64/kernel/mpparse.c
@@ -57,6 +57,8 @@
 
 /* Processor that is doing the boot up */
 unsigned int boot_cpu_id = -1U;
+EXPORT_SYMBOL(boot_cpu_id);
+
 /* Internal processor count */
 unsigned int num_processors __cpuinitdata = 0;
 

-- 
