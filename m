Return-Path: <acahalan@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.185])
	by ozlabs.org (Postfix) with ESMTP id 99CF067C4D
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Aug 2006 13:20:34 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id k27so2430728nfc
	for <linuxppc-dev@ozlabs.org>; Sun, 13 Aug 2006 20:20:32 -0700 (PDT)
Message-ID: <787b0d920608132020q4ad2b5c2y49e25ca7ecc33536@mail.gmail.com>
Date: Sun, 13 Aug 2006 23:20:32 -0400
From: "Albert Cahalan" <acahalan@gmail.com>
To: linuxppc-dev@ozlabs.org, debian-powerpc <debian-powerpc@lists.debian.org>
Subject: [PATCH] no-execute -- please test
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This kernel patch implements no-execute protection (like x86 "NX bit")
for the Mac G2, Mac G3, Mac G4, and other systems running 32-bit
PowerPC processors in the 6xx, 7xx, and 7xxx families.

As given, it usually protects from executing code on the stack.
This has to do with the typical buffer overflow exploit.

I'm running this now on a Mac G4, including X, with no ill effect.

If you want to see messages when an app violates this, change
the "#if 0" to "#if 1". I get no messages except when I run
paxtest to verify that the protection works.

If you want heap protection, change VM_DATA_DEFAULT_FLAGS32
in include/asm-powerpc/page.h to be like VM_STACK_DEFAULT_FLAGS.
I'd love to hear if anybody can get X to start with this change.
For me (Xorg w/ ATI) a module load fails. Probably because of
poor address space layout, paxtest shows no improvement with this.
Still, I'd love to hear if X (perhaps framebuffer and no GL) works
OK with this extra change.

Apply like this:

cd directory-with-kernel-source
patch -p1 -s -E -l < file-containing-this-email

--- linux-2.6.17-rc5/arch/powerpc/kernel/head_32.S      2006-05-24
21:50:17.000000000 -0400
+++ linux-17rc5-secure/arch/powerpc/kernel/head_32.S    2006-08-13
10:48:38.000000000 -0400
@@ -1182,7 +1182,7 @@
 _GLOBAL(set_context)
        mulli   r3,r3,897       /* multiply context by skew factor */
        rlwinm  r3,r3,4,8,27    /* VSID = (context & 0xfffff) << 4 */
-       addis   r3,r3,0x6000    /* Set Ks, Ku bits */
+       addis   r3,r3,0x7000    /* Set Ks, Ku, N bits */
        li      r0,NUM_USER_SEGMENTS
        mtctr   r0

--- linux-2.6.17-rc5/arch/powerpc/mm/fault.c    2006-05-24
21:50:17.000000000 -0400
+++ linux-17rc5-secure/arch/powerpc/mm/fault.c  2006-08-13
19:17:22.000000000 -0400
@@ -134,8 +134,8 @@
         * bits we are interested in.  But there are some bits which
         * indicate errors in DSISR but can validly be set in SRR1.
         */
-       if (trap == 0x400)
-               error_code &= 0x48200000;
+       if (is_exec)
+               error_code &= 0x58200000;
        else
                is_write = error_code & DSISR_ISSTORE;
 #else
@@ -242,7 +242,7 @@
 good_area:
        code = SEGV_ACCERR;
 #if defined(CONFIG_6xx)
-       if (error_code & 0x95700000)
+       if (error_code & 0x85700000)
                /* an error such as lwarx to I/O controller space,
                   address matching DABR, eciwx, etc. */
                goto bad_area;
@@ -258,12 +258,24 @@
 #endif /* CONFIG_8xx */

        if (is_exec) {
+               if (!(vma->vm_flags & VM_EXEC)) {
+#if 0
+                       static __typeof__(jiffies) oldjif;
+                       static int count;
+                       if(count++ < 5)
+                       printk(KERN_CRIT "fuckup @ %08lx with trap
0x%x code %08lx by %s\n",
+                               address, trap, error_code, current->comm);
+                       if(jiffies/(HZ*15) != oldjif/(HZ*15)) {
+                               oldjif = jiffies;
+                               count = 0;
+                       }
+#endif
+                       goto bad_area;
+               }
 #ifdef CONFIG_PPC64
                /* protection fault */
                if (error_code & DSISR_PROTFAULT)
                        goto bad_area;
-               if (!(vma->vm_flags & VM_EXEC))
-                       goto bad_area;
 #endif
 #if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
                pte_t *ptep;
@@ -291,6 +303,27 @@
                        pte_unmap_unlock(ptep, ptl);
                }
 #endif
+#if !defined(CONFIG_4xx) && !defined(CONFIG_BOOKE) && !defined(CONFIG_PPC64)
+               if (!(error_code & 0x10000000))
+                       goto survive;
+               /* It was an ISI exception with SRR1 bit 3 set.
+                * We have no-execute bits in the 256 MiB segments.
+                * We sometimes take faults to turn the bits on.
+                * Faults happen when the user executes from guarded mem,
+                * no-execute segment, or (extinct) direct-store segment.
+                * The segment-related faults happen first. */
+               unsigned segreg;
+               __asm__ __volatile__("mfsrin %0,%1":"=r"(segreg):"r"(address));
+               /* if current segment is no-execute but not direct-store */
+               if (segreg>>28==7) {
+                       /* clear the N bit to make it executable */
+                       segreg &= 0x6fffffff;
+                       __asm__ __volatile__("mtsrin
%0,%1"::"r"(segreg),"r"(address));
+                       /* TODO: as this one goes executable, make
other segments not */
+                       up_read(&mm->mmap_sem);
+                       return 0;
+               }
+#endif
        /* a write */
        } else if (is_write) {
                if (!(vma->vm_flags & VM_WRITE))
@@ -300,7 +333,7 @@
                /* protection fault */
                if (error_code & 0x08000000)
                        goto bad_area;
-               if (!(vma->vm_flags & (VM_READ | VM_EXEC)))
+               if (!(vma->vm_flags & (VM_READ | VM_EXEC))) /* VM_EXEC
wrong for ppc32? */
                        goto bad_area;
        }

--- linux-2.6.17-rc5/include/asm-powerpc/page.h 2006-05-24
21:50:17.000000000 -0400
+++ linux-17rc5-secure/include/asm-powerpc/page.h       2006-08-13
11:58:25.000000000 -0400
@@ -90,6 +90,9 @@
 #define VM_DATA_DEFAULT_FLAGS64        (VM_READ | VM_WRITE | \
                                 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)

+#define VM_STACK_DEFAULT_FLAGS (VM_READ | VM_WRITE | \
+                                VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
+
 #ifdef __powerpc64__
 #include <asm/page_64.h>
 #else
