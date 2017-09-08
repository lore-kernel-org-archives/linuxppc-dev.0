Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qk0-x241.google.com (mail-qk0-x241.google.com
 [IPv6:2607:f8b0:400d:c09::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xpsrQ2YcVzDrcw
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Sep 2017 08:46:46 +1000 (AEST)
Received: by mail-qk0-x241.google.com with SMTP id d70so2319242qkc.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 08 Sep 2017 15:46:46 -0700 (PDT)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: mpe@ellerman.id.au,
	linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com,
 linuxram@us.ibm.com
Subject: [PATCH 02/25] powerpc: define an additional vma bit for protection
 keys.
Date: Fri,  8 Sep 2017 15:44:50 -0700
Message-Id: <1504910713-7094-11-git-send-email-linuxram@us.ibm.com>
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

powerpc needs an additional vma bit to support 32 keys.
Till the additional vma bit lands in include/linux/mm.h
we have to define  it  in powerpc specific header file.
This is  needed to get pkeys working on power.

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 arch/powerpc/include/asm/pkeys.h |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
index c02305a..44e01a2 100644
--- a/arch/powerpc/include/asm/pkeys.h
+++ b/arch/powerpc/include/asm/pkeys.h
@@ -3,6 +3,24 @@
 
 extern bool pkey_inited;
 extern bool pkey_execute_disable_support;
+
+/*
+ * powerpc needs an additional vma bit to support 32 keys.
+ * Till the additional vma bit lands in include/linux/mm.h
+ * we have to carry the hunk below. This is  needed to get
+ * pkeys working on power. -- Ram
+ */
+#ifndef VM_HIGH_ARCH_BIT_4
+#define VM_HIGH_ARCH_BIT_4	36
+#define VM_HIGH_ARCH_4	BIT(VM_HIGH_ARCH_BIT_4)
+#define VM_PKEY_SHIFT VM_HIGH_ARCH_BIT_0
+#define VM_PKEY_BIT0	VM_HIGH_ARCH_0
+#define VM_PKEY_BIT1	VM_HIGH_ARCH_1
+#define VM_PKEY_BIT2	VM_HIGH_ARCH_2
+#define VM_PKEY_BIT3	VM_HIGH_ARCH_3
+#define VM_PKEY_BIT4	VM_HIGH_ARCH_4
+#endif
+
 #define ARCH_VM_PKEY_FLAGS 0
 
 static inline bool mm_pkey_is_allocated(struct mm_struct *mm, int pkey)
-- 
1.7.1
