From: Cort Dougan <cort@fsmlabs.com>
Date: Thu, 6 Jun 2002 15:26:33 -0600
To: linuxppc-dev@lists.linuxppc.org
Cc: mporter@mvista.com, hozer@drgw.net, paulus@host110.fsmlabs.com
Subject: [PATCH] Fix for PReP SMP
Message-ID: <20020606152633.K22181@host110.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This patch is against the Linux v2.4.16 tree.  My SMP PReP box now boots.

It fixes SMP for PReP systems and allows us to run safely with only one (or
a fewer than max available) processor active.  Before, using only 1 CPU on
a SMP box left the other CPU executing in and reading from memory that the
kernel would later write over.  It also removes some bad code in the PReP
bootloader that resulted in some pointless 'if' constructs (explicitly
casting a pointer to an int) that never actually tested what they needed
to.  I removed some other warnings with this patch in
prep_show_percpuinfo().

I removed park_cpus() and the residual data SMP code associated with it
since it wasn't doing the right thing.  We get the SmpIar value from the
firmware but then copy it 3 times before it gets to the SMP startup code.
Now, this code passes it in with the much cleaner and architecture
independent bootinfo method.

The SmpIar passing can and should be changed so that we just pass in the
residual data with bootinfo.  We could then just fixup the ....->SmpIar
variable to contain a pointer to the SmpIar address rather than being the
actual location of the SmpIar register.  So, we would write to
*(ulong *)(...->SmpIar) instead of (...->SmpIar).

diff -Nru a/arch/ppc/boot/prep/misc.c b/arch/ppc/boot/prep/misc.c
--- a/arch/ppc/boot/prep/misc.c	Thu Jun  6 15:16:26 2002
+++ b/arch/ppc/boot/prep/misc.c	Thu Jun  6 15:16:26 2002
@@ -123,29 +123,6 @@
 }
 #endif /* CONFIG_VGA_CONSOLE */

-/*
- * This routine is used to control the second processor on the
- * Motorola dual processor platforms.
- */
-void
-park_cpus(void)
-{
-	volatile void (*go)(RESIDUAL *, int, int, char *, int);
-	unsigned int i;
-	volatile unsigned long *smp_iar = &(hold_residual->VitalProductData.SmpIar);
-
-	/* Wait for indication to continue.  If the kernel
-	   was not compiled with SMP support then the second
-	   processor will spin forever here makeing the kernel
-	   multiprocessor safe. */
-	while (*smp_iar == 0) {
-                for (i=0; i < 512; i++);
-	}
-
-	(unsigned long)go = hold_residual->VitalProductData.SmpIar;
-	go(hold_residual, 0, 0, cmd_line, sizeof(cmd_preset));
-}
-
 unsigned long
 decompress_kernel(unsigned long load_addr, int num_words, unsigned long cksum,
 		  RESIDUAL *residual, void *OFW_interface)
@@ -225,9 +202,8 @@
 			 * park the other processor so that the
 			 * kernel knows where to find them.
 			 */
-			if (residual->MaxNumCpus > 1) {
+			if (residual->MaxNumCpus > 1)
 				start_multi = 1;
-			}
 		}
 		memcpy(hold_residual,residual,sizeof(RESIDUAL));
 	} else {
@@ -270,11 +246,10 @@
 		_put_MSR(orig_MSR & ~0x0030);
         }

