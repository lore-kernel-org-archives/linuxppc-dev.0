Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Thu, 16 Nov 2006 18:23:26 +1100
Subject: [RFC/PATCH 6/9] Add spu disassembly to xmon
In-Reply-To: <1163661800.406227.631357998554.qpush@cradle>
Message-Id: <20061116072327.C55EA67C83@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd.bergmann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds a "sdi" command to xmon, to disassemble the contents
of an spu's local store.

---

 arch/powerpc/xmon/Makefile |    1 +
 arch/powerpc/xmon/xmon.c   |   35 +++++++++++++++++++++++++++--------
 2 files changed, 28 insertions(+), 8 deletions(-)

Index: cell/arch/powerpc/xmon/Makefile
===================================================================
--- cell.orig/arch/powerpc/xmon/Makefile
+++ cell/arch/powerpc/xmon/Makefile
@@ -5,3 +5,4 @@ EXTRA_CFLAGS += -mno-minimal-toc
 endif
 obj-y			+= xmon.o ppc-dis.o ppc-opc.o setjmp.o start.o \
 			   nonstdio.o
+obj-$(CONFIG_PPC_CELL)	+= spu-dis.o spu-opc.o
Index: cell/arch/powerpc/xmon/xmon.c
===================================================================
--- cell.orig/arch/powerpc/xmon/xmon.c
+++ cell/arch/powerpc/xmon/xmon.c
@@ -154,6 +154,7 @@ static int do_spu_cmd(void);
 int xmon_no_auto_backtrace;
 
 extern int print_insn_powerpc(unsigned long insn, unsigned long memaddr);
+extern int print_insn_spu(unsigned long insn, unsigned long memaddr);
 
 extern void xmon_enter(void);
 extern void xmon_leave(void);
@@ -218,7 +219,8 @@ Commands:\n\
 "  ss	stop execution on all spus\n\
   sr	restore execution on stopped spus\n\
   sf  #	dump spu fields for spu # (in hex)\n\
-  sd  #	dump spu local store for spu # (in hex)\n"
+  sd  #	dump spu local store for spu # (in hex)\
+  sdi #	disassemble spu local store for spu # (in hex)\n"
 #endif
 "  S	print special registers\n\
   t	print backtrace\n\
@@ -2826,7 +2828,13 @@ static void dump_spu_fields(struct spu *
 	DUMP_FIELD(spu, "0x%p", priv2);
 }
 
-static void dump_spu_ls(unsigned long num)
+int
+spu_inst_dump(unsigned long adr, long count, int praddr)
+{
+	return generic_inst_dump(adr, count, praddr, print_insn_spu);
+}
+
+static void dump_spu_ls(unsigned long num, int subcmd)
 {
 	unsigned long offset, addr, ls_addr;
 
@@ -2853,9 +2861,17 @@ static void dump_spu_ls(unsigned long nu
 		return;
 	}
 
-	prdump(addr, 64);
-	addr += 64;
-	last_cmd = "sd\n";
+	switch (subcmd) {
+	case 'i':
+		addr += spu_inst_dump(addr, 16, 1);
+		last_cmd = "sdi\n";
+		break;
+	default:
+		prdump(addr, 64);
+		addr += 64;
+		last_cmd = "sd\n";
+		break;
+	}
 
 	spu_info[num].dump_addr = addr;
 }
@@ -2863,7 +2879,7 @@ static void dump_spu_ls(unsigned long nu
 static int do_spu_cmd(void)
 {
 	static unsigned long num = 0;
-	int cmd;
+	int cmd, subcmd = 0;
 
 	cmd = inchar();
 	switch (cmd) {
@@ -2873,8 +2889,11 @@ static int do_spu_cmd(void)
 	case 'r':
 		restart_spus();
 		break;
-	case 'f':
 	case 'd':
+		subcmd = inchar();
+		if (isxdigit(subcmd) || subcmd == '\n')
+			termch = subcmd;
+	case 'f':
 		scanhex(&num);
 		if (num >= XMON_NUM_SPUS || !spu_info[num].spu) {
 			printf("*** Error: invalid spu number\n");
@@ -2886,7 +2905,7 @@ static int do_spu_cmd(void)
 			dump_spu_fields(spu_info[num].spu);
 			break;
 		default:
-			dump_spu_ls(num);
+			dump_spu_ls(num, subcmd);
 			break;
 		}
 
