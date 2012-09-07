Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp08.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3D4D12C007E
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Sep 2012 15:42:57 +1000 (EST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 7 Sep 2012 11:12:53 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q875godp61604086
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Sep 2012 11:12:50 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q875gnq6010055
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Sep 2012 15:42:50 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH -V8 0/11] arch/powerpc: Add 64TB support to ppc64
In-Reply-To: <1346982235.2385.33.camel@pasglop>
References: <1346945351-7672-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1346982235.2385.33.camel@pasglop>
Date: Fri, 07 Sep 2012 11:12:49 +0530
Message-ID: <871uiexuau.fsf@linux.vnet.ibm.com>
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

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Thu, 2012-09-06 at 20:59 +0530, Aneesh Kumar K.V wrote:
>> Hi,
>> 
>> This patchset include patches for supporting 64TB with ppc64. I haven't booted
>> this on hardware with 64TB memory yet. But they boot fine on real hardware with
>> less memory. Changes extend VSID bits to 38 bits for a 256MB segment
>> and 26 bits for 1TB segments.
>
> Your series breaks the embedded 64-bit build. You seem to be hard wiring
> dependencies on slice stuff all over 64-bit stuff regardless of the MMU
> type or the value of CONFIG_MM_SLICES.
>
> Also all these:
>
>> +/* 4 bits per slice and we have one slice per 1TB */
>> +#if 0 /* We can't directly include pgtable.h hence this hack */
>> +#define SLICE_ARRAY_SIZE  (PGTABLE_RANGE >> 41)
>> +#else
>> +/* Right now we only support 64TB */
>> +#define SLICE_ARRAY_SIZE  32
>> +#endif
>
> Things are just too horrible. Find a different way of doing it, if
> necessary create a new range define somewhere, whatever but don't leave
> that crap as-is, it's too wrong.
>
> Dropping the series for now.
>

How about the change below. If you are ok moving the range details to
new header, I can fold this into patch 7 and send a new series

-aneesh

diff --git a/arch/powerpc/include/asm/mmu-hash64.h b/arch/powerpc/include/asm/mmu-hash64.h
index 428f23e..057a12a 100644
--- a/arch/powerpc/include/asm/mmu-hash64.h
+++ b/arch/powerpc/include/asm/mmu-hash64.h
@@ -14,6 +14,7 @@
 
 #include <asm/asm-compat.h>
 #include <asm/page.h>
+#include <asm/pgtable-ppc64-range.h>
 
 /*
  * Segment table
@@ -415,12 +416,7 @@ extern void slb_set_size(u16 size);
 	add	rt,rt,rx
 
 /* 4 bits per slice and we have one slice per 1TB */
-#if 0 /* We can't directly include pgtable.h hence this hack */
 #define SLICE_ARRAY_SIZE  (PGTABLE_RANGE >> 41)
-#else
-/* Right now we only support 64TB */
-#define SLICE_ARRAY_SIZE  32
-#endif
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/powerpc/include/asm/page_64.h b/arch/powerpc/include/asm/page_64.h
index b55beb4..01ab518 100644
--- a/arch/powerpc/include/asm/page_64.h
+++ b/arch/powerpc/include/asm/page_64.h
@@ -78,16 +78,14 @@ extern u64 ppc64_pft_size;
 #define GET_LOW_SLICE_INDEX(addr)	((addr) >> SLICE_LOW_SHIFT)
 #define GET_HIGH_SLICE_INDEX(addr)	((addr) >> SLICE_HIGH_SHIFT)
 
-/* 1 bit per slice and we have one slice per 1TB */
-#if 0 /* We can't directly include pgtable.h hence this hack */
-#define SLICE_MASK_SIZE (PGTABLE_RANGE >> 43)
-#else
-/*
+/* 1 bit per slice and we have one slice per 1TB
  * Right now we support only 64TB.
  * IF we change this we will have to change the type
  * of high_slices
  */
 #define SLICE_MASK_SIZE 8
+#if (PGTABLE_RANGE >> 43) > SLICE_MASK_SIZE
+#error PGTABLE_RANGE exceeds slice_mask high_slices size
 #endif
 
 #ifndef __ASSEMBLY__
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
index dea953f..ee783b4 100644
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
@@ -32,14 +26,6 @@
 #endif
 #endif
 
-#if (PGTABLE_RANGE >> 41) > SLICE_ARRAY_SIZE
-#error PGTABLE_RANGE exceeds SLICE_ARRAY_SIZE
-#endif
-
-#if (PGTABLE_RANGE >> 43) > SLICE_MASK_SIZE
-#error PGTABLE_RANGE exceeds slice_mask high_slices size
-#endif
-
 /*
  * Define the address range of the kernel non-linear virtual area
  */
