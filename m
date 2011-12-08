Return-Path: <rientjes@google.com>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
 [209.85.210.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id B2C851007D7
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Dec 2011 09:33:35 +1100 (EST)
Received: by iacb35 with SMTP id b35so3148474iac.38
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Dec 2011 14:33:32 -0800 (PST)
Date: Thu, 8 Dec 2011 14:33:29 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: Subrata Modak <subrata@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [patch] powerpc, mm: fix section mismatch for
 mark_reserved_regions_for_nid
In-Reply-To: <1323371433.23534.8.camel@subratamodak.linux.ibm.com>
Message-ID: <alpine.DEB.2.00.1112081428290.28693@chino.kir.corp.google.com>
References: <1323371433.23534.8.camel@subratamodak.linux.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mark Wizner <markwiz@us.ibm.com>, Naveed <naveedaus@in.ibm.com>,
 linux-kernel@vger.kernel.org, Manas k Nayak <maknayak@in.ibm.com>,
 Pavaman <pavsubra@in.ibm.com>, Anton Blanchard <anton@samba.org>,
 Vishu <svishuku@in.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 "divya.vikas" <divya.vikas@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 9 Dec 2011, Subrata Modak wrote:

> WARNING: vmlinux.o(.text+0x4c760): Section mismatch in reference from
> the function .mark_reserved_regions_for_nid() to the
> function .meminit.text:.early_pfn_to_nid()
> The function .mark_reserved_regions_for_nid() references
> the function __meminit .early_pfn_to_nid().
> This is often because .mark_reserved_regions_for_nid lacks a __meminit 
> annotation or the annotation of .early_pfn_to_nid is wrong.
> 
> WARNING: vmlinux.o(.text+0x4c780): Section mismatch in reference from
> the function .mark_reserved_regions_for_nid() to the
> function .init.text:.work_with_active_regions()
> The function .mark_reserved_regions_for_nid() references
> the function __init .work_with_active_regions().
> This is often because .mark_reserved_regions_for_nid lacks a __init 
> annotation or the annotation of .work_with_active_regions is wrong.
> 
> WARNING: vmlinux.o(.text+0x4c7d4): Section mismatch in reference from
> the function .mark_reserved_regions_for_nid() to the
> function .meminit.text:.early_pfn_to_nid()
> The function .mark_reserved_regions_for_nid() references
> the function __meminit .early_pfn_to_nid().
> This is often because .mark_reserved_regions_for_nid lacks a __meminit 
> annotation or the annotation of .early_pfn_to_nid is wrong.
> 
> WARNING: vmlinux.o(.text+0x4c7f0): Section mismatch in reference from
> the function .mark_reserved_regions_for_nid() to the
> function .init.text:.work_with_active_regions()
> The function .mark_reserved_regions_for_nid() references
> the function __init .work_with_active_regions().
> This is often because .mark_reserved_regions_for_nid lacks a __init 
> annotation or the annotation of .work_with_active_regions is wrong.
> 
> WARNING: vmlinux.o(.text+0x4c828): Section mismatch in reference from
> the function .mark_reserved_regions_for_nid() to the
> function .init.text:.reserve_bootmem_node()
> The function .mark_reserved_regions_for_nid() references
> the function __init .reserve_bootmem_node().
> This is often because .mark_reserved_regions_for_nid lacks a __init 
> annotation or the annotation of .reserve_bootmem_node is wrong.
> 

Wow, lots of ibm folks on the cc :)  I can only talk about the mm related 
section mismatches, but these five can easily be solved with the 
following.


powerpc, mm: fix section mismatch for mark_reserved_regions_for_nid

mark_reserved_regions_for_nid() is only called from do_init_bootmem(), 
which is in .init.text, so it must be in the same section to avoid a 
section mismatch warning.

Reported-by: Subrata Modak <subrata@linux.vnet.ibm.com>
Signed-off-by: David Rientjes <rientjes@google.com>
---
 arch/powerpc/mm/numa.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -969,7 +969,7 @@ static struct notifier_block __cpuinitdata ppc64_numa_nb = {
 	.priority = 1 /* Must run before sched domains notifier. */
 };
 
-static void mark_reserved_regions_for_nid(int nid)
+static void __init mark_reserved_regions_for_nid(int nid)
 {
 	struct pglist_data *node = NODE_DATA(nid);
 	struct memblock_region *reg;
