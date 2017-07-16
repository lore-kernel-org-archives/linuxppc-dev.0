Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qk0-x241.google.com (mail-qk0-x241.google.com
 [IPv6:2607:f8b0:400d:c09::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x9CMs6x2nzDqmr
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 16 Jul 2017 13:58:49 +1000 (AEST)
Received: by mail-qk0-x241.google.com with SMTP id c18so6917803qkb.2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Jul 2017 20:58:49 -0700 (PDT)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, dave.hansen@intel.com, hbabu@us.ibm.com,
 linuxram@us.ibm.com, arnd@arndb.de, akpm@linux-foundation.org,
 corbet@lwn.net, mingo@redhat.com, mhocko@kernel.org
Subject: [RFC v6 19/62] powerpc: ability to create execute-disabled pkeys
Date: Sat, 15 Jul 2017 20:56:21 -0700
Message-Id: <1500177424-13695-20-git-send-email-linuxram@us.ibm.com>
In-Reply-To: <1500177424-13695-1-git-send-email-linuxram@us.ibm.com>
References: <1500177424-13695-1-git-send-email-linuxram@us.ibm.com>
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
 arch/powerpc/mm/pkeys.c          |   10 ++++++++++
 2 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
index 1943e6b..0e744f1 100644
--- a/arch/powerpc/include/asm/pkeys.h
+++ b/arch/powerpc/include/asm/pkeys.h
@@ -2,6 +2,18 @@
 #define _ASM_PPC64_PKEYS_H
 
 extern bool pkey_inited;
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
 #define arch_max_pkey()  32
 #define AMR_RD_BIT 0x1UL
 #define AMR_WR_BIT 0x2UL
diff --git a/arch/powerpc/mm/pkeys.c b/arch/powerpc/mm/pkeys.c
index 98d0391..b9ad98d 100644
--- a/arch/powerpc/mm/pkeys.c
+++ b/arch/powerpc/mm/pkeys.c
@@ -73,6 +73,7 @@ int __arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
 		unsigned long init_val)
 {
 	u64 new_amr_bits = 0x0ul;
+	u64 new_iamr_bits = 0x0ul;
 
 	if (!is_pkey_enabled(pkey))
 		return -1;
@@ -85,5 +86,14 @@ int __arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
 
 	init_amr(pkey, new_amr_bits);
 
+	/*
+	 * By default execute is disabled.
+	 * To enable execute, PKEY_ENABLE_EXECUTE
+	 * needs to be specified.
+	 */
+	if ((init_val & PKEY_DISABLE_EXECUTE))
+		new_iamr_bits |= IAMR_EX_BIT;
+
+	init_iamr(pkey, new_iamr_bits);
 	return 0;
 }
-- 
1.7.1
