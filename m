Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qt0-x242.google.com (mail-qt0-x242.google.com
 [IPv6:2607:f8b0:400d:c0d::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xpsrF3XSszDrcy
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Sep 2017 08:46:37 +1000 (AEST)
Received: by mail-qt0-x242.google.com with SMTP id b1so14399qtc.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 08 Sep 2017 15:46:37 -0700 (PDT)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: mpe@ellerman.id.au,
	linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com,
 linuxram@us.ibm.com
Subject: [PATCH 5/7] powerpc: Swizzle around 4K PTE bits to free up bit 5 and
 bit 6
Date: Fri,  8 Sep 2017 15:44:45 -0700
Message-Id: <1504910713-7094-6-git-send-email-linuxram@us.ibm.com>
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

We  need  PTE bits  3 ,4, 5, 6 and 57 to support protection-keys,
because these are  the bits we want to consolidate on across all
configuration to support protection keys.

Bit 3,4,5 and 6 are currently used on 4K-pte kernels.  But bit 9
and 10 are available.  Hence  we  use the two available bits and
free up bit 5 and 6.  We will still not be able to free up bit 3
and 4. In the absence  of  any  other free bits, we will have to
stay satisfied  with  what we have :-(.   This means we will not
be  able  to support  32  protection  keys, but only 8.  The bit
numbers are  big-endian as defined in the  ISA3.0

This patch  does  the  following change to 4K PTE.

H_PAGE_F_SECOND (S) which   occupied  bit  4   moves  to  bit  7.
H_PAGE_F_GIX (G,I,X)  which  occupied  bit 5, 6 and 7 also moves
to  bit 8,9, 10 respectively.
H_PAGE_HASHPTE (H)  which   occupied   bit  8  moves  to  bit  4.

Before the patch, the 4k PTE format was as follows

 0 1 2 3 4  5  6  7  8 9 10....................57.....63
 : : : : :  :  :  :  : : :                      :     :
 v v v v v  v  v  v  v v v                      v     v
,-,-,-,-,--,--,--,--,-,-,-,-,-,------------------,-,-,-,
|x|x|x|B|S |G |I |X |H| | |x|x|................| |x|x|x|
'_'_'_'_'__'__'__'__'_'_'_'_'_'________________'_'_'_'_'

After the patch, the 4k PTE format is as follows

 0 1 2 3 4  5  6  7  8 9 10....................57.....63
 : : : : :  :  :  :  : : :                      :     :
 v v v v v  v  v  v  v v v                      v     v
,-,-,-,-,--,--,--,--,-,-,-,-,-,------------------,-,-,-,
|x|x|x|B|H |  |  |S |G|I|X|x|x|................| |.|.|.|
'_'_'_'_'__'__'__'__'_'_'_'_'_'________________'_'_'_'_'

The patch has no code changes; just swizzles around bits.

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/hash-4k.h  |    7 ++++---
 arch/powerpc/include/asm/book3s/64/hash-64k.h |    1 +
 arch/powerpc/include/asm/book3s/64/hash.h     |    1 -
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash-4k.h b/arch/powerpc/include/asm/book3s/64/hash-4k.h
index dc153c6..5187249 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-4k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-4k.h
@@ -16,10 +16,11 @@
 #define H_PUD_TABLE_SIZE	(sizeof(pud_t) << H_PUD_INDEX_SIZE)
 #define H_PGD_TABLE_SIZE	(sizeof(pgd_t) << H_PGD_INDEX_SIZE)
 
-#define H_PAGE_F_GIX_SHIFT	56
-#define H_PAGE_F_SECOND	_RPAGE_RSV2	/* HPTE is in 2ndary HPTEG */
-#define H_PAGE_F_GIX	(_RPAGE_RSV3 | _RPAGE_RSV4 | _RPAGE_RPN44)
+#define H_PAGE_F_GIX_SHIFT	53
+#define H_PAGE_F_SECOND	_RPAGE_RPN44	/* HPTE is in 2ndary HPTEG */
+#define H_PAGE_F_GIX	(_RPAGE_RPN43 | _RPAGE_RPN42 | _RPAGE_RPN41)
 #define H_PAGE_BUSY	_RPAGE_RSV1     /* software: PTE & hash are busy */
+#define H_PAGE_HASHPTE	_RPAGE_RSV2     /* software: PTE & hash are busy */
 
 /* PTE flags to conserve for HPTE identification */
 #define _PAGE_HPTEFLAGS (H_PAGE_BUSY | H_PAGE_HASHPTE | \
diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
index 89ef5a9..8576060 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
@@ -13,6 +13,7 @@
 #define H_PAGE_COMBO	_RPAGE_RPN0 /* this is a combo 4k page */
 #define H_PAGE_4K_PFN	_RPAGE_RPN1 /* PFN is for a single 4k page */
 #define H_PAGE_BUSY	_RPAGE_RPN44     /* software: PTE & hash are busy */
+#define H_PAGE_HASHPTE	_RPAGE_RPN43	/* PTE has associated HPTE */
 
 /*
  * We need to differentiate between explicit huge page and THP huge
diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
index 46f3a23..953795e 100644
--- a/arch/powerpc/include/asm/book3s/64/hash.h
+++ b/arch/powerpc/include/asm/book3s/64/hash.h
@@ -8,7 +8,6 @@
  *
  */
 #define H_PTE_NONE_MASK		_PAGE_HPTEFLAGS
-#define H_PAGE_HASHPTE		_RPAGE_RPN43	/* PTE has associated HPTE */
 
 #ifdef CONFIG_PPC_64K_PAGES
 #include <asm/book3s/64/hash-64k.h>
-- 
1.7.1
