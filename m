Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xC4X35gmkzDrSq
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 14:57:23 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 20/24] powerpc/mm: Set fault flags earlier
Date: Wed, 19 Jul 2017 14:49:42 +1000
Message-Id: <20170719044946.22030-20-benh@kernel.crashing.org>
In-Reply-To: <20170719044946.22030-1-benh@kernel.crashing.org>
References: <20170719044946.22030-1-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Move out the code that sets FAULT_FLAG_WRITE so the block that check
access permissions can be extracted. While at it also set
FAULT_FLAG_INSTRUCTION which will be used for protection keys.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/mm/fault.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index f1abdc90e330..6a938fc8c5fb 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -384,6 +384,10 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
 
 	if (is_user)
 		flags |= FAULT_FLAG_USER;
+	if (is_write)
+		flags |= FAULT_FLAG_WRITE;
+	if (is_exec)
+		flags |= FAULT_FLAG_INSTRUCTION;
 
 	/* When running in the kernel we expect faults to occur only to
 	 * addresses in user space.  All other faults represent errors in the
@@ -476,7 +480,6 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
 	} else if (is_write) {
 		if (unlikely(!(vma->vm_flags & VM_WRITE)))
 			return bad_area(regs, address);
-		flags |= FAULT_FLAG_WRITE;
 	/* a read */
 	} else {
 		if (unlikely(!(vma->vm_flags & (VM_READ | VM_EXEC | VM_WRITE))))
-- 
2.13.3
