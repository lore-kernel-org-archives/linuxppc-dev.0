Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qt0-x244.google.com (mail-qt0-x244.google.com
 [IPv6:2607:f8b0:400d:c0d::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xLKfC1tn9zDrCd
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Jul 2017 10:12:51 +1000 (AEST)
Received: by mail-qt0-x244.google.com with SMTP id d10so15667313qtb.4
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Jul 2017 17:12:51 -0700 (PDT)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, hbabu@us.ibm.com, linuxram@us.ibm.com,
 bauerman@linux.vnet.ibm.com, mhocko@kernel.org
Subject: [RFC v7 06/25] powerpc: implementation for arch_set_user_pkey_access()
Date: Sun, 30 Jul 2017 17:12:07 -0700
Message-Id: <1501459946-11619-7-git-send-email-linuxram@us.ibm.com>
In-Reply-To: <1501459946-11619-1-git-send-email-linuxram@us.ibm.com>
References: <1501459946-11619-1-git-send-email-linuxram@us.ibm.com>
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

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 arch/powerpc/include/asm/pkeys.h |    9 ++++++++-
 arch/powerpc/mm/pkeys.c          |   28 ++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
index 40bfaac..aec3f49 100644
--- a/arch/powerpc/include/asm/pkeys.h
+++ b/arch/powerpc/include/asm/pkeys.h
@@ -23,6 +23,9 @@
 #endif
 
 #define arch_max_pkey()  pkeys_total
+#define AMR_RD_BIT 0x1UL
+#define AMR_WR_BIT 0x2UL
+#define IAMR_EX_BIT 0x1UL
 #define ARCH_VM_PKEY_FLAGS (VM_PKEY_BIT0 | VM_PKEY_BIT1 | VM_PKEY_BIT2 | \
 				VM_PKEY_BIT3 | VM_PKEY_BIT4)
 #define AMR_BITS_PER_PKEY 2
@@ -122,10 +125,14 @@ static inline int arch_override_mprotect_pkey(struct vm_area_struct *vma,
 	return 0;
 }
 
+extern int __arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
+		unsigned long init_val);
 static inline int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
 		unsigned long init_val)
 {
-	return 0;
+	if (!pkey_inited)
+		return -EINVAL;
+	return __arch_set_user_pkey_access(tsk, pkey, init_val);
 }
 
 static inline void pkey_mm_init(struct mm_struct *mm)
diff --git a/arch/powerpc/mm/pkeys.c b/arch/powerpc/mm/pkeys.c
index 846d984..5b3531e 100644
--- a/arch/powerpc/mm/pkeys.c
+++ b/arch/powerpc/mm/pkeys.c
@@ -22,6 +22,11 @@
 #define PKEY_REG_BITS (sizeof(u64)*8)
 #define pkeyshift(pkey) (PKEY_REG_BITS - ((pkey+1) * AMR_BITS_PER_PKEY))
 
+static bool is_pkey_enabled(int pkey)
+{
+	return !!(read_uamor() & (0x3ul << pkeyshift(pkey)));
+}
+
 static inline void init_amr(int pkey, u8 init_bits)
 {
 	u64 new_amr_bits = (((u64)init_bits & 0x3UL) << pkeyshift(pkey));
@@ -64,3 +69,26 @@ void __arch_deactivate_pkey(int pkey)
 {
 	pkey_status_change(pkey, false);
 }
+
+/*
+ * set the access right in AMR IAMR and UAMOR register
+ * for @pkey to that specified in @init_val.
+ */
+int __arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
+		unsigned long init_val)
+{
+	u64 new_amr_bits = 0x0ul;
+
+	if (!is_pkey_enabled(pkey))
+		return -EINVAL;
+
+	/* Set the bits we need in AMR:  */
+	if (init_val & PKEY_DISABLE_ACCESS)
+		new_amr_bits |= AMR_RD_BIT | AMR_WR_BIT;
+	else if (init_val & PKEY_DISABLE_WRITE)
+		new_amr_bits |= AMR_WR_BIT;
+
+	init_amr(pkey, new_amr_bits);
+
+	return 0;
+}
-- 
1.7.1
