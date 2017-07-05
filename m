Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qk0-x242.google.com (mail-qk0-x242.google.com
 [IPv6:2607:f8b0:400d:c09::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x2v4n0Zg5zDr3s
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Jul 2017 07:23:53 +1000 (AEST)
Received: by mail-qk0-x242.google.com with SMTP id v143so182638qkb.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Jul 2017 14:23:52 -0700 (PDT)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, dave.hansen@intel.com, hbabu@us.ibm.com,
 linuxram@us.ibm.com, arnd@arndb.de, akpm@linux-foundation.org,
 corbet@lwn.net, mingo@redhat.com
Subject: [RFC v5 34/38] procfs: display the protection-key number associated
 with a vma
Date: Wed,  5 Jul 2017 14:22:11 -0700
Message-Id: <1499289735-14220-35-git-send-email-linuxram@us.ibm.com>
In-Reply-To: <1499289735-14220-1-git-send-email-linuxram@us.ibm.com>
References: <1499289735-14220-1-git-send-email-linuxram@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Display the pkey number associated with the vma in smaps of a task.
The key will be seen as below:

ProtectionKey: 0

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 arch/powerpc/kernel/setup_64.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index f35ff9d..ebc82b3 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -37,6 +37,7 @@
 #include <linux/memblock.h>
 #include <linux/memory.h>
 #include <linux/nmi.h>
+#include <linux/pkeys.h>
 
 #include <asm/io.h>
 #include <asm/kdump.h>
@@ -745,3 +746,10 @@ static int __init disable_hardlockup_detector(void)
 }
 early_initcall(disable_hardlockup_detector);
 #endif
+
+#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
+void arch_show_smap(struct seq_file *m, struct vm_area_struct *vma)
+{
+	seq_printf(m, "ProtectionKey:  %8u\n", vma_pkey(vma));
+}
+#endif /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
-- 
1.7.1
