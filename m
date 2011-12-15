Return-Path: <suzuki@in.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp07.in.ibm.com", Issuer "GeoTrust SSL CA" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id C88FF1007DC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Dec 2011 19:58:47 +1100 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <suzuki@in.ibm.com>;
 Thu, 15 Dec 2011 14:28:41 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 pBF8wddi3932414
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Dec 2011 14:28:39 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pBF8wcuY003124
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Dec 2011 14:28:38 +0530
From: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Subject: [PATCH v5 4/7] [ppc] Define virtual-physical translations for
 RELOCATABLE
To: Josh Boyer <jwboyer@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 15 Dec 2011 14:28:37 +0530
Message-ID: <20111215085817.3404.79178.stgit@suzukikp.in.ibm.com>
In-Reply-To: <20111215085516.3404.56377.stgit@suzukikp.in.ibm.com>
References: <20111215085516.3404.56377.stgit@suzukikp.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Scott Wood <scottwood@freescale.com>,
 Josh Poimboeuf <jpoimboe@linux.vnet.ibm.com>,
 linux ppc dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We find the runtime address of _stext and relocate ourselves based
on the following calculation.

	virtual_base = ALIGN(KERNELBASE,KERNEL_TLB_PIN_SIZE) +
			MODULO(_stext.run,KERNEL_TLB_PIN_SIZE)

relocate() is called with the Effective Virtual Base Address (as
shown below)

            | Phys. Addr| Virt. Addr |
Page        |------------------------|
Boundary    |           |            |
            |           |            |
            |           |            |
Kernel Load |___________|_ __ _ _ _ _|<- Effective
Addr(_stext)|           |      ^     |Virt. Base Addr
            |           |      |     |
            |           |      |     |
            |           |reloc_offset|
            |           |      |     |
            |           |      |     |
            |           |______v_____|<-(KERNELBASE)%TLB_SIZE
            |           |            |
            |           |            |
            |           |            |
Page        |-----------|------------|
Boundary    |           |            |


On BookE, we need __va() & __pa() early in the boot process to access
the device tree.

Currently this has been defined as :

#define __va(x) ((void *)(unsigned long)((phys_addr_t)(x) -
						PHYSICAL_START + KERNELBASE)
where:
 PHYSICAL_START is kernstart_addr - a variable updated at runtime.
 KERNELBASE	is the compile time Virtual base address of kernel.

This won't work for us, as kernstart_addr is dynamic and will yield different
results for __va()/__pa() for same mapping.

e.g.,

Let the kernel be loaded at 64MB and KERNELBASE be 0xc0000000 (same as
PAGE_OFFSET).

In this case, we would be mapping 0 to 0xc0000000, and kernstart_addr = 64M

Now __va(1MB) = (0x100000) - (0x4000000) + 0xc0000000
		= 0xbc100000 , which is wrong.

it should be : 0xc0000000 + 0x100000 = 0xc0100000

On platforms which support AMP, like PPC_47x (based on 44x), the kernel
could be loaded at highmem. Hence we cannot always depend on the compile
time constants for mapping.

Here are the possible solutions:

1) Update kernstart_addr(PHSYICAL_START) to match the Physical address of
compile time KERNELBASE value, instead of the actual Physical_Address(_stext).

The disadvantage is that we may break other users of PHYSICAL_START. They
could be replaced with __pa(_stext).

2) Redefine __va() & __pa() with relocation offset


#ifdef	CONFIG_RELOCATABLE_PPC32
#define __va(x) ((void *)(unsigned long)((phys_addr_t)(x) - PHYSICAL_START + (KERNELBASE + RELOC_OFFSET)))
#define __pa(x) ((unsigned long)(x) + PHYSICAL_START - (KERNELBASE + RELOC_OFFSET))
#endif

