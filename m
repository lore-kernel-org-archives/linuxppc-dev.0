Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qt0-x243.google.com (mail-qt0-x243.google.com
 [IPv6:2607:f8b0:400d:c0d::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yVmgm1qm7zDr5J
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Nov 2017 19:58:44 +1100 (AEDT)
Received: by mail-qt0-x243.google.com with SMTP id z28so9973305qtz.13
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Nov 2017 00:58:44 -0800 (PST)
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
Subject: [PATCH v9 08/51] powerpc: implementation for
 arch_set_user_pkey_access()
Date: Mon,  6 Nov 2017 00:57:00 -0800
Message-Id: <1509958663-18737-9-git-send-email-linuxram@us.ibm.com>
In-Reply-To: <1509958663-18737-1-git-send-email-linuxram@us.ibm.com>
References: <1509958663-18737-1-git-send-email-linuxram@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch provides the detailed implementation for
a user to allocate a key and enable it in the hardware.

It provides the plumbing, but it cannot be used till
the system call is implemented. The next patch  will
do so.

Reviewed-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 arch/powerpc/include/asm/pkeys.h |    6 ++++-
 arch/powerpc/mm/pkeys.c          |   40 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
index 0d00a54..652c750 100644
--- a/arch/powerpc/include/asm/pkeys.h
+++ b/arch/powerpc/include/asm/pkeys.h
@@ -139,10 +139,14 @@ static inline int arch_override_mprotect_pkey(struct vm_area_struct *vma,
 	return 0;
 }
 
+extern int __arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
+				       unsigned long init_val);
 static inline int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
 					    unsigned long init_val)
 {
-	return 0;
+	if (static_branch_likely(&pkey_disabled))
+		return -EINVAL;
+	return __arch_set_user_pkey_access(tsk, pkey, init_val);
 }
 
 static inline void pkey_mm_init(struct mm_struct *mm)
diff --git a/arch/powerpc/mm/pkeys.c b/arch/powerpc/mm/pkeys.c
index f3bf661..4a01c2f 100644
--- a/arch/powerpc/mm/pkeys.c
+++ b/arch/powerpc/mm/pkeys.c
@@ -9,6 +9,7 @@
  * (at your option) any later version.
  */
 
+#include <asm/mman.h>
 #include <linux/pkeys.h>
 
 DEFINE_STATIC_KEY_TRUE(pkey_disabled);
@@ -17,6 +18,9 @@
 u32  initial_allocation_mask;	/* Bits set for reserved keys */
 
 #define AMR_BITS_PER_PKEY 2
+#define AMR_RD_BIT 0x1UL
+#define AMR_WR_BIT 0x2UL
+#define IAMR_EX_BIT 0x1UL
 #define PKEY_REG_BITS (sizeof(u64)*8)
 #define pkeyshift(pkey) (PKEY_REG_BITS - ((pkey+1) * AMR_BITS_PER_PKEY))
 
@@ -102,6 +106,20 @@ static inline void write_uamor(u64 value)
 	mtspr(SPRN_UAMOR, value);
 }
 
+static bool is_pkey_enabled(int pkey)
+{
+	u64 uamor = read_uamor();
+	u64 pkey_bits = 0x3ul << pkeyshift(pkey);
+	u64 uamor_pkey_bits = (uamor & pkey_bits);
+
+	/*
+	 * Both the bits in UAMOR corresponding to the key should be set or
+	 * reset.
+	 */
+	WARN_ON(uamor_pkey_bits && (uamor_pkey_bits != pkey_bits));
+	return !!(uamor_pkey_bits);
+}
+
 static inline void init_amr(int pkey, u8 init_bits)
 {
 	u64 new_amr_bits = (((u64)init_bits & 0x3UL) << pkeyshift(pkey));
@@ -144,3 +162,25 @@ void __arch_deactivate_pkey(int pkey)
 {
 	pkey_status_change(pkey, false);
 }
+
+/*
+ * Set the access rights in AMR IAMR and UAMOR registers for @pkey to that
+ * specified in @init_val.
+ */
+int __arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
+				unsigned long init_val)
+{
+	u64 new_amr_bits = 0x0ul;
+
+	if (!is_pkey_enabled(pkey))
+		return -EINVAL;
+
+	/* Set the bits we need in AMR: */
+	if (init_val & PKEY_DISABLE_ACCESS)
+		new_amr_bits |= AMR_RD_BIT | AMR_WR_BIT;
+	else if (init_val & PKEY_DISABLE_WRITE)
+		new_amr_bits |= AMR_WR_BIT;
+
+	init_amr(pkey, new_amr_bits);
+	return 0;
+}
-- 
1.7.1
