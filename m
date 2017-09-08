Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qt0-x242.google.com (mail-qt0-x242.google.com
 [IPv6:2607:f8b0:400d:c0d::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xpsrm3QVJzDrdP
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Sep 2017 08:47:04 +1000 (AEST)
Received: by mail-qt0-x242.google.com with SMTP id k2so2348973qte.5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 08 Sep 2017 15:47:04 -0700 (PDT)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: mpe@ellerman.id.au,
	linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com,
 linuxram@us.ibm.com
Subject: [PATCH 12/25] powerpc: ability to associate pkey to a vma
Date: Fri,  8 Sep 2017 15:45:00 -0700
Message-Id: <1504910713-7094-21-git-send-email-linuxram@us.ibm.com>
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

arch-independent code expects the arch to  map
a  pkey  into the vma's protection bit setting.
The patch provides that ability.

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 arch/powerpc/include/asm/mman.h  |    8 +++++++-
 arch/powerpc/include/asm/pkeys.h |   18 ++++++++++++++++++
 2 files changed, 25 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/mman.h b/arch/powerpc/include/asm/mman.h
index 30922f6..067eec2 100644
--- a/arch/powerpc/include/asm/mman.h
+++ b/arch/powerpc/include/asm/mman.h
@@ -13,6 +13,7 @@
 
 #include <asm/cputable.h>
 #include <linux/mm.h>
+#include <linux/pkeys.h>
 #include <asm/cpu_has_feature.h>
 
 /*
@@ -22,7 +23,12 @@
 static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
 		unsigned long pkey)
 {
-	return (prot & PROT_SAO) ? VM_SAO : 0;
+#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
+	return (((prot & PROT_SAO) ? VM_SAO : 0) |
+			pkey_to_vmflag_bits(pkey));
+#else
+	return ((prot & PROT_SAO) ? VM_SAO : 0);
+#endif
 }
 #define arch_calc_vm_prot_bits(prot, pkey) arch_calc_vm_prot_bits(prot, pkey)
 
diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
index 0cf115f..f13e913 100644
--- a/arch/powerpc/include/asm/pkeys.h
+++ b/arch/powerpc/include/asm/pkeys.h
@@ -23,6 +23,24 @@
 #define VM_PKEY_BIT4	VM_HIGH_ARCH_4
 #endif
 
+/* override any generic PKEY Permission defines */
+#define PKEY_DISABLE_EXECUTE   0x4
+#define PKEY_ACCESS_MASK       (PKEY_DISABLE_ACCESS |\
+				PKEY_DISABLE_WRITE  |\
+				PKEY_DISABLE_EXECUTE)
+
+static inline u64 pkey_to_vmflag_bits(u16 pkey)
+{
+	if (!pkey_inited)
+		return 0x0UL;
+
+	return (((pkey & 0x1UL) ? VM_PKEY_BIT0 : 0x0UL) |
+		((pkey & 0x2UL) ? VM_PKEY_BIT1 : 0x0UL) |
+		((pkey & 0x4UL) ? VM_PKEY_BIT2 : 0x0UL) |
+		((pkey & 0x8UL) ? VM_PKEY_BIT3 : 0x0UL) |
+		((pkey & 0x10UL) ? VM_PKEY_BIT4 : 0x0UL));
+}
+
 #define arch_max_pkey()  pkeys_total
 #define AMR_RD_BIT 0x1UL
 #define AMR_WR_BIT 0x2UL
-- 
1.7.1
