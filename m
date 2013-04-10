Return-Path: <kumagai-atsushi@mxc.nes.nec.co.jp>
Received: from tyo200.gate.nec.co.jp (TYO200.gate.nec.co.jp [210.143.35.50])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 89B3F2C00C5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2013 17:25:26 +1000 (EST)
Received: from tyo202.gate.nec.co.jp ([10.7.69.202])
 by tyo200.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id r3A7PKcP024585
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2013 16:25:20 +0900 (JST)
Date: Wed, 10 Apr 2013 16:20:18 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
To: kexec@lists.infradead.org
Subject: [RESEND PATCH 4/4] Use vmap_area_list to get vmalloc_start for ppc64.
Message-Id: <20130410162018.2ee96e649d212d69c0710b6e@mxc.nes.nec.co.jp>
In-Reply-To: <20130410150524.804cd23b99a697f71146be67@mxc.nes.nec.co.jp>
References: <20130410150524.804cd23b99a697f71146be67@mxc.nes.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Date: Fri, 15 Mar 2013 19:34:30 +0900
Subject: [PATCH 4/4] Use vmap_area_list to get vmalloc_start for ppc64.

Try to get vmalloc_start value from vmap_area_list first for
newer ppc64 kernels.

Signed-off-by: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
---
 arch/ppc64.c | 44 +++++++++++++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 13 deletions(-)

diff --git a/arch/ppc64.c b/arch/ppc64.c
index afbaf55..c229ede 100644
--- a/arch/ppc64.c
+++ b/arch/ppc64.c
@@ -66,22 +66,40 @@ get_machdep_info_ppc64(void)
 	DEBUG_MSG("kernel_start : %lx\n", info->kernel_start);
 
 	/*
-	 * For the compatibility, makedumpfile should run without the symbol
-	 * vmlist and the offset of vm_struct.addr if they are not necessary.
+	 * Get vmalloc_start value from either vmap_area_list or vmlist.
 	 */
-	if ((SYMBOL(vmlist) == NOT_FOUND_SYMBOL)
-	    || (OFFSET(vm_struct.addr) == NOT_FOUND_STRUCTURE)) {
+	if ((SYMBOL(vmap_area_list) != NOT_FOUND_SYMBOL)
+	    && (OFFSET(vmap_area.va_start) != NOT_FOUND_STRUCTURE)
+	    && (OFFSET(vmap_area.list) != NOT_FOUND_STRUCTURE)) {
+		if (!readmem(VADDR, SYMBOL(vmap_area_list) + OFFSET(list_head.next),
+			     &vmap_area_list, sizeof(vmap_area_list))) {
+			ERRMSG("Can't get vmap_area_list.\n");
+			return FALSE;
+		}
+		if (!readmem(VADDR, vmap_area_list - OFFSET(vmap_area.list) +
+			     OFFSET(vmap_area.va_start), &vmalloc_start,
+			     sizeof(vmalloc_start))) {
+			ERRMSG("Can't get vmalloc_start.\n");
+			return FALSE;
+		}
+	} else if ((SYMBOL(vmlist) != NOT_FOUND_SYMBOL)
+		   && (OFFSET(vm_struct.addr) != NOT_FOUND_STRUCTURE)) {
+		if (!readmem(VADDR, SYMBOL(vmlist), &vmlist, sizeof(vmlist))) {
+			ERRMSG("Can't get vmlist.\n");
+			return FALSE;
+		}
+		if (!readmem(VADDR, vmlist + OFFSET(vm_struct.addr), &vmalloc_start,
+			     sizeof(vmalloc_start))) {
+			ERRMSG("Can't get vmalloc_start.\n");
+			return FALSE;
+		}
+	} else {
+		/*
+		 * For the compatibility, makedumpfile should run without the symbol
+		 * vmlist and the offset of vm_struct.addr if they are not necessary.
+		 */
 		return TRUE;
 	}
-	if (!readmem(VADDR, SYMBOL(vmlist), &vmlist, sizeof(vmlist))) {
-		ERRMSG("Can't get vmlist.\n");
-		return FALSE;
-	}
-	if (!readmem(VADDR, vmlist + OFFSET(vm_struct.addr), &vmalloc_start,
-	    sizeof(vmalloc_start))) {
-		ERRMSG("Can't get vmalloc_start.\n");
-		return FALSE;
-	}
 	info->vmalloc_start = vmalloc_start;
 	DEBUG_MSG("vmalloc_start: %lx\n", vmalloc_start);
 
-- 
1.8.0.2
