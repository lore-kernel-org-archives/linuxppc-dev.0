Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tHyq30QXPzDvhR
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2016 17:56:31 +1100 (AEDT)
Received: by mail-pg0-x242.google.com with SMTP id e9so10692337pgc.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2016 22:56:30 -0800 (PST)
From: Balbir Singh <bsingharora@gmail.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
	Balbir Singh <bsingharora@gmail.com>
Subject: [powerpc v6 1/3] Setup AMOR in HV mode
Date: Tue, 15 Nov 2016 17:56:14 +1100
Message-Id: <1479192976-17847-2-git-send-email-bsingharora@gmail.com>
In-Reply-To: <1479192976-17847-1-git-send-email-bsingharora@gmail.com>
References: <1479192976-17847-1-git-send-email-bsingharora@gmail.com>
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
defined in ISA 3. We don't setup AMOR in DD1, since we
can't setup IAMR in DD1 (bits have to be 0). If we setup
AMOR some other code could potentially try to set IAMR
(guest kernel for example).

Reported-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---
 arch/powerpc/mm/pgtable-radix.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index ed7bddc..7aa104d 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -320,6 +320,27 @@ static void update_hid_for_radix(void)
 		cpu_relax();
 }
 
+/*
+ * In HV mode, we init AMOR so that the hypervisor
+ * and guest can setup IMAR, enable key 0 and set
+ * it to 1
+ * AMOR = 1100....00 (Mask for key 0 is 11)
+ */
+static void radix_init_amor(void)
+{
+	unsigned long amor_mask = 0xc000000000000000;
+	unsigned long amor;
+
+	/*
+	 * The amor bits are unused in DD1
+	 */
+	if (cpu_has_feature(CPU_FTR_POWER9_DD1))
+		return;
+
+	amor = amor_mask;
+	mtspr(SPRN_AMOR, amor);
+}
+
 void __init radix__early_init_mmu(void)
 {
 	unsigned long lpcr;
@@ -376,6 +397,7 @@ void __init radix__early_init_mmu(void)
 		lpcr = mfspr(SPRN_LPCR);
 		mtspr(SPRN_LPCR, lpcr | LPCR_UPRT | LPCR_HR);
 		radix_init_partition_table();
+		radix_init_amor();
 	}
 
 	radix_init_pgtable();
@@ -393,6 +415,7 @@ void radix__early_init_mmu_secondary(void)
 
 		mtspr(SPRN_PTCR,
 		      __pa(partition_tb) | (PATB_SIZE_SHIFT - 12));
+		radix_init_amor();
 	}
 }
 
-- 
2.5.5
