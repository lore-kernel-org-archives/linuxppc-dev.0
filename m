Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qt0-x242.google.com (mail-qt0-x242.google.com
 [IPv6:2607:f8b0:400d:c0d::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zN3hz1ZLCzF0mf
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jan 2018 12:51:47 +1100 (AEDT)
Received: by mail-qt0-x242.google.com with SMTP id z10so440468qti.5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jan 2018 17:51:47 -0800 (PST)
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
Subject: [PATCH v10 02/27] mm, powerpc,
 x86: introduce an additional vma bit for powerpc pkey
Date: Thu, 18 Jan 2018 17:50:23 -0800
Message-Id: <1516326648-22775-3-git-send-email-linuxram@us.ibm.com>
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

Currently only 4bits are allocated in the vma flags to hold 16
keys. This is sufficient for x86. PowerPC  supports  32  keys,
which needs 5bits. This patch allocates an  additional bit.

Acked-by: Balbir Singh <bsingharora@gmail.com>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 fs/proc/task_mmu.c |    1 +
 include/linux/mm.h |    3 ++-
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index b139617..0edd4da 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -680,6 +680,7 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
 		[ilog2(VM_PKEY_BIT1)]	= "",
 		[ilog2(VM_PKEY_BIT2)]	= "",
 		[ilog2(VM_PKEY_BIT3)]	= "",
+		[ilog2(VM_PKEY_BIT4)]	= "",
 #endif /* CONFIG_ARCH_HAS_PKEYS */
 	};
 	size_t i;
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 01381d3..ebcb997 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -231,9 +231,10 @@ extern int overcommit_kbytes_handler(struct ctl_table *, int, void __user *,
 #ifdef CONFIG_ARCH_HAS_PKEYS
 # define VM_PKEY_SHIFT	VM_HIGH_ARCH_BIT_0
 # define VM_PKEY_BIT0	VM_HIGH_ARCH_0	/* A protection key is a 4-bit value */
-# define VM_PKEY_BIT1	VM_HIGH_ARCH_1
+# define VM_PKEY_BIT1	VM_HIGH_ARCH_1	/* on x86 and 5-bit value on ppc64   */
 # define VM_PKEY_BIT2	VM_HIGH_ARCH_2
 # define VM_PKEY_BIT3	VM_HIGH_ARCH_3
+# define VM_PKEY_BIT4	VM_HIGH_ARCH_4
 #endif /* CONFIG_ARCH_HAS_PKEYS */
 
 #if defined(CONFIG_X86)
-- 
1.7.1