where, RELOC_OFFSET could be

  a) A variable, say relocation_offset (like kernstart_addr), updated
     at boot time. This impacts performance, as we have to load an additional
     variable from memory.

		OR

  b) #define RELOC_OFFSET ((PHYSICAL_START & PPC_PIN_SIZE_OFFSET_MASK) - \
                      (KERNELBASE & PPC_PIN_SIZE_OFFSET_MASK))

   This introduces more calculations for doing the translation.

3) Redefine __va() & __pa() with a new variable

i.e,

#define __va(x) ((void *)(unsigned long)((phys_addr_t)(x) + VIRT_PHYS_OFFSET))

where VIRT_PHYS_OFFSET :

#ifdef CONFIG_RELOCATABLE_PPC32
#define VIRT_PHYS_OFFSET virt_phys_offset
#else
#define VIRT_PHYS_OFFSET (KERNELBASE - PHYSICAL_START)
#endif /* CONFIG_RELOCATABLE_PPC32 */

where virt_phy_offset is updated at runtime to :

	Effective KERNELBASE - kernstart_addr.

Taking our example, above:

virt_phys_offset = effective_kernelstart_vaddr - kernstart_addr
		 = 0xc0400000 - 0x400000
		 = 0xc0000000
	and

	__va(0x100000) = 0xc0000000 + 0x100000 = 0xc0100000
	 which is what we want.

I have implemented (3) in the following patch which has same cost of
operation as the existing one.

I have tested the patches on 440x platforms only. However this should
work fine for PPC_47x also, as we only depend on the runtime address
and the current TLB XLAT entry for the startup code, which is available
in r25. I don't have access to a 47x board yet. So, it would be great if
somebody could test this on 47x.

Signed-off-by: Suzuki K. Poulose <suzuki@in.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
---

 arch/powerpc/include/asm/page.h |   85 ++++++++++++++++++++++++++++++++++++++-
 arch/powerpc/mm/init_32.c       |    7 +++
 2 files changed, 89 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
index f149967..f072e97 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -97,12 +97,26 @@ extern unsigned int HPAGE_SHIFT;
 
 extern phys_addr_t memstart_addr;
 extern phys_addr_t kernstart_addr;
+
+#ifdef CONFIG_RELOCATABLE_PPC32
+extern long long virt_phys_offset;
 #endif
+
+#endif /* __ASSEMBLY__ */
 #define PHYSICAL_START	kernstart_addr
-#else
+
+#else	/* !CONFIG_NONSTATIC_KERNEL */
 #define PHYSICAL_START	ASM_CONST(CONFIG_PHYSICAL_START)
 #endif
 
+/* See Description below for VIRT_PHYS_OFFSET */
+#ifdef CONFIG_RELOCATABLE_PPC32
+#define VIRT_PHYS_OFFSET virt_phys_offset
+#else
+#define VIRT_PHYS_OFFSET (KERNELBASE - PHYSICAL_START)
+#endif
+
+
 #ifdef CONFIG_PPC64
 #define MEMORY_START	0UL
 #elif defined(CONFIG_NONSTATIC_KERNEL)
@@ -125,12 +139,77 @@ extern phys_addr_t kernstart_addr;
  * determine MEMORY_START until then.  However we can determine PHYSICAL_START
  * from information at hand (program counter, TLB lookup).
  *
