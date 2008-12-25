Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5F629DDECA
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Dec 2008 19:07:45 +1100 (EST)
Date: Thu, 25 Dec 2008 00:07:35 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Chandru <chandru@in.ibm.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>
Subject: Re: 2.6.28-rc9 panics with crashkernel=256M while booting
Message-Id: <20081225000735.4dd4e802.akpm@linux-foundation.org>
In-Reply-To: <20081224233536.b067c9da.akpm@linux-foundation.org>
References: <200812241325.49404.chandru@in.ibm.com>
	<20081224233536.b067c9da.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 24 Dec 2008 23:35:36 -0800 Andrew Morton <akpm@linux-foundation.org> wrote:

> - Please put [patch] in the Subject: line of patches
> 
> - Please choose a suitable title, as per
>   Documentation/SubmittingPatches, section 15.
> 
> - Please cc suitable mailing lists and maintainers on bug reports and
>   on patches.

Also the patch was wordwrapped and the changelog was filled with weird
UTF8 characters.

I think I have it all cleaned up now.


From: Chandru <chandru@in.ibm.com>

When booted with crashkernel=224M@32M or any memory size less than this,
the system boots properly.  The following was the observation..  The
system comes up with two nodes (0-256M and 256M-4GB).  The crashkernel
memory reservation spans across these two nodes.  The
mark_reserved_regions_for_nid() in arch/powerpc/mm/numa.c resizes the
reserved part of the memory within it as:

	if (end_pfn > node_ar.end_pfn)
		reserve_size = (node_ar.end_pfn << PAGE_SHIFT)
				- (start_pfn << PAGE_SHIFT);


but the reserve_bootmem_node() in mm/bootmem.c raises the pfn value of end 

	end = PFN_UP(physaddr + size);

This causes end to get a value past the last page in the 0-256M node. 
Again when reserve_bootmem_node() returns, mark_reserved_regions_for_nid()
loops around to set the rest of the crashkernel memory in the next node as
reserved.  It references NODE_DATA(node_ar.nid) and this causes another
'Oops: kernel access of bad area' problem.  The following changes made the
system to boot with any amount of crashkernel memory size.

Signed-off-by: Chandru S <chandru@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/powerpc/mm/numa.c |    7 ++++---
 mm/bootmem.c           |    4 ++++
 2 files changed, 8 insertions(+), 3 deletions(-)

diff -puN arch/powerpc/mm/numa.c~powerpc-fix-code-for-reserved-memory-spanning-across-nodes arch/powerpc/mm/numa.c
--- a/arch/powerpc/mm/numa.c~powerpc-fix-code-for-reserved-memory-spanning-across-nodes
+++ a/arch/powerpc/mm/numa.c
@@ -995,10 +995,11 @@ void __init do_init_bootmem(void)
 				  start_pfn, end_pfn);
 
 		free_bootmem_with_active_regions(nid, end_pfn);
+	}
+
+	for_each_online_node(nid) {
 		/*
-		 * Be very careful about moving this around.  Future
-		 * calls to careful_allocation() depend on this getting
-		 * done correctly.
+		 * Be very careful about moving this around.
 		 */
 		mark_reserved_regions_for_nid(nid);
 		sparse_memory_present_with_active_regions(nid);
diff -puN mm/bootmem.c~powerpc-fix-code-for-reserved-memory-spanning-across-nodes mm/bootmem.c
--- a/mm/bootmem.c~powerpc-fix-code-for-reserved-memory-spanning-across-nodes
+++ a/mm/bootmem.c
@@ -375,10 +375,14 @@ int __init reserve_bootmem_node(pg_data_
 				 unsigned long size, int flags)
 {
 	unsigned long start, end;
+	bootmem_data_t *bdata = pgdat->bdata;
 
 	start = PFN_DOWN(physaddr);
 	end = PFN_UP(physaddr + size);
 
+	if (end > bdata->node_low_pfn)
+		end = bdata->node_low_pfn;
+
 	return mark_bootmem_node(pgdat->bdata, start, end, 1, flags);
 }
 
_
