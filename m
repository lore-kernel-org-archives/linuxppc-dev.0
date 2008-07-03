Return-Path: <shaggy@linux.vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 09CC8DDF5D
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Jul 2008 05:37:44 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m63JbfnW017358
	for <linuxppc-dev@ozlabs.org>; Thu, 3 Jul 2008 15:37:41 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m63Jbc26224292
	for <linuxppc-dev@ozlabs.org>; Thu, 3 Jul 2008 15:37:38 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m63JbcZ2019509
	for <linuxppc-dev@ozlabs.org>; Thu, 3 Jul 2008 15:37:38 -0400
Subject: Resend: [patch 4/5] powerpc: Add Strong Access Ordering
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18540.32962.631137.738278@cargo.ozlabs.ibm.com>
References: <20080701200706.011591798@linux.vnet.ibm.com>
	<20080701200719.494365861@linux.vnet.ibm.com>
	<18540.32962.631137.738278@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Thu, 03 Jul 2008 14:37:36 -0500
Message-Id: <1215113856.19521.6.camel@norville.austin.ibm.com>
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-07-03 at 17:33 +1000, Paul Mackerras wrote:
> Dave Kleikamp writes:
> 
> > This patch defines:
> > 
> > - PROT_SAO, which is passed into mmap() and mprotect() in the prot field
> > - VM_SAO in vma->vm_flags, and
> > - _PAGE_SAO, the combination of WIMG bits in the pte that enables strong
> > access ordering for the page.
> > 
> > NOTE: There doesn't seem to be a precedent for architecture-dependent vm_flags.
> > It may be better to define VM_SAO somewhere in include/asm-powerpc/.  Since
> > vm_flags is a long, defining it in the high-order word would help prevent a
> > collision with any newly added values in architecture-independent code.
> 
> This puts _PAGE_SAO in pgtable-ppc64.h, which is fine, but then your
> patch 4/5 breaks the build for 32-bit machines with an error like
> this:
> 
> In file included from /home/paulus/kernel/powerpc/include/linux/mman.h:4,
>                  from /home/paulus/kernel/powerpc/arch/powerpc/kernel/asm-offsets.c:22:
> include2/asm/mman.h: In function ?arch_vm_get_page_prot?:
> include2/asm/mman.h:43: error: ?_PAGE_SAO? undeclared (first use in this function)
> include2/asm/mman.h:43: error: (Each undeclared identifier is reported only once
> include2/asm/mman.h:43: error: for each function it appears in.)
> make[2]: *** [arch/powerpc/kernel/asm-offsets.s] Error 1
> 
> because of course we don't have a definition of _PAGE_SAO for 32-bit
> machines...
> 
> Could you fix it and re-send please?

Sorry.  Here's a replacement for patch 4/5.  It adds an #ifdef
CONFIG_PPC64 around the new code.

The alternative would be to introduce mman_ppc64.h which I think would
be overkill.

powerpc: Add Strong Access Ordering

Allow an application to enable Strong Access Ordering on specific pages of
memory on Power 7 hardware. Currently, power has a weaker memory model than
x86. Implementing a stronger memory model allows an emulator to more
efficiently translate x86 code into power code, resulting in faster code
execution.

On Power 7 hardware, storing 0b1110 in the WIMG bits of the hpte enables
strong access ordering mode for the memory page.  This patchset allows a
user to specify which pages are thus enabled by passing a new protection
bit through mmap() and mprotect().  I have tentatively defined this bit,
PROT_SAO, as 0x10.

Signed-off-by: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
---

 arch/powerpc/kernel/syscalls.c |    3 +++
 include/asm-powerpc/mman.h     |   30 ++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

Index: b/arch/powerpc/kernel/syscalls.c
===================================================================
--- a/arch/powerpc/kernel/syscalls.c
+++ b/arch/powerpc/kernel/syscalls.c
@@ -143,6 +143,9 @@
 	struct file * file = NULL;
 	unsigned long ret = -EINVAL;
 
+	if (!arch_validate_prot(prot))
+		goto out;
+
 	if (shift) {
 		if (off & ((1 << shift) - 1))
 			goto out;
Index: b/include/asm-powerpc/mman.h
===================================================================
--- a/include/asm-powerpc/mman.h
+++ b/include/asm-powerpc/mman.h
@@ -1,7 +1,9 @@
 #ifndef _ASM_POWERPC_MMAN_H
 #define _ASM_POWERPC_MMAN_H
 
+#include <asm/cputable.h>
 #include <asm-generic/mman.h>
+#include <linux/mm.h>
 
 /*
  * This program is free software; you can redistribute it and/or
@@ -26,4 +28,32 @@
 #define MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
 #define MAP_NONBLOCK	0x10000		/* do not block on IO */
 
+#ifdef CONFIG_PPC64
+/*
+ * This file is included by linux/mman.h, so we can't use cacl_vm_prot_bits()
+ * here.  How important is the optimization?
+ */
+static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot)
+{
+	return (prot & PROT_SAO) ? VM_SAO : 0;
+}
+#define arch_calc_vm_prot_bits(prot) arch_calc_vm_prot_bits(prot)
+
+static inline pgprot_t arch_vm_get_page_prot(unsigned long vm_flags)
+{
+	return (vm_flags & VM_SAO) ? __pgprot(_PAGE_SAO) : 0;
+}
+#define arch_vm_get_page_prot(vm_flags) arch_vm_get_page_prot(vm_flags)
+
+static inline int arch_validate_prot(unsigned long prot)
+{
+	if (prot & ~(PROT_READ | PROT_WRITE | PROT_EXEC | PROT_SEM | PROT_SAO))
+		return 0;
+	if ((prot & PROT_SAO) && !cpu_has_feature(CPU_FTR_SAO))
+		return 0;
+	return 1;
+}
+#define arch_validate_prot(prot) arch_validate_prot(prot)
+
+#endif /* CONFIG_PPC64 */
 #endif	/* _ASM_POWERPC_MMAN_H */

-- 
David Kleikamp
IBM Linux Technology Center
