Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tHJrb1SRTzDvHZ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2016 16:25:35 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id 3so8004061pgd.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 Nov 2016 21:25:35 -0800 (PST)
From: Balbir Singh <bsingharora@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [powerpc v4 3/3] Enable storage keys for radix - user mode execution
Date: Mon, 14 Nov 2016 16:25:12 +1100
Message-Id: <1479101112-21120-4-git-send-email-bsingharora@gmail.com>
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

ISA 3 defines new encoded access authority that allows instruction
access prevention in privileged mode and allows normal access
to problem state. This patch just enables IAMR (Instruction Authority
Mask Register), enabling AMR would require more work.

I've tested this with a buggy driver and a simple payload. The payload
is specific to the build I've tested.

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---
 arch/powerpc/mm/pgtable-radix.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index 7343573..5c90bcd 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -339,6 +339,24 @@ static void __init radix_init_amor(void)
 	mtspr(SPRN_AMOR, amor);
 }
 
+/*
+ * For radix page tables we setup, the IAMR values as follows
+ * IMAR = 0100...00 (key 0 is set to 1)
+ * AMR, UAMR, UAMOR are not affected
+ */
+static void __init radix_init_iamr(void)
+{
+	unsigned long iamr_mask = 0x4000000000000000;
+	unsigned long iamr = mfspr(SPRN_IAMR);
+
+	if (cpu_has_feature(CPU_FTR_POWER9_DD1))
+		return;
+
+	iamr = iamr_mask;
+
+	mtspr(SPRN_IAMR, iamr);
+}
+
 void __init radix__early_init_mmu(void)
 {
 	unsigned long lpcr;
@@ -398,6 +416,7 @@ void __init radix__early_init_mmu(void)
 		radix_init_amor();
 	}
 
+	radix_init_iamr();
 	radix_init_pgtable();
 }
 
@@ -415,6 +434,7 @@ void radix__early_init_mmu_secondary(void)
 		      __pa(partition_tb) | (PATB_SIZE_SHIFT - 12));
 		radix_init_amor();
 	}
+	radix_init_iamr();
 }
 
 void radix__mmu_cleanup_all(void)
-- 
2.5.5
