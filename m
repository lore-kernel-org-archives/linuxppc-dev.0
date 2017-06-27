Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qt0-x242.google.com (mail-qt0-x242.google.com
 [IPv6:2607:f8b0:400d:c0d::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wxhYs28nhzDr3N
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jun 2017 20:12:33 +1000 (AEST)
Received: by mail-qt0-x242.google.com with SMTP id m54so646089qtb.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jun 2017 03:12:33 -0700 (PDT)
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
Subject: [RFC v4 08/17] powerpc: Program HPTE key protection bits
Date: Tue, 27 Jun 2017 03:11:50 -0700
Message-Id: <1498558319-32466-9-git-send-email-linuxram@us.ibm.com>
In-Reply-To: <1498558319-32466-1-git-send-email-linuxram@us.ibm.com>
References: <1498558319-32466-1-git-send-email-linuxram@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Map the PTE protection key bits to the HPTE key protection bits,
while creating HPTE  entries.

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 Makefile                                      | 2 +-
 arch/powerpc/include/asm/book3s/64/mmu-hash.h | 5 +++++
 arch/powerpc/include/asm/pkeys.h              | 9 +++++++++
 arch/powerpc/mm/hash_utils_64.c               | 4 ++++
 4 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 470bd4d..141ea4e 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 VERSION = 4
 PATCHLEVEL = 12
 SUBLEVEL = 0
-EXTRAVERSION = -rc3
+EXTRAVERSION = -rc3-64k
 NAME = Fearless Coyote
 
 # *DOCUMENTATION*
diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
index aa3c299..721a4c3 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
@@ -90,6 +90,8 @@
 #define HPTE_R_PP0		ASM_CONST(0x8000000000000000)
 #define HPTE_R_TS		ASM_CONST(0x4000000000000000)
 #define HPTE_R_KEY_HI		ASM_CONST(0x3000000000000000)
+#define HPTE_R_KEY_BIT0		ASM_CONST(0x2000000000000000)
+#define HPTE_R_KEY_BIT1		ASM_CONST(0x1000000000000000)
 #define HPTE_R_RPN_SHIFT	12
 #define HPTE_R_RPN		ASM_CONST(0x0ffffffffffff000)
 #define HPTE_R_RPN_3_0		ASM_CONST(0x01fffffffffff000)
@@ -104,6 +106,9 @@
 #define HPTE_R_C		ASM_CONST(0x0000000000000080)
 #define HPTE_R_R		ASM_CONST(0x0000000000000100)
 #define HPTE_R_KEY_LO		ASM_CONST(0x0000000000000e00)
+#define HPTE_R_KEY_BIT2		ASM_CONST(0x0000000000000800)
+#define HPTE_R_KEY_BIT3		ASM_CONST(0x0000000000000400)
+#define HPTE_R_KEY_BIT4		ASM_CONST(0x0000000000000200)
 
 #define HPTE_V_1TB_SEG		ASM_CONST(0x4000000000000000)
 #define HPTE_V_VRMA_MASK	ASM_CONST(0x4001ffffff000000)
diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
index 41bf5d4..ef1c601 100644
--- a/arch/powerpc/include/asm/pkeys.h
+++ b/arch/powerpc/include/asm/pkeys.h
@@ -23,6 +23,15 @@ static inline unsigned long  pkey_to_vmflag_bits(int pkey)
 		((pkey & 0x10UL) ? VM_PKEY_BIT4 : 0x0UL));
 }
 
+static inline unsigned long  pkey_to_hpte_pkey_bits(int pkey)
+{
+	return	(((pkey & 0x10) ? HPTE_R_KEY_BIT0 : 0x0UL) |
+		((pkey & 0x8) ? HPTE_R_KEY_BIT1 : 0x0UL) |
+		((pkey & 0x4) ? HPTE_R_KEY_BIT2 : 0x0UL) |
+		((pkey & 0x2) ? HPTE_R_KEY_BIT3 : 0x0UL) |
+		((pkey & 0x1) ? HPTE_R_KEY_BIT4 : 0x0UL));
+}
+
 /*
  * Bits are in BE format.
  * NOTE: key 31, 1, 0 are not used.
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 2254ff0..7e67dea 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -231,6 +231,10 @@ unsigned long htab_convert_pte_flags(unsigned long pteflags, int pkey)
 		 */
 		rflags |= HPTE_R_M;
 
+#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
+	rflags |= pkey_to_hpte_pkey_bits(pkey);
+#endif
+
 	return rflags;
 }
 
-- 
1.8.3.1
