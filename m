Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qk0-x242.google.com (mail-qk0-x242.google.com
 [IPv6:2607:f8b0:400d:c09::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x9CMh33RzzDqmM
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 16 Jul 2017 13:58:40 +1000 (AEST)
Received: by mail-qk0-x242.google.com with SMTP id v17so14723892qka.3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Jul 2017 20:58:40 -0700 (PDT)
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
Subject: [RFC v6 15/62] powerpc: helper functions to initialize AMR,
 IAMR and UMOR registers
Date: Sat, 15 Jul 2017 20:56:17 -0700
Message-Id: <1500177424-13695-16-git-send-email-linuxram@us.ibm.com>
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

Introduce helper functions that can initialize the bits in the AMR,
IAMR and UMOR register; the bits that correspond to the given pkey.

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 arch/powerpc/include/asm/pkeys.h |    1 +
 arch/powerpc/mm/pkeys.c          |   44 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
index 09b268e..4327842 100644
--- a/arch/powerpc/include/asm/pkeys.h
+++ b/arch/powerpc/include/asm/pkeys.h
@@ -5,6 +5,7 @@
 #define arch_max_pkey()  32
 #define ARCH_VM_PKEY_FLAGS (VM_PKEY_BIT0 | VM_PKEY_BIT1 | VM_PKEY_BIT2 | \
 				VM_PKEY_BIT3 | VM_PKEY_BIT4)
+#define AMR_BITS_PER_PKEY 2
 /*
  * Bits are in BE format.
  * NOTE: key 31, 1, 0 are not used.
diff --git a/arch/powerpc/mm/pkeys.c b/arch/powerpc/mm/pkeys.c
index c3acee1..04ee361 100644
--- a/arch/powerpc/mm/pkeys.c
+++ b/arch/powerpc/mm/pkeys.c
@@ -16,3 +16,47 @@
 #include <linux/pkeys.h>                /* PKEY_*                       */
 
 bool pkey_inited;
+#define pkeyshift(pkey) ((arch_max_pkey()-pkey-1) * AMR_BITS_PER_PKEY)
+
+static inline void init_amr(int pkey, u8 init_bits)
+{
+	u64 new_amr_bits = (((u64)init_bits & 0x3UL) << pkeyshift(pkey));
+	u64 old_amr = read_amr() & ~((u64)(0x3ul) << pkeyshift(pkey));
+
+	write_amr(old_amr | new_amr_bits);
+}
+
+static inline void init_iamr(int pkey, u8 init_bits)
+{
+	u64 new_iamr_bits = (((u64)init_bits & 0x3UL) << pkeyshift(pkey));
+	u64 old_iamr = read_iamr() & ~((u64)(0x3ul) << pkeyshift(pkey));
+
+	write_amr(old_iamr | new_iamr_bits);
+}
+
+static void pkey_status_change(int pkey, bool enable)
+{
+	u64 old_uamor;
+
+	/* reset the AMR and IAMR bits for this key */
+	init_amr(pkey, 0x0);
+	init_iamr(pkey, 0x0);
+
+	/* enable/disable key */
+	old_uamor = read_uamor();
+	if (enable)
+		old_uamor |= (0x3ul << pkeyshift(pkey));
+	else
+		old_uamor &= ~(0x3ul << pkeyshift(pkey));
+	write_uamor(old_uamor);
+}
+
+void __arch_activate_pkey(int pkey)
+{
+	pkey_status_change(pkey, true);
+}
+
+void __arch_deactivate_pkey(int pkey)
+{
+	pkey_status_change(pkey, false);
+}
-- 
1.7.1
