Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qt0-x244.google.com (mail-qt0-x244.google.com
 [IPv6:2607:f8b0:400d:c0d::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xLKfG4RH4zDr5s
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Jul 2017 10:12:54 +1000 (AEST)
Received: by mail-qt0-x244.google.com with SMTP id d10so15667408qtb.4
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Jul 2017 17:12:54 -0700 (PDT)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, hbabu@us.ibm.com, linuxram@us.ibm.com,
 bauerman@linux.vnet.ibm.com, mhocko@kernel.org
Subject: [RFC v7 08/25] powerpc: ability to create execute-disabled pkeys
Date: Sun, 30 Jul 2017 17:12:09 -0700
Message-Id: <1501459946-11619-9-git-send-email-linuxram@us.ibm.com>
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

powerpc has hardware support to disable execute on a pkey.
This patch enables the ability to create execute-disabled
keys.

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 arch/powerpc/include/asm/pkeys.h |   12 ++++++++++++
 arch/powerpc/mm/pkeys.c          |    5 +++++
 2 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
index aec3f49..9d59619 100644
--- a/arch/powerpc/include/asm/pkeys.h
+++ b/arch/powerpc/include/asm/pkeys.h
@@ -22,6 +22,18 @@
 #define VM_PKEY_BIT4	VM_HIGH_ARCH_4
 #endif
 
+/* override any generic PKEY Permission defines */
+#undef  PKEY_DISABLE_ACCESS
+#define PKEY_DISABLE_ACCESS    0x1
+#undef  PKEY_DISABLE_WRITE
+#define PKEY_DISABLE_WRITE     0x2
+#undef  PKEY_DISABLE_EXECUTE
+#define PKEY_DISABLE_EXECUTE   0x4
+#undef  PKEY_ACCESS_MASK
+#define PKEY_ACCESS_MASK       (PKEY_DISABLE_ACCESS |\
+				PKEY_DISABLE_WRITE  |\
+				PKEY_DISABLE_EXECUTE)
+
 #define arch_max_pkey()  pkeys_total
 #define AMR_RD_BIT 0x1UL
 #define AMR_WR_BIT 0x2UL
diff --git a/arch/powerpc/mm/pkeys.c b/arch/powerpc/mm/pkeys.c
index 5b3531e..c1c40c3 100644
--- a/arch/powerpc/mm/pkeys.c
+++ b/arch/powerpc/mm/pkeys.c
@@ -78,6 +78,7 @@ int __arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
 		unsigned long init_val)
 {
 	u64 new_amr_bits = 0x0ul;
+	u64 new_iamr_bits = 0x0ul;
 
 	if (!is_pkey_enabled(pkey))
 		return -EINVAL;
@@ -90,5 +91,9 @@ int __arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
 
 	init_amr(pkey, new_amr_bits);
 
+	if ((init_val & PKEY_DISABLE_EXECUTE))
+		new_iamr_bits |= IAMR_EX_BIT;
+
+	init_iamr(pkey, new_iamr_bits);
 	return 0;
 }
-- 
1.7.1
