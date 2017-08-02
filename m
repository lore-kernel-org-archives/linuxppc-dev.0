Return-Path: <pasha.tatashin@oracle.com>
Received: from userp1050.oracle.com (userp1050.oracle.com [156.151.31.82])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xN4nB24kPzDqnQ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Aug 2017 06:39:58 +1000 (AEST)
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 by userp1050.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id
 v72KduI0026612
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Aug 2017 20:39:56 GMT
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 x86@kernel.org, kasan-dev@googlegroups.com, borntraeger@de.ibm.com,
 heiko.carstens@de.ibm.com, davem@davemloft.net, willy@infradead.org,
 mhocko@kernel.org
Subject: [v4 15/15] mm: debug for raw alloctor
Date: Wed,  2 Aug 2017 16:38:24 -0400
Message-Id: <1501706304-869240-16-git-send-email-pasha.tatashin@oracle.com>
In-Reply-To: <1501706304-869240-1-git-send-email-pasha.tatashin@oracle.com>
References: <1501706304-869240-1-git-send-email-pasha.tatashin@oracle.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When CONFIG_DEBUG_VM is enabled, this patch sets all the memory that is
returned by memblock_virt_alloc_try_nid_raw() to ones to ensure that no
places excpect zeroed memory.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Reviewed-by: Steven Sistare <steven.sistare@oracle.com>
Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
Reviewed-by: Bob Picco <bob.picco@oracle.com>
---
 mm/memblock.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index bdf31f207fa4..b6f90e75946c 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1363,12 +1363,19 @@ void * __init memblock_virt_alloc_try_nid_raw(
 			phys_addr_t min_addr, phys_addr_t max_addr,
 			int nid)
 {
+	void *ptr;
+
 	memblock_dbg("%s: %llu bytes align=0x%llx nid=%d from=0x%llx max_addr=0x%llx %pF\n",
 		     __func__, (u64)size, (u64)align, nid, (u64)min_addr,
 		     (u64)max_addr, (void *)_RET_IP_);
 
-	return memblock_virt_alloc_internal(size, align,
-					    min_addr, max_addr, nid);
+	ptr = memblock_virt_alloc_internal(size, align,
+					   min_addr, max_addr, nid);
+#ifdef CONFIG_DEBUG_VM
+	if (ptr && size > 0)
+		memset(ptr, 0xff, size);
+#endif
+	return ptr;
 }
 
 /**
-- 
2.13.3
