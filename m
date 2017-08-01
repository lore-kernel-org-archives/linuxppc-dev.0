Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xMCHF0qThzDrhD
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Aug 2017 20:29:29 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: anton@samba.org,
	aneesh.kumar@linux.vnet.ibm.com
Subject: [PATCH 3/3] powerpc/mm/hash64: Make vmalloc 56T on hash
Date: Tue,  1 Aug 2017 20:29:24 +1000
Message-Id: <1501583364-14909-3-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1501583364-14909-1-git-send-email-mpe@ellerman.id.au>
References: <1501583364-14909-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 64-bit book3s, with the hash MMU, we currently define the kernel
virtual space (vmalloc, ioremap etc.), to be 16T in size. This is a
leftover from pre v3.7 when our user VM was also 16T.

Of that 16T we split it 50/50, with half used for PCI IO and ioremap
and the other 8T for vmalloc.

We never bothered to make it any bigger because 8T of vmalloc ought to
be enough for anybody. But it turns out that's not true, the per cpu
allocator wants large amounts of vmalloc space, not to make large
allocations, but to allow a large stride between allocations, because
we use pcpu_embed_first_chunk().

With a bit of juggling we can keep 8T for the IO etc. and make the
vmalloc space 56T. The only complication is the check of the address
in the SLB miss handler, see the comment in the code.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/book3s/64/hash.h |  4 ++--
 arch/powerpc/mm/slb_low.S                 | 18 +++++++++++++++---
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
index d613653ed5b9..f88452019114 100644
--- a/arch/powerpc/include/asm/book3s/64/hash.h
+++ b/arch/powerpc/include/asm/book3s/64/hash.h
@@ -40,7 +40,7 @@
  * Define the address range of the kernel non-linear virtual area
  */
 #define H_KERN_VIRT_START ASM_CONST(0xD000000000000000)
-#define H_KERN_VIRT_SIZE	ASM_CONST(0x0000100000000000)
+#define H_KERN_VIRT_SIZE  ASM_CONST(0x0000400000000000) /* 64T */
 
 /*
  * The vmalloc space starts at the beginning of that region, and
@@ -48,7 +48,7 @@
  * (we keep a quarter for the virtual memmap)
  */
 #define H_VMALLOC_START	H_KERN_VIRT_START
-#define H_VMALLOC_SIZE	(H_KERN_VIRT_SIZE >> 1)
+#define H_VMALLOC_SIZE	ASM_CONST(0x380000000000) /* 56T */
 #define H_VMALLOC_END	(H_VMALLOC_START + H_VMALLOC_SIZE)
 
 #define H_KERN_IO_START	H_VMALLOC_END
diff --git a/arch/powerpc/mm/slb_low.S b/arch/powerpc/mm/slb_low.S
index 2eb1b92a68ff..906a86fe457b 100644
--- a/arch/powerpc/mm/slb_low.S
+++ b/arch/powerpc/mm/slb_low.S
@@ -121,9 +121,21 @@ slb_miss_kernel_load_vmemmap:
 1:
 #endif /* CONFIG_SPARSEMEM_VMEMMAP */
 
-	clrldi	r11,r10,48
-	cmpldi	r11,(H_VMALLOC_SIZE >> 28) - 1
-	bgt	5f
+	/*
+	 * r10 contains the ESID, which is the original faulting EA shifted
+	 * right by 28 bits. We need to compare that with (H_VMALLOC_END >> 28)
+	 * which is 0xd00038000. That can't be used as an immediate, even if we
+	 * ignored the 0xd, so we have to load it into a register, and we only
+	 * have one register free. So we must load all of (H_VMALLOC_END >> 28)
+	 * into a register and compare ESID against that.
+	 */
+	lis	r11,(H_VMALLOC_END >> 32)@h	// r11 = 0xffffffffd0000000
+	ori	r11,r11,(H_VMALLOC_END >> 32)@l	// r11 = 0xffffffffd0003800
+	// Rotate left 4, then mask with 0xffffffff0
+	rldic	r11,r11,4,28			// r11 = 0xd00038000
+	cmpld	r10,r11				// if r10 >= r11
+	bge	5f				//   goto io_mapping
+
 	/*
 	 * vmalloc mapping gets the encoding from the PACA as the mapping
 	 * can be demoted from 64K -> 4K dynamically on some machines.
-- 
2.7.4
