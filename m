Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 84FB967B40
	for <linuxppc-dev@ozlabs.org>; Fri,  6 May 2005 15:05:03 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Fri, 06 May 2005 15:04:45 +1000
Message-Id: <1115355885.28075.2.camel@gaston>
Mime-Version: 1.0
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] ppc32: Kill embedded system.map, use kallsyms
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi !

This patch kills the whole embedded System.map mecanism and the
bootloader-passed System.map that was used to provide symbol resolution
in xmon. Instead, xmon now uses kallsyms like ppc64 does.

Andrew: No hurry getting that in Linus tree, let it be tested in -mm for
a while first and make sure it doesn't break various embedded configs.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/arch/ppc64/xmon/xmon.c
===================================================================
--- linux-work.orig/arch/ppc64/xmon/xmon.c	2005-05-06 12:52:10.000000000 +1000
+++ linux-work/arch/ppc64/xmon/xmon.c	2005-05-06 12:55:17.000000000 +1000
@@ -2247,7 +2247,14 @@
 			tmpstr[i] = c;
 		}
 		tmpstr[i++] = 0;
-		*vp = kallsyms_lookup_name(tmpstr);
+		*vp = 0;
+		if (setjmp(bus_error_jmp) == 0) {
+			catch_memory_errors = 1;
+			sync();
+			*vp = kallsyms_lookup_name(tmpstr);
+			sync();
+		}
+		catch_memory_errors = 0;
 		if (!(*vp)) {
 			printf("unknown symbol '%s'\n", tmpstr);
 			return 0;
Index: linux-work/arch/ppc/xmon/xmon.c
===================================================================
--- linux-work.orig/arch/ppc/xmon/xmon.c	2005-05-06 12:52:10.000000000 +1000
+++ linux-work/arch/ppc/xmon/xmon.c	2005-05-06 12:55:18.000000000 +1000
@@ -9,6 +9,7 @@
 #include <linux/smp.h>
 #include <linux/interrupt.h>
 #include <linux/bitops.h>
+#include <linux/kallsyms.h>
 #include <asm/ptrace.h>
 #include <asm/string.h>
 #include <asm/prom.h>
@@ -93,8 +94,7 @@
 static unsigned read_spr(int);
 static void write_spr(int, unsigned);
 static void super_regs(void);
-static void print_sysmap(void);
-static void sysmap_lookup(void);
+static void symbol_lookup(void);
 static void remove_bpts(void);
 static void insert_bpts(void);
 static struct bpt *at_breakpoint(unsigned pc);
@@ -103,7 +103,6 @@
 #ifdef CONFIG_SMP
 static void cpu_cmd(void);
 #endif /* CONFIG_SMP */
-static int pretty_print_addr(unsigned long addr);
 static void csum(void);
 #ifdef CONFIG_BOOTX_TEXT
 static void vidcmds(void);
@@ -120,8 +119,6 @@
 
 extern void xmon_enter(void);
 extern void xmon_leave(void);
-extern char* xmon_find_symbol(unsigned long addr, unsigned long* saddr);
-extern unsigned long xmon_symbol_to_addr(char* symbol);
 
 static unsigned start_tb[NR_CPUS][2];
 static unsigned stop_tb[NR_CPUS][2];
@@ -148,7 +145,6 @@
   mm	move a block of memory\n\
   ms	set a block of memory\n\
   md	compare two blocks of memory\n\
-  M	print System.map\n\
   r	print registers\n\
   S	print special registers\n\
   t	print backtrace\n\
@@ -175,6 +171,35 @@
 				     "r" (loops) : "ctr");
 }
 
