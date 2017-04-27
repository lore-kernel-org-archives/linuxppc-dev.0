Return-Path: <piliu@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wD87l2XR6zDqCd
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Apr 2017 17:43:15 +1000 (AEST)
From: Pingfan Liu <piliu@redhat.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Hari Bathini <hbathini@linux.vnet.ibm.com>, kernelfans@gmail.com
Subject: [PATCH] powerpc/pseries hotplug: prevent the reserved mem from
 removing
Date: Thu, 27 Apr 2017 15:43:08 +0800
Message-Id: <1493278988-26169-1-git-send-email-piliu@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

E.g after fadump reserves mem regions, these regions should not be removed
before fadump explicitly free them.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
---
 arch/powerpc/platforms/pseries/hotplug-memory.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index e104c71..201be23 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -346,6 +346,8 @@ static int pseries_remove_memblock(unsigned long base, unsigned int memblock_siz
 
 	if (!pfn_valid(start_pfn))
 		goto out;
+	if (memblock_is_reserved(base))
+		return -EINVAL;
 
 	block_sz = pseries_memory_block_size();
 	sections_per_block = block_sz / MIN_MEMORY_BLOCK_SIZE;
@@ -388,8 +390,7 @@ static int pseries_remove_mem_node(struct device_node *np)
 	base = be64_to_cpu(*(unsigned long *)regs);
 	lmb_size = be32_to_cpu(regs[3]);
 
-	pseries_remove_memblock(base, lmb_size);
-	return 0;
+	return pseries_remove_memblock(base, lmb_size);
 }
 
 static bool lmb_is_removable(struct of_drconf_cell *lmb)
-- 
2.7.4
