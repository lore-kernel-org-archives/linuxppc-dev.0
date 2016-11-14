Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tHJrV2L0JzDvPn
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2016 16:25:30 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id p66so8016660pga.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 Nov 2016 21:25:30 -0800 (PST)
From: Balbir Singh <bsingharora@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [powerpc v4 1/3] Setup AMOR in HV mode
Date: Mon, 14 Nov 2016 16:25:10 +1100
Message-Id: <1479101112-21120-2-git-send-email-bsingharora@gmail.com>
In-Reply-To: <1479101112-21120-1-git-send-email-bsingharora@gmail.com>
References: <1479101112-21120-1-git-send-email-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

AMOR should be setup in HV mode, we set it up once
and let the generic kernel handle IAMR. This patch is
used to enable storage keys in a following patch as
defined in ISA 3

Reported-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---
 arch/powerpc/mm/pgtable-radix.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index ed7bddc..7343573 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -320,6 +320,25 @@ static void update_hid_for_radix(void)
 		cpu_relax();
 }
 
+/*
+ * In HV mode, we init AMOR so that the hypervisor
+ * and guest can setup IMAR, enable key 0 and set
+ * it to 1
+ * AMOR = 1100....00 (Mask for key 0 is 11)
+ */
+static void __init radix_init_amor(void)
+{
+	unsigned long amor_mask = 0xc000000000000000;
+	unsigned long amor = mfspr(SPRN_AMOR);
+
+	if (cpu_has_feature(CPU_FTR_POWER9_DD1))
+		return;
+
+	amor = amor_mask;
+
+	mtspr(SPRN_AMOR, amor);
+}
+
 void __init radix__early_init_mmu(void)
 {
 	unsigned long lpcr;
@@ -376,6 +395,7 @@ void __init radix__early_init_mmu(void)
 		lpcr = mfspr(SPRN_LPCR);
 		mtspr(SPRN_LPCR, lpcr | LPCR_UPRT | LPCR_HR);
 		radix_init_partition_table();
+		radix_init_amor();
 	}
 
 	radix_init_pgtable();
@@ -393,6 +413,7 @@ void radix__early_init_mmu_secondary(void)
 
 		mtspr(SPRN_PTCR,
 		      __pa(partition_tb) | (PATB_SIZE_SHIFT - 12));
+		radix_init_amor();
 	}
 }
 
-- 
2.5.5
