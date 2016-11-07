Return-Path: <arbab@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tCTZ63Jm7zDt1h
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Nov 2016 10:44:45 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uA7NiKuT075836
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Nov 2016 18:44:43 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26jvc4mkhm-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Nov 2016 18:44:43 -0500
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <arbab@linux.vnet.ibm.com>;
 Mon, 7 Nov 2016 16:44:42 -0700
From: Reza Arbab <arbab@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 devicetree@vger.kernel.org, Bharata B Rao <bharata@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Alistair Popple <apopple@au1.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org
Subject: [PATCH v6 4/4] of/fdt: mark hotpluggable memory
Date: Mon,  7 Nov 2016 17:44:36 -0600
In-Reply-To: <1478562276-25539-1-git-send-email-arbab@linux.vnet.ibm.com>
References: <1478562276-25539-1-git-send-email-arbab@linux.vnet.ibm.com>
Message-Id: <1478562276-25539-5-git-send-email-arbab@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When movable nodes are enabled, any node containing only hotpluggable
memory is made movable at boot time.

On x86, hotpluggable memory is discovered by parsing the ACPI SRAT,
making corresponding calls to memblock_mark_hotplug().

If we introduce a dt property to describe memory as hotpluggable,
configs supporting early fdt may then also do this marking and use
movable nodes.

Signed-off-by: Reza Arbab <arbab@linux.vnet.ibm.com>
---
 drivers/of/fdt.c | 6 ++++++
 mm/Kconfig       | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index c89d5d2..2cf1d66 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -1015,6 +1015,7 @@ int __init early_init_dt_scan_memory(unsigned long node, const char *uname,
 	const char *type = of_get_flat_dt_prop(node, "device_type", NULL);
 	const __be32 *reg, *endp;
 	int l;
+	bool hotpluggable;
 
 	/* We are scanning "memory" nodes only */
 	if (type == NULL) {
@@ -1034,6 +1035,7 @@ int __init early_init_dt_scan_memory(unsigned long node, const char *uname,
 		return 0;
 
 	endp = reg + (l / sizeof(__be32));
+	hotpluggable = of_get_flat_dt_prop(node, "linux,hotpluggable", NULL);
 
 	pr_debug("memory scan node %s, reg size %d,\n", uname, l);
 
@@ -1049,6 +1051,10 @@ int __init early_init_dt_scan_memory(unsigned long node, const char *uname,
 		    (unsigned long long)size);
 
 		early_init_dt_add_memory_arch(base, size);
+
+		if (hotpluggable && memblock_mark_hotplug(base, size))
+			pr_warn("failed to mark hotplug range 0x%llx - 0x%llx\n",
+				base, base + size);
 	}
 
 	return 0;
diff --git a/mm/Kconfig b/mm/Kconfig
index 061b46b..33a9b06 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -153,7 +153,7 @@ config MOVABLE_NODE
 	bool "Enable to assign a node which has only movable memory"
 	depends on HAVE_MEMBLOCK
 	depends on NO_BOOTMEM
-	depends on X86_64 || MEMORY_HOTPLUG
+	depends on X86_64 || OF_EARLY_FLATTREE || MEMORY_HOTPLUG
 	depends on NUMA
 	default n
 	help
-- 
1.8.3.1
