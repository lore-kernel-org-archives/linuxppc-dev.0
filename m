Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp09.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 43CF4B7332
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Jun 2012 05:58:56 +1000 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 1 Jun 2012 01:28:51 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q4VJwnXF35127458
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Jun 2012 01:28:50 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q511TKkG007878
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Jun 2012 11:29:21 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, michael@ellerman.id.au,
 anton@samba.org
Subject: Re: [Early RFC 0/6] arch/powerpc: Add 64TB support to ppc64
In-Reply-To: <1338493841-9926-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1338493841-9926-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>User-Agent: Notmuch/0.11.1+346~g13d19c3
 (http://notmuchmail.org) Emacs/23.3.1 (x86_64-pc-linux-gnu)
Date: Fri, 01 Jun 2012 01:28:45 +0530
Message-ID: <874nqwyvey.fsf@skywalker.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:

> Hi,
>
> This patchset include preparatory patches for supporting 64TB with ppc64. I haven't
> completed the actual patch that bump the USER_ESID bits. I wanted the share the
> changes early so that I can get feedback on the approach. The changes itself
> contains few FIXME!! which I will be addressing in the later updates.
>

Here is the patch that update USER_ESID_BITS. I get a machine check
exception with this changes. That is why I didn't include this in the patch
series. 

commit 5fff8ff606bc136c510350a40528431196f60001
Author: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Date:   Wed May 23 16:59:36 2012 +0530

    arch/powerpc: Add 64TB support
    
    Increase max addressable range to 64TB. This is not tested on
    real hardware yet.
    
    Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

diff --git a/arch/powerpc/include/asm/mmu-hash64.h b/arch/powerpc/include/asm/mmu-hash64.h
index 0f8b10d..9f9a2a1 100644
--- a/arch/powerpc/include/asm/mmu-hash64.h
+++ b/arch/powerpc/include/asm/mmu-hash64.h
@@ -375,8 +375,8 @@ extern void slb_set_size(u16 size);
 #define VSID_MODULUS_1T		((1UL<<VSID_BITS_1T)-1)
 
 #define CONTEXT_BITS		19
-#define USER_ESID_BITS		16
-#define USER_ESID_BITS_1T	4
+#define USER_ESID_BITS		18
+#define USER_ESID_BITS_1T	6
 
 #define USER_VSID_RANGE	(1UL << (USER_ESID_BITS + SID_SHIFT))
 
diff --git a/arch/powerpc/include/asm/pgtable-ppc64-4k.h b/arch/powerpc/include/asm/pgtable-ppc64-4k.h
index 6eefdcf..b3eccf2 100644
--- a/arch/powerpc/include/asm/pgtable-ppc64-4k.h
+++ b/arch/powerpc/include/asm/pgtable-ppc64-4k.h
@@ -7,7 +7,7 @@
  */
 #define PTE_INDEX_SIZE  9
 #define PMD_INDEX_SIZE  7
-#define PUD_INDEX_SIZE  7
+#define PUD_INDEX_SIZE  9
 #define PGD_INDEX_SIZE  9
 
 #ifndef __ASSEMBLY__
diff --git a/arch/powerpc/include/asm/pgtable-ppc64-64k.h b/arch/powerpc/include/asm/pgtable-ppc64-64k.h
index 90533dd..be4e287 100644
--- a/arch/powerpc/include/asm/pgtable-ppc64-64k.h
+++ b/arch/powerpc/include/asm/pgtable-ppc64-64k.h
@@ -7,7 +7,7 @@
 #define PTE_INDEX_SIZE  12
 #define PMD_INDEX_SIZE  12
 #define PUD_INDEX_SIZE	0
-#define PGD_INDEX_SIZE  4
+#define PGD_INDEX_SIZE  6
 
 #ifndef __ASSEMBLY__
 #define PTE_TABLE_SIZE	(sizeof(real_pte_t) << PTE_INDEX_SIZE)
diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index 8e2d037..426ed13 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -100,8 +100,8 @@ extern struct task_struct *last_task_used_spe;
 #endif
 
 #ifdef CONFIG_PPC64
-/* 64-bit user address space is 44-bits (16TB user VM) */
-#define TASK_SIZE_USER64 (0x0000100000000000UL)
+/* 64-bit user address space is 46-bits (64TB user VM) */
+#define TASK_SIZE_USER64 (0x0000400000000000UL)
 
 /* 
  * 32-bit user address space is 4GB - 1 page 
diff --git a/arch/powerpc/include/asm/sparsemem.h b/arch/powerpc/include/asm/sparsemem.h
index 0c5fa31..f6fc0ee 100644
--- a/arch/powerpc/include/asm/sparsemem.h
+++ b/arch/powerpc/include/asm/sparsemem.h
@@ -10,8 +10,8 @@
  */
 #define SECTION_SIZE_BITS       24
 
-#define MAX_PHYSADDR_BITS       44
-#define MAX_PHYSMEM_BITS        44
+#define MAX_PHYSADDR_BITS       46
+#define MAX_PHYSMEM_BITS        46
 
 #endif /* CONFIG_SPARSEMEM */
 
