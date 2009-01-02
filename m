Return-Path: <miltonm@bga.com>
Received: from mercury.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id ACC19DE015
	for <linuxppc-dev@ozlabs.org>; Sat,  3 Jan 2009 08:04:56 +1100 (EST)
From: Milton Miller <miltonm@bga.com>
To: Simon Horman <horms@verge.net.au>, <kexec@lists.infradead.org> 
Message-Id: <kexec-29-1-2r.miltonm@bga.com>
In-Reply-To: <kexec-29-1.miltonm@bga.com>
Subject: [PATCH kexec-tools 2/5] ppc64: update kdump for 2.6.28 relocatable
	kernel
Date: Fri, 02 Jan 2009 15:04:42 -0600
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The kernel updated its ABI to tell the relocatable kernel to run
where it was loaded.

We now need to set a flag in the kernel image.  Since we only have
the kernel image avialable as const data to kexec-tools c code, set
the flag in the copy we put in purgatory, and have it set the flag
in the kernel (after purgatory has run its checksum).  To simplfy
the purgatory code we can always copy the flag word back to the
kernel as the c code made a copy of the original flag value.

Signed-off-by: Milton Miller <miltonm@bga.com>
---
v3: 
purgatory now copies the flag to the kernel master entrypoint instead of
the kernel reading the value copied to 0 with the slave spinloop.

rename the local varable to my_run_at_load to be more consistent, and
change its type to uint32_t from unsigned int


Index: kexec-tools/purgatory/arch/ppc64/v2wrap.S
===================================================================
--- kexec-tools.orig/purgatory/arch/ppc64/v2wrap.S	2009-01-01 21:46:15.000000000 -0600
+++ kexec-tools/purgatory/arch/ppc64/v2wrap.S	2009-01-01 22:01:10.000000000 -0600
@@ -45,11 +45,14 @@
 	oris    rn,rn,name##@h;         \
 	ori     rn,rn,name##@l
 
-#define KDUMP_SIGNATURE 0xfeed1234
-
 	.machine ppc64
 	.globl purgatory_start
 purgatory_start:	b	master
+	.org purgatory_start + 0x5c     # ABI: possible run_at_load flag at 0x5c
+	.globl run_at_load
+run_at_load:
+	.long 0
+	.size run_at_load, . - run_at_load
 	.org purgatory_start + 0x60     # ABI: slaves start at 60 with r3=phys
 slave:	b $
 	.org purgatory_start + 0x100    # ABI: end of copied region
@@ -57,7 +60,7 @@ slave:	b $
 
 #
 # The above 0x100 bytes at purgatory_start are replaced with the
-# code from the kernel (or next stage) by kexec/arch/ppc64/kexec-ppc64.c
+# code from the kernel (or next stage) by kexec/arch/ppc64/kexec-elf-ppc64.c
 #
 
 master:
@@ -65,7 +68,6 @@ master:
 	isync
 	mr      17,3            # save cpu id to r17
 	mr      15,4            # save physical address in reg15
-	mr      18,6            # save kdump flag in reg18
 
 	LOADADDR(6,my_toc)
 	ld      2,0(6)          #setup toc
@@ -92,18 +94,13 @@ master:
 80:
 	LOADADDR(6,kernel)
 	ld      4,0(6)          # load the kernel address
+	LOADADDR(6,run_at_load) # the load flag
+	lwz	7,0(6)		# possibly patched by kexec-elf-ppc64
+	stw	7,0x5c(4)	# and patch it into the kernel
 	li	5,0		# r5 will be 0 for kernel
 	mtctr	4		# prepare branch too
 	mr      3,16            # restore dt address
 
-	LOADADDR(6,KDUMP_SIGNATURE)
-	cmpd	18,6
-	bne	regular
-	li	7,1
-	std	7,24(4)		# mark kdump flag at kernel
-regular:
-	lwz	7,0(4)		# get the first instruction that we stole
-	stw	7,0(0)		# and put it in the slave loop at 0
 				# skip cache flush, do we care?
 
 	bctr			# start kernel
