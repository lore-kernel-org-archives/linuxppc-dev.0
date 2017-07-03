Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x1S2b6xDKzDr4B
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Jul 2017 23:01:59 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v6 02/10] powerpc/mm/radix: Fix execute permissions for
 interrupt_vectors
Date: Mon,  3 Jul 2017 23:01:46 +1000
Message-Id: <1499086914-25695-2-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1499086914-25695-1-git-send-email-mpe@ellerman.id.au>
References: <1499086914-25695-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Balbir Singh <bsingharora@gmail.com>

Commit 9abcc981de97 ("powerpc/mm/radix: Only add X for pages
overlapping kernel text") changed the linear mapping on Radix to only
mark the kernel text executable.

However if the kernel is run relocated, for example as a kdump kernel,
then the exception vectors are split from the kernel text, ie. they
remain at real address 0.

We tend to get away with it, because the kernel itself will usually be
below 1G, which means the 1G page at 0-1G is marked executable and
everything works OK. However if the kernel is loaded above 1G, or the
system has less than 1G in total (meaning we can't use a 1G page),
then the exception vectors will not be marked executable and the
kernel will fail to boot.

Fix it by also checking if the address range overlaps the exception
vectors when deciding if we should add PAGE_KERNEL_X.

Fixes: 9abcc981de97 ("powerpc/mm/radix: Only add X for pages overlapping kernel text")
Cc: stable@vger.kernel.org # v4.7+
Signed-off-by: Balbir Singh <bsingharora@gmail.com>
[mpe: Combine with the existing check, rewrite change log]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/mm/pgtable-radix.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index f6af90371b1e..1342859552b1 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -150,7 +150,8 @@ static int __meminit create_physical_mapping(unsigned long start,
 
 		vaddr = (unsigned long)__va(addr);
 
-		if (overlaps_kernel_text(vaddr, vaddr + mapping_size))
+		if (overlaps_kernel_text(vaddr, vaddr + mapping_size) ||
+		    overlaps_interrupt_vector_text(vaddr, vaddr + mapping_size))
 			prot = PAGE_KERNEL_X;
 		else
 			prot = PAGE_KERNEL;
-- 
2.7.4
