Return-Path: <haishan.bai@gmail.com>
Received: from mail-qy0-f179.google.com (mail-qy0-f179.google.com
	[209.85.216.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0592B100873
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 15 Jul 2011 18:05:56 +1000 (EST)
Received: by qyk29 with SMTP id 29so715828qyk.17
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 15 Jul 2011 01:05:53 -0700 (PDT)
From: Shan Hai <haishan.bai@gmail.com>
To: benh@kernel.crashing.org,
	paulus@samba.org
Subject: [PATCH 1/1] Fixup write permission of TLB on powerpc e500 core
Date: Fri, 15 Jul 2011 16:07:18 +0800
Message-Id: <1310717238-13857-2-git-send-email-haishan.bai@gmail.com>
In-Reply-To: <1310717238-13857-1-git-send-email-haishan.bai@gmail.com>
References: <1310717238-13857-1-git-send-email-haishan.bai@gmail.com>
Cc: tony.luck@intel.com, a.p.zijlstra@chello.nl,
	Shan Hai <haishan.bai@gmail.com>, linux-kernel@vger.kernel.org,
	cmetcalf@tilera.com, dhowells@redhat.com, tglx@linutronix.de,
	walken@google.com, linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The kernel has no write permission on COW pages by default on e500 core, this
will cause endless loop in futex_lock_pi, because futex code assumes the kernel
has write permission on COW pages. Grant write permission to the kernel on COW
pages when access violation page fault occurs.

Signed-off-by: Shan Hai <haishan.bai@gmail.com>
---
 arch/powerpc/include/asm/futex.h |   11 ++++++++++-
 arch/powerpc/include/asm/tlb.h   |   25 +++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/futex.h b/arch/powerpc/include/asm/futex.h
index c94e4a3..54c3e74 100644
--- a/arch/powerpc/include/asm/futex.h
+++ b/arch/powerpc/include/asm/futex.h
@@ -8,6 +8,7 @@
 #include <asm/errno.h>
 #include <asm/synch.h>
 #include <asm/asm-compat.h>
+#include <asm/tlb.h>
 
 #define __futex_atomic_op(insn, ret, oldval, uaddr, oparg) \
   __asm__ __volatile ( \
@@ -113,7 +114,15 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
         : "cc", "memory");
 
 	*uval = prev;
-        return ret;
+
+	/* Futex assumes the kernel has permission to write to
+	 * COW pages, grant the kernel write permission on COW
+	 * pages because it has none by default.
+	 */
+	if (ret == -EFAULT)
+		__tlb_fixup_write_permission(current->mm, (unsigned long)uaddr);
+
+	return ret;
 }
 
 #endif /* __KERNEL__ */
diff --git a/arch/powerpc/include/asm/tlb.h b/arch/powerpc/include/asm/tlb.h
index e2b428b..3863c6a 100644
--- a/arch/powerpc/include/asm/tlb.h
+++ b/arch/powerpc/include/asm/tlb.h
@@ -45,5 +45,30 @@ static inline void __tlb_remove_tlb_entry(struct mmu_gather *tlb, pte_t *ptep,
 #endif
 }
 
+/* Grant write permission to the kernel on a page. */
+static inline void __tlb_fixup_write_permission(struct mm_struct *mm,
+						unsigned long address)
+{
+#if defined(CONFIG_FSL_BOOKE)
+	/* Grant write permission to the kernel on a page by setting TLB.SW
+	 * bit, the bit setting operation is tricky here, calling
+	 * handle_mm_fault with FAULT_FLAG_WRITE causes _PAGE_DIRTY bit of
+	 * the pte to be set, the _PAGE_DIRTY of the pte is translated into
+	 * TLB.SW on Powerpc e500 core.
+	 */
+
+	struct vm_area_struct *vma;
+
+	vma = find_vma(mm, address);
+	if (likely(vma)) {
+		/* only fixup present page */
+		if (follow_page(vma, address, FOLL_WRITE)) {
+			handle_mm_fault(mm, vma, address, FAULT_FLAG_WRITE);
+			flush_tlb_page(vma, address);
+		}
+	}
+#endif
+}
+
 #endif /* __KERNEL__ */
 #endif /* __ASM_POWERPC_TLB_H */
-- 
1.7.1
