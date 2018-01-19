Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qt0-x241.google.com (mail-qt0-x241.google.com
 [IPv6:2607:f8b0:400d:c0d::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zN3jt5mmczF0mY
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jan 2018 12:52:34 +1100 (AEDT)
Received: by mail-qt0-x241.google.com with SMTP id 33so466777qtv.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jan 2018 17:52:34 -0800 (PST)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: mpe@ellerman.id.au, mingo@redhat.com, akpm@linux-foundation.org,
 corbet@lwn.net, arnd@arndb.de
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org,
 linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 dave.hansen@intel.com, benh@kernel.crashing.org, paulus@samba.org,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org,
 bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, linuxram@us.ibm.com
Subject: [PATCH v10 17/27] powerpc: check key protection for user page access
Date: Thu, 18 Jan 2018 17:50:38 -0800
Message-Id: <1516326648-22775-18-git-send-email-linuxram@us.ibm.com>
In-Reply-To: <1516326648-22775-1-git-send-email-linuxram@us.ibm.com>
References: <1516326648-22775-1-git-send-email-linuxram@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Make sure that the kernel does not access user pages without
checking their key-protection.

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/pgtable.h |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index e785c68..3d8186e 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -464,6 +464,25 @@ static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
 
 #ifdef CONFIG_PPC_MEM_KEYS
 extern bool arch_pte_access_permitted(u64 pte, bool write, bool execute);
+
+#define pte_access_permitted(pte, write) \
+	(pte_present(pte) && \
+	 ((!(write) || pte_write(pte)) && \
+	  arch_pte_access_permitted(pte_val(pte), !!write, 0)))
+
+/*
+ * We store key in pmd/pud for huge pages. Need to check for key protection.
+ */
+#define pmd_access_permitted(pmd, write) \
+	(pmd_present(pmd) && \
+	 ((!(write) || pmd_write(pmd)) && \
+	  arch_pte_access_permitted(pmd_val(pmd), !!write, 0)))
+
+#define pud_access_permitted(pud, write) \
+	(pud_present(pud) && \
+	 ((!(write) || pud_write(pud)) && \
+	  arch_pte_access_permitted(pud_val(pud), !!write, 0)))
+
 #endif /* CONFIG_PPC_MEM_KEYS */
 
 #define __HAVE_ARCH_PTEP_GET_AND_CLEAR
-- 
1.7.1
