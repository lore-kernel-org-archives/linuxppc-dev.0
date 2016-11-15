Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tHyq76vh8zDvj8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2016 17:56:35 +1100 (AEDT)
Received: by mail-pg0-x242.google.com with SMTP id x23so11035114pgx.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2016 22:56:35 -0800 (PST)
From: Balbir Singh <bsingharora@gmail.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
	Balbir Singh <bsingharora@gmail.com>
Subject: [powerpc v6 3/3] Enable storage keys for radix - user mode execution
Date: Tue, 15 Nov 2016 17:56:16 +1100
Message-Id: <1479192976-17847-4-git-send-email-bsingharora@gmail.com>
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

ISA 3 defines new encoded access authority that allows instruction
access prevention in privileged mode and allows normal access
to problem state. This patch just enables IAMR (Instruction Authority
Mask Register), enabling AMR would require more work.

I've tested this with a buggy driver and a simple payload. The payload
is specific to the build I've tested.

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---
 arch/powerpc/mm/pgtable-radix.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index 7aa104d..1a3ea06 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -341,6 +341,26 @@ static void radix_init_amor(void)
 	mtspr(SPRN_AMOR, amor);
 }
 
+/*
+ * For radix page tables we setup, the IAMR values as follows
+ * IMAR = 0100...00 (key 0 is set to 1)
+ * AMR, UAMR, UAMOR are not affected
+ */
+static void radix_init_iamr(void)
+{
+	unsigned long iamr_mask = 0x4000000000000000;
+	unsigned long iamr;
+
+	/*
+	 * The IAMR should set to 0 in DD1
+	 */
+	if (cpu_has_feature(CPU_FTR_POWER9_DD1))
+		return;
+
+	iamr = iamr_mask;
+	mtspr(SPRN_IAMR, iamr);
+}
+
 void __init radix__early_init_mmu(void)
 {
 	unsigned long lpcr;
@@ -400,6 +420,7 @@ void __init radix__early_init_mmu(void)
 		radix_init_amor();
 	}
 
+	radix_init_iamr();
 	radix_init_pgtable();
 }
 
@@ -417,6 +438,7 @@ void radix__early_init_mmu_secondary(void)
 		      __pa(partition_tb) | (PATB_SIZE_SHIFT - 12));
 		radix_init_amor();
 	}
+	radix_init_iamr();
 }
 
 void radix__mmu_cleanup_all(void)
-- 
2.5.5
