Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tXHKr3lnQzDvP3
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Dec 2016 19:02:24 +1100 (AEDT)
Date: Mon, 5 Dec 2016 19:02:19 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/3] powerpc/64: Fixes for the
 ibm,client-architecture-support options
Message-ID: <20161205080219.GA13528@fergus.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This fixes the values for some of the option vector 5 bits in
the ibm,client-architecture-support vector 5.  The "platform
facilities options" bits are in byte 17 not byte 14, so the
upper 8 bits of their definitions need to be 0x11 not 0x0E.
The "sub processor support" option is in byte 21 not byte 15.

When checking whether option bits are set, we should check that
the offset of the byte being checked is less than the vector
length that we got from the hypervisor.

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/include/asm/prom.h           | 8 ++++----
 arch/powerpc/platforms/pseries/firmware.c | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/prom.h b/arch/powerpc/include/asm/prom.h
index 5e57705..e6d83d0 100644
--- a/arch/powerpc/include/asm/prom.h
+++ b/arch/powerpc/include/asm/prom.h
@@ -151,10 +151,10 @@ struct of_drconf_cell {
 #define OV5_XCMO		0x0440	/* Page Coalescing */
 #define OV5_TYPE1_AFFINITY	0x0580	/* Type 1 NUMA affinity */
 #define OV5_PRRN		0x0540	/* Platform Resource Reassignment */
-#define OV5_PFO_HW_RNG		0x0E80	/* PFO Random Number Generator */
-#define OV5_PFO_HW_842		0x0E40	/* PFO Compression Accelerator */
-#define OV5_PFO_HW_ENCR		0x0E20	/* PFO Encryption Accelerator */
-#define OV5_SUB_PROCESSORS	0x0F01	/* 1,2,or 4 Sub-Processors supported */
+#define OV5_PFO_HW_RNG		0x1180	/* PFO Random Number Generator */
+#define OV5_PFO_HW_842		0x1140	/* PFO Compression Accelerator */
+#define OV5_PFO_HW_ENCR		0x1120	/* PFO Encryption Accelerator */
+#define OV5_SUB_PROCESSORS	0x1501	/* 1,2,or 4 Sub-Processors supported */
 
 /* Option Vector 6: IBM PAPR hints */
 #define OV6_LINUX		0x02	/* Linux is our OS */
diff --git a/arch/powerpc/platforms/pseries/firmware.c b/arch/powerpc/platforms/pseries/firmware.c
index ea7f09b..7d67623 100644
--- a/arch/powerpc/platforms/pseries/firmware.c
+++ b/arch/powerpc/platforms/pseries/firmware.c
@@ -126,7 +126,7 @@ static void __init fw_vec5_feature_init(const char *vec5, unsigned long len)
 		index = OV5_INDX(vec5_fw_features_table[i].feature);
 		feat = OV5_FEAT(vec5_fw_features_table[i].feature);
 
-		if (vec5[index] & feat)
+		if (index < len && (vec5[index] & feat))
 			powerpc_firmware_features |=
 				vec5_fw_features_table[i].val;
 	}
-- 
2.7.4
