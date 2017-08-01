Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xMCHD1GQkzDrMP
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Aug 2017 20:29:28 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: anton@samba.org,
	aneesh.kumar@linux.vnet.ibm.com
Subject: [PATCH 2/3] powerpc/mm/slb: Move comment next to the code it's
 referring to
Date: Tue,  1 Aug 2017 20:29:23 +1000
Message-Id: <1501583364-14909-2-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1501583364-14909-1-git-send-email-mpe@ellerman.id.au>
References: <1501583364-14909-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There is a comment in slb_allocate() referring to the load of
paca->vmalloc_sllp, but it's several lines prior in the assembly.
We're about to change this code, and we want to add another comment,
so move the comment immediately prior to the instruction it's talking
about.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/mm/slb_low.S | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/slb_low.S b/arch/powerpc/mm/slb_low.S
index bde378559d01..2eb1b92a68ff 100644
--- a/arch/powerpc/mm/slb_low.S
+++ b/arch/powerpc/mm/slb_low.S
@@ -121,12 +121,13 @@ slb_miss_kernel_load_vmemmap:
 1:
 #endif /* CONFIG_SPARSEMEM_VMEMMAP */
 
-	/* vmalloc mapping gets the encoding from the PACA as the mapping
-	 * can be demoted from 64K -> 4K dynamically on some machines
-	 */
 	clrldi	r11,r10,48
 	cmpldi	r11,(H_VMALLOC_SIZE >> 28) - 1
 	bgt	5f
+	/*
+	 * vmalloc mapping gets the encoding from the PACA as the mapping
+	 * can be demoted from 64K -> 4K dynamically on some machines.
+	 */
 	lhz	r11,PACAVMALLOCSLLP(r13)
 	b	6f
 5:
-- 
2.7.4