+/* Print an address in numeric and symbolic form (if possible) */
+static void xmon_print_symbol(unsigned long address, const char *mid,
+			      const char *after)
+{
+	char *modname;
+	const char *name = NULL;
+	unsigned long offset, size;
+	static char tmpstr[128];
+
+	printf("%.8lx", address);
+	if (setjmp(bus_error_jmp) == 0) {
+		debugger_fault_handler = handle_fault;
+		sync();
+		name = kallsyms_lookup(address, &size, &offset, &modname,
+				       tmpstr);
+		sync();
+		/* wait a little while to see if we get a machine check */
+		__delay(200);
+	}
+	debugger_fault_handler = NULL;
+
+	if (name) {
+		printf("%s%s+%#lx/%#lx", mid, name, offset, size);
+		if (modname)
+			printf(" [%s]", modname);
+	}
+	printf("%s", after);
+}
+
 static void get_tb(unsigned *p)
 {
 	unsigned hi, lo, hiagain;
@@ -454,7 +479,7 @@
 			dump();
 			break;
 		case 'l':
-			sysmap_lookup();
+			symbol_lookup();
 			break;
 		case 'r':
 			if (excp != NULL)
@@ -466,9 +491,6 @@
 			else
 				excprint(excp);
 			break;
-		case 'M':
-			print_sysmap();
-			break;
 		case 'S':
 			super_regs();
 			break;
@@ -825,20 +847,19 @@
 	for (; sp != 0; sp = stack[0]) {
 		if (mread(sp, stack, sizeof(stack)) != sizeof(stack))
 			break;
-		pretty_print_addr(stack[1]);
-		printf(" ");
+		printf("[%.8lx] ", stack);
+		xmon_print_symbol(stack[1], " ", "\n");
 		if (stack[1] == (unsigned) &ret_from_except
 		    || stack[1] == (unsigned) &ret_from_except_full
 		    || stack[1] == (unsigned) &ret_from_syscall) {
 			if (mread(sp+16, &regs, sizeof(regs)) != sizeof(regs))
 				break;
-			printf("\nexception:%x [%x] %x ", regs.trap, sp+16,
+			printf("exception:%x [%x] %x\n", regs.trap, sp+16,
 			       regs.nip);
 			sp = regs.gpr[1];
 			if (mread(sp, stack, sizeof(stack)) != sizeof(stack))
 				break;
 		}
-		printf("\n");
 	}
 }
 
@@ -859,11 +880,10 @@
 #ifdef CONFIG_SMP
 	printf("cpu %d: ", smp_processor_id());
 #endif /* CONFIG_SMP */
-	printf("vector: %x at pc = ", fp->trap);
-	pretty_print_addr(fp->nip);
-	printf(", lr = ");
-	pretty_print_addr(fp->link);
-	printf("\nmsr = %x, sp = %x [%x]\n", fp->msr, fp->gpr[1], fp);
+	printf("vector: %x at pc=", fp->trap);
+	xmon_print_symbol(fp->nip, ": ", ", lr=");
+	xmon_print_symbol(fp->link, ": ", "\n");
+	printf("msr = %x, sp = %x [%x]\n", fp->msr, fp->gpr[1], fp);
 	trap = TRAP(fp);
 	if (trap == 0x300 || trap == 0x600)
 		printf("dar = %x, dsisr = %x\n", fp->dar, fp->dsisr);
@@ -951,24 +971,6 @@
 extern char dec_exc;
 
 void
-print_sysmap(void)
-{
-	extern char *sysmap;
-	if ( sysmap ) {
-		printf("System.map: \n");
-		if( setjmp(bus_error_jmp) == 0 ) {
-			debugger_fault_handler = handle_fault;
-			sync();
-			xmon_puts(sysmap);
-			sync();
-		}
-		debugger_fault_handler = NULL;
-	}
-	else
-		printf("No System.map\n");
-}
-
-void
 super_regs(void)
 {
 	int i, cmd;
@@ -1738,7 +1740,7 @@
 		printf("invalid register name '%%%s'\n", regname);
 		return 0;
 	} else if (c == '$') {
-		static char symname[64];
+		static char symname[128];
 		int i;
 		for (i=0; i<63; i++) {
 			c = inchar();
@@ -1749,7 +1751,14 @@
 			symname[i] = c;
 		}
 		symname[i++] = 0;
-		*vp = xmon_symbol_to_addr(symname);
+		*vp = 0;
+		if (setjmp(bus_error_jmp) == 0) {
+			debugger_fault_handler = handle_fault;
+			sync();
+			*vp = kallsyms_lookup_name(symname);
+			sync();
+		}
+		debugger_fault_handler = NULL;
 		if (!(*vp)) {
 			printf("unknown symbol\n");
 			return 0;
@@ -1840,169 +1849,34 @@
 	lineptr = str;
 }
 
-void
-sysmap_lookup(void)
+static void
+symbol_lookup(void)
 {
 	int type = inchar();
 	unsigned addr;
-	static char tmp[64];
-	char* cur;
-
-	extern char *sysmap;
-	extern unsigned long sysmap_size;
-	if ( !sysmap || !sysmap_size )
-		return;
-
-	switch(type) {
-		case 'a':
-			if (scanhex(&addr)) {
-				pretty_print_addr(addr);
-				printf("\n");
-			}
-			termch = 0;
-			break;
-		case 's':
-			getstring(tmp, 64);
-			if( setjmp(bus_error_jmp) == 0 ) {
-				debugger_fault_handler = handle_fault;
-				sync();
-				cur = sysmap;
-				do {
-					cur = strstr(cur, tmp);
-					if (cur) {
-						static char res[64];
-						char *p, *d;
-						p = cur;
-						while(p > sysmap && *p != 10)
-							p--;
-						if (*p == 10) p++;
-						d = res;
-						while(*p && p < (sysmap + sysmap_size) && *p != 10)
-							*(d++) = *(p++);
-						*(d++) = 0;
-						printf("%s\n", res);
-						cur++;
-					}
-				} while (cur);
-				sync();
-			}
-			debugger_fault_handler = NULL;
-			termch = 0;
-			break;
-	}
-}
+	static char tmp[128];
 
-static int
-pretty_print_addr(unsigned long addr)
-{
-	char *sym;
-	unsigned long saddr;
-	
-	printf("%08x", addr);
-	sym = xmon_find_symbol(addr, &saddr);
-	if (sym)
-		printf(" (%s+0x%x)", sym, addr-saddr);
-	return (sym != 0);
-}
-
-char*
-xmon_find_symbol(unsigned long addr, unsigned long* saddr)
-{
-	static char rbuffer[64];
-	char *p, *ep, *limit;
-	unsigned long prev, next;
-	char* psym;
-
-	extern char *sysmap;
-	extern unsigned long sysmap_size;
-	if ( !sysmap || !sysmap_size )
-		return NULL;
-	
-	prev = 0;
-	psym = NULL;
-	p = sysmap;
-	limit = p + sysmap_size;
-	if( setjmp(bus_error_jmp) == 0 ) {
-		debugger_fault_handler = handle_fault;
-		sync();
-		do {
-			next = simple_strtoul(p, &p, 16);
-			if (next > addr && prev <= addr) {
-				if (!psym)
-					goto bail;
-				ep = rbuffer;
-				p = psym;
-				while(*p && p < limit && *p == 32)
-					p++;
-				while(*p && p < limit && *p != 10 && (ep - rbuffer) < 63)
-					*(ep++) = *(p++);
-				*(ep++) = 0;
-				if (saddr)
-					*saddr = prev;
-				debugger_fault_handler = NULL;
-				return rbuffer;
-			}
-			prev = next;
-			psym = p;
-			while(*p && p < limit && *p != 10)
-				p++;
-			if (*p) p++;
-		} while(*p && p < limit && next);
-bail:
-		sync();
+	switch (type) {
+	case 'a':
+		if (scanhex(&addr))
+			xmon_print_symbol(addr, ": ", "\n");
+		termch = 0;
+		break;
+	case 's':
+		getstring(tmp, 64);
+		if (setjmp(bus_error_jmp) == 0) {
+			debugger_fault_handler = handle_fault;
+			sync();
+			addr = kallsyms_lookup_name(tmp);
+			if (addr)
+				printf("%s: %lx\n", tmp, addr);
+			else
+				printf("Symbol '%s' not found.\n", tmp);
+			sync();
+		}
+		debugger_fault_handler = NULL;
+		termch = 0;
+		break;
 	}
-	debugger_fault_handler = NULL;
-	return NULL;
 }
 
-unsigned long
-xmon_symbol_to_addr(char* symbol)
-{
-	char *p, *cur;
-	char *match = NULL;
-	int goodness = 0;
-	int result = 0;
-	
-	extern char *sysmap;
-	extern unsigned long sysmap_size;
-	if ( !sysmap || !sysmap_size )
-		return 0;
-
-	if( setjmp(bus_error_jmp) == 0 ) {
-		debugger_fault_handler = handle_fault;
-		sync();
-		cur = sysmap;
-		while(cur) {
-			cur = strstr(cur, symbol);
-			if (cur) {
-				int gd = 1;
-
-				/* best match if equal, better match if
-				 * begins with
-				 */
-				if (cur == sysmap || *(cur-1) == ' ') {
-					gd++;
-					if (cur[strlen(symbol)] == 10)
-						gd++;
-				}
-				if (gd > goodness) {
-					match = cur;
-					goodness = gd;
-					if (gd == 3)
-						break;
-				}
-				cur++;
-			}
-		}	
-		if (goodness) {
-			p = match;
-			while(p > sysmap && *p != 10)
-				p--;
-			if (*p == 10) p++;
-			result = simple_strtoul(p, &p, 16);
-		}
-		sync();
-	}
-	debugger_fault_handler = NULL;
-	return result;
-}		
Index: linux-work/arch/ppc/boot/ld.script
===================================================================
--- linux-work.orig/arch/ppc/boot/ld.script	2005-05-02 10:48:08.000000000 +1000
+++ linux-work/arch/ppc/boot/ld.script	2005-05-06 13:17:21.000000000 +1000
@@ -58,9 +58,6 @@
     *(.ramdisk)
     __ramdisk_end = .;
     . = ALIGN(4096);
-    __sysmap_begin = .;
-    *(.sysmap)
-    __sysmap_end = .;
     CONSTRUCTORS
   }
   _edata  =  .;
Index: linux-work/arch/ppc/boot/utils/addSystemMap.c
===================================================================
--- linux-work.orig/arch/ppc/boot/utils/addSystemMap.c	2005-05-02 10:48:08.000000000 +1000
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,186 +0,0 @@
-#include <stdio.h>
-#include <stdlib.h>
-#include <byteswap.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-
-void xlate( char * inb, char * trb, unsigned len )
-{
-    unsigned i;
-    for (  i=0; i<len; ++i ) {
-	char c = *inb++;
-	char c1 = c >> 4;
-	char c2 = c & 0xf;
-	if ( c1 > 9 )
-	    c1 = c1 + 'A' - 10;
-	else
-	    c1 = c1 + '0';
-	if ( c2 > 9 )
-	    c2 = c2 + 'A' - 10;
-	else
-	    c2 = c2 + '0';
-	*trb++ = c1;
-	*trb++ = c2;
-    }
-    *trb = 0;
-}
-
-#define ElfHeaderSize  (64 * 1024)
-#define ElfPages  (ElfHeaderSize / 4096)
-#define KERNELBASE (0xc0000000)
-
-void get4k( /*istream *inf*/FILE *file, char *buf )
-{
-    unsigned j;
-    unsigned num = fread(buf, 1, 4096, file);
-    for (  j=num; j<4096; ++j )
-	buf[j] = 0;
-}
-
-void put4k( /*ostream *outf*/FILE *file, char *buf )
-{
-    fwrite(buf, 1, 4096, file);
-}
-
-int main(int argc, char **argv)
-{
-    char inbuf[4096];
-    FILE *ramDisk = NULL;
-    FILE *inputVmlinux = NULL;
-    FILE *outputVmlinux = NULL;
-    unsigned i = 0;
-    unsigned long ramFileLen = 0;
-    unsigned long ramLen = 0;
-    unsigned long roundR = 0;
-    unsigned long kernelLen = 0;
-    unsigned long actualKernelLen = 0;
-    unsigned long round = 0;
-    unsigned long roundedKernelLen = 0;
-    unsigned long ramStartOffs = 0;
-    unsigned long ramPages = 0;
-    unsigned long roundedKernelPages = 0;
-    if ( argc < 2 ) {
-	printf("Name of System Map file missing.\n");
-	exit(1);
-    }
-
-    if ( argc < 3 ) {
-	printf("Name of vmlinux file missing.\n");
-	exit(1);
-    }
-
-    if ( argc < 4 ) {
-	printf("Name of vmlinux output file missing.\n");
-	exit(1);
-    }
-
-    ramDisk = fopen(argv[1], "r");
-    if ( ! ramDisk ) {
-	printf("System Map file \"%s\" failed to open.\n", argv[1]);
-	exit(1);
-    }
-    inputVmlinux = fopen(argv[2], "r");
-    if ( ! inputVmlinux ) {
-	printf("vmlinux file \"%s\" failed to open.\n", argv[2]);
-	exit(1);
-    }
-    outputVmlinux = fopen(argv[3], "w");
-    if ( ! outputVmlinux ) {
-	printf("output vmlinux file \"%s\" failed to open.\n", argv[3]);
-	exit(1);
-    }
-    fseek(ramDisk, 0, SEEK_END);
-    ramFileLen = ftell(ramDisk);
-    fseek(ramDisk, 0, SEEK_SET);
-    printf("%s file size = %ld\n", argv[1], ramFileLen);
-
-    ramLen = ramFileLen;
-
-    roundR = 4096 - (ramLen % 4096);
-    if ( roundR ) {
-	printf("Rounding System Map file up to a multiple of 4096, adding %ld\n", roundR);
-	ramLen += roundR;
-    }
-
-    printf("Rounded System Map size is %ld\n", ramLen);
-    fseek(inputVmlinux, 0, SEEK_END);
-    kernelLen = ftell(inputVmlinux);
-    fseek(inputVmlinux, 0, SEEK_SET);
-    printf("kernel file size = %ld\n", kernelLen);
-    if ( kernelLen == 0 ) {
-	printf("You must have a linux kernel specified as argv[2]\n");
-	exit(1);
-    }
-
-    actualKernelLen = kernelLen - ElfHeaderSize;
-
-    printf("actual kernel length (minus ELF header) = %ld\n", actualKernelLen);
-
-    round = actualKernelLen % 4096;
-    roundedKernelLen = actualKernelLen;
-    if ( round )
-	roundedKernelLen += (4096 - round);
-
-    printf("actual kernel length rounded up to a 4k multiple = %ld\n", roundedKernelLen);
-
-    ramStartOffs = roundedKernelLen;
-    ramPages = ramLen / 4096;
-
-    printf("System map pages to copy = %ld\n", ramPages);
-
-    // Copy 64K ELF header
-      for (i=0; i<(ElfPages); ++i) {
-	  get4k( inputVmlinux, inbuf );
-	  put4k( outputVmlinux, inbuf );
-      }
-
-
-
-    roundedKernelPages = roundedKernelLen / 4096;
-
-    fseek(inputVmlinux, ElfHeaderSize, SEEK_SET);
-
-    {
-	for ( i=0; i<roundedKernelPages; ++i ) {
-	    get4k( inputVmlinux, inbuf );
-	    if ( i == 0 ) {
-		unsigned long * p;
-		printf("Storing embedded_sysmap_start at 0x3c\n");
-		p = (unsigned long *)(inbuf + 0x3c);
-
-#if (BYTE_ORDER == __BIG_ENDIAN)
-		*p = ramStartOffs;
-#else
-		*p = bswap_32(ramStartOffs);
-#endif
-
-		printf("Storing embedded_sysmap_end at 0x44\n");
-		p = (unsigned long *)(inbuf + 0x44);
-#if (BYTE_ORDER == __BIG_ENDIAN)
-		*p = ramStartOffs + ramFileLen;
-#else
-		*p = bswap_32(ramStartOffs + ramFileLen);
-#endif
-	    }
-	    put4k( outputVmlinux, inbuf );
-	}
-    }
-
-    {
-	for ( i=0; i<ramPages; ++i ) {
-	    get4k( ramDisk, inbuf );
-	    put4k( outputVmlinux, inbuf );
-	}
-    }
-
-
-    fclose(ramDisk);
-    fclose(inputVmlinux);
-    fclose(outputVmlinux);
-    /* Set permission to executable */
-    chmod(argv[3], S_IRUSR|S_IWUSR|S_IXUSR|S_IRGRP|S_IXGRP|S_IROTH|S_IXOTH);
-
-    return 0;
-
-}
-
Index: linux-work/arch/ppc/kernel/setup.c
===================================================================
--- linux-work.orig/arch/ppc/kernel/setup.c	2005-05-03 14:57:45.000000000 +1000
+++ linux-work/arch/ppc/kernel/setup.c	2005-05-06 13:16:49.000000000 +1000
@@ -61,8 +61,6 @@
 
 extern boot_infos_t *boot_infos;
 struct ide_machdep_calls ppc_ide_md;
-char *sysmap;
-unsigned long sysmap_size;
 
 /* Used with the BI_MEMSIZE bootinfo parameter to store the memory
    size value reported by the boot loader. */
@@ -579,11 +577,6 @@
 		case BI_CMD_LINE:
 			strlcpy(cmd_line, (void *)data, sizeof(cmd_line));
 			break;
-		case BI_SYSMAP:
-			sysmap = (char *)((data[0] >= (KERNELBASE)) ? data[0] :
-					  (data[0]+KERNELBASE));
-			sysmap_size = data[1];
-			break;
 #ifdef CONFIG_BLK_DEV_INITRD
 		case BI_INITRD:
 			initrd_start = data[0] + KERNELBASE;
Index: linux-work/arch/ppc/boot/simple/Makefile
===================================================================
--- linux-work.orig/arch/ppc/boot/simple/Makefile	2005-05-02 10:48:08.000000000 +1000
+++ linux-work/arch/ppc/boot/simple/Makefile	2005-05-06 13:18:48.000000000 +1000
@@ -203,7 +203,7 @@
 		$(obj)/dummy.o $(obj)/image.o
 	$(LD) $(LD_ARGS) -o $@ $(OBJS) $(obj)/image.o $(LIBS)
 	$(OBJCOPY) $(OBJCOPY_ARGS) $@ $@ -R .comment -R .stab \
-		-R .stabstr -R .ramdisk -R .sysmap
+		-R .stabstr -R .ramdisk
 
 $(obj)/zvmlinux.initrd: $(OBJS) $(LIBS) $(srctree)/$(boot)/ld.script \
 		$(images)/vmlinux.gz $(obj)/dummy.o
@@ -215,7 +215,7 @@
 		$(obj)/dummy.o $(obj)/image.o
 	$(LD) $(LD_ARGS) -o $@ $(OBJS) $(obj)/image.o $(LIBS)
 	$(OBJCOPY) $(OBJCOPY_ARGS) $@ $@ -R .comment -R .stab \
-		-R .stabstr -R .sysmap
+		-R .stabstr
 
 # Sort-of dummy rules, that let us format the image we want.
 zImage: $(images)/$(zimage-y) $(obj)/zvmlinux
Index: linux-work/arch/ppc/boot/openfirmware/Makefile
===================================================================
--- linux-work.orig/arch/ppc/boot/openfirmware/Makefile	2005-05-02 10:48:08.000000000 +1000
+++ linux-work/arch/ppc/boot/openfirmware/Makefile	2005-05-06 13:20:29.000000000 +1000
@@ -54,13 +54,10 @@
 	@echo '          RAM disk image must be provided separately'
 	@/bin/false
 
-objcpxmon-$(CONFIG_XMON) := --add-section=.sysmap=System.map \
-	--set-section-flags=.sysmap=contents,alloc,load,readonly,data
 quiet_cmd_genimage = GEN     $@
       cmd_genimage = $(OBJCOPY) -R .comment       \
 	--add-section=.image=$(images)/vmlinux.gz \
-	--set-section-flags=.image=contents,alloc,load,readonly,data \
-	$(objcpxmon-y) $< $@
+	--set-section-flags=.image=contents,alloc,load,readonly,data $< $@
 
 targets += image.o
 $(obj)/image.o: $(obj)/dummy.o $(images)/vmlinux.gz FORCE
Index: linux-work/arch/ppc/boot/openfirmware/common.c
===================================================================
--- linux-work.orig/arch/ppc/boot/openfirmware/common.c	2005-05-02 10:48:08.000000000 +1000
+++ linux-work/arch/ppc/boot/openfirmware/common.c	2005-05-06 13:19:22.000000000 +1000
@@ -15,7 +15,6 @@
 #include <asm/page.h>
 
 /* Information from the linker */
-extern char __sysmap_begin, __sysmap_end;
 
 extern int strcmp(const char *s1, const char *s2);
 extern char *avail_ram, *avail_high;
@@ -116,14 +115,8 @@
 void make_bi_recs(unsigned long addr, char *name, unsigned int mach,
 		unsigned long progend)
 {
-	unsigned long sysmap_size;
 	struct bi_record *rec;
 
-	/* Figure out the size of a possible System.map we're going to
-	 * pass along.
-	 * */
-	sysmap_size = (unsigned long)(&__sysmap_end) -
-		(unsigned long)(&__sysmap_begin);
 
 	/* leave a 1MB gap then align to the next 1MB boundary */
 	addr = _ALIGN(addr+ (1<<20) - 1, (1<<20));
@@ -147,15 +140,6 @@
 	rec->size = sizeof(struct bi_record) + 2 * sizeof(unsigned long);
 	rec = (struct bi_record *)((unsigned long)rec + rec->size);
 
-	if (sysmap_size) {
-		rec->tag = BI_SYSMAP;
-		rec->data[0] = (unsigned long)(&__sysmap_begin);
-		rec->data[1] = sysmap_size;
-		rec->size = sizeof(struct bi_record) + 2 *
-			sizeof(unsigned long);
-		rec = (struct bi_record *)((unsigned long)rec + rec->size);
-	}
-
 	rec->tag = BI_LAST;
 	rec->size = sizeof(struct bi_record);
 	rec = (struct bi_record *)((unsigned long)rec + rec->size);
Index: linux-work/arch/ppc/mm/init.c
===================================================================
--- linux-work.orig/arch/ppc/mm/init.c	2005-05-02 10:48:08.000000000 +1000
+++ linux-work/arch/ppc/mm/init.c	2005-05-06 13:16:18.000000000 +1000
@@ -96,9 +96,6 @@
 char *klimit = _end;
 struct mem_pieces phys_avail;
 
-extern char *sysmap;
-extern unsigned long sysmap_size;
-
 /*
  * this tells the system to map all of ram with the segregs
  * (i.e. page tables) instead of the bats.
@@ -441,12 +438,6 @@
 	if (agp_special_page)
 		SetPageReserved(virt_to_page(agp_special_page));
 #endif
-	if ( sysmap )
-		for (addr = (unsigned long)sysmap;
-		     addr < PAGE_ALIGN((unsigned long)sysmap+sysmap_size) ;
-		     addr += PAGE_SIZE)
-			SetPageReserved(virt_to_page(addr));
-
 	for (addr = PAGE_OFFSET; addr < (unsigned long)high_memory;
 	     addr += PAGE_SIZE) {
 		if (!PageReserved(virt_to_page(addr)))
@@ -482,9 +473,7 @@
 	       codepages<< (PAGE_SHIFT-10), datapages<< (PAGE_SHIFT-10),
 	       initpages<< (PAGE_SHIFT-10),
 	       (unsigned long) (totalhigh_pages << (PAGE_SHIFT-10)));
-	if (sysmap)
-		printk("System.map loaded at 0x%08x for debugger, size: %ld bytes\n",
-			(unsigned int)sysmap, sysmap_size);
+
 #ifdef CONFIG_PPC_PMAC
 	if (agp_special_page)
 		printk(KERN_INFO "AGP special page: 0x%08lx\n", agp_special_page);
@@ -534,9 +523,6 @@
 	if (rtas_data)
 		mem_pieces_remove(&phys_avail, rtas_data, rtas_size, 1);
 #endif
-	/* remove the sysmap pages from the available memory */
-	if (sysmap)
-		mem_pieces_remove(&phys_avail, __pa(sysmap), sysmap_size, 1);
 #ifdef CONFIG_PPC_PMAC
 	/* Because of some uninorth weirdness, we need a page of
 	 * memory as high as possible (it must be outside of the
