Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A5B9C2C00C6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Feb 2014 03:31:05 +1100 (EST)
Received: from /spool/local
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Mon, 24 Feb 2014 16:30:59 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 9E10017D8047
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Feb 2014 16:31:29 +0000 (GMT)
Received: from d06av09.portsmouth.uk.ibm.com (d06av09.portsmouth.uk.ibm.com
 [9.149.37.250])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1OGUjUL62783554
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Feb 2014 16:30:45 GMT
Received: from d06av09.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av09.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1OGUuQP022541
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Feb 2014 09:30:56 -0700
Subject: [PATCH] powerpc/crashdump : fix page frame number check in
 copy_oldmem_page
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Mon, 24 Feb 2014 17:30:55 +0100
Message-ID: <20140224163055.7263.86979.stgit@nimbus>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In copy_oldmem_page, the current check using max_pfn and min_low_pfn to
decide if the page is backed or not, is not valid when the memory layout is
not continuous.

This happens when running as a QEMU/KVM guest, where RTAS is mapped higher
in the memory. In that case max_pfn points to the end of RTAS, and a hole
between the end of the kdump kernel and RTAS is not backed by PTEs. As a
consequence, the kdump kernel is crashing in copy_oldmem_page when accessing
in a direct way the pages in that hole.

This fix relies on the memblock's service memblock_is_region_memory to
check if the read page is part or not of the directly accessible memory.

Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/crash_dump.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/crash_dump.c b/arch/powerpc/kernel/crash_dump.c
index 11c1d06..7a13f37 100644
--- a/arch/powerpc/kernel/crash_dump.c
+++ b/arch/powerpc/kernel/crash_dump.c
@@ -98,17 +98,19 @@ ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
 			size_t csize, unsigned long offset, int userbuf)
 {
 	void  *vaddr;
+	phys_addr_t paddr;
 
 	if (!csize)
 		return 0;
 
 	csize = min_t(size_t, csize, PAGE_SIZE);
+	paddr = pfn << PAGE_SHIFT;
 
-	if ((min_low_pfn < pfn) && (pfn < max_pfn)) {
-		vaddr = __va(pfn << PAGE_SHIFT);
+	if (memblock_is_region_memory(paddr, csize)) {
+		vaddr = __va(paddr);
 		csize = copy_oldmem_vaddr(vaddr, buf, csize, offset, userbuf);
 	} else {
-		vaddr = __ioremap(pfn << PAGE_SHIFT, PAGE_SIZE, 0);
+		vaddr = __ioremap(paddr, PAGE_SIZE, 0);
 		csize = copy_oldmem_vaddr(vaddr, buf, csize, offset, userbuf);
 		iounmap(vaddr);
 	}
