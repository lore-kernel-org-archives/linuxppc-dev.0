Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 88E8C1A0276
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jun 2015 02:01:15 +1000 (AEST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Wed, 3 Jun 2015 02:01:15 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id C4A6C357804F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jun 2015 02:01:12 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t52G14vh3735866
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Jun 2015 02:01:13 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t52G0d7X019312
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Jun 2015 02:00:40 +1000
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Stephane Eranian <eranian@google.com>
Subject: [PATCH v1 5/9]powerpc/powernv: nest pmu feature detection support
Date: Tue,  2 Jun 2015 21:29:34 +0530
Message-Id: <1433260778-26497-6-git-send-email-maddy@linux.vnet.ibm.com>
In-Reply-To: <1433260778-26497-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1433260778-26497-1-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Patch adds a device tree function to detect the nest pmu
support. Function will look for specific dt property "ibm,ima-chip"
as a detection mechanism for the nest pmu.

For Nest pmu, device tree will have two set of information.
1) Per-chip Homer address region for nest pmu counter collection area.
2) Supported Nest PMUs and events

Device tree layout for the Nest PMU as follows.

  /			-- DT root folder
  |
  -nest-ima		-- Nest PMU folder
   |

   -ima-chip@<chip-id>	-- Per-chip folder for HOMER region information
    |
    -ibm,chip-id	-- Chip id
    -ibm,ima-chip
    -reg		-- HOMER PORE Nest Counter collection Address (RA)
    -size		-- size to map in kernel space

   -Alink_BW		-- Nest PMU folder
    |
    -Alink0		-- Nest PMU Alink Event file
    -scale.Alink0.scale	-- Event scale file
    -unit.Alink0.unit	-- Event unit file
    -device_type	-- "nest-ima-unit" marker
  ....

Patch save per-chip HOMER offset and maps the same to kernel structure.
Subsequent patch will parse the next part of the DT to find various
Nest PMUs and their events.

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: Stephane Eranian <eranian@google.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/perf/nest-pmu.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/powerpc/perf/nest-pmu.c b/arch/powerpc/perf/nest-pmu.c
index 345707c..c979e57 100644
--- a/arch/powerpc/perf/nest-pmu.c
+++ b/arch/powerpc/perf/nest-pmu.c
@@ -11,6 +11,7 @@
 
 #include "nest-pmu.h"
 
+static struct perchip_nest_info p8_perchip_nest_info[P8_MAX_CHIP];
 static cpumask_t cpu_mask_nest_pmu;
 
 static ssize_t cpumask_nest_pmu_get_attr(struct device *dev,
@@ -242,6 +243,36 @@ static int update_pmu_ops(struct nest_pmu *pmu)
 	return 0;
 }
 
+static int nest_ima_detect_parse(void)
+{
+	const __be32 *gcid;
+	const __be64 *chip_ima_reg;
+	const __be64 *chip_ima_size;
+	struct device_node *dev;
+	int rc = -EINVAL, idx;
+
+	for_each_node_with_property(dev, "ibm,ima-chip") {
+		gcid = of_get_property(dev, "ibm,chip-id", NULL);
+		chip_ima_reg = of_get_property(dev, "reg", NULL);
+		chip_ima_size = of_get_property(dev, "size", NULL);
+		if ((!gcid) || (!chip_ima_reg) || (!chip_ima_size)) {
+			pr_err("%s: device %s missing property \n",
+				__func__, dev->full_name);
+			return rc;
+		}
+
+		idx = (uint32_t)be32_to_cpup(gcid);
+		p8_perchip_nest_info[idx].pbase = be64_to_cpup(chip_ima_reg);
+		p8_perchip_nest_info[idx].size = be64_to_cpup(chip_ima_size);
+		p8_perchip_nest_info[idx].vbase = (uint64_t)
+			phys_to_virt(p8_perchip_nest_info[idx].pbase);
+
+		rc = 0;
+	}
+
+	return rc;
+}
+
 static int __init nest_pmu_init(void)
 {
 	int ret = 0;
@@ -256,6 +287,12 @@ static int __init nest_pmu_init(void)
 
 	cpumask_chip();
 
+	/*
+	 * Detect the Nest PMU feature
+	 */
+	if (nest_ima_detect_parse())
+		return 0;
+
 	return 0;
 }
 device_initcall(nest_pmu_init);
-- 
1.9.1
