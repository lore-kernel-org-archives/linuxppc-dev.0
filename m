Return-Path: <bsingharora@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t7XR81RlRzDt1Y
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Nov 2016 00:40:04 +1100 (AEDT)
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3t7XR73yDRz9t0q
 for <linuxppc-dev@ozlabs.org>; Wed,  2 Nov 2016 00:40:03 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id y68so5866770pfb.1
 for <linuxppc-dev@ozlabs.org>; Tue, 01 Nov 2016 06:40:03 -0700 (PDT)
From: Balbir Singh <bsingharora@gmail.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 3/3] Enable storage keys for radix - user mode execution
Date: Wed,  2 Nov 2016 00:38:20 +1100
Message-Id: <1478007500-23624-4-git-send-email-bsingharora@gmail.com>
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

ISA 3 defines new encoded access authority that allows instruction
access prevention in privileged mode and allows normal access
to problem state. This patch just enables IAMR (Instruction Authority
Mask Register), enabling AMR would require more work.

I've tested this with a buggy driver and a simple payload. The payload
is specific to the build I've tested.

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---
 arch/powerpc/mm/pgtable-radix.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index 0fdd8ed..cd3d400 100644
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
+	iamr |= iamr_mask;
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
 
-- 
2.5.5
