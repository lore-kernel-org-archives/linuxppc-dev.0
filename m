Return-Path: <suzuki@in.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp03.in.ibm.com", Issuer "GeoTrust SSL CA" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id E6D5CB70BB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Oct 2011 20:58:19 +1100 (EST)
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by e28smtp03.in.ibm.com (8.14.4/8.13.1) with ESMTP id p9A9wAXq025425
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Oct 2011 15:28:10 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 p9A9us8t3588326
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Oct 2011 15:26:54 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 p9A9urmF000322
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Oct 2011 20:56:54 +1100
From: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Subject: [PATCH 2/3] [44x] Enable CONFIG_RELOCATABLE for PPC44x
To: linux ppc dev <linuxppc-dev@lists.ozlabs.org>
Date: Mon, 10 Oct 2011 15:26:51 +0530
Message-ID: <20111010095514.16589.85241.stgit@suzukikp.in.ibm.com>
In-Reply-To: <20111010094627.16589.52367.stgit@suzukikp.in.ibm.com>
References: <20111010094627.16589.52367.stgit@suzukikp.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Michal Simek <monstr@monstr.eu>, tmarri@apm.com,
 Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Dave Hansen <dave@linux.vnet.ibm.com>, David Laight <David.Laight@ACULAB.COM>,
 "Suzuki K. Poulose" <suzuki@in.ibm.com>, Scott Wood <scottwood@freescale.com>,
 Paul Mackerras <paulus@samba.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Vivek Goyal <vgoyal@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The following patch adds relocatable support for PPC44x kernel.

We find the runtime address of _stext and relocate ourselves based
on the following calculation.

	virtual_base = ALIGN(KERNELBASE,256M) +
			MODULO(_stext.run,256M)

relocate() is called with the Effective Virtual Base Address (as
shown below)

            | Phys. Addr| Virt. Addr |
Page (256M) |------------------------|
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
            |           |______v_____|<-(KERNELBASE)%256M
            |           |            |
            |           |            |
            |           |            |
Page(256M)  |-----------|------------|
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

On PPC_47x (which is based on 44x), the kernel could be loaded at highmem.
Hence we cannot always depend on the compile time constants for mapping.

Here are the possible solutions:

1) Update kernstart_addr(PHSYICAL_START) to match the Physical address of
compile time KERNELBASE value, instead of the actual Physical_Address(_stext).

The disadvantage is that we may break other users of PHYSICAL_START. They
could be replaced with __pa(_stext).

2) Redefine __va() & __pa() with relocation offset


#if defined(CONFIG_RELOCATABLE) && defined(CONFIG_44x)
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

#ifdef CONFIG_44x
#define VIRT_PHYS_OFFSET virt_phys_offset
#else
#define VIRT_PHYS_OFFSET (KERNELBASE - PHYSICAL_START)
#endif /* 44x */

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
Cc:	Paul Mackerras <paulus@samba.org>
Cc:	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:	Kumar Gala <galak@kernel.crashing.org>
Cc:	Tony Breeds <tony@bakeyournoodle.com>
Cc:	Josh Boyer <jwboyer@gmail.com>
Cc:	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
---

 arch/powerpc/Kconfig            |    2 -
 arch/powerpc/Makefile           |    1 
 arch/powerpc/include/asm/page.h |   84 +++++++++++++++++++++++++++++-
 arch/powerpc/kernel/head_44x.S  |  111 ++++++++++++++++++++++++++++++++++-----
 arch/powerpc/mm/init_32.c       |    7 ++
 5 files changed, 187 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 9eb2e60..99558d6 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -843,7 +843,7 @@ config LOWMEM_CAM_NUM
 
 config RELOCATABLE
 	bool "Build a relocatable kernel (EXPERIMENTAL)"
