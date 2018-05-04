Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qt0-x241.google.com (mail-qt0-x241.google.com
 [IPv6:2607:f8b0:400d:c0d::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40d5Xs0FWQzDr4X
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 May 2018 08:00:12 +1000 (AEST)
Received: by mail-qt0-x241.google.com with SMTP id h2-v6so29351567qtp.7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 May 2018 15:00:12 -0700 (PDT)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: mpe@ellerman.id.au,
	mingo@redhat.com,
	akpm@linux-foundation.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 dave.hansen@intel.com, benh@kernel.crashing.org, paulus@samba.org,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org,
 bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, linuxram@us.ibm.com,
 corbet@lwn.net, arnd@arndb.de
Subject: [PATCH v13 3/3] mm, powerpc,
 x86: introduce an additional vma bit for powerpc pkey
Date: Fri,  4 May 2018 14:59:42 -0700
Message-Id: <1525471183-21277-3-git-send-email-linuxram@us.ibm.com>
In-Reply-To: <1525471183-21277-1-git-send-email-linuxram@us.ibm.com>
References: <1525471183-21277-1-git-send-email-linuxram@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Only 4bits are allocated in the vma flags to hold 16 keys. This is
sufficient on x86. PowerPC supports 32 keys, which needs 5bits.
Allocate an  additional bit.

cc: Dave Hansen <dave.hansen@intel.com>
cc: Michael Ellermen <mpe@ellerman.id.au>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Balbir Singh <bsingharora@gmail.com>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 fs/proc/task_mmu.c |    1 +
 include/linux/mm.h |    8 +++++++-
 2 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 0c9e392..3ddddc7 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -679,6 +679,7 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
 		[ilog2(VM_PKEY_BIT1)]	= "",
 		[ilog2(VM_PKEY_BIT2)]	= "",
 		[ilog2(VM_PKEY_BIT3)]	= "",
+		[ilog2(VM_PKEY_BIT4)]	= "",
 #endif /* CONFIG_ARCH_HAS_PKEYS */
 	};
 	size_t i;
diff --git a/include/linux/mm.h b/include/linux/mm.h
index c6a6f24..cca67d1 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -230,10 +230,16 @@ extern int overcommit_kbytes_handler(struct ctl_table *, int, void __user *,
 
 #ifdef CONFIG_ARCH_HAS_PKEYS
 # define VM_PKEY_SHIFT	VM_HIGH_ARCH_BIT_0
-# define VM_PKEY_BIT0	VM_HIGH_ARCH_0	/* A protection key is a 4-bit value */
+/* Protection key is a 4-bit value on x86 and 5-bit value on ppc64   */
+# define VM_PKEY_BIT0	VM_HIGH_ARCH_0
 # define VM_PKEY_BIT1	VM_HIGH_ARCH_1
 # define VM_PKEY_BIT2	VM_HIGH_ARCH_2
 # define VM_PKEY_BIT3	VM_HIGH_ARCH_3
+#if defined(CONFIG_PPC)
+# define VM_PKEY_BIT4	VM_HIGH_ARCH_4
+#else 
+# define VM_PKEY_BIT4	0
+#endif
 #endif /* CONFIG_ARCH_HAS_PKEYS */
 
 #if defined(CONFIG_X86)
-- 
1.7.1
