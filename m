Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qt0-x243.google.com (mail-qt0-x243.google.com
 [IPv6:2607:f8b0:400d:c0d::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zN3jM48L8zF0w7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jan 2018 12:52:07 +1100 (AEDT)
Received: by mail-qt0-x243.google.com with SMTP id f4so439298qtj.6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jan 2018 17:52:07 -0800 (PST)
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
Subject: [PATCH v10 09/27] powerpc: ability to create execute-disabled pkeys
Date: Thu, 18 Jan 2018 17:50:30 -0800
Message-Id: <1516326648-22775-10-git-send-email-linuxram@us.ibm.com>
In-Reply-To: <1516326648-22775-1-git-send-email-linuxram@us.ibm.com>
References: <1516326648-22775-1-git-send-email-linuxram@us.ibm.com>
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
 arch/powerpc/include/uapi/asm/mman.h |    6 ++++++
 arch/powerpc/mm/pkeys.c              |   16 ++++++++++++++++
 2 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/uapi/asm/mman.h b/arch/powerpc/include/uapi/asm/mman.h
index e63bc37..65065ce 100644
--- a/arch/powerpc/include/uapi/asm/mman.h
+++ b/arch/powerpc/include/uapi/asm/mman.h
@@ -30,4 +30,10 @@
 #define MAP_STACK	0x20000		/* give out an address that is best suited for process/thread stacks */
 #define MAP_HUGETLB	0x40000		/* create a huge page mapping */
 
+/* Override any generic PKEY permission defines */
+#define PKEY_DISABLE_EXECUTE   0x4
+#undef PKEY_ACCESS_MASK
+#define PKEY_ACCESS_MASK       (PKEY_DISABLE_ACCESS |\
+				PKEY_DISABLE_WRITE  |\
+				PKEY_DISABLE_EXECUTE)
 #endif /* _UAPI_ASM_POWERPC_MMAN_H */
diff --git a/arch/powerpc/mm/pkeys.c b/arch/powerpc/mm/pkeys.c
index eca04cd..39e9814 100644
--- a/arch/powerpc/mm/pkeys.c
+++ b/arch/powerpc/mm/pkeys.c
@@ -29,6 +29,14 @@ int pkey_initialize(void)
 	int os_reserved, i;
 
 	/*
+	 * We define PKEY_DISABLE_EXECUTE in addition to the arch-neutral
+	 * generic defines for PKEY_DISABLE_ACCESS and PKEY_DISABLE_WRITE.
+	 * Ensure that the bits a distinct.
+	 */
+	BUILD_BUG_ON(PKEY_DISABLE_EXECUTE &
+		     (PKEY_DISABLE_ACCESS | PKEY_DISABLE_WRITE));
+
+	/*
 	 * Disable the pkey system till everything is in place. A subsequent
 	 * patch will enable it.
 	 */
@@ -181,10 +189,18 @@ int __arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
 				unsigned long init_val)
 {
 	u64 new_amr_bits = 0x0ul;
+	u64 new_iamr_bits = 0x0ul;
 
 	if (!is_pkey_enabled(pkey))
 		return -EINVAL;
 
+	if (init_val & PKEY_DISABLE_EXECUTE) {
+		if (!pkey_execute_disable_supported)
+			return -EINVAL;
+		new_iamr_bits |= IAMR_EX_BIT;
+	}
+	init_iamr(pkey, new_iamr_bits);
+
 	/* Set the bits we need in AMR: */
 	if (init_val & PKEY_DISABLE_ACCESS)
 		new_amr_bits |= AMR_RD_BIT | AMR_WR_BIT;
-- 
1.7.1
