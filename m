Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CB072474C7
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Oct 2008 07:39:32 +1100 (EST)
Date: Wed, 22 Oct 2008 15:39:17 -0500 (CDT)
From: Milton Miller <miltonm@bga.com>
Sender: Milton Miller <miltonm@realtime.net>
To: Simon Horman <horms@verge.net.au>
Subject: [PATCH 1/2 kexec-tools] ppc64: new relocatble kernel activation ABI
Message-id: <kexec-user-1@bga.com>
In-Reply-To: <f90d4d7306443a720ca31adf513faf25@bga.com>
Cc: linuxppc-dev@ozlabs.org, Simon Horman <horms@verge.net.au>,
	kexec@lists.infradead.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


The updates kexec-tools to match the kernel after the patches

"kexec exit should not use magic numbers" and 

"better flag for running relocatable" are applied.



Signed-off-by: Milton Miller <miltonm@bga.com>
---
Still proposed change

Index: kexec-tools/purgatory/arch/ppc64/v2wrap.S
===================================================================
--- kexec-tools.orig/purgatory/arch/ppc64/v2wrap.S	2008-10-22 06:14:44.000000000 -0500
+++ kexec-tools/purgatory/arch/ppc64/v2wrap.S	2008-10-22 06:14:48.000000000 -0500
@@ -45,11 +45,13 @@
 	oris    rn,rn,name##@h;         \
 	ori     rn,rn,name##@l
 
-#define KDUMP_SIGNATURE 0xfeed1234
-
 	.machine ppc64
 	.globl purgatory_start
 purgatory_start:	b	master
+	.org purgatory_start + 0x5c     # ABI: possible run_at_load flag at 0x5c
+run_at_load:
+	.long 0
+	.size run_at_load, . - run_at_load
 	.org purgatory_start + 0x60     # ABI: slaves start at 60 with r3=phys
 slave:	b $
 	.org purgatory_start + 0x100    # ABI: end of copied region
@@ -65,7 +67,6 @@ master:
 	isync
 	mr      17,3            # save cpu id to r17
 	mr      15,4            # save physical address in reg15
-	mr      18,6            # save kdump flag in reg18
 
 	LOADADDR(6,my_toc)
 	ld      2,0(6)          #setup toc
@@ -96,14 +97,6 @@ master:
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
--- kexec-tools.orig/kexec/arch/ppc64/crashdump-ppc64.h	2008-10-22 06:14:44.000000000 -0500
+++ kexec-tools/kexec/arch/ppc64/crashdump-ppc64.h	2008-10-22 06:14:48.000000000 -0500
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
--- kexec-tools.orig/kexec/arch/ppc64/kexec-elf-ppc64.c	2008-10-22 06:14:44.000000000 -0500
+++ kexec-tools/kexec/arch/ppc64/kexec-elf-ppc64.c	2008-10-22 06:14:48.000000000 -0500
@@ -93,6 +93,7 @@ int elf_ppc64_load(int argc, char **argv
 	uint64_t my_stack, my_backup_start;
 	uint64_t toc_addr;
 	unsigned int slave_code[256/sizeof (unsigned int)], master_entry;
+	unsigned int run_at_load;
 
 #define OPT_APPEND     (OPT_ARCH_MAX+0)
 #define OPT_RAMDISK     (OPT_ARCH_MAX+1)
@@ -307,6 +308,18 @@ int elf_ppc64_load(int argc, char **argv
 		my_backup_start = info->backup_start;
 		elf_rel_set_symbol(&info->rhdr, "backup_start",
 				&my_backup_start, sizeof(my_backup_start));
+
+		/* Tell relocatable kernel to run at load address
+		 * via word before slave code in purgatory
+		 */
+
+		elf_rel_get_symbol(&info->rhdr, "run_at_load", &run_at_load,
+				sizeof(run_at_load));
+		if (run_at_load == KERNEL_RUN_AT_ZERO_MAGIC)
+			run_at_load = 1;
+			/* else it should be a fixed offset image */
+		elf_rel_set_symbol(&info->rhdr, "run_at_load", &run_at_load,
+				sizeof(run_at_load));
 	}
 
 	/* Set stack address */
@@ -325,10 +338,13 @@ int elf_ppc64_load(int argc, char **argv
 	my_backup_start = 0;
 	my_stack = 0;
 	toc_addr = 0;
+	run_at_load = 0;
 
 	elf_rel_get_symbol(&info->rhdr, "kernel", &my_kernel, sizeof(my_kernel));
 	elf_rel_get_symbol(&info->rhdr, "dt_offset", &my_dt_offset,
 				sizeof(my_dt_offset));
+	elf_rel_get_symbol(&info->rhdr, "run_at_load", &run_at_load,
+				sizeof(run_at_load));
 	elf_rel_get_symbol(&info->rhdr, "panic_kernel", &my_panic_kernel,
 				sizeof(my_panic_kernel));
 	elf_rel_get_symbol(&info->rhdr, "backup_start", &my_backup_start,
@@ -341,6 +357,7 @@ int elf_ppc64_load(int argc, char **argv
 	fprintf(stderr, "kernel is %llx\n", (unsigned long long)my_kernel);
 	fprintf(stderr, "dt_offset is %llx\n",
 		(unsigned long long)my_dt_offset);
+	fprintf(stderr, "run_at_load flag is %x\n", run_at_load);
 	fprintf(stderr, "panic_kernel is %x\n", my_panic_kernel);
 	fprintf(stderr, "backup_start is %llx\n",
 		(unsigned long long)my_backup_start);
