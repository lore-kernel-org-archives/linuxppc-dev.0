Mime-Version: 1.0 (Apple Message framework v613)
To: linuxppc-dev@lists.linuxppc.org
Message-Id: <49B568CB-832A-11D8-9FF0-000A95A07384@sands-edge.com>
Content-Type: multipart/mixed; boundary=Apple-Mail-8--638549463
From: John Whitney <johnw@sands-edge.com>
Subject: Proposed changes to io.h
Date: Wed, 31 Mar 2004 10:44:25 -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--Apple-Mail-8--638549463
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed

I've made few changes to include/asm-ppc/io.h that might want to be
incorporated into the mainline tree.  These changes include:

1. Modifications to virt_to_bus, bus_to_virt, virt_to_phys, and
phys_to_virt.  With the use of fully virtual addresses for
cache-coherent allocations (consistent_alloc(), etc.), just subracting
KERNELBASE from the virtual address is no longer sufficient.  Because
of this, I have modified virt_to_phys and phys_to_virt to look like:

extern inline unsigned long virt_to_phys(volatile void * address)
{
     unsigned long phys_addr;
     unsigned long virt_addr = (unsigned long) address;

#ifndef CONFIG_APUS
     if ((virt_addr >= KERNELBASE) && (virt_addr < (unsigned long)
high_memory))
         phys_addr = (virt_addr - KERNELBASE);
     else
         phys_addr = iopa (virt_addr);
#else
     phys_addr = iopa (virt_addr);
#endif

     return phys_addr;
}

extern inline void * phys_to_virt(unsigned long address)
{
#ifndef CONFIG_APUS
     return (void *) (address + KERNELBASE);
#else
     return (void*) mm_ptov (address);
#endif
}

And I have modified virt_to_bus and bus_to_virt to use those inlined
functions:

extern inline unsigned long virt_to_bus(volatile void * address)
{
     if (address == (void *) 0)
         return 0;

     return virt_to_phys (address) + PCI_DRAM_OFFSET;
}

extern inline void * bus_to_virt(unsigned long address)
{
     if (address == 0)
         return 0;

     return phys_to_virt (address - PCI_DRAM_OFFSET);
}

This simplifies the "bus" routines, and makes sure that they use the
standard virtual/physical translations.


2. I'd like to add 64-bit __raw_readll and __raw_writell routines to
io.h, done using floating-point registers.  Currently, modules such as
MTD (when writing to 64-bit buses) perform two 32-bit, non-atomic
writes, which can cause problems.  Using a floating-point register to
guarantee a 64-bit write is ugly, but it works.  Code for these inlined
routines is as follows:

/*
  * For reading and writing 64-bit values, we need to use the floating
point
  * registers.  The code will enable MSR_FP in the MSR register, use
FPR1 to
  * read from and write to memory, and then restore everything to the
  * previous values.
  */
#define __raw_readll __raw_readll
static inline unsigned long long __raw_readll (int addr)
{
     unsigned long flags;
     unsigned long msr;
     unsigned long msr_save;
     unsigned long long result;
     unsigned long long fp_save;

     local_irq_save (flags);
     asm volatile ("sync\n"
                   "mfmsr    %0\n"
                   "ori      %1,%0,0x2000\n"
                   "mtmsr    %1\n"
                   "isync\n"
                   "stfdx    1,0,%2\n"
                   "lfdx     1,0,%4\n"
                   "stfdx    1,0,%3\n"
                   "sync\n"
                   "lfdx     1,0,%2\n"
                   "mtmsr    %0\n"
                   "sync\n"
                   "isync\n"
                   : "=&r" (msr_save), "=&r" (msr)
                   : "r" (&fp_save), "r" (&result), "r" (addr)
                   : "memory" );
     local_irq_restore (flags);

     return result;
}

#define __raw_writell __raw_writell
static inline void __raw_writell (unsigned long long value, int addr)
{
     unsigned long flags;
     unsigned long msr;
     unsigned long msr_save;
     unsigned long long fp_save;

     local_irq_save (flags);
     asm volatile ("sync\n"
                   "mfmsr    %0\n"
                   "ori      %1,%0,0x2000\n"
                   "mtmsr    %1\n"
                   "isync\n"
                   "stfdx    1,0,%2\n"
                   "lfdx     1,0,%3\n"
                   "stfdx    1,0,%4\n"
                   "sync\n"
                   "lfdx     1,0,%2\n"
                   "mtmsr    %0\n"
                   "sync\n"
                   "isync\n"
                   : "=&r" (msr_save), "=&r" (msr)
                   : "r" (&fp_save), "r" (&value), "r" (addr)
                   : "memory" );
     local_irq_restore (flags);
     return;
}


Questions, comments, or flames?

John Whitney
--Apple-Mail-8--638549463
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream;
	x-unix-mode=0600;
	name="io.h.patch"
Content-Disposition: attachment;
	filename=io.h.patch

