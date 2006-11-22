Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Wed, 22 Nov 2006 18:55:28 +1100
Subject: [PATCH 4/9] Prepare for spu disassembly in xmon
In-Reply-To: <1164182122.302443.256192350213.qpush@cradle>
Message-Id: <20061122075533.BF71F67D28@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd.bergmann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In order to do disassembly of spu binaries in xmon, we need to abstract
the disassembly function from ppc_inst_dump.

We do this by making the actual disassembly function a function pointer
that we pass to ppc_inst_dump(). To save updating all the callers, we
turn ppc_inst_dump() into generic_inst_dump() and make ppc_inst_dump()
a wrapper which always uses print_insn_powerpc().

Currently we pass the dialect into print_insn_powerpc(), but we always
pass 0 - so just make it a local.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/xmon/ppc-dis.c |    6 +++---
 arch/powerpc/xmon/xmon.c    |   15 ++++++++++++---
 2 files changed, 15 insertions(+), 6 deletions(-)

Index: cell/arch/powerpc/xmon/ppc-dis.c
===================================================================
--- cell.orig/arch/powerpc/xmon/ppc-dis.c
+++ cell/arch/powerpc/xmon/ppc-dis.c
@@ -27,14 +27,14 @@ extern void print_address (unsigned long
 /* Print a PowerPC or POWER instruction.  */
 
 int
-print_insn_powerpc (unsigned long insn, unsigned long memaddr, int dialect)
+print_insn_powerpc (unsigned long insn, unsigned long memaddr)
 {
   const struct powerpc_opcode *opcode;
   const struct powerpc_opcode *opcode_end;
   unsigned long op;
+  int dialect;
 
-  if (dialect == 0)
-    dialect = PPC_OPCODE_PPC | PPC_OPCODE_CLASSIC | PPC_OPCODE_COMMON
+  dialect = PPC_OPCODE_PPC | PPC_OPCODE_CLASSIC | PPC_OPCODE_COMMON
 	      | PPC_OPCODE_64 | PPC_OPCODE_POWER4 | PPC_OPCODE_ALTIVEC;
 
   /* Get the major opcode of the instruction.  */
Index: cell/arch/powerpc/xmon/xmon.c
===================================================================
--- cell.orig/arch/powerpc/xmon/xmon.c
+++ cell/arch/powerpc/xmon/xmon.c
@@ -153,7 +153,7 @@ static int do_spu_cmd(void);
 
 int xmon_no_auto_backtrace;
 
-extern int print_insn_powerpc(unsigned long, unsigned long, int);
+extern int print_insn_powerpc(unsigned long insn, unsigned long memaddr);
 
 extern void xmon_enter(void);
 extern void xmon_leave(void);
@@ -2066,8 +2066,11 @@ prdump(unsigned long adrs, long ndump)
 	}
 }
 
+typedef int (*instruction_dump_func)(unsigned long inst, unsigned long addr);
+
 int
-ppc_inst_dump(unsigned long adr, long count, int praddr)
+generic_inst_dump(unsigned long adr, long count, int praddr,
+			instruction_dump_func dump_func)
 {
 	int nr, dotted;
 	unsigned long first_adr;
@@ -2097,12 +2100,18 @@ ppc_inst_dump(unsigned long adr, long co
 		if (praddr)
 			printf(REG"  %.8x", adr, inst);
 		printf("\t");
-		print_insn_powerpc(inst, adr, 0);	/* always returns 4 */
+		dump_func(inst, adr);
 		printf("\n");
 	}
 	return adr - first_adr;
 }
 
+int
+ppc_inst_dump(unsigned long adr, long count, int praddr)
+{
+	return generic_inst_dump(adr, count, praddr, print_insn_powerpc);
+}
+
 void
 print_address(unsigned long addr)
 {
