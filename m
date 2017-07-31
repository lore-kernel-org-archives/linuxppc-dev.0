Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qt0-x242.google.com (mail-qt0-x242.google.com
 [IPv6:2607:f8b0:400d:c0d::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xLKf049yYzDr5m
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Jul 2017 10:12:40 +1000 (AEST)
Received: by mail-qt0-x242.google.com with SMTP id c15so11604647qta.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Jul 2017 17:12:40 -0700 (PDT)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, hbabu@us.ibm.com, linuxram@us.ibm.com,
 bauerman@linux.vnet.ibm.com, mhocko@kernel.org
Subject: [RFC v7 01/25] powerpc: define an additional vma bit for protection
 keys.
Date: Sun, 30 Jul 2017 17:12:02 -0700
Message-Id: <1501459946-11619-2-git-send-email-linuxram@us.ibm.com>
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

powerpc needs an additional vma bit to support 32 keys.
Till the additional vma bit lands in include/linux/mm.h
we have to define  it  in powerpc specific header file.
This is  needed to get pkeys working on power.

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 arch/powerpc/include/asm/pkeys.h |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
index acad7c2..4ccb8f5 100644
--- a/arch/powerpc/include/asm/pkeys.h
+++ b/arch/powerpc/include/asm/pkeys.h
@@ -2,6 +2,24 @@
 #define _ASM_PPC64_PKEYS_H
 
 extern bool pkey_inited;
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
