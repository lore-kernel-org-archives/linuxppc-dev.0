Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sHcBy6zVwzDr5Q
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Aug 2016 11:57:14 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id h186so5325484pfg.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Aug 2016 18:57:14 -0700 (PDT)
From: Balbir Singh <bsingharora@gmail.com>
To: benh@kernel.crashing.org,
	paulus@samba.org,
	mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, Michael Neuling <mikey@neuling.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>
Subject: [PATCH 1/2] Enable storage keys for radix - user mode execution
Date: Mon, 22 Aug 2016 11:56:56 +1000
Message-Id: <1471831017-18167-1-git-send-email-bsingharora@gmail.com>
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
index af897d9..9e25663 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -294,6 +294,27 @@ found:
 	return;
 }
 
+/*
+ * For radix page tables we setup, the IAMR values as follows
+ * IMAR = 0100...00 (key 0 is set to 1)
+ * AMOR = 1100....00 (Mask for key 0 is 11)
+ * AMR, UAMR, UAMOR are not affected
+ */
+static void __init radix_init_iamr(void)
+{
+	unsigned long iamr_mask = 0x4000000000000000;
+	unsigned long iamr = mfspr(SPRN_IAMR);
+
+	unsigned long amor_mask = 0xc000000000000000;
+	unsigned long amor = mfspr(SPRN_AMOR);
+
+	iamr |= iamr_mask;
+	amor |= amor_mask;
+
+	mtspr(SPRN_AMOR, amor);
+	mtspr(SPRN_IAMR, iamr);
+}
+
 void __init radix__early_init_mmu(void)
 {
 	unsigned long lpcr;
@@ -350,6 +371,7 @@ void __init radix__early_init_mmu(void)
 		radix_init_partition_table();
 	}
 
+	radix_init_iamr();
 	radix_init_pgtable();
 }
 
-- 
2.5.5
