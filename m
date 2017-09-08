Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qk0-x241.google.com (mail-qk0-x241.google.com
 [IPv6:2607:f8b0:400d:c09::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xpsrT3ZDpzDrcv
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Sep 2017 08:46:49 +1000 (AEST)
Received: by mail-qk0-x241.google.com with SMTP id c69so2309134qke.5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 08 Sep 2017 15:46:49 -0700 (PDT)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: mpe@ellerman.id.au,
	linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com,
 linuxram@us.ibm.com
Subject: [PATCH 04/25] powerpc: helper function to read, write AMR, IAMR,
 UAMOR registers
Date: Fri,  8 Sep 2017 15:44:52 -0700
Message-Id: <1504910713-7094-13-git-send-email-linuxram@us.ibm.com>
In-Reply-To: <1504910713-7094-1-git-send-email-linuxram@us.ibm.com>
References: <1504910713-7094-1-git-send-email-linuxram@us.ibm.com>
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
 arch/powerpc/include/asm/book3s/64/pgtable.h |   31 ++++++++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index b9aff51..73ed52c 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -438,6 +438,37 @@ static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
 		pte_update(mm, addr, ptep, 0, _PAGE_PRIVILEGED, 1);
 }
 
+#include <asm/reg.h>
+static inline u64 read_amr(void)
+{
+	return mfspr(SPRN_AMR);
+}
+static inline void write_amr(u64 value)
+{
+	mtspr(SPRN_AMR, value);
+}
+extern bool pkey_execute_disable_support;
+static inline u64 read_iamr(void)
+{
+	if (pkey_execute_disable_support)
+		return mfspr(SPRN_IAMR);
+	else
+		return 0x0UL;
+}
+static inline void write_iamr(u64 value)
+{
+	if (pkey_execute_disable_support)
+		mtspr(SPRN_IAMR, value);
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
 #define __HAVE_ARCH_PTEP_GET_AND_CLEAR
 static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
 				       unsigned long addr, pte_t *ptep)
-- 
1.7.1
