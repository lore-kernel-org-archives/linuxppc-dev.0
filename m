Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 97748B7B94
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 13 Oct 2009 17:44:55 +1100 (EST)
Subject: [PATCH] powerpc/mm: Fix hang accessing top of vmalloc space
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 13 Oct 2009 17:43:47 +1100
Message-Id: <1255416227.2192.184.camel@pasglop>
Mime-Version: 1.0
Cc: Tejun Heo <tj@kernel.org>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On pSeries, we always force the IO space to be mapped using 4K
pages even with a 64K base page size to cope with some limitations
in the HV interface to some devices.

However, the SLB miss handler code to discriminate between vmalloc
and ioremap space uses a CPU feature section such that the code
is nop'ed out when the processor support large pages non-cachable
mappings.

Thus, we end up always using the ioremap page size for vmalloc
segments on such processors, causing a discrepency between the
segment and the hash table, and thus a hang continously hashing
the page.

It works for the first segment of the vmalloc space since that
segment is "bolted" in by C code correctly, and thankfully we
almost never use the vmalloc space beyond the first segment,
but the new percpu code made the bug happen.

This fixes it by removing the feature section from the assembly,
we now always do the comparison between vmalloc and ioremap.

Signed-off-by; Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Sachin, can you verify that works for you ?

diff --git a/arch/powerpc/mm/slb_low.S b/arch/powerpc/mm/slb_low.S
index bc44dc4..95ce355 100644
--- a/arch/powerpc/mm/slb_low.S
+++ b/arch/powerpc/mm/slb_low.S
@@ -72,19 +72,17 @@ _GLOBAL(slb_miss_kernel_load_vmemmap)
 1:
 #endif /* CONFIG_SPARSEMEM_VMEMMAP */
 
-	/* vmalloc/ioremap mapping encoding bits, the "li" instructions below
-	 * will be patched by the kernel at boot
+	/* vmalloc mapping gets the encoding from the PACA as the mapping
+	 * can be demoted from 64K -> 4K dynamically on some machines
 	 */
-BEGIN_FTR_SECTION
-	/* check whether this is in vmalloc or ioremap space */
 	clrldi	r11,r10,48
 	cmpldi	r11,(VMALLOC_SIZE >> 28) - 1
 	bgt	5f
 	lhz	r11,PACAVMALLOCSLLP(r13)
 	b	6f
 5:
-END_FTR_SECTION_IFCLR(CPU_FTR_CI_LARGE_PAGE)
-_GLOBAL(slb_miss_kernel_load_io)
+	/* IO mapping */
+	_GLOBAL(slb_miss_kernel_load_io)
 	li	r11,0
 6:
 BEGIN_FTR_SECTION
