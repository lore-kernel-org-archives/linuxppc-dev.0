Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 45D8FDDE02
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Nov 2007 20:59:56 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.13.8/8.13.8) with ESMTP id lA99xplb030693
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Nov 2007 03:59:51 -0600
Date: Fri, 9 Nov 2007 03:58:49 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] Fix oops related to 4xx flush_tlb_page modification
Message-ID: <Pine.LNX.4.64.0711090358300.28266@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

kmap_atomic calls flush_tlb_page with a NULL VMA and thus we end
up dereferencing a NULL pointer to try and get the context.id.

If the VMA is null use the global pid value of 0.

---
 include/asm-powerpc/tlbflush.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/asm-powerpc/tlbflush.h b/include/asm-powerpc/tlbflush.h
index e7b4c0d..5c91081 100644
--- a/include/asm-powerpc/tlbflush.h
+++ b/include/asm-powerpc/tlbflush.h
@@ -44,13 +44,13 @@ static inline void flush_tlb_mm(struct mm_struct *mm)
 static inline void flush_tlb_page(struct vm_area_struct *vma,
 				  unsigned long vmaddr)
 {
-	_tlbie(vmaddr, vma->vm_mm->context.id);
+	_tlbie(vmaddr, vma ? vma->vm_mm->context.id : 0);
 }

 static inline void flush_tlb_page_nohash(struct vm_area_struct *vma,
 					 unsigned long vmaddr)
 {
-	_tlbie(vmaddr, vma->vm_mm->context.id);
+	_tlbie(vmaddr, vma ? vma->vm_mm->context.id : 0);
 }

 static inline void flush_tlb_range(struct vm_area_struct *vma,
-- 
1.5.3.3
