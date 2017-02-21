Return-Path: <mdroth@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vS2YF3DyczDqD0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 12:12:49 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1L19jhK067327
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Feb 2017 20:12:46 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28r8s85jc2-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Feb 2017 20:12:46 -0500
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mdroth@linux.vnet.ibm.com>;
 Mon, 20 Feb 2017 18:12:45 -0700
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH] powerpc/pseries: advertise Hot Plug Event support to firmware
Date: Mon, 20 Feb 2017 19:12:18 -0600
Message-Id: <1487639538-25922-1-git-send-email-mdroth@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With the inclusion of:

  powerpc/pseries: Implement indexed-count hotplug memory remove
  powerpc/pseries: Implement indexed-count hotplug memory add

we now have complete handling of the RTAS hotplug event format
as described by PAPR via ACR "PAPR Changes for Hotplug RTAS Events".

This capability is indicated by byte 6, bit 5 of architecture
option vector 5, and allows for greater control over cpu/memory/pci
hot plug/unplug operations.

Existing pseries kernels will utilize this capability based on the
existence of the /event-sources/hot-plug-events DT property, so we
only need to advertise it via CAS and do not need a corresponding
FW_FEATURE_* value to test for.

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Cc: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/prom.h | 1 +
 arch/powerpc/kernel/prom_init.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/prom.h b/arch/powerpc/include/asm/prom.h
index 2c8001c..4a90634 100644
--- a/arch/powerpc/include/asm/prom.h
+++ b/arch/powerpc/include/asm/prom.h
@@ -153,6 +153,7 @@ struct of_drconf_cell {
 #define OV5_XCMO		0x0440	/* Page Coalescing */
 #define OV5_TYPE1_AFFINITY	0x0580	/* Type 1 NUMA affinity */
 #define OV5_PRRN		0x0540	/* Platform Resource Reassignment */
+#define OV5_HP_EVT		0x0604	/* Hot Plug Event support */
 #define OV5_RESIZE_HPT		0x0601	/* Hash Page Table resizing */
 #define OV5_PFO_HW_RNG		0x1180	/* PFO Random Number Generator */
 #define OV5_PFO_HW_842		0x1140	/* PFO Compression Accelerator */
diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index f3c8799..1a835e7 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -839,7 +839,7 @@ struct ibm_arch_vec __cacheline_aligned ibm_architecture_vec = {
 		0,
 #endif
 		.associativity = OV5_FEAT(OV5_TYPE1_AFFINITY) | OV5_FEAT(OV5_PRRN),
-		.bin_opts = OV5_FEAT(OV5_RESIZE_HPT),
+		.bin_opts = OV5_FEAT(OV5_RESIZE_HPT) | OV5_FEAT(OV5_HP_EVT),
 		.micro_checkpoint = 0,
 		.reserved0 = 0,
 		.max_cpus = cpu_to_be32(NR_CPUS),	/* number of cores supported */
-- 
2.7.4
