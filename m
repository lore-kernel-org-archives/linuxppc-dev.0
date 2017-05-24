Return-Path: <jk@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wXjhG2Hx0zDqZS
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 May 2017 16:50:22 +1000 (AEST)
From: Jeremy Kerr <jk@ozlabs.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Sombat Tragolgosol <sombat3960@gmail.com>, Jeremy Kerr <jk@ozlabs.org>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/spufs: Fix hash faults for kernel regions
Date: Wed, 24 May 2017 16:49:59 +1000
Message-Id: <1495608599-16819-1-git-send-email-jk@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Change ac29c64089b7 swapped _PAGE_USER for _PAGE_PRIVILEGED, and
introduced check_pte_access() which denied kernel access to
non-_PAGE_PRIVILEGED pages.

However, it didn't add _PAGE_PRIVILEGED to the hash fault handler for
spufs' kernel accesses, so the DMAs required to establish SPE memory
no longer work.

This change adds _PAGE_PRIVILEGED to the hash fault handler for
kernel accesses.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
Reported-by: Sombat Tragolgosol <sombat3960@gmail.com>
CC: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/cell/spu_base.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/cell/spu_base.c b/arch/powerpc/platforms/cell/spu_base.c
index 96c2b8a..0c45cdb 100644
--- a/arch/powerpc/platforms/cell/spu_base.c
+++ b/arch/powerpc/platforms/cell/spu_base.c
@@ -197,7 +197,9 @@ static int __spu_trap_data_map(struct spu *spu, unsigned long ea, u64 dsisr)
 	    (REGION_ID(ea) != USER_REGION_ID)) {
 
 		spin_unlock(&spu->register_lock);
-		ret = hash_page(ea, _PAGE_PRESENT | _PAGE_READ, 0x300, dsisr);
+		ret = hash_page(ea,
+				_PAGE_PRESENT | _PAGE_READ | _PAGE_PRIVILEGED,
+				0x300, dsisr);
 		spin_lock(&spu->register_lock);
 
 		if (!ret) {
-- 
2.7.4
