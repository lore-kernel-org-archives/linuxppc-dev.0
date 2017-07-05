Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qt0-x244.google.com (mail-qt0-x244.google.com
 [IPv6:2607:f8b0:400d:c0d::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x2v4P6DXFzDr3m
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Jul 2017 07:23:33 +1000 (AEST)
Received: by mail-qt0-x244.google.com with SMTP id w12so191451qta.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Jul 2017 14:23:33 -0700 (PDT)
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
Subject: [RFC v5 26/38] powerpc: check key protection for user page access
Date: Wed,  5 Jul 2017 14:22:03 -0700
Message-Id: <1499289735-14220-27-git-send-email-linuxram@us.ibm.com>
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

Make sure that the kernel does not access user pages without
checking their key-protection.

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/pgtable.h |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index aad205c..d590f30 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -476,6 +476,20 @@ static inline void write_uamor(u64 value)
 
 extern bool arch_pte_access_permitted(u64 pte, bool write, bool execute);
 
+#define pte_access_permitted(pte, write) \
+	(pte_present(pte) && \
+	 ((!(write) || pte_write(pte)) && \
+	  arch_pte_access_permitted(pte_val(pte), !!write, 0)))
+
+/*
+ * We store key in pmd for huge tlb pages. So need
+ * to check for key protection.
+ */
+#define pmd_access_permitted(pmd, write) \
+	(pmd_present(pmd) && \
+	 ((!(write) || pmd_write(pmd)) && \
+	  arch_pte_access_permitted(pmd_val(pmd), !!write, 0)))
+
 #else /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
 
 static inline u64 read_amr(void)
-- 
1.7.1
