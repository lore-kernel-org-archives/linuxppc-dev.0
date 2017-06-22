Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qt0-x241.google.com (mail-qt0-x241.google.com
 [IPv6:2607:f8b0:400d:c0d::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wtPQj3ghYzDrVd
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 11:39:57 +1000 (AEST)
Received: by mail-qt0-x241.google.com with SMTP id s33so347659qtg.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 18:39:57 -0700 (PDT)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, dave.hansen@intel.com, hbabu@us.ibm.com,
 linuxram@us.ibm.com, arnd@arndb.de, akpm@linux-foundation.org,
 corbet@lwn.net, mingo@redhat.com
Subject: [RFC v3 02/23] powerpc: introduce set_hidx_slot helper
Date: Wed, 21 Jun 2017 18:39:18 -0700
Message-Id: <1498095579-6790-3-git-send-email-linuxram@us.ibm.com>
In-Reply-To: <1498095579-6790-1-git-send-email-linuxram@us.ibm.com>
References: <1498095579-6790-1-git-send-email-linuxram@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Introduce set_hidx_slot() which sets the (H_PAGE_F_SECOND|H_PAGE_F_GIX)
bits at  the  appropriate  location  in  the  PTE  of  4K  PTE.  In the
case of 64K PTE, it sets the bits in the second part of the PTE. Though
the implementation for the former just needs the slot parameter, it does
take some additional parameters to keep the prototype consistent.

This function will come in handy as we  work  towards  re-arranging the
bits in the later patches.

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/hash-4k.h  |  7 +++++++
 arch/powerpc/include/asm/book3s/64/hash-64k.h | 16 ++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/arch/powerpc/include/asm/book3s/64/hash-4k.h b/arch/powerpc/include/asm/book3s/64/hash-4k.h
index 9c2c8f1..cef644c 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-4k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-4k.h
@@ -55,6 +55,13 @@ static inline int hash__hugepd_ok(hugepd_t hpd)
 }
 #endif
 
+static inline unsigned long set_hidx_slot(pte_t *ptep, real_pte_t rpte,
+			unsigned int subpg_index, unsigned long slot)
+{
+	return (slot << H_PAGE_F_GIX_SHIFT) &
+		(H_PAGE_F_SECOND | H_PAGE_F_GIX);
+}
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 
 static inline char *get_hpte_slot_array(pmd_t *pmdp)
diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
index 3f49941..4bac70a 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
@@ -75,6 +75,22 @@ static inline unsigned long __rpte_to_hidx(real_pte_t rpte, unsigned long index)
 	return (pte_val(rpte.pte) >> H_PAGE_F_GIX_SHIFT) & 0xf;
 }
 
+static inline unsigned long set_hidx_slot(pte_t *ptep, real_pte_t rpte,
+		unsigned int subpg_index, unsigned long slot)
+{
+	unsigned long *hidxp = (unsigned long *)(ptep + PTRS_PER_PTE);
+
+	rpte.hidx &= ~(0xfUL << (subpg_index << 2));
+	*hidxp = rpte.hidx  | (slot << (subpg_index << 2));
+	/*
+	 * Avoid race with __real_pte()
+	 * hidx must be committed to memory before committing
+	 * the pte.
+	 */
+	smp_wmb();
+	return 0x0UL;
+}
+
 #define __rpte_to_pte(r)	((r).pte)
 extern bool __rpte_sub_valid(real_pte_t rpte, unsigned long index);
 /*
-- 
1.8.3.1