Index: kexec-tools/kexec/arch/ppc64/crashdump-ppc64.h
===================================================================
--- kexec-tools.orig/kexec/arch/ppc64/crashdump-ppc64.h	2009-01-01 21:46:15.000000000 -0600
+++ kexec-tools/kexec/arch/ppc64/crashdump-ppc64.h	2009-01-01 21:46:24.000000000 -0600
@@ -23,6 +23,8 @@ void add_usable_mem_rgns(unsigned long l
 #define _ALIGN_UP(addr,size)	(((addr)+((size)-1))&(~((size)-1)))
 #define _ALIGN_DOWN(addr,size)	((addr)&(~((size)-1)))
 
+#define KERNEL_RUN_AT_ZERO_MAGIC 0x72756e30	/* "run0" */
+
 extern uint64_t crash_base;
 extern uint64_t crash_size;
 extern unsigned int rtas_base;
Index: kexec-tools/kexec/arch/ppc64/kexec-elf-ppc64.c
===================================================================
--- kexec-tools.orig/kexec/arch/ppc64/kexec-elf-ppc64.c	2009-01-01 21:46:15.000000000 -0600
+++ kexec-tools/kexec/arch/ppc64/kexec-elf-ppc64.c	2009-01-01 21:46:24.000000000 -0600
@@ -92,6 +92,7 @@ int elf_ppc64_load(int argc, char **argv
 	unsigned int my_panic_kernel;
 	uint64_t my_stack, my_backup_start;
 	uint64_t toc_addr;
+	uint32_t my_run_at_load;
 	unsigned int slave_code[256/sizeof (unsigned int)], master_entry;
 
 #define OPT_APPEND     (OPT_ARCH_MAX+0)
@@ -307,6 +308,18 @@ int elf_ppc64_load(int argc, char **argv
 		my_backup_start = info->backup_start;
 		elf_rel_set_symbol(&info->rhdr, "backup_start",
 				&my_backup_start, sizeof(my_backup_start));
+
+		/* Tell relocatable kernel to run at load address
+		 * via word before slave code in purgatory
+		 */
+
+		elf_rel_get_symbol(&info->rhdr, "run_at_load", &my_run_at_load,
+				sizeof(my_run_at_load));
+		if (my_run_at_load == KERNEL_RUN_AT_ZERO_MAGIC)
+			my_run_at_load = 1;
+			/* else it should be a fixed offset image */
+		elf_rel_set_symbol(&info->rhdr, "run_at_load", &my_run_at_load,
+				sizeof(my_run_at_load));
 	}
 
 	/* Set stack address */
@@ -325,10 +338,13 @@ int elf_ppc64_load(int argc, char **argv
 	my_backup_start = 0;
 	my_stack = 0;
 	toc_addr = 0;
+	my_run_at_load = 0;
 
 	elf_rel_get_symbol(&info->rhdr, "kernel", &my_kernel, sizeof(my_kernel));
 	elf_rel_get_symbol(&info->rhdr, "dt_offset", &my_dt_offset,
 				sizeof(my_dt_offset));
+	elf_rel_get_symbol(&info->rhdr, "run_at_load", &my_run_at_load,
+				sizeof(my_run_at_load));
 	elf_rel_get_symbol(&info->rhdr, "panic_kernel", &my_panic_kernel,
 				sizeof(my_panic_kernel));
 	elf_rel_get_symbol(&info->rhdr, "backup_start", &my_backup_start,
@@ -341,6 +357,7 @@ int elf_ppc64_load(int argc, char **argv
 	fprintf(stderr, "kernel is %llx\n", (unsigned long long)my_kernel);
 	fprintf(stderr, "dt_offset is %llx\n",
 		(unsigned long long)my_dt_offset);
+	fprintf(stderr, "run_at_load flag is %x\n", my_run_at_load);
 	fprintf(stderr, "panic_kernel is %x\n", my_panic_kernel);
 	fprintf(stderr, "backup_start is %llx\n",
 		(unsigned long long)my_backup_start);
