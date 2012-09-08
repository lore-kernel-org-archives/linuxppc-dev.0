Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp08.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8F8DC2C0092
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  9 Sep 2012 02:57:38 +1000 (EST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sun, 9 Sep 2012 02:57:08 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q88Gv7DT21299270
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 9 Sep 2012 02:57:07 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q88Gv7iA027043
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 9 Sep 2012 02:57:07 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH -V8 0/11] arch/powerpc: Add 64TB support to ppc64
In-Reply-To: <87fw6uoxo3.fsf@linux.vnet.ibm.com>
References: <1346945351-7672-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1346982235.2385.33.camel@pasglop> <87fw6uoxo3.fsf@linux.vnet.ibm.com>
Date: Sat, 08 Sep 2012 22:27:02 +0530
Message-ID: <87ipbomp0h.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:

> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
>
>> On Thu, 2012-09-06 at 20:59 +0530, Aneesh Kumar K.V wrote:
>>> Hi,
>>> 
>>> This patchset include patches for supporting 64TB with ppc64. I haven't booted
>>> this on hardware with 64TB memory yet. But they boot fine on real hardware with
>>> less memory. Changes extend VSID bits to 38 bits for a 256MB segment
>>> and 26 bits for 1TB segments.
>>
>> Your series breaks the embedded 64-bit build. You seem to be hard wiring
>> dependencies on slice stuff all over 64-bit stuff regardless of the MMU
>> type or the value of CONFIG_MM_SLICES.
>>
>> Also all these:
>>
>>> +/* 4 bits per slice and we have one slice per 1TB */
>>> +#if 0 /* We can't directly include pgtable.h hence this hack */
>>> +#define SLICE_ARRAY_SIZE  (PGTABLE_RANGE >> 41)
>>> +#else
>>> +/* Right now we only support 64TB */
>>> +#define SLICE_ARRAY_SIZE  32
>>> +#endif
>>
>> Things are just too horrible. Find a different way of doing it, if
>> necessary create a new range define somewhere, whatever but don't leave
>> that crap as-is, it's too wrong.
>>
>> Dropping the series for now.
>>
>
> You can drop the patch [PATCH -V8 07/11] arch/powerpc: Make some of the PGTABLE_RANGE dependency explicit
> from the series. The above two problems are introduced by that patch and
> as such can be looked up as a cleanup. I can rework the patch later. You
> should be able to apply series without any conflicts even if you drop
> that patch.
>

I tried multiple changes to get the dependency isolated. But below is
the most clean one I ended with. You have nacked it in the previous
mail, but considering the mm_context_t dependency, IMHO this is better.
Let me know if you have any other suggestion . This can go as a patch
on top of the series after dropping patch 7 in this series.

>From 22a6f8c636112e54eb9c07e2bfbe4fd9b3861114 Mon Sep 17 00:00:00 2001
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Fri, 7 Sep 2012 10:59:21 +0530
Subject: [PATCH] arch/powerpc: Make some of the PGTABLE_RANGE dependency
 explicit

slice array size and slice mask size depend on PGTABLE_RANGE. We
can't directly include pgtable.h in these header because there is
a circular dependency. So split the pgtable range into a separate
header and include that

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/mmu-hash64.h          |    9 ++++-----
 arch/powerpc/include/asm/page_64.h             |   12 ++++++++----
 arch/powerpc/include/asm/pgtable-ppc64-range.h |   16 ++++++++++++++++
 arch/powerpc/include/asm/pgtable-ppc64.h       |   14 +++++++-------
 4 files changed, 35 insertions(+), 16 deletions(-)
 create mode 100644 arch/powerpc/include/asm/pgtable-ppc64-range.h

diff --git a/arch/powerpc/include/asm/mmu-hash64.h b/arch/powerpc/include/asm/mmu-hash64.h
index 3e88746..057a12a 100644
--- a/arch/powerpc/include/asm/mmu-hash64.h
+++ b/arch/powerpc/include/asm/mmu-hash64.h
@@ -14,6 +14,7 @@
 
 #include <asm/asm-compat.h>
 #include <asm/page.h>
+#include <asm/pgtable-ppc64-range.h>
 
 /*
  * Segment table
@@ -414,6 +415,8 @@ extern void slb_set_size(u16 size);
 	srdi	rx,rx,VSID_BITS_##size;	/* extract 2^VSID_BITS bit */	\
 	add	rt,rt,rx
 
