Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tZ3RW5QpLzDw1f
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Dec 2016 16:13:27 +1100 (AEDT)
From: David Gibson <david@gibson.dropbear.id.au>
To: michael@ellerman.id.au,
	paulus@samba.org
Cc: linuxppc-dev@ozlabs.org, kvm@vger.kernel.org,
 David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 3/6] pseries: Add hypercall wrappers for hash page table
 resizing
Date: Thu,  8 Dec 2016 16:13:18 +1100
Message-Id: <20161208051321.31446-4-david@gibson.dropbear.id.au>
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

This adds the hypercall numbers and wrapper functions for the hash page
table resizing hypercalls.

These are experimental "platform specific" values for now, until we have a
formal PAPR update.

It also adds a new firmware feature flag to track the presence of the
HPT resizing calls.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/include/asm/firmware.h       |  5 +++--
 arch/powerpc/include/asm/hvcall.h         |  4 +++-
 arch/powerpc/include/asm/plpar_wrappers.h | 12 ++++++++++++
 arch/powerpc/platforms/pseries/firmware.c |  1 +
 4 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/firmware.h b/arch/powerpc/include/asm/firmware.h
index 1e0b5a5..8645897 100644
--- a/arch/powerpc/include/asm/firmware.h
+++ b/arch/powerpc/include/asm/firmware.h
@@ -42,7 +42,7 @@
 #define FW_FEATURE_SPLPAR	ASM_CONST(0x0000000000100000)
 #define FW_FEATURE_LPAR		ASM_CONST(0x0000000000400000)
 #define FW_FEATURE_PS3_LV1	ASM_CONST(0x0000000000800000)
-/* Free				ASM_CONST(0x0000000001000000) */
+#define FW_FEATURE_HPT_RESIZE	ASM_CONST(0x0000000001000000)
 #define FW_FEATURE_CMO		ASM_CONST(0x0000000002000000)
 #define FW_FEATURE_VPHN		ASM_CONST(0x0000000004000000)
 #define FW_FEATURE_XCMO		ASM_CONST(0x0000000008000000)
@@ -66,7 +66,8 @@ enum {
 		FW_FEATURE_MULTITCE | FW_FEATURE_SPLPAR | FW_FEATURE_LPAR |
 		FW_FEATURE_CMO | FW_FEATURE_VPHN | FW_FEATURE_XCMO |
 		FW_FEATURE_SET_MODE | FW_FEATURE_BEST_ENERGY |
-		FW_FEATURE_TYPE1_AFFINITY | FW_FEATURE_PRRN,
+		FW_FEATURE_TYPE1_AFFINITY | FW_FEATURE_PRRN |
+		FW_FEATURE_HPT_RESIZE,
 	FW_FEATURE_PSERIES_ALWAYS = 0,
 	FW_FEATURE_POWERNV_POSSIBLE = FW_FEATURE_OPAL,
 	FW_FEATURE_POWERNV_ALWAYS = 0,
diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
index 708edeb..9b7ff7c 100644
--- a/arch/powerpc/include/asm/hvcall.h
+++ b/arch/powerpc/include/asm/hvcall.h
@@ -275,7 +275,9 @@
 #define H_COP			0x304
 #define H_GET_MPP_X		0x314
 #define H_SET_MODE		0x31C
-#define MAX_HCALL_OPCODE	H_SET_MODE
+#define H_RESIZE_HPT_PREPARE	0x36C
+#define H_RESIZE_HPT_COMMIT	0x370
+#define MAX_HCALL_OPCODE	H_RESIZE_HPT_COMMIT
 
 /* H_VIOCTL functions */
 #define H_GET_VIOA_DUMP_SIZE	0x01
diff --git a/arch/powerpc/include/asm/plpar_wrappers.h b/arch/powerpc/include/asm/plpar_wrappers.h
index 1b39424..b7ee6d9 100644
--- a/arch/powerpc/include/asm/plpar_wrappers.h
+++ b/arch/powerpc/include/asm/plpar_wrappers.h
@@ -242,6 +242,18 @@ static inline long plpar_pte_protect(unsigned long flags, unsigned long ptex,
 	return plpar_hcall_norets(H_PROTECT, flags, ptex, avpn);
 }
 
+static inline long plpar_resize_hpt_prepare(unsigned long flags,
+					    unsigned long shift)
+{
+	return plpar_hcall_norets(H_RESIZE_HPT_PREPARE, flags, shift);
+}
+
+static inline long plpar_resize_hpt_commit(unsigned long flags,
+					   unsigned long shift)
+{
+	return plpar_hcall_norets(H_RESIZE_HPT_COMMIT, flags, shift);
+}
+
 static inline long plpar_tce_get(unsigned long liobn, unsigned long ioba,
 		unsigned long *tce_ret)
 {
diff --git a/arch/powerpc/platforms/pseries/firmware.c b/arch/powerpc/platforms/pseries/firmware.c
index ea7f09b..658c02d 100644
--- a/arch/powerpc/platforms/pseries/firmware.c
+++ b/arch/powerpc/platforms/pseries/firmware.c
@@ -64,6 +64,7 @@ hypertas_fw_features_table[] = {
 	{FW_FEATURE_VPHN,		"hcall-vphn"},
 	{FW_FEATURE_SET_MODE,		"hcall-set-mode"},
 	{FW_FEATURE_BEST_ENERGY,	"hcall-best-energy-1*"},
+	{FW_FEATURE_HPT_RESIZE,		"hcall-hpt-resize"},
 };
 
 /* Build up the firmware features bitmask using the contents of
-- 
2.9.3
