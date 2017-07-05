Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qk0-x244.google.com (mail-qk0-x244.google.com
 [IPv6:2607:f8b0:400d:c09::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x2v3v41CyzDr2t
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Jul 2017 07:23:07 +1000 (AEST)
Received: by mail-qk0-x244.google.com with SMTP id 16so187310qkg.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Jul 2017 14:23:07 -0700 (PDT)
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
Subject: [RFC v5 15/38] powerpc: helper function to read, write AMR, IAMR,
 UAMOR registers
Date: Wed,  5 Jul 2017 14:21:52 -0700
Message-Id: <1499289735-14220-16-git-send-email-linuxram@us.ibm.com>
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

Implements helper functions to read and write the key related
registers; AMR, IAMR, UAMOR.

AMR register tracks the read,write permission of a key
IAMR register tracks the execute permission of a key
UAMOR register enables and disables a key

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/pgtable.h |   60 ++++++++++++++++++++++++++
 1 files changed, 60 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 85bc987..435d6a7 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -428,6 +428,66 @@ static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
 		pte_update(mm, addr, ptep, 0, _PAGE_PRIVILEGED, 1);
 }
 
+#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
+
+#include <asm/reg.h>
+static inline u64 read_amr(void)
+{
+	return mfspr(SPRN_AMR);
+}
+static inline void write_amr(u64 value)
+{
+	mtspr(SPRN_AMR, value);
+}
+static inline u64 read_iamr(void)
+{
+	return mfspr(SPRN_IAMR);
+}
+static inline void write_iamr(u64 value)
+{
+	mtspr(SPRN_IAMR, value);
+}
+static inline u64 read_uamor(void)
+{
+	return mfspr(SPRN_UAMOR);
+}
+static inline void write_uamor(u64 value)
+{
+	mtspr(SPRN_UAMOR, value);
+}
+
+#else /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
+
+static inline u64 read_amr(void)
+{
+	WARN(1, "%s called with MEMORY PROTECTION KEYS disabled\n", __func__);
+	return -1;
+}
+static inline void write_amr(u64 value)
+{
+	WARN(1, "%s called with MEMORY PROTECTION KEYS disabled\n", __func__);
+}
+static inline u64 read_uamor(void)
+{
+	WARN(1, "%s called with MEMORY PROTECTION KEYS disabled\n", __func__);
+	return -1;
+}
+static inline void write_uamor(u64 value)
+{
+	WARN(1, "%s called with MEMORY PROTECTION KEYS disabled\n", __func__);
+}
+static inline u64 read_iamr(void)
+{
+	WARN(1, "%s called with MEMORY PROTECTION KEYS disabled\n", __func__);
+	return -1;
+}
+static inline void write_iamr(u64 value)
+{
+	WARN(1, "%s called with MEMORY PROTECTION KEYS disabled\n", __func__);
+}
+
+#endif /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
+
 #define __HAVE_ARCH_PTEP_GET_AND_CLEAR
 static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
 				       unsigned long addr, pte_t *ptep)
-- 
1.7.1
