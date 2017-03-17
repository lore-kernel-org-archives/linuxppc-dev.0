Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vknNW1KX2zDqZf
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Mar 2017 12:11:23 +1100 (AEDT)
From: David Gibson <david@gibson.dropbear.id.au>
To: michael@ellerman.id.au
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH] powerpc/pseries: Don't give a warning when HPT resizing isn't
 available
Date: Fri, 17 Mar 2017 12:11:19 +1100
Message-Id: <20170317011119.31091-1-david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As of 438cc81a41 "powerpc/pseries: Automatically resize HPT for memory hot
add/remove" when running on the pseries platform, we always attempt to
use the PAPR extension to resize the hashed page table (HPT) when we add
or remove memory.

This is fine, but when the extension is available we'll give a harmless,
but scary warning.  This patch suppresses the warning in this case.  It
will still warn if the feature is supposed to be available, but didn't
work.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 arch/powerpc/mm/hash_utils_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Kind of cosmetic, but getting an error message on every memory hot
plug/unplug attempt if your host doesn't support HPT resizing is
pretty ugly.  So I think this is a candidate for quick inclusion.

diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index c554768..cc16e4f 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -771,7 +771,7 @@ void resize_hpt_for_hotplug(unsigned long new_mem_size)
 		int rc;
 
 		rc = mmu_hash_ops.resize_hpt(target_hpt_shift);
-		if (rc)
+		if (rc && (rc != -ENODEV))
 			printk(KERN_WARNING
 			       "Unable to resize hash page table to target order %d: %d\n",
 			       target_hpt_shift, rc);
-- 
2.9.3
