Return-Path: <bsingharora@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t7XQx61zkzDt31
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Nov 2016 00:39:53 +1100 (AEDT)
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3t7XQw72Sdz9t0q
 for <linuxppc-dev@ozlabs.org>; Wed,  2 Nov 2016 00:39:52 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id y68so5866471pfb.1
 for <linuxppc-dev@ozlabs.org>; Tue, 01 Nov 2016 06:39:52 -0700 (PDT)
From: Balbir Singh <bsingharora@gmail.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 1/3] Setup AMOR in HV mode
Date: Wed,  2 Nov 2016 00:38:18 +1100
Message-Id: <1478007500-23624-2-git-send-email-bsingharora@gmail.com>
In-Reply-To: <1478007500-23624-1-git-send-email-bsingharora@gmail.com>
References: <1478007500-23624-1-git-send-email-bsingharora@gmail.com>
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
 arch/powerpc/mm/pgtable-radix.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index ed7bddc..0fdd8ed 100644
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
+	amor |= amor_mask;
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
-- 
2.5.5