+/* 4 bits per slice and we have one slice per 1TB */
+#define SLICE_ARRAY_SIZE  (PGTABLE_RANGE >> 41)
 
 #ifndef __ASSEMBLY__
 
@@ -458,11 +461,7 @@ typedef struct {
 
 #ifdef CONFIG_PPC_MM_SLICES
 	u64 low_slices_psize;	/* SLB page size encodings */
-	/*
-	 * Right now we support 64TB and 4 bits for each
-	 * 1TB slice we need 32 bytes for 64TB.
-	 */
-	unsigned char high_slices_psize[32];  /* 4 bits per slice for now */
+	unsigned char high_slices_psize[SLICE_ARRAY_SIZE];
 #else
 	u16 sllp;		/* SLB page size encoding */
 #endif
diff --git a/arch/powerpc/include/asm/page_64.h b/arch/powerpc/include/asm/page_64.h
index 6c9bef4..cd915d6 100644
--- a/arch/powerpc/include/asm/page_64.h
+++ b/arch/powerpc/include/asm/page_64.h
@@ -78,14 +78,18 @@ extern u64 ppc64_pft_size;
 #define GET_LOW_SLICE_INDEX(addr)	((addr) >> SLICE_LOW_SHIFT)
 #define GET_HIGH_SLICE_INDEX(addr)	((addr) >> SLICE_HIGH_SHIFT)
 
+/*
+ * 1 bit per slice and we have one slice per 1TB
+ * Right now we support only 64TB.
+ * IF we change this we will have to change the type
+ * of high_slices
+ */
+#define SLICE_MASK_SIZE 8
+
 #ifndef __ASSEMBLY__
 
 struct slice_mask {
 	u16 low_slices;
-	/*
-	 * This should be derived out of PGTABLE_RANGE. For the current
-	 * max 64TB, u64 should be ok.
-	 */
 	u64 high_slices;
 };
 
diff --git a/arch/powerpc/include/asm/pgtable-ppc64-range.h b/arch/powerpc/include/asm/pgtable-ppc64-range.h
new file mode 100644
index 0000000..04a825c
--- /dev/null
+++ b/arch/powerpc/include/asm/pgtable-ppc64-range.h
@@ -0,0 +1,16 @@
+#ifndef _ASM_POWERPC_PGTABLE_PPC64_RANGE_H_
+#define _ASM_POWERPC_PGTABLE_PPC64_RANGE_H_
+
+#ifdef CONFIG_PPC_64K_PAGES
+#include <asm/pgtable-ppc64-64k.h>
+#else
+#include <asm/pgtable-ppc64-4k.h>
+#endif
+
+/*
+ * Size of EA range mapped by our pagetables.
+ */
+#define PGTABLE_EADDR_SIZE (PTE_INDEX_SIZE + PMD_INDEX_SIZE + \
+			    PUD_INDEX_SIZE + PGD_INDEX_SIZE + PAGE_SHIFT)
+#define PGTABLE_RANGE (ASM_CONST(1) << PGTABLE_EADDR_SIZE)
+#endif
diff --git a/arch/powerpc/include/asm/pgtable-ppc64.h b/arch/powerpc/include/asm/pgtable-ppc64.h
index 8af1cf2..701bec6 100644
--- a/arch/powerpc/include/asm/pgtable-ppc64.h
+++ b/arch/powerpc/include/asm/pgtable-ppc64.h
@@ -13,13 +13,7 @@
 
 #define FIRST_USER_ADDRESS	0
 
-/*
- * Size of EA range mapped by our pagetables.
- */
-#define PGTABLE_EADDR_SIZE (PTE_INDEX_SIZE + PMD_INDEX_SIZE + \
-                	    PUD_INDEX_SIZE + PGD_INDEX_SIZE + PAGE_SHIFT)
-#define PGTABLE_RANGE (ASM_CONST(1) << PGTABLE_EADDR_SIZE)
-
+#include <asm/pgtable-ppc64-range.h>
 
 /* Some sanity checking */
 #if TASK_SIZE_USER64 > PGTABLE_RANGE
@@ -32,6 +26,12 @@
 #endif
 #endif
 
+#ifdef CONFIG_PPC_MM_SLICES
+#if (PGTABLE_RANGE >> 43) > SLICE_MASK_SIZE
+#error PGTABLE_RANGE exceeds slice_mask high_slices size
+#endif
+#endif
+
 /*
  * Define the address range of the kernel non-linear virtual area
  */
-- 
1.7.10