-	depends on EXPERIMENTAL && ADVANCED_OPTIONS && FLATMEM && (FSL_BOOKE || PPC_47x)
+	depends on EXPERIMENTAL && ADVANCED_OPTIONS && FLATMEM && (FSL_BOOKE || 44x || PPC_47x)
 	help
 	  This builds a kernel image that is capable of running at the
 	  location the kernel is loaded at (some alignment restrictions may
diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 57af16e..632b3dd 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -65,6 +65,7 @@ endif
 
 LDFLAGS_vmlinux-yy := -Bstatic
 LDFLAGS_vmlinux-$(CONFIG_PPC64)$(CONFIG_RELOCATABLE) := -pie
+LDFLAGS_vmlinux-$(CONFIG_44x)$(CONFIG_RELOCATABLE) := -pie
 LDFLAGS_vmlinux	:= $(LDFLAGS_vmlinux-yy)
 
 CFLAGS-$(CONFIG_PPC64)	:= -mminimal-toc -mtraceback=no -mcall-aixdesc
diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
index dd9c4fd..6898542 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -97,10 +97,25 @@ extern unsigned int HPAGE_SHIFT;
 
 extern phys_addr_t memstart_addr;
 extern phys_addr_t kernstart_addr;
+
+#ifdef CONFIG_44x
+extern long long virt_phys_offset;
 #endif
+
+#endif /* __ASSEMBLY__ */
 #define PHYSICAL_START	kernstart_addr
+
+
+/* See Description below for VIRT_PHYS_OFFSET */
+#ifdef CONFIG_44x
+#define VIRT_PHYS_OFFSET virt_phys_offset
 #else
+#define VIRT_PHYS_OFFSET (KERNELBASE - PHYSICAL_START)
+#endif /* 44x */
+
+#else	/* !CONFIG_RELOCATABLE */
 #define PHYSICAL_START	ASM_CONST(CONFIG_PHYSICAL_START)
+#define VIRT_PHYS_OFFSET (KERNELBASE - PHYSICAL_START)
 #endif
 
 #ifdef CONFIG_PPC64
@@ -125,12 +140,77 @@ extern phys_addr_t kernstart_addr;
  * determine MEMORY_START until then.  However we can determine PHYSICAL_START
  * from information at hand (program counter, TLB lookup).
  *
+ *  Relocation on 44x
+ *
+ *  On 44x, we support loading the kernel at any physical address without
+ *  any restriction on the page alignment.
+ *
+ *  We find the runtime address of _stext and relocate ourselves based on 
+ *  the following calculation:
+ *
+ *  	virtual_base = ALIGN_DOWN(KERNELBASE,256M) +
+ *  				MODULO(_stext.run,256M)
+ *  and create the following mapping:
+ *
+ * 	 ALIGN_DOWN(_stext.run,256M) => ALIGN_DOWN(KERNELBASE,256M)
+ *
+ * When we process relocations, we cannot depend on the
+ * existing equation for the __va()/__pa() translations:
+ *
+ * 	 __va(x) = (x)  - PHYSICAL_START + KERNELBASE
+ *
+ *  Where:
+ *  	PHYSICAL_START = kernstart_addr = Physical address of _stext
+ *  	KERNELBASE = Compiled virtual address of _stext.
+ *
+ * This formula holds true iff, kernel load address is TLB page aligned.
+ *
+ * In our case, we need to also account for the shift in the kernel Virtual 
+ * address.
+ *
+ * E.g.,
+ *
+ * Let the kernel be loaded at 64MB and KERNELBASE be 0xc0000000 (same as PAGE_OFFSET).
+ * In this case, we would be mapping 0 to 0xc0000000, and kernstart_addr = 64M
+ *
+ * Now __va(1MB) = (0x100000) - (0x4000000) + 0xc0000000
+ *               = 0xbc100000 , which is wrong.
+ *
+ * Rather, it should be : 0xc0000000 + 0x100000 = 0xc0100000
+ * 	according to our mapping.
+ *
+ * Hence we use the following formula to get the translations right:
+ *
+ * 	__va(x) = (x) - [ PHYSICAL_START - Effective KERNELBASE ]
+ *
+ * 	Where :
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
diff --git a/arch/powerpc/kernel/head_44x.S b/arch/powerpc/kernel/head_44x.S
index b725dab..8f57c31 100644
--- a/arch/powerpc/kernel/head_44x.S
+++ b/arch/powerpc/kernel/head_44x.S
@@ -64,6 +64,35 @@ _ENTRY(_start);
 	mr	r31,r3		/* save device tree ptr */
 	li	r24,0		/* CPU number */
 
+#if defined(CONFIG_RELOCATABLE)
+/*
+ * Relocate ourselves to the current runtime address.
+ * This is called only by the Boot CPU.
+ * "relocate" is called with our current runtime virutal
+ * address.
+ * r21 will be loaded with the physical runtime address of _stext
+ */
+	bl	0f				/* Get our runtime address */
+0:	mflr	r21				/* Make it accessible */
+	addis	r21,r21,(_stext - 0b)@ha
+	addi	r21,r21,(_stext - 0b)@l 	/* Get our current runtime base */
+
+	/*
+	 * We have the runtime (virutal) address of our base.
+	 * We calculate our shift of offset from a 256M page.
+	 * We could map the 256M page we belong to at PAGE_OFFSET and
+	 * get going from there.
+	 */
+	lis	r4,KERNELBASE@h
+	ori	r4,r4,KERNELBASE@l
+	rlwinm	r6,r21,0,4,31			/* r6 = PHYS_START % 256M */
+	rlwinm	r5,r4,0,4,31			/* r5 = KERNELBASE % 256M */
+	subf	r3,r5,r6			/* r3 = r6 - r5 */
+	add	r3,r4,r3			/* Required Virutal Address */
+
+	bl	relocate
+#endif
+
 	bl	init_cpu_state
 
 	/*
@@ -88,27 +117,60 @@ _ENTRY(_start);
 
 #ifdef CONFIG_RELOCATABLE
 	/*
-	 * r25 will contain RPN/ERPN for the start address of memory
-	 *
-	 * Add the difference between KERNELBASE and PAGE_OFFSET to the
-	 * start of physical memory to get kernstart_addr.
+	 * When we reach here :
+	 * r25 holds RPN/ERPN for the start address of memory
+	 * r21 contain the physical address of _stext
 	 */
 	lis	r3,kernstart_addr@ha
 	la	r3,kernstart_addr@l(r3)
 
-	lis	r4,KERNELBASE@h
-	ori	r4,r4,KERNELBASE@l
-	lis	r5,PAGE_OFFSET@h
-	ori	r5,r5,PAGE_OFFSET@l
-	subf	r4,r5,r4
-
-	rlwinm	r6,r25,0,28,31	/* ERPN */
+	/*
+	 * Compute the kernstart_addr.
+	 * kernstart_addr => (r6,r8)
+	 * kernstart_addr & ~0xfffffff => (r6,r7)
+	 */
+	rlwinm	r6,r25,0,28,31	/* ERPN. Bits 32-35 of Address */
 	rlwinm	r7,r25,0,0,3	/* RPN - assuming 256 MB page size */
-	add	r7,r7,r4
+	rlwinm	r8,r21,0,4,31	/* r8 = (_stext & 0xfffffff) */
+	or	r8,r7,r8	/* Compute the lower 32bit of kernstart_addr */
+
+	/* Store kernstart_addr */
+	stw	r6,0(r3)	/* higher 32bit */
+	stw	r8,4(r3)	/* lower 32bit  */
+
+	/* 
+	 * Compute the virt_phys_offset :
+	 * virt_phys_offset = stext.run - kernstart_addr
+	 * 
+	 * stext.run = (KERNELBASE & ~0xfffffff) + (kernstart_addr & 0xfffffff)
+	 * When we relocate, we have :
+	 *
+	 *	(kernstart_addr & 0xfffffff) = (stext.run & 0xfffffff) 
+	 *
+	 * hence:
+	 *  virt_phys_offset = (KERNELBASE & ~0xfffffff) - (kernstart_addr & ~0xfffffff)
+	 * 
+	 */
 
-	stw	r6,0(r3)
-	stw	r7,4(r3)
-#endif
+	/* KERNELBASE&~0xfffffff => (r4,r5) */
+	li	r4, 0		/* higer 32bit */
+	lis	r5,KERNELBASE@h
+	rlwinm	r5,r5,0,0,3	/* Align to 256M, lower 32bit */
+
+	/* 
+	 * 64bit subtraction.
+	 */ 
+	subfc	r5,r7,r5
+	subfe	r4,r6,r4
+
+	/* Store virt_phys_offset */
+	lis	r3,virt_phys_offset@ha
+	la	r3,virt_phys_offset@l(r3)
+
+	stw	r4,0(r3)
+	stw	r5,4(r3)
+
+#endif	/* CONFIG_RELOCATABLE */
 
 /*
  * Decide what sort of machine this is and initialize the MMU.
@@ -801,11 +863,30 @@ skpinv:	addi	r4,r4,1				/* Increment */
  * Configure and load pinned entry into TLB slot 63.
  */
 
+#ifdef CONFIG_RELOCATABLE
+	/*
+	 * Stores the XLAT entry for this code at r25.
+	 * Uses the mapping where we are loaded.
+	 */
+
+	tlbre	r25,r23,PPC44x_TLB_XLAT		/* Read our XLAT entry in r25 */
+
+	/* PAGEID fields for mapping */
+	lis	r3,KERNELBASE@h
+	rlwinm	r3,r3,0,0,3			/* Round to 256M page boundary */
+
+	/* Use the current XLAT entry */
+	mr	r4,r25
+#else
+
+
 	lis	r3,PAGE_OFFSET@h
 	ori	r3,r3,PAGE_OFFSET@l
 
 	/* Kernel is at the base of RAM */
 	li r4, 0			/* Load the kernel physical address */
+#endif
+
 
 	/* Load the kernel PID = 0 */
 	li	r0,0
diff --git a/arch/powerpc/mm/init_32.c b/arch/powerpc/mm/init_32.c
index 161cefd..a249edb 100644
--- a/arch/powerpc/mm/init_32.c
+++ b/arch/powerpc/mm/init_32.c
@@ -65,6 +65,13 @@ phys_addr_t memstart_addr = (phys_addr_t)~0ull;
 EXPORT_SYMBOL(memstart_addr);
 phys_addr_t kernstart_addr;
 EXPORT_SYMBOL(kernstart_addr);
+
+#if	defined(CONFIG_44x) && defined(CONFIG_RELOCATABLE)
+/* Used in __va()/__pa() for 44x */
+long long virt_phys_offset;
+EXPORT_SYMBOL(virt_phys_offset);
+#endif
+
 phys_addr_t lowmem_end_addr;
 
 int boot_mapsize;
