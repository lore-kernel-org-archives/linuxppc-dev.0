Return-Path: <kato.takeharu@jp.fujitsu.com>
Received: from fgwmail5.fujitsu.co.jp (fgwmail5.fujitsu.co.jp [192.51.44.35])
	by ozlabs.org (Postfix) with ESMTP id E453567A6B
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Mar 2005 21:25:30 +1100 (EST)
Message-ID: <4236B7E5.8030402@jp.fujitsu.com>
Date: Tue, 15 Mar 2005 19:24:37 +0900
From: Takeharu KATO <kato.takeharu@jp.fujitsu.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=us-ascii
Cc: tmm@tmm.dk
Subject: [PATCH]  boot time scheduling w hile atomic  fix
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi

I've fixed the problem by changing the implementation of
kernel_thread function.

> Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
> scheduling while atomic: swapper/0x00000002/0
> Call trace:
>  [c0007620] dump_stack+0x18/0x28
>  [c01de704] schedule+0x678/0x67c
>  [c0004500] syscall_exit_work+0x108/0x10c
>  [c02a97b4] proc_root_init+0x168/0x174
>  [ff847288] 0xff847288
>  [c02945e8] start_kernel+0x144/0x170
>  [00003a30] 0x3a30

As I mentioned before, it was caused by calling kernel_thread function via
trap call.

So, I've replaced the implementation of kernel_thread with function call like as
other architectures.

I tested this patch on PowerPC440GP (ebony evaluation board).

Please apply this patch.

I show the boot log for your information:
-- boot-log
Linux/PPC load: console=ttyS0,9600 nfsroot=192.168.0.1:/opt/fje/devkit/ppc/440/0
Uncompressing Linux...done.
Now booting the kernel
Linux version 2.6.11 (tkato@XXXX) (gcc version 3.4.0 20040331 (prerelease))5
IBM Ebony port (MontaVista Software, Inc. (source@mvista.com))
Built 1 zonelists
Kernel command line: console=ttyS0,9600 nfsroot=192.168.0.1:/opt/fje/devkit/ppc0
PID hash table entries: 1024 (order: 10, 16384 bytes)
Console: colour dummy device 80x25
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 126720k available (2064k kernel code, 600k data, 332k init, 0k highmem)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
NET: Registered protocol family 16
PCI: Probing PCI hardware
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
i8042.c: i8042 controller self test timeout.
Serial: 8250/16550 driver $Revision: 1.90 $ 6 ports, IRQ sharing enabled
ttyS0 at MMIO 0x0 (irq = 0) is a 16550A
ttyS1 at MMIO 0x0 (irq = 1) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
[snip]
-- boot-log

Regards,

-- 
Takeharu KATO
Fujitsu Limited
Email:kato.takeharu at jp.fujitsu.com

Signed-off-by: Takeharu KATO <kato.takeharu@jp.fujitsu.com>

diff -Nupr linux-2.6.11/arch/ppc/kernel/misc.S linux-2.6.11-preempt/arch/ppc/kernel/misc.S
--- linux-2.6.11/arch/ppc/kernel/misc.S	2005-03-11 17:26:14.000000000 +0900
+++ linux-2.6.11-preempt/arch/ppc/kernel/misc.S	2005-03-15 17:57:30.000000000 +0900
@@ -1125,36 +1125,23 @@ _GLOBAL(cvt_df)
 	stfd	0,-4(r5)
 	blr
 #endif
-
 /*
- * Create a kernel thread
- *   kernel_thread(fn, arg, flags)
+ * void kernel_thread_helper(void)
+ * This gets run with r13 containing the
+ * function to call, and r14 containing
+ * the "args".
+ * These register is set in ``kernel_thread'' function in
+ * arch/ppc/kernel/process.c.	
+ * Note:
+ * Registers used for arguments for this function should NOT be caller-saves.
  */
-_GLOBAL(kernel_thread)
+_GLOBAL(kernel_thread_helper)
 	stwu	r1,-16(r1)
-	stw	r30,8(r1)
-	stw	r31,12(r1)
-	mr	r30,r3		/* function */
-	mr	r31,r4		/* argument */
-	ori	r3,r5,CLONE_VM	/* flags */
-	oris	r3,r3,CLONE_UNTRACED>>16
-	li	r4,0		/* new sp (unused) */
-	li	r0,__NR_clone
-	sc
-	cmpwi	0,r3,0		/* parent or child? */
-	bne	1f		/* return if parent */
-	li	r0,0		/* make top-level stack frame */
-	stwu	r0,-16(r1)
-	mtlr	r30		/* fn addr in lr */
-	mr	r3,r31		/* load arg and call fn */
+	mtlr    r13
+	mr      r3,r14
 	blrl
-	li	r0,__NR_exit	/* exit if function returns */
-	li	r3,0
-	sc
-1:	lwz	r30,8(r1)
-	lwz	r31,12(r1)
-	addi	r1,r1,16
-	blr
+	bl      do_exit
+	/*  Never return here */

 /*
  * This routine is just here to keep GCC happy - sigh...
diff -Nupr linux-2.6.11/arch/ppc/kernel/process.c linux-2.6.11-preempt/arch/ppc/kernel/process.c
--- linux-2.6.11/arch/ppc/kernel/process.c	2005-03-11 17:23:13.000000000 +0900
+++ linux-2.6.11-preempt/arch/ppc/kernel/process.c	2005-03-15 17:57:31.000000000 +0900
@@ -405,6 +405,31 @@ void prepare_to_copy(struct task_struct
 #endif /* CONFIG_SPE */
 	preempt_enable();
 }
+/*
+ *  Kernel thread relevant functions
+ */
+extern void kernel_thread_helper(void);
+/*
+ * Create a kernel thread
+ */
+long kernel_thread(int (*fn)(void *), void * arg, unsigned long flags)
+{
+	struct pt_regs regs;
+
+	memset(&regs, 0, sizeof(regs));
+	/*  We use r13,14 for arguments for kernel_thread_helper.
+	 *  Because registers used for arguments for this function
+	 *  should NOT be caller-saves.
+	 */
+	regs.gpr[13] = (unsigned long) fn;
+	regs.gpr[14] = (unsigned long) arg;
+
+	regs.nip = (unsigned long) kernel_thread_helper;
+	regs.msr = MSR_KERNEL;
+
+	/* Ok, create the new process.. */
+	return do_fork(flags | CLONE_VM | CLONE_UNTRACED, 0, &regs, 0, NULL, NULL);
+}

 /*
  * Copy a thread..
