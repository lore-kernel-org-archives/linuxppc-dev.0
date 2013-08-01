Return-Path: <R65777@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0252.outbound.messaging.microsoft.com [213.199.154.252])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D49F82C0298
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Aug 2013 21:18:16 +1000 (EST)
From: Bharat Bhushan <r65777@freescale.com>
To: <benh@kernel.crashing.org>, <agraf@suse.de>, <kvm-ppc@vger.kernel.org>,
 <kvm@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <scottwood@freescale.com>
Subject: [PATCH 5/6 v2] kvm: powerpc: booke: Add linux pte lookup like booke3s
Date: Thu, 1 Aug 2013 16:42:37 +0530
Message-ID: <1375355558-19187-6-git-send-email-Bharat.Bhushan@freescale.com>
In-Reply-To: <1375355558-19187-1-git-send-email-Bharat.Bhushan@freescale.com>
References: <1375355558-19187-1-git-send-email-Bharat.Bhushan@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Bharat Bhushan <bharat.bhushan@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

KVM need to lookup linux pte for getting TLB attributes (WIMGE).
This is similar to how book3s does.
This will be used in follow-up patches.

Signed-off-by: Bharat Bhushan <bharat.bhushan@freescale.com>
---
v1->v2
 - This is a new change in this version

 arch/powerpc/include/asm/kvm_booke.h |   73 ++++++++++++++++++++++++++++++++++
 1 files changed, 73 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_booke.h b/arch/powerpc/include/asm/kvm_booke.h
index d3c1eb3..903624d 100644
--- a/arch/powerpc/include/asm/kvm_booke.h
+++ b/arch/powerpc/include/asm/kvm_booke.h
@@ -102,4 +102,77 @@ static inline ulong kvmppc_get_msr(struct kvm_vcpu *vcpu)
 {
 	return vcpu->arch.shared->msr;
 }
+
+/*
+ * Lock and read a linux PTE.  If it's present and writable, atomically
+ * set dirty and referenced bits and return the PTE, otherwise return 0.
+ */
+static inline pte_t kvmppc_read_update_linux_pte(pte_t *p, int writing)
+{
+	pte_t pte;
+
+#ifdef PTE_ATOMIC_UPDATES
+	pte_t tmp;
+        /* wait until _PAGE_BUSY is clear then set it atomically */
+#ifdef CONFIG_PPC64
+	__asm__ __volatile__ (
+		"1:	ldarx	%0,0,%3\n"
+		"	andi.	%1,%0,%4\n"
+		"	bne-	1b\n"
+		"	ori	%1,%0,%4\n"
+		"	stdcx.	%1,0,%3\n"
+		"	bne-	1b"
+		: "=&r" (pte), "=&r" (tmp), "=m" (*p)
+		: "r" (p), "i" (_PAGE_BUSY)
+		: "cc");
+#else
+        __asm__ __volatile__ (
+                "1:     lwarx   %0,0,%3\n"
+                "       andi.   %1,%0,%4\n"
+                "       bne-    1b\n"
+                "       ori     %1,%0,%4\n"
+                "       stwcx.  %1,0,%3\n"
+                "       bne-    1b"
+                : "=&r" (pte), "=&r" (tmp), "=m" (*p)
+                : "r" (p), "i" (_PAGE_BUSY)
+                : "cc");
+#endif
+#else
+	pte = pte_val(*p);
+#endif
+
+	if (pte_present(pte)) {
+		pte = pte_mkyoung(pte);
+		if (writing && pte_write(pte))
+			pte = pte_mkdirty(pte);
+	}
+
+	*p = pte;	/* clears _PAGE_BUSY */
+
+	return pte;
+}
+
+static inline pte_t lookup_linux_pte(pgd_t *pgdir, unsigned long hva,
+			      int writing, unsigned long *pte_sizep)
+{
+	pte_t *ptep;
+	unsigned long ps = *pte_sizep;
+	unsigned int shift;
+
+	ptep = find_linux_pte_or_hugepte(pgdir, hva, &shift);
+	if (!ptep)
+		return __pte(0);
+	if (shift)
+		*pte_sizep = 1ul << shift;
+	else
+		*pte_sizep = PAGE_SIZE;
+
+	if (ps > *pte_sizep)
+		return __pte(0);
+	if (!pte_present(*ptep))
+		return __pte(0);
+
+	return kvmppc_read_update_linux_pte(ptep, writing);
+}
+
 #endif /* __ASM_KVM_BOOKE_H__ */
-- 
1.7.0.4
