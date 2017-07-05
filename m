Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x2XF00qP5zDr13
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Jul 2017 17:14:44 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id c24so19239923pfe.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Jul 2017 00:14:44 -0700 (PDT)
From: Balbir Singh <bsingharora@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	mpe@ellerman.id.au
Subject: [PATCH 2/3] powerpc/mm/hash: WARN if relocation is enabled and
 CONFIG_STRICT_KERNEL_RWX
Date: Wed,  5 Jul 2017 17:14:24 +1000
Message-Id: <20170705071425.5417-3-bsingharora@gmail.com>
In-Reply-To: <20170705071425.5417-1-bsingharora@gmail.com>
References: <20170705071425.5417-1-bsingharora@gmail.com>
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
 arch/powerpc/mm/pgtable-hash64.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/pgtable-hash64.c b/arch/powerpc/mm/pgtable-hash64.c
index 0809102b..7c2479d 100644
--- a/arch/powerpc/mm/pgtable-hash64.c
+++ b/arch/powerpc/mm/pgtable-hash64.c
@@ -438,6 +438,11 @@ void hash__mark_rodata_ro(void)
 		return;
 	}
 
+	if (PHYSICAL_START > MEMORY_START)
+		pr_warn("Detected relocation and CONFIG_STRICT_KERNEL_RWX "
+			"permissions are best effort, some non-text area "
+			"might still be left as executable");
+
 	shift = mmu_psize_defs[mmu_linear_psize].shift;
 	step = 1 << shift;
 
@@ -448,7 +453,7 @@ void hash__mark_rodata_ro(void)
 			start, end, step);
 
 	if (start == end) {
-		pr_warn("could not set rodata ro, relocate the start"
+		pr_warn("Could not set rodata ro, relocate the start"
 			" of the kernel to a 0x%x boundary\n", step);
 		return;
 	}
-- 
2.9.4
