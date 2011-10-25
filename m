Return-Path: <suzuki@in.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp07.au.ibm.com", Issuer "Equifax" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 8541C100D17
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Oct 2011 22:54:26 +1100 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
 by e23smtp07.au.ibm.com (8.14.4/8.13.1) with ESMTP id p9PBsObE013235
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Oct 2011 22:54:24 +1100
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 p9PBpgLO2338918
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Oct 2011 22:51:42 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 p9PBsMKi014559
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Oct 2011 22:54:23 +1100
From: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Subject: [PATCH v2 3/5] [44x] Enable CONFIG_RELOCATABLE for PPC44x
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Tue, 25 Oct 2011 17:24:20 +0530
Message-ID: <20111025115417.8183.31217.stgit@suzukikp.in.ibm.com>
In-Reply-To: <20111025114829.8183.1725.stgit@suzukikp.in.ibm.com>
References: <20111025114829.8183.1725.stgit@suzukikp.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Suzuki Poulose <suzuki@in.ibm.com>, Alan Modra <amodra@au1.ibm.com>,
 Scott Wood <scottwood@freescale.com>, Paul Mackerras <paulus@samba.org>,
 Dave Hansen <dave@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The following patch adds relocatable support for PPC44x kernel.

This enables two types of relocatable kernel support for PPC44x.

1) The old style, mapping based- which restricts the load address to 256M
   aligned.

2) The new approach based on processing dynamic relocation entries -
   CONFIG_RELOCATABLE_PPC32_PIE


In case of CONFIG_RELOCATABLE_PPC32_PIE :

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

The virt_phys_offset is updated accordingly, i.e,

	virt_phys_offset = effective. kernel virt base - kernstart_addr

I have tested the patches on 440x platforms only. However this should
work fine for PPC_47x also, as we only depend on the runtime address
and the current TLB XLAT entry for the startup code, which is available
in r25. I don't have access to a 47x board yet. So, it would be great if
somebody could test this on 47x.

Signed-off-by: Suzuki K. Poulose <suzuki@in.ibm.com>
Cc:	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:	Kumar Gala <galak@kernel.crashing.org>
Cc:	Tony Breeds <tony@bakeyournoodle.com>
Cc:	Josh Boyer <jwboyer@gmail.com>
Cc:	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
---

 arch/powerpc/Kconfig           |    4 +
 arch/powerpc/kernel/head_44x.S |  110 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 108 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 016f863..1cedcda 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -843,7 +843,7 @@ config LOWMEM_CAM_NUM
 
 config RELOCATABLE
 	bool "Build a relocatable kernel (EXPERIMENTAL)"
-	depends on EXPERIMENTAL && ADVANCED_OPTIONS && FLATMEM && (FSL_BOOKE || PPC_47x)
+	depends on EXPERIMENTAL && ADVANCED_OPTIONS && FLATMEM && (FSL_BOOKE || 44x)
 	help
 	  This builds a kernel image that is capable of running at the
 	  location the kernel is loaded at (some alignment restrictions may
@@ -862,7 +862,7 @@ config RELOCATABLE
 config RELOCATABLE_PPC32_PIE
 	bool "Compile the kernel with dynamic relocations (EXPERIMENTAL)"
 	default n
-	depends on PPC32 && RELOCATABLE
+	depends on PPC32 && RELOCATABLE && 44x
 	help
 	  This option builds the kernel with dynamic relocations(-pie). Enables
 	  the kernel to be loaded at any address for BOOKE processors, removing
diff --git a/arch/powerpc/kernel/head_44x.S b/arch/powerpc/kernel/head_44x.S
index b725dab..213759e 100644
--- a/arch/powerpc/kernel/head_44x.S
+++ b/arch/powerpc/kernel/head_44x.S
@@ -64,6 +64,35 @@ _ENTRY(_start);
 	mr	r31,r3		/* save device tree ptr */
 	li	r24,0		/* CPU number */
 
+#ifdef CONFIG_RELOCATABLE_PPC32_PIE
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
@@ -88,14 +117,66 @@ _ENTRY(_start);
 
 #ifdef CONFIG_RELOCATABLE
 	/*
+	 * When we reach here :
 	 * r25 will contain RPN/ERPN for the start address of memory
-	 *
-	 * Add the difference between KERNELBASE and PAGE_OFFSET to the
-	 * start of physical memory to get kernstart_addr.
+	 * r21 contain the physical address of _stext in case of PIE
 	 */
 	lis	r3,kernstart_addr@ha
 	la	r3,kernstart_addr@l(r3)
 
+#ifdef CONFIG_RELOCATABLE_PPC32_PIE
+	/*
+	 * Compute the kernstart_addr.
+	 * kernstart_addr => (r6,r8)
+	 * kernstart_addr & ~0xfffffff => (r6,r7)
+	 */
+	rlwinm	r6,r25,0,28,31	/* ERPN. Bits 32-35 of Address */
+	rlwinm	r7,r25,0,0,3	/* RPN - assuming 256 MB page size */
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
+
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
+#else
+	/* Old style mapping based relocation */
+
+	/*
+	 * Add the difference between KERNELBASE and PAGE_OFFSET to the
+	 * start of physical memory to get kernstart_addr.
+	 */
 	lis	r4,KERNELBASE@h
 	ori	r4,r4,KERNELBASE@l
 	lis	r5,PAGE_OFFSET@h
@@ -108,7 +189,9 @@ _ENTRY(_start);
 
 	stw	r6,0(r3)
 	stw	r7,4(r3)
-#endif
+#endif	/* CONFIG_RELOCATABLE_PPC32_PIE */
+
+#endif /* CONFIG_RELOCATABLE */
 
 /*
  * Decide what sort of machine this is and initialize the MMU.
@@ -801,11 +884,30 @@ skpinv:	addi	r4,r4,1				/* Increment */
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