-	if (start_multi) {
+	if (start_multi)
+	{
 		hold_residual->VitalProductData.SmpIar = 0;
 		hold_residual->Cpus[1].CpuState = CPU_GOOD_FW;
-		residual->VitalProductData.SmpIar = (unsigned long)park_cpus;
-		residual->Cpus[1].CpuState = CPU_GOOD;
 		hold_residual->VitalProductData.Reserved5 = 0xdeadbeef;
 	}

@@ -395,9 +370,9 @@
 	puts("\n");

 	/* mappings on early boot can only handle 16M */
-	if ( (int)(cmd_line[0]) > (16<<20))
+	if ( (ulong)cmd_line > (16<<20))
 		puts("cmd_line located > 16M\n");
-	if ( (int)hold_residual > (16<<20))
+	if ( (ulong)hold_residual > (16<<20))
 		puts("hold_residual located > 16M\n");
 	if ( initrd_start > (16<<20))
 		puts("initrd_start located > 16M\n");
@@ -420,7 +395,28 @@
 		memcpy( (void *)rec->data, "prepboot", 9);
 		rec->size = sizeof(struct bi_record) + 8 + 1;
 		rec = (struct bi_record *)((unsigned long)rec + rec->size);
-
+
+		/*
+		 * Added 6/6/02 to remove crazy park_cpu() routines and
+		 * passing of addresses through 3 different copies of
+		 * the residual data. That ended up losing the original
+		 * SmpIar address and left the other CPU in a state
+		 * that would be reading and executing from memory that
+		 * the kernel would eventually write over.
+		 *
+		 * This should be replaced by passing the residual data
+		 * to the kernel via bootinfo rather than the intuited
+		 * r3 method.  Until then, this gets the smpiar into the
+		 * kernel unambiguously.
+		 *
+		 *   -- Cort <cort@fsmlabs.com>
+		 */
+		rec->tag = BI_SMPIAR;
+		rec->data[0] = (ulong)&(residual->VitalProductData.SmpIar);
+		rec->data[1] = (ulong)&(residual->Cpus[1].CpuState);
+		rec->size = sizeof(struct bi_record) + 2*sizeof(unsigned long);
+		rec = (struct bi_record *)((unsigned long)rec + rec->size);
+
 		rec->tag = BI_MACHTYPE;
 		rec->data[0] = _MACH_prep;
 		rec->data[1] = 0;
diff -Nru a/arch/ppc/kernel/head.S b/arch/ppc/kernel/head.S
--- a/arch/ppc/kernel/head.S	Thu Jun  6 15:16:26 2002
+++ b/arch/ppc/kernel/head.S	Thu Jun  6 15:16:26 2002
@@ -1249,7 +1249,11 @@
         sync
         b       __secondary_start
 #endif /* CONFIG_GEMINI */
-
+
+	.globl __secondary_start_generic1
+__secondary_start_generic1:
+	li	r24,1			/* cpu # */
+	b	__secondary_start
 	.globl	__secondary_start_psurge
 __secondary_start_psurge:
 	li	r24,1			/* cpu # */
diff -Nru a/arch/ppc/kernel/prep_setup.c b/arch/ppc/kernel/prep_setup.c
--- a/arch/ppc/kernel/prep_setup.c	Thu Jun  6 15:16:26 2002
+++ b/arch/ppc/kernel/prep_setup.c	Thu Jun  6 15:16:26 2002
@@ -97,6 +97,7 @@
 extern char saved_command_line[];

 int _prep_type;
+ulong *smp_iar, *cpu1_state;

 #define cached_21	(((char *)(ppc_cached_irq_mask))[3])
 #define cached_A1	(((char *)(ppc_cached_irq_mask))[2])
@@ -209,8 +210,6 @@
 static int __prep
 prep_show_percpuinfo(struct seq_file *m, int i)
 {
-	int len = 0;
-
 	/* PREP's without residual data will give incorrect values here */
 	seq_printf(m, "clock\t\t: ");
 #ifdef CONFIG_PREP_RESIDUAL
@@ -751,8 +750,24 @@
 static void __init
 smp_prep_kick_cpu(int nr)
 {
-	*(unsigned long *)KERNELBASE = nr;
-	asm volatile("dcbf 0,%0"::"r"(KERNELBASE):"memory");
+	void __secondary_start_generic1(void);
+
+	/* this can happen when booting a SMP kernel on a UP PReP
+	 * machine.  -- Cort <cort@fsmlabs.com>
+	 */
+	if ( !smp_iar || !cpu1_state )
+		return;
+
+	/* write the address for the other cpu and tell it to start
+	 * executing and flush it to make sure those writes are seen
+	 *   -- Cort <cort@fsmlabs.com>
+	 */
+	*smp_iar = __pa(__secondary_start_generic1);
+	asm volatile("dcbf 0,%0"::"r" (smp_iar): "memory");
+	*cpu1_state = CPU_GOOD;
+	asm volatile("dcbf 0,%0"::"r" (cpu1_state): "memory");
+
+	udelay(10000);
 	printk("CPU1 reset, waiting\n");
 }

diff -Nru a/arch/ppc/kernel/setup.c b/arch/ppc/kernel/setup.c
--- a/arch/ppc/kernel/setup.c	Thu Jun  6 15:16:26 2002
+++ b/arch/ppc/kernel/setup.c	Thu Jun  6 15:16:26 2002
@@ -166,7 +166,7 @@
 		return 0;
 	pvr = cpu_data[i].pvr;
 	lpj = cpu_data[i].loops_per_jiffy;
-	seq_printf(m, "processor\t: %lu\n", i);
+	seq_printf(m, "processor\t: %d\n", i);
 #else
 	pvr = mfspr(PVR);
 	lpj = loops_per_jiffy;
@@ -465,6 +465,17 @@
 		case BI_CMD_LINE:
 			memcpy(cmd_line, (void *)data, rec->size);
 			break;
+
+#if defined(CONFIG_ALL_PPC)
+		case BI_SMPIAR:
+		{
+			extern ulong *smp_iar, *cpu1_state;
+			smp_iar = (ulong *)__va(data[0]);
+			cpu1_state = (ulong *)__va(data[1]);
+			break;
+		}
+#endif /* CONFIG_ALL_PPC */
+
 		case BI_SYSMAP:
 			sysmap = (char *)((data[0] >= (KERNELBASE)) ? data[0] :
 					  (data[0]+KERNELBASE));
diff -Nru a/include/asm-ppc/bootinfo.h b/include/asm-ppc/bootinfo.h
--- a/include/asm-ppc/bootinfo.h	Thu Jun  6 15:16:26 2002
+++ b/include/asm-ppc/bootinfo.h	Thu Jun  6 15:16:26 2002
@@ -32,6 +32,7 @@
 #define BI_SYSMAP		0x1015
 #define BI_MACHTYPE		0x1016
 #define BI_MEMSIZE		0x1017
+#define BI_SMPIAR		0x1018

 #endif /* CONFIG_APUS */


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
