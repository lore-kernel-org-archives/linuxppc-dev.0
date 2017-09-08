Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qt0-x241.google.com (mail-qt0-x241.google.com
 [IPv6:2607:f8b0:400d:c0d::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xpsrZ4gF6zDrch
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Sep 2017 08:46:54 +1000 (AEST)
Received: by mail-qt0-x241.google.com with SMTP id 7so2356951qtz.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 08 Sep 2017 15:46:54 -0700 (PDT)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: mpe@ellerman.id.au,
	linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com,
 linuxram@us.ibm.com
Subject: [PATCH 07/25] powerpc: implementation for arch_set_user_pkey_access()
Date: Fri,  8 Sep 2017 15:44:55 -0700
Message-Id: <1504910713-7094-16-git-send-email-linuxram@us.ibm.com>
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
index 53bf13b..7fd48a4 100644
--- a/arch/powerpc/include/asm/pkeys.h
+++ b/arch/powerpc/include/asm/pkeys.h
@@ -24,6 +24,9 @@
 #endif
 
 #define arch_max_pkey()  pkeys_total
+#define AMR_RD_BIT 0x1UL
+#define AMR_WR_BIT 0x2UL
+#define IAMR_EX_BIT 0x1UL
 #define ARCH_VM_PKEY_FLAGS (VM_PKEY_BIT0 | VM_PKEY_BIT1 | VM_PKEY_BIT2 | \
 				VM_PKEY_BIT3 | VM_PKEY_BIT4)
 #define AMR_BITS_PER_PKEY 2
@@ -123,10 +126,14 @@ static inline int arch_override_mprotect_pkey(struct vm_area_struct *vma,
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
index 178aa33..cc5be6a 100644
--- a/arch/powerpc/mm/pkeys.c
+++ b/arch/powerpc/mm/pkeys.c
@@ -12,6 +12,7 @@
  * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
  * more details.
  */
+#include <asm/mman.h>
 #include <linux/pkeys.h>                /* PKEY_*                       */
 
 bool pkey_inited;
@@ -63,6 +64,11 @@ void __init pkey_initialize(void)
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
@@ -105,3 +111,25 @@ void __arch_deactivate_pkey(int pkey)
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
+	return 0;
+}
-- 
1.7.1
