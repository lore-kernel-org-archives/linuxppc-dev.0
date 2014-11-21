Return-Path: <mgorman@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 740C11A12D6
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Nov 2014 00:57:58 +1100 (AEDT)
From: Mel Gorman <mgorman@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
 LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 04/10] ppc64: Add paranoid warnings for unexpected
 DSISR_PROTFAULT
Date: Fri, 21 Nov 2014 13:57:42 +0000
Message-Id: <1416578268-19597-5-git-send-email-mgorman@suse.de>
In-Reply-To: <1416578268-19597-1-git-send-email-mgorman@suse.de>
References: <1416578268-19597-1-git-send-email-mgorman@suse.de>
Cc: Rik van Riel <riel@redhat.com>, Hugh Dickins <hughd@google.com>,
 Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
 Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>,
 Sasha Levin <sasha.levin@oracle.com>, Dave Jones <davej@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Kirill Shutemov <kirill.shutemov@linux.intel.com>,
 Mel Gorman <mgorman@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

ppc64 should not be depending on DSISR_PROTFAULT and it's unexpected
if they are triggered. This patch adds warnings just in case they
are being accidentally depended upon.

Signed-off-by: Mel Gorman <mgorman@suse.de>
Acked-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/copro_fault.c |  8 ++++++--
 arch/powerpc/mm/fault.c       | 20 +++++++++-----------
 2 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/mm/copro_fault.c b/arch/powerpc/mm/copro_fault.c
index 5a236f0..0450d68 100644
--- a/arch/powerpc/mm/copro_fault.c
+++ b/arch/powerpc/mm/copro_fault.c
@@ -64,10 +64,14 @@ int copro_handle_mm_fault(struct mm_struct *mm, unsigned long ea,
 		if (!(vma->vm_flags & VM_WRITE))
 			goto out_unlock;
 	} else {
-		if (dsisr & DSISR_PROTFAULT)
-			goto out_unlock;
 		if (!(vma->vm_flags & (VM_READ | VM_EXEC)))
 			goto out_unlock;
+		/*
+		 * protfault should only happen due to us
+		 * mapping a region readonly temporarily. PROT_NONE
+		 * is also covered by the VMA check above.
+		 */
+		WARN_ON_ONCE(dsisr & DSISR_PROTFAULT);
 	}
 
 	ret = 0;
diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index b434153..1bcd378 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -389,17 +389,6 @@ good_area:
 #endif /* CONFIG_8xx */
 
 	if (is_exec) {
-#ifdef CONFIG_PPC_STD_MMU
-		/* Protection fault on exec go straight to failure on
-		 * Hash based MMUs as they either don't support per-page
-		 * execute permission, or if they do, it's handled already
-		 * at the hash level. This test would probably have to
-		 * be removed if we change the way this works to make hash
-		 * processors use the same I/D cache coherency mechanism
-		 * as embedded.
-		 */
-#endif /* CONFIG_PPC_STD_MMU */
-
 		/*
 		 * Allow execution from readable areas if the MMU does not
 		 * provide separate controls over reading and executing.
@@ -414,6 +403,14 @@ good_area:
 		    (cpu_has_feature(CPU_FTR_NOEXECUTE) ||
 		     !(vma->vm_flags & (VM_READ | VM_WRITE))))
 			goto bad_area;
+#ifdef CONFIG_PPC_STD_MMU
+		/*
+		 * protfault should only happen due to us
+		 * mapping a region readonly temporarily. PROT_NONE
+		 * is also covered by the VMA check above.
+		 */
+		WARN_ON_ONCE(error_code & DSISR_PROTFAULT);
+#endif /* CONFIG_PPC_STD_MMU */
 	/* a write */
 	} else if (is_write) {
 		if (!(vma->vm_flags & VM_WRITE))
@@ -423,6 +420,7 @@ good_area:
 	} else {
 		if (!(vma->vm_flags & (VM_READ | VM_EXEC | VM_WRITE)))
 			goto bad_area;
+		WARN_ON_ONCE(error_code & DSISR_PROTFAULT);
 	}
 
 	/*
-- 
2.1.2
