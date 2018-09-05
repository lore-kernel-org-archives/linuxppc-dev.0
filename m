Return-Path: <rppt@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4257hl56PJzF38p
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Sep 2018 02:00:39 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w85FtUPx022380
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Sep 2018 12:00:37 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2maj548k7t-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Sep 2018 12:00:33 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <rppt@linux.vnet.ibm.com>;
 Wed, 5 Sep 2018 17:00:31 +0100
From: Mike Rapoport <rppt@linux.vnet.ibm.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Ingo Molnar <mingo@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Michal Hocko <mhocko@suse.com>, Paul Burton <paul.burton@mips.com>,
 Thomas Gleixner <tglx@linutronix.de>, Tony Luck <tony.luck@intel.com>,
 linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
 linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [RFC PATCH 14/29] memblock: add align parameter to
 memblock_alloc_node()
Date: Wed,  5 Sep 2018 18:59:29 +0300
In-Reply-To: <1536163184-26356-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1536163184-26356-1-git-send-email-rppt@linux.vnet.ibm.com>
Message-Id: <1536163184-26356-15-git-send-email-rppt@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With the align parameter memblock_alloc_node() can be used as drop in
replacement for alloc_bootmem_pages_node().

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
---
 include/linux/bootmem.h | 4 ++--
 mm/sparse.c             | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/bootmem.h b/include/linux/bootmem.h
index 7d91f0f..3896af2 100644
--- a/include/linux/bootmem.h
+++ b/include/linux/bootmem.h
@@ -157,9 +157,9 @@ static inline void * __init memblock_alloc_from_nopanic(
 }
 
 static inline void * __init memblock_alloc_node(
-						phys_addr_t size, int nid)
+		phys_addr_t size, phys_addr_t align, int nid)
 {
-	return memblock_alloc_try_nid(size, 0, BOOTMEM_LOW_LIMIT,
+	return memblock_alloc_try_nid(size, align, BOOTMEM_LOW_LIMIT,
 					    BOOTMEM_ALLOC_ACCESSIBLE, nid);
 }
 
diff --git a/mm/sparse.c b/mm/sparse.c
index 04e97af..509828f 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -68,7 +68,7 @@ static noinline struct mem_section __ref *sparse_index_alloc(int nid)
 	if (slab_is_available())
 		section = kzalloc_node(array_size, GFP_KERNEL, nid);
 	else
-		section = memblock_alloc_node(array_size, nid);
+		section = memblock_alloc_node(array_size, 0, nid);
 
 	return section;
 }
-- 
2.7.4
