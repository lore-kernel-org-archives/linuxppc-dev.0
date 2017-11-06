Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qt0-x241.google.com (mail-qt0-x241.google.com
 [IPv6:2607:f8b0:400d:c0d::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yVmc55DLXzDr8P
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Nov 2017 19:55:33 +1100 (AEDT)
Received: by mail-qt0-x241.google.com with SMTP id 1so10013924qtn.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Nov 2017 00:55:33 -0800 (PST)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org, paulus@samba.org,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org,
 bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, linuxram@us.ibm.com
Subject: [PATCH v9 5/8] powerpc: shifted-by-one hidx value
Date: Mon,  6 Nov 2017 00:50:49 -0800
Message-Id: <1509958252-18302-6-git-send-email-linuxram@us.ibm.com>
In-Reply-To: <1509958252-18302-1-git-send-email-linuxram@us.ibm.com>
References: <1509958252-18302-1-git-send-email-linuxram@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

0xf is considered invalid hidx value. It indicates absence of a backing
HPTE. A PTE is initialized to 0xf either
a) when it is new it is newly allocated to hold 4k-backing-HPTE
	or
b) Any time it gets demoted to a 4k-backing-HPTE

This patch shifts the representation by one-modulo-0xf; i.e hidx 0 is
represented as 1, 1 as 2,... , and 0xf as 0. This convention lets us
initialize the secondary-part of the PTE to all zeroes. PTEs are anyway
zero'd when allocated. We do not have to zero them again; thus saving on
the initialization.

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/hash-64k.h |   14 +++++++++++---
 1 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
index 73ed988..b78d94e 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
@@ -63,13 +63,21 @@ static inline real_pte_t __real_pte(pte_t pte, pte_t *ptep)
 	return rpte;
 }
 
+/*
+ * shift the hidx representation by one-modulo-0xf; i.e hidx 0 is respresented
+ * as 1, 1 as 2,... , and 0xf as 0.  This convention lets us represent a
+ * invalid hidx 0xf with a 0x0 bit value. PTEs are anyway zero'd when
+ * allocated. We dont have to zero them gain; thus save on the initialization.
+ */
+#define HIDX_UNSHIFT_BY_ONE(x) ((x + 0xfUL) & 0xfUL) /* shift backward by one */
+#define HIDX_SHIFT_BY_ONE(x) ((x + 0x1UL) & 0xfUL)   /* shift forward by one */
 #define HIDX_BITS(x, index)  (x << (index << 2))
 #define BITS_TO_HIDX(x, index)  ((x >> (index << 2)) & 0xfUL)
-#define INVALID_RPTE_HIDX  ~(0x0UL)
+#define INVALID_RPTE_HIDX  0x0UL
 
 static inline unsigned long __rpte_to_hidx(real_pte_t rpte, unsigned long index)
 {
-	return BITS_TO_HIDX(rpte.hidx, index);
+	return HIDX_UNSHIFT_BY_ONE(BITS_TO_HIDX(rpte.hidx, index));
 }
 
 /*
@@ -82,7 +90,7 @@ static inline unsigned long pte_set_hidx(pte_t *ptep, real_pte_t rpte,
 	unsigned long *hidxp = (unsigned long *)(ptep + PTRS_PER_PTE);
 
 	rpte.hidx &= ~HIDX_BITS(0xfUL, subpg_index);
-	*hidxp = rpte.hidx  | HIDX_BITS(hidx, subpg_index);
+	*hidxp = rpte.hidx  | HIDX_BITS(HIDX_SHIFT_BY_ONE(hidx), subpg_index);
 
 	/*
 	 * Anyone reading PTE must ensure hidx bits are read after reading the
-- 
1.7.1
