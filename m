Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z1hXB1xx4zDr77
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Dec 2017 15:25:30 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: anton@samba.org, aneesh.kumar@linux.vnet.ibm.com,
 david@gibson.dropbear.id.au
Subject: [PATCH] powerpc/pseries: Increase memory block size to 1GB on radix
Date: Wed, 20 Dec 2017 15:25:20 +1100
Message-Id: <20171220042520.7946-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When we're using the Radix MMU we map the kernel linear mapping with
1G pages. That means we must do memory hot remove in blocks of at
least that size. Otherwise the linear mapping can end up not mapping
all of memory because we've removed part of a 1G region but unmapped
the entire 1G region from the linear mapping.

Currently on pseries we consult the device tree to find out the the
"LMB" (Logical Memory Block) size. This is the unit of memory hotplug
communicated to us by the hypervisor, but it does not take into
account anything the kernel has done itself, such as use 1G pages for
the linear mapping.

So take what's in the device tree as a start, but make sure we round
up to 1G when Radix is enabled if the size from the device tree is
smaller.

Note that this code is also theoretically broken on hash, except that
with hash we use 16MB pages for the linear mapping and all hypervisors
I'm aware of use at least a 256MB LMB size.

Fixes: 4b5d62ca17a1 ("powerpc/mm: add radix__remove_section_mapping()")
Cc: stable@vger.kernel.org # v4.11+
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/platforms/pseries/hotplug-memory.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index 1d48ab424bd9..a602be935777 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -67,6 +67,15 @@ unsigned long pseries_memory_block_size(void)
 			}
 		}
 	}
+
+	/*
+	 * We map the kernel linear region with 1GB large pages on radix. For
+	 * memory hot unplug to work our memory block size must be at least
+	 * that big.
+	 */
+	if (radix_enabled())
+		memblock_size = max(1u << 30, memblock_size);
+
 	return memblock_size;
 }
 
-- 
2.14.3
