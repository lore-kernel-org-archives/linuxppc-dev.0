Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qt0-x242.google.com (mail-qt0-x242.google.com
 [IPv6:2607:f8b0:400d:c0d::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x2v4M3tNPzDr3F
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Jul 2017 07:23:31 +1000 (AEST)
Received: by mail-qt0-x242.google.com with SMTP id c20so201585qte.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Jul 2017 14:23:31 -0700 (PDT)
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
Subject: [RFC v5 25/38] powerpc: helper to validate key-access permissions of
 a pte
Date: Wed,  5 Jul 2017 14:22:02 -0700
Message-Id: <1499289735-14220-26-git-send-email-linuxram@us.ibm.com>
In-Reply-To: <1499289735-14220-1-git-send-email-linuxram@us.ibm.com>
References: <1499289735-14220-1-git-send-email-linuxram@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

helper function that checks if the read/write/execute is allowed
on the pte.

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/pgtable.h |    2 +
 arch/powerpc/include/asm/pkeys.h             |    9 +++++++
 arch/powerpc/mm/pkeys.c                      |   31 ++++++++++++++++++++++++++
 3 files changed, 42 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index d9c87c4..aad205c 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -474,6 +474,8 @@ static inline void write_uamor(u64 value)
 	mtspr(SPRN_UAMOR, value);
 }
 
+extern bool arch_pte_access_permitted(u64 pte, bool write, bool execute);
+
 #else /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
 
 static inline u64 read_amr(void)
diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
index 6477b87..01f2bfc 100644
--- a/arch/powerpc/include/asm/pkeys.h
+++ b/arch/powerpc/include/asm/pkeys.h
@@ -31,6 +31,15 @@ static inline u64 pte_to_hpte_pkey_bits(u64 pteflags)
 		((pteflags & H_PAGE_PKEY_BIT4) ? HPTE_R_KEY_BIT4 : 0x0UL));
 }
 
+static inline u16 pte_to_pkey_bits(u64 pteflags)
+{
+	return (((pteflags & H_PAGE_PKEY_BIT0) ? 0x10 : 0x0UL) |
+		((pteflags & H_PAGE_PKEY_BIT1) ? 0x8 : 0x0UL) |
+		((pteflags & H_PAGE_PKEY_BIT2) ? 0x4 : 0x0UL) |
+		((pteflags & H_PAGE_PKEY_BIT3) ? 0x2 : 0x0UL) |
+		((pteflags & H_PAGE_PKEY_BIT4) ? 0x1 : 0x0UL));
+}
+
 static inline int vma_pkey(struct vm_area_struct *vma)
 {
 	return (vma->vm_flags & ARCH_VM_PKEY_FLAGS) >> VM_PKEY_SHIFT;
diff --git a/arch/powerpc/mm/pkeys.c b/arch/powerpc/mm/pkeys.c
index c60a045..044a17d 100644
--- a/arch/powerpc/mm/pkeys.c
+++ b/arch/powerpc/mm/pkeys.c
@@ -170,3 +170,34 @@ int __arch_override_mprotect_pkey(struct vm_area_struct *vma, int prot,
 	 */
 	return vma_pkey(vma);
 }
+
+static bool pkey_access_permitted(int pkey, bool write, bool execute)
+{
+	int pkey_shift;
+	u64 amr;
+
+	if (!pkey)
+		return true;
+
+	pkey_shift = pkeyshift(pkey);
+	if (!(read_uamor() & (0x3UL << pkey_shift)))
+		return true;
+
+	if (execute && !(read_iamr() & (IAMR_EX_BIT << pkey_shift)))
+		return true;
+
+	if (!write) {
+		amr = read_amr();
+		if (!(amr & (AMR_AD_BIT << pkey_shift)))
+			return true;
+	}
+
+	amr = read_amr(); /* delay reading amr uptil absolutely needed */
+	return (write && !(amr & (AMR_WD_BIT << pkey_shift)));
+}
+
+bool arch_pte_access_permitted(u64 pte, bool write, bool execute)
+{
+	return pkey_access_permitted(pte_to_pkey_bits(pte),
+			write, execute);
+}
-- 
1.7.1
