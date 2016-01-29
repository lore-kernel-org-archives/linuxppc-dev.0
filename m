Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CB8721A1A0C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jan 2016 16:23:07 +1100 (AEDT)
From: David Gibson <david@gibson.dropbear.id.au>
To: paulus@samba.org,
	mpe@ellerman.id.au,
	benh@kernel.crashing.org
Cc: linuxppc-dev@lists.ozlabs.org, aik@ozlabs.ru, thuth@redhat.com,
 lvivier@redhat.com, David Gibson <david@gibson.dropbear.id.au>
Subject: [RFCv2 1/9] memblock: Don't mark memblock_phys_mem_size() as __init
Date: Fri, 29 Jan 2016 16:23:55 +1100
Message-Id: <1454045043-25545-2-git-send-email-david@gibson.dropbear.id.au>
In-Reply-To: <1454045043-25545-1-git-send-email-david@gibson.dropbear.id.au>
References: <1454045043-25545-1-git-send-email-david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

At the moment memblock_phys_mem_size() is marked as __init, and so is
discarded after boot.  This is different from most of the memblock
functions which are marked __init_memblock, and are only discarded after
boot if memory hotplug is not configured.

To allow for upcoming code which will need memblock_phys_mem_size() in the
hotplug path, change it from __init to __init_memblock.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 mm/memblock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index d2ed81e..dd79899 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1448,7 +1448,7 @@ void __init __memblock_free_late(phys_addr_t base, phys_addr_t size)
  * Remaining API functions
  */
 
-phys_addr_t __init memblock_phys_mem_size(void)
+phys_addr_t __init_memblock memblock_phys_mem_size(void)
 {
 	return memblock.memory.total_size;
 }
-- 
2.5.0
