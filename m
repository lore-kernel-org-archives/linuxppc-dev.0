Return-Path: <dale@farnsworth.org>
Received: from farnsworth.org (xyzzy.farnsworth.org [65.39.95.219])
	by ozlabs.org (Postfix) with SMTP id 7DC88DDE3F
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  4 Oct 2007 05:01:43 +1000 (EST)
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Wed, 3 Oct 2007 12:01:40 -0700
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH] PPC 85xx failure with odd memory sizes and CONFIG_HIGHMEM
Message-ID: <20071003190140.GA19169@xyzzy.farnsworth.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

From: Dale Farnsworth <dale@farnsworth.org>

The CONFIG_FSL_BOOKE mmu setup code fails when CONFIG_HIGHMEM=y
and the 3 fixed TLB entries cannot exactly map the lowmem size.
Each TLB entry can map 4MB, 16MB, 64MB or 256MB, so the failure
is observed when the kernel lowmem size is not equal to the
sum of up to 3 of those values.

Normally, memory is sized in nice numbers, but I observed this
problem while testing a crash dump kernel.  The failure can
also be observed by artificially reducing the kernel's main
memory via the mem= kernel command line parameter.

This commit fixes the problem by setting __initial_memory_limit
in adjust_total_lowmem().

Signed-off-by: Dale Farnsworth <dale@farnsworth.org>

---
 arch/powerpc/mm/fsl_booke_mmu.c |    2 ++
 1 file changed, 2 insertions(+)

Index: linux-2.6.21/arch/powerpc/mm/fsl_booke_mmu.c
===================================================================
--- linux-2.6.21.orig/arch/powerpc/mm/fsl_booke_mmu.c	2007-10-02 01:18:10.000000000 +0000
+++ linux-2.6.21/arch/powerpc/mm/fsl_booke_mmu.c	2007-10-03 16:40:24.000000000 +0000
@@ -60,6 +60,7 @@ unsigned int num_tlbcam_entries;
 static unsigned long __cam0, __cam1, __cam2;
 extern unsigned long total_lowmem;
 extern unsigned long __max_low_memory;
+extern unsigned long __initial_memory_limit;
 #define MAX_LOW_MEM	CONFIG_LOWMEM_SIZE
 
 #define NUM_TLBCAMS	(16)
@@ -233,4 +234,5 @@ adjust_total_lowmem(void)
 			__cam0 >> 20, __cam1 >> 20, __cam2 >> 20,
 			(total_lowmem - __cam0 - __cam1 - __cam2) >> 20);
 	__max_low_memory = max_low_mem = __cam0 + __cam1 + __cam2;
+	__initial_memory_limit = __max_low_memory;
 }