--- kernel-2.6.5/include/asm-ppc/io.h	2004-03-29 13:36:34.000000000 -0500
+++ kernel-sbs-2.6.5/include/asm-ppc/io.h	2004-03-30 15:54:18.000000000 -0500
@@ -70,6 +70,72 @@
 #define __raw_writel(v, addr)	(*(volatile unsigned int *)(addr) = (v))

 /*
+ * For reading and writing 64-bit values, we need to use the floating point
+ * registers.  The code will enable MSR_FP in the MSR register, use FPR1 to
+ * read from and write to memory, and then restore everything to the
+ * previous values.
+ */
+#define __raw_readll __raw_readll
+static inline unsigned long long __raw_readll (int addr)
+{
+	unsigned long flags;
+	unsigned long msr;
+	unsigned long msr_save;
+	unsigned long long result;
+	unsigned long long fp_save;
+
+	local_irq_save (flags);
+	asm volatile ("sync\n"
+	              "mfmsr	%0\n"
+	              "ori		%1,%0,0x2000\n"
+	              "mtmsr	%1\n"
+	              "isync\n"
+	              "stfdx	1,0,%2\n"
+	              "lfdx		1,0,%4\n"
+	              "stfdx	1,0,%3\n"
+	              "sync\n"
+	              "lfdx		1,0,%2\n"
+	              "mtmsr	%0\n"
+	              "sync\n"
+	              "isync\n"
+	              : "=&r" (msr_save), "=&r" (msr)
+	              : "r" (&fp_save), "r" (&result), "r" (addr)
+	              : "memory" );
+	local_irq_restore (flags);
+
+	return result;
+}
+
+#define __raw_writell __raw_writell
+static inline void __raw_writell (unsigned long long value, int addr)
+{
+	unsigned long flags;
+	unsigned long msr;
+	unsigned long msr_save;
+	unsigned long long fp_save;
+
+	local_irq_save (flags);
+	asm volatile ("sync\n"
+	              "mfmsr	%0\n"
+	              "ori		%1,%0,0x2000\n"
+	              "mtmsr	%1\n"
+	              "isync\n"
+	              "stfdx	1,0,%2\n"
+	              "lfdx		1,0,%3\n"
+	              "stfdx	1,0,%4\n"
+	              "sync\n"
+	              "lfdx		1,0,%2\n"
+	              "mtmsr	%0\n"
+	              "sync\n"
+	              "isync\n"
+	              : "=&r" (msr_save), "=&r" (msr)
+	              : "r" (&fp_save), "r" (&value), "r" (addr)
+	              : "memory" );
+	local_irq_restore (flags);
+	return;
+}
+
+/*
  * The insw/outsw/insl/outsl macros don't do byte-swapping.
  * They are only used in practice for transferring buffers which
  * are arrays of bytes, and byte-swapping is not appropriate in
@@ -205,54 +271,56 @@
 			     unsigned int size, int flags);

 /*
- * The PCI bus is inherently Little-Endian.  The PowerPC is being
- * run Big-Endian.  Thus all values which cross the [PCI] barrier
- * must be endian-adjusted.  Also, the local DRAM has a different
- * address from the PCI point of view, thus buffer addresses also
- * have to be modified [mapped] appropriately.
+ * Change virtual addresses to physical addresses and vv, for
+ * addresses in the area where the kernel has the RAM mapped.
  */
-extern inline unsigned long virt_to_bus(volatile void * address)
+extern inline unsigned long virt_to_phys(volatile void * address)
 {
+	unsigned long phys_addr;
+	unsigned long virt_addr = (unsigned long) address;
+
 #ifndef CONFIG_APUS
-        if (address == (void *)0)
-		return 0;
-        return (unsigned long)address - KERNELBASE + PCI_DRAM_OFFSET;
+	if ((virt_addr >= KERNELBASE) && (virt_addr < (unsigned long) high_memory))
+		phys_addr = (virt_addr - KERNELBASE);
+	else
+		phys_addr = iopa (virt_addr);
 #else
-	return iopa ((unsigned long) address);
+	phys_addr = iopa (virt_addr);
 #endif
+
+	return phys_addr;
 }

-extern inline void * bus_to_virt(unsigned long address)
+extern inline void * phys_to_virt(unsigned long address)
 {
 #ifndef CONFIG_APUS
-        if (address == 0)
-		return 0;
-        return (void *)(address - PCI_DRAM_OFFSET + KERNELBASE);
+	return (void *) (address + KERNELBASE);
 #else
 	return (void*) mm_ptov (address);
 #endif
 }

 /*
- * Change virtual addresses to physical addresses and vv, for
- * addresses in the area where the kernel has the RAM mapped.
+ * The PCI bus is inherently Little-Endian.  The PowerPC is being
+ * run Big-Endian.  Thus all values which cross the [PCI] barrier
+ * must be endian-adjusted.  Also, the local DRAM has a different
+ * address from the PCI point of view, thus buffer addresses also
+ * have to be modified [mapped] appropriately.
  */
-extern inline unsigned long virt_to_phys(volatile void * address)
+extern inline unsigned long virt_to_bus(volatile void * address)
 {
-#ifndef CONFIG_APUS
-	return (unsigned long) address - KERNELBASE;
-#else
-	return iopa ((unsigned long) address);
-#endif
+	if (address == (void *) 0)
+		return 0;
+
+	return virt_to_phys (address) + PCI_DRAM_OFFSET;
 }

-extern inline void * phys_to_virt(unsigned long address)
+extern inline void * bus_to_virt(unsigned long address)
 {
-#ifndef CONFIG_APUS
-	return (void *) (address + KERNELBASE);
-#else
-	return (void*) mm_ptov (address);
-#endif
+	if (address == 0)
+		return 0;
+
+	return phys_to_virt (address - PCI_DRAM_OFFSET);
 }

 /*

--Apple-Mail-8--638549463--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