+ * On BookE with RELOCATABLE (RELOCATABLE_PPC32)
+ *
+ *   With RELOCATABLE_PPC32,  we support loading the kernel at any physical 
+ *   address without any restriction on the page alignment.
+ *
+ *   We find the runtime address of _stext and relocate ourselves based on 
+ *   the following calculation:
+ *
+ *  	  virtual_base = ALIGN_DOWN(KERNELBASE,256M) +
+ *  				MODULO(_stext.run,256M)
+ *   and create the following mapping:
+ *
+ * 	  ALIGN_DOWN(_stext.run,256M) => ALIGN_DOWN(KERNELBASE,256M)
+ *
+ *   When we process relocations, we cannot depend on the
+ *   existing equation for the __va()/__pa() translations:
+ *
+ * 	   __va(x) = (x)  - PHYSICAL_START + KERNELBASE
+ *
+ *   Where:
+ *   	 PHYSICAL_START = kernstart_addr = Physical address of _stext
+ *  	 KERNELBASE = Compiled virtual address of _stext.
+ *
+ *   This formula holds true iff, kernel load address is TLB page aligned.
+ *
+ *   In our case, we need to also account for the shift in the kernel Virtual 
+ *   address.
+ *
+ *   E.g.,
+ *
+ *   Let the kernel be loaded at 64MB and KERNELBASE be 0xc0000000 (same as PAGE_OFFSET).
+ *   In this case, we would be mapping 0 to 0xc0000000, and kernstart_addr = 64M
+ *
+ *   Now __va(1MB) = (0x100000) - (0x4000000) + 0xc0000000
+ *                 = 0xbc100000 , which is wrong.
+ *
+ *   Rather, it should be : 0xc0000000 + 0x100000 = 0xc0100000
+ *      	according to our mapping.
+ *
+ *   Hence we use the following formula to get the translations right:
+ *
+ * 	  __va(x) = (x) - [ PHYSICAL_START - Effective KERNELBASE ]
+ *
+ * 	  Where :
+ * 		PHYSICAL_START = dynamic load address.(kernstart_addr variable)
+ * 		Effective KERNELBASE = virtual_base =
+ * 				     = ALIGN_DOWN(KERNELBASE,256M) +
+ * 						MODULO(PHYSICAL_START,256M)
+ *
+ * 	To make the cost of __va() / __pa() more light weight, we introduce
+ * 	a new variable virt_phys_offset, which will hold :
+ *
+ * 	virt_phys_offset = Effective KERNELBASE - PHYSICAL_START
+ * 			 = ALIGN_DOWN(KERNELBASE,256M) - 
+ * 			 	ALIGN_DOWN(PHYSICALSTART,256M)
+ *
+ * 	Hence :
+ *
+ * 	__va(x) = x - PHYSICAL_START + Effective KERNELBASE
+ * 		= x + virt_phys_offset
+ *
+ * 		and
+ * 	__pa(x) = x + PHYSICAL_START - Effective KERNELBASE
+ * 		= x - virt_phys_offset
+ * 		
  * On non-Book-E PPC64 PAGE_OFFSET and MEMORY_START are constants so use
  * the other definitions for __va & __pa.
  */
 #ifdef CONFIG_BOOKE
-#define __va(x) ((void *)(unsigned long)((phys_addr_t)(x) - PHYSICAL_START + KERNELBASE))
-#define __pa(x) ((unsigned long)(x) + PHYSICAL_START - KERNELBASE)
+#define __va(x) ((void *)(unsigned long)((phys_addr_t)(x) + VIRT_PHYS_OFFSET))
+#define __pa(x) ((unsigned long)(x) - VIRT_PHYS_OFFSET)
 #else
 #define __va(x) ((void *)(unsigned long)((phys_addr_t)(x) + PAGE_OFFSET - MEMORY_START))
 #define __pa(x) ((unsigned long)(x) - PAGE_OFFSET + MEMORY_START)
diff --git a/arch/powerpc/mm/init_32.c b/arch/powerpc/mm/init_32.c
index 161cefd..60a4e4e 100644
--- a/arch/powerpc/mm/init_32.c
+++ b/arch/powerpc/mm/init_32.c
@@ -65,6 +65,13 @@ phys_addr_t memstart_addr = (phys_addr_t)~0ull;
 EXPORT_SYMBOL(memstart_addr);
 phys_addr_t kernstart_addr;
 EXPORT_SYMBOL(kernstart_addr);
+
+#ifdef CONFIG_RELOCATABLE_PPC32
+/* Used in __va()/__pa() */
+long long virt_phys_offset;
+EXPORT_SYMBOL(virt_phys_offset);
+#endif
+
 phys_addr_t lowmem_end_addr;
 
 int boot_mapsize;
