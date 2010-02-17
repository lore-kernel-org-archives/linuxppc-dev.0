Return-Path: <rayan@nucleodyne.com>
Received: from easyspace2.ezspl.net (easyspace2.ezspl.net [66.45.254.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 689FBB7C09
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Feb 2010 19:02:22 +1100 (EST)
Received: from mail-yw0-f201.google.com ([209.85.211.201])
	by easyspace2.ezspl.net with esmtpsa (TLSv1:RC4-MD5:128) (Exim 4.69)
	(envelope-from <rayan@nucleodyne.com>) id 1NheYT-0005rO-EB
	for linuxppc-dev@lists.ozlabs.org; Wed, 17 Feb 2010 02:42:41 -0500
Received: by ywh39 with SMTP id 39so6009054ywh.17
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 16 Feb 2010 23:42:37 -0800 (PST)
MIME-Version: 1.0
Date: Tue, 16 Feb 2010 23:42:37 -0800
Message-ID: <5bbdacc81002162342y4f63f22at53bb88505b049bd6@mail.gmail.com>
Subject: patch-2.6.21-rt8 works for ppc arch?
From: Ryan <rayan@nucleodyne.com>
To: ppcdev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I'm trying to build a 2.6.21 kernel (ppc arch for a 74xx processor)
with the PREEMPT_RT patch "patch-2.6.21-rt8". But I'm having some
compilation errors in the very early stage. The errors are shown
below.

arch/ppc/kernel/asm-offsets.c: In function 'main':
arch/ppc/kernel/asm-offsets.c:148: error: 'struct vdso_data' has no
member named 'tb_orig_stamp'
arch/ppc/kernel/asm-offsets.c:149: error: 'struct vdso_data' has no
member named 'tb_ticks_per_sec'
arch/ppc/kernel/asm-offsets.c:150: error: 'struct vdso_data' has no
member named 'tb_to_xs'
arch/ppc/kernel/asm-offsets.c:151: error: 'struct vdso_data' has no
member named 'stamp_xsec'
arch/ppc/kernel/asm-offsets.c:152: error: 'struct vdso_data' has no
member named 'tb_update_count'
arch/ppc/kernel/asm-offsets.c:153: error: 'struct vdso_data' has no
member named 'tz_minuteswest'
arch/ppc/kernel/asm-offsets.c:154: error: 'struct vdso_data' has no
member named 'tz_dsttime'
arch/ppc/kernel/asm-offsets.c:156: error: 'struct vdso_data' has no
member named 'wtom_clock_sec'
arch/ppc/kernel/asm-offsets.c:157: error: 'struct vdso_data' has no
member named 'wtom_clock_nsec'
make[1]: *** [arch/ppc/kernel/asm-offsets.s] Error 1

I did dig a little deep to find why this error occurred. It turned out
these members are explicitly removed by patch-2.6.21-rt8. See below
exerted from this patch file. It makes me wondering if the PREEMPT_RT
patch ever worked for ppc arch.

Index: linux/include/asm-powerpc/vdso_datapage.h
===================================================================
--- linux.orig/include/asm-powerpc/vdso_datapage.h
+++ linux/include/asm-powerpc/vdso_datapage.h
@@ -74,11 +74,6 @@ struct vdso_data {
 	__u32 icache_size;		/* L1 i-cache size		0x68 */
 	__u32 icache_line_size;		/* L1 i-cache line size		0x6C */

-	/* those additional ones don't have to be located anywhere
-	 * special as they were not part of the original systemcfg
-	 */
-	__s32 wtom_clock_sec;			/* Wall to monotonic clock */
-	__s32 wtom_clock_nsec;
    	__u32 syscall_map_64[SYSCALL_MAP_SIZE]; /* map of syscalls  */
    	__u32 syscall_map_32[SYSCALL_MAP_SIZE]; /* map of syscalls */
 };
@@ -89,15 +84,6 @@ struct vdso_data {
  * And here is the simpler 32 bits version
  */
 struct vdso_data {
-	__u64 tb_orig_stamp;		/* Timebase at boot		0x30 */
-	__u64 tb_ticks_per_sec;		/* Timebase tics / sec		0x38 */
-	__u64 tb_to_xs;			/* Inverse of TB to 2^20	0x40 */
-	__u64 stamp_xsec;		/*				0x48 */
-	__u32 tb_update_count;		/* Timebase atomicity ctr	0x50 */
-	__u32 tz_minuteswest;		/* Minutes west of Greenwich	0x58 */
-	__u32 tz_dsttime;		/* Type of dst correction	0x5C */
-	__s32 wtom_clock_sec;			/* Wall to monotonic clock */
-	__s32 wtom_clock_nsec;
    	__u32 syscall_map_32[SYSCALL_MAP_SIZE]; /* map of syscalls */
 };

The kernel build also had some compilation warnings as follows.

  CC      arch/ppc/kernel/asm-offsets.s
In file included from arch/ppc/include/asm/hw_irq.h:110,
                 from include/asm/system.h:10,
                 from include/linux/list.h:9,
                 from include/linux/signal.h:8,
                 from arch/ppc/kernel/asm-offsets.c:11:
include/linux/irqflags.h:92:1: warning: "raw_local_irq_save" redefined
In file included from include/asm/system.h:10,
                 from include/linux/list.h:9,
                 from include/linux/signal.h:8,
                 from arch/ppc/kernel/asm-offsets.c:11:
arch/ppc/include/asm/hw_irq.h:103:1: warning: this is the location of
the previous definition
In file included from arch/ppc/include/asm/hw_irq.h:110,
                 from include/asm/system.h:10,
                 from include/linux/list.h:9,
                 from include/linux/signal.h:8,
                 from arch/ppc/kernel/asm-offsets.c:11:
include/linux/irqflags.h:97:1: warning: "raw_local_irq_restore" redefined
In file included from include/asm/system.h:10,
                 from include/linux/list.h:9,
                 from include/linux/signal.h:8,
                 from arch/ppc/kernel/asm-offsets.c:11:
arch/ppc/include/asm/hw_irq.h:62:1: warning: this is the location of
the previous definition
In file included from include/linux/time.h:7,
                 from include/linux/timex.h:57,
                 from include/linux/sched.h:51,
                 from arch/ppc/kernel/asm-offsets.c:12:
include/linux/seqlock.h: In function '__read_seqretry':
include/linux/seqlock.h:139: warning: implicit declaration of function
'local_irq_save'
include/linux/seqlock.h:140: warning: implicit declaration of function
'local_irq_restore'

All the failure makes me doubt the correctness of the PREEMPT_RT patch
in 2.6.21 for ppc arch. Has anyone made a RT patch work for ppc arch
in 2.6.21? In other words, is 2.6.21 a good candidate to test a
PREEMPT_RT patch for ppc arch? I understand that ppc arch will
eventually replaced by powerpc arch. Is there active work going on in
ppc arch to support the PREEMPT_RT?

Thanks a lot in advance for your help.
-Ryan.
