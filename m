Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xLdcd19kBzDsRn
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Jul 2017 22:12:33 +1000 (AEST)
Received: by mail-pg0-x243.google.com with SMTP id l64so231348pge.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Jul 2017 05:12:33 -0700 (PDT)
From: Balbir Singh <bsingharora@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 2/3] powerpc/mm/hash: WARN if relocation is enabled and
 CONFIG_STRICT_KERNEL_RWX
Date: Mon, 31 Jul 2017 22:11:02 +1000
Message-Id: <20170731121103.6984-3-bsingharora@gmail.com>
In-Reply-To: <20170731121103.6984-1-bsingharora@gmail.com>
References: <20170731121103.6984-1-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For radix we split the mapping into smaller page sizes (at the cost of
additional TLB overhead), but for hash its best to print a warning. In
the case of hash and no-relocation, the kernel should be well aligned
to provide the least overhead with the current linear mapping size (16M)

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---
 arch/powerpc/mm/pgtable-hash64.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/pgtable-hash64.c b/arch/powerpc/mm/pgtable-hash64.c
index 443a2c6..656f7f3 100644
--- a/arch/powerpc/mm/pgtable-hash64.c
+++ b/arch/powerpc/mm/pgtable-hash64.c
@@ -434,8 +434,26 @@ static bool hash__change_memory_range(unsigned long start, unsigned long end,
 	shift = mmu_psize_defs[mmu_linear_psize].shift;
 	step = 1 << shift;
 
-	start = ALIGN_DOWN(start, step);
-	end = ALIGN(end, step); // aligns up
+	if (!IS_ALIGNED(PHYSICAL_START, step)) {
+		/*
+		 * For the relocatable case we might have
+		 * a case where _stext shares the page
+		 * with rw memory or __init_begin might
+		 * share the page with executable text.
+		 * This breaks strict RWX, but allows the
+		 * kernel to boot. If PHYSICAL_START is mmu_linear_psize
+		 * aligned, then we can continue to make the same
+		 * assumptions as the non-relocatable case.
+		 *
+		 * TODO: If we really care about the relocatable
+		 * case, we can align __init_begin/end better.
+		 */
+		start = ALIGN(start, step);
+		end = ALIGN_DOWN(end, step);
+	} else {
+		start = ALIGN_DOWN(start, step);
+		end = ALIGN(end, step); /* Aligns up */
+	}
 
 	if (start >= end)
 		return false;
@@ -455,6 +473,12 @@ void hash__mark_rodata_ro(void)
 {
 	unsigned long start, end;
 
+	if (PHYSICAL_START > MEMORY_START)
+		pr_warn("Detected relocation and CONFIG_STRICT_KERNEL_RWX "
+			"permissions are best effort, some non-text area "
+			"might still be left as executable");
+
+
 	start = (unsigned long)_stext;
 	end = (unsigned long)__init_begin;
 
-- 
2.9.4
