Return-Path: <suzuki@in.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp07.in.ibm.com", Issuer "GeoTrust SSL CA" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 7E4D7100D0E
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Dec 2011 22:48:09 +1100 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <suzuki@in.ibm.com>;
 Fri, 9 Dec 2011 17:18:07 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 pB9Bm4uc2433248
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Dec 2011 17:18:04 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pB9Bm3rP027258
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Dec 2011 17:18:03 +0530
From: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Subject: [PATCH v4 5/7] [44x] Enable CONFIG_RELOCATABLE for PPC44x
To: Josh Boyer <jwboyer@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 09 Dec 2011 17:18:02 +0530
Message-ID: <20111209114754.16360.17845.stgit@suzukikp.in.ibm.com>
In-Reply-To: <20111209114148.15616.15996.stgit@suzukikp.in.ibm.com>
References: <20111209114148.15616.15996.stgit@suzukikp.in.ibm.com>
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

The following patch adds relocatable kernel support - based on processing
of dynamic relocations - for PPC44x kernel.

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
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Kumar Gala <galak@kernel.crashing.org>
Cc: Tony Breeds <tony@bakeyournoodle.com>
Cc: Josh Boyer <jwboyer@gmail.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
---

 arch/powerpc/Kconfig           |    2 -
 arch/powerpc/kernel/head_44x.S |   95 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 94 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 6936cb0..90cd8d3 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -847,7 +847,7 @@ config DYNAMIC_MEMSTART
 
 config RELOCATABLE
 	bool "Build a relocatable kernel (EXPERIMENTAL)"
-	depends on EXPERIMENTAL && ADVANCED_OPTIONS && FLATMEM
+	depends on EXPERIMENTAL && ADVANCED_OPTIONS && FLATMEM && 44x
 	select NONSTATIC_KERNEL
 	help
 	  This builds a kernel image that is capable of running at the
diff --git a/arch/powerpc/kernel/head_44x.S b/arch/powerpc/kernel/head_44x.S
index 62a4cd5..213ed31 100644
--- a/arch/powerpc/kernel/head_44x.S
+++ b/arch/powerpc/kernel/head_44x.S
@@ -64,6 +64,35 @@ _ENTRY(_start);
 	mr	r31,r3		/* save device tree ptr */
 	li	r24,0		/* CPU number */
 
+#ifdef CONFIG_RELOCATABLE
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
@@ -86,7 +115,64 @@ _ENTRY(_start);
 
 	bl	early_init
 
-#ifdef CONFIG_DYNAMIC_MEMSTART
+#ifdef CONFIG_RELOCATABLE
+	/*
+	 * Relocatable kernel support based on processing of dynamic
+	 * relocation entries.
+	 *
+	 * r25 will contain RPN/ERPN for the start address of memory
+	 * r21 will contain the current offset of _stext
+	 */
+	lis	r3,kernstart_addr@ha
+	la	r3,kernstart_addr@l(r3)
+
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
+
+#elif defined(CONFIG_DYNAMIC_MEMSTART)
 	/*
 	 * Mapping based, page aligned dyanmic kernel loading.
 	 *
@@ -802,7 +888,12 @@ skpinv:	addi	r4,r4,1				/* Increment */
 /*
  * Configure and load pinned entry into TLB slot 63.
  */
-#ifdef CONFIG_DYNAMIC_MEMSTART
+#ifdef CONFIG_NONSTATIC_KERNEL
+	/*
+	 * In case of a NONSTATIC_KERNEL we reuse the TLB XLAT
+	 * entries of the initial mapping set by the boot loader.
+	 * The XLAT entry is stored in r25
+	 */
 
 	/* Read the XLAT entry for our current mapping */
 	tlbre	r25,r23,PPC44x_TLB_XLAT
