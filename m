Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tZ3RX0YvDzDvHy
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Dec 2016 16:13:28 +1100 (AEDT)
From: David Gibson <david@gibson.dropbear.id.au>
To: michael@ellerman.id.au,
	paulus@samba.org
Cc: linuxppc-dev@ozlabs.org, kvm@vger.kernel.org,
 David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 5/6] pseries: Advertise HPT resizing support via CAS
Date: Thu,  8 Dec 2016 16:13:20 +1100
Message-Id: <20161208051321.31446-6-david@gibson.dropbear.id.au>
In-Reply-To: <20161208051321.31446-1-david@gibson.dropbear.id.au>
References: <20161208051321.31446-1-david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The hypervisor needs to know a guest is capable of using the HPT resizing
PAPR extension in order to make full advantage of it for memory hotplug.

If the hypervisor knows the guest is HPT resize aware, it can size the
initial HPT based on the initial guest RAM size, relying on the guest to
resize the HPT when more memory is hot-added.  Without this, the hypervisor
must size the HPT for the maximum possible guest RAM, which can lead to
a huge waste of space if the guest never actually expends to that maximum
size.

This patch advertises the guest's support for HPT resizing via the
ibm,client-architecture-support OF interface.  We use bit 5 of byte 6 of
option vector 5 for this purpose (tentatively assigned in in-progress PAPR
change request).

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Reviewed-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/include/asm/prom.h | 1 +
 arch/powerpc/kernel/prom_init.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/prom.h b/arch/powerpc/include/asm/prom.h
index 7f436ba..94c92bb 100644
--- a/arch/powerpc/include/asm/prom.h
+++ b/arch/powerpc/include/asm/prom.h
@@ -151,6 +151,7 @@ struct of_drconf_cell {
 #define OV5_XCMO		0x0440	/* Page Coalescing */
 #define OV5_TYPE1_AFFINITY	0x0580	/* Type 1 NUMA affinity */
 #define OV5_PRRN		0x0540	/* Platform Resource Reassignment */
+#define OV5_RESIZE_HPT		0x0601	/* Hash Page Table resizing */
 #define OV5_PFO_HW_RNG		0x0E80	/* PFO Random Number Generator */
 #define OV5_PFO_HW_842		0x0E40	/* PFO Compression Accelerator */
 #define OV5_PFO_HW_ENCR		0x0E20	/* PFO Encryption Accelerator */
diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 88ac964..9942d9f 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -713,7 +713,7 @@ unsigned char ibm_architecture_vec[] = {
 	0,
 #endif
 	OV5_FEAT(OV5_TYPE1_AFFINITY) | OV5_FEAT(OV5_PRRN),
-	0,
+	OV5_FEAT(OV5_RESIZE_HPT),
 	0,
 	0,
 	/* WARNING: The offset of the "number of cores" field below
-- 
2.9.3
