Return-Path: <bsingharora@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vDSb12VTrzDqGt
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Feb 2017 16:04:13 +1100 (AEDT)
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vDSb02YJjz9s7B
 for <linuxppc-dev@ozlabs.org>; Thu,  2 Feb 2017 16:04:12 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id y143so565219pfb.1
 for <linuxppc-dev@ozlabs.org>; Wed, 01 Feb 2017 21:04:12 -0800 (PST)
From: Balbir Singh <bsingharora@gmail.com>
To: mpe@ellerman.id.au,
	linuxppc-dev@ozlabs.org
Cc: Balbir Singh <bsingharora@gmail.com>, Peter Bergner <bergner@vnet.ibm.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH 1/3] powerpc/xmon Update ppc-dis/opc.c and ppc.h
Date: Thu,  2 Feb 2017 10:33:42 +0530
Message-Id: <20170202050344.6825-2-bsingharora@gmail.com>
In-Reply-To: <20170202050344.6825-1-bsingharora@gmail.com>
References: <20170202050344.6825-1-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Upgrade ppc-opc.c, ppc-dis.c and ppc.h to the
versions belonging to the following commit

65b650b4c7463f4508bed523c24ab0031a5ae5cd
* ppc-dis.c (print_insn_powerpc): Don't skip all operands
  after setting skip_optional.

This version will not compile, but make it easier to
apply newer reclicensed commits on top of

NOTE: This commit is not bisect friendly

Cc: Peter Bergner <bergner@vnet.ibm.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---
 arch/powerpc/xmon/ppc-dis.c | 272 ++++++++++++++---
 arch/powerpc/xmon/ppc-opc.c | 728 ++++++++++++++------------------------------
 arch/powerpc/xmon/ppc.h     |  62 ++--
 3 files changed, 492 insertions(+), 570 deletions(-)

diff --git a/arch/powerpc/xmon/ppc-dis.c b/arch/powerpc/xmon/ppc-dis.c
index ee98917..2545a36 100644
--- a/arch/powerpc/xmon/ppc-dis.c
+++ b/arch/powerpc/xmon/ppc-dis.c
@@ -1,5 +1,5 @@
 /* ppc-dis.c -- Disassemble PowerPC instructions
-   Copyright 1994, 1995, 2000, 2001, 2002, 2003, 2004, 2005, 2006
+   Copyright 1994, 1995, 2000, 2001, 2002, 2003, 2004, 2005, 2006, 2007
    Free Software Foundation, Inc.
    Written by Ian Lance Taylor, Cygnus Support
 
@@ -19,34 +19,193 @@ You should have received a copy of the GNU General Public License
 along with this file; see the file COPYING.  If not, write to the Free
 Software Foundation, 51 Franklin Street - Fifth Floor, Boston, MA 02110-1301, USA.  */
 
-#include <asm/cputable.h>
-#include <asm/cpu_has_feature.h>
-#include "nonstdio.h"
-#include "ansidecl.h"
-#include "ppc.h"
+#include <stdio.h>
+#include "sysdep.h"
 #include "dis-asm.h"
+#include "opcode/ppc.h"
 
-/* Print a PowerPC or POWER instruction.  */
+/* This file provides several disassembler functions, all of which use
+   the disassembler interface defined in dis-asm.h.  Several functions
+   are provided because this file handles disassembly for the PowerPC
+   in both big and little endian mode and also for the POWER (RS/6000)
+   chip.  */
+
+static int print_insn_powerpc (bfd_vma, struct disassemble_info *, int, int);
+
+/* Determine which set of machines to disassemble for.  PPC403/601 or
+   BookE.  For convenience, also disassemble instructions supported
+   by the AltiVec vector unit.  */
+
+static int
+powerpc_dialect (struct disassemble_info *info)
+{
+  int dialect = PPC_OPCODE_PPC;
+
+  if (BFD_DEFAULT_TARGET_SIZE == 64)
+    dialect |= PPC_OPCODE_64;
+
+  if (info->disassembler_options
+      && strstr (info->disassembler_options, "booke") != NULL)
+    dialect |= PPC_OPCODE_BOOKE | PPC_OPCODE_BOOKE64;
+  else if ((info->mach == bfd_mach_ppc_e500)
+	   || (info->disassembler_options
+	       && strstr (info->disassembler_options, "e500") != NULL))
+    dialect |= (PPC_OPCODE_BOOKE
+		| PPC_OPCODE_SPE | PPC_OPCODE_ISEL
+		| PPC_OPCODE_EFS | PPC_OPCODE_BRLOCK
+		| PPC_OPCODE_PMR | PPC_OPCODE_CACHELCK
+		| PPC_OPCODE_RFMCI);
+  else if (info->disassembler_options
+	   && strstr (info->disassembler_options, "efs") != NULL)
+    dialect |= PPC_OPCODE_EFS;
+  else if (info->disassembler_options
+	   && strstr (info->disassembler_options, "e300") != NULL)
+    dialect |= PPC_OPCODE_E300 | PPC_OPCODE_CLASSIC | PPC_OPCODE_COMMON;
+  else if (info->disassembler_options
+	   && strstr (info->disassembler_options, "440") != NULL)
+    dialect |= PPC_OPCODE_BOOKE | PPC_OPCODE_32
+      | PPC_OPCODE_440 | PPC_OPCODE_ISEL | PPC_OPCODE_RFMCI;
+  else
+    dialect |= (PPC_OPCODE_403 | PPC_OPCODE_601 | PPC_OPCODE_CLASSIC
+		| PPC_OPCODE_COMMON | PPC_OPCODE_ALTIVEC);
+
+  if (info->disassembler_options
+      && strstr (info->disassembler_options, "power4") != NULL)
+    dialect |= PPC_OPCODE_POWER4;
+
+  if (info->disassembler_options
+      && strstr (info->disassembler_options, "power5") != NULL)
+    dialect |= PPC_OPCODE_POWER4 | PPC_OPCODE_POWER5;
+
+  if (info->disassembler_options
+      && strstr (info->disassembler_options, "cell") != NULL)
+    dialect |= PPC_OPCODE_POWER4 | PPC_OPCODE_CELL | PPC_OPCODE_ALTIVEC;
+
+  if (info->disassembler_options
+      && strstr (info->disassembler_options, "power6") != NULL)
+    dialect |= PPC_OPCODE_POWER4 | PPC_OPCODE_POWER5 | PPC_OPCODE_POWER6 | PPC_OPCODE_ALTIVEC;
+
+  if (info->disassembler_options
+      && strstr (info->disassembler_options, "any") != NULL)
+    dialect |= PPC_OPCODE_ANY;
+
+  if (info->disassembler_options)
+    {
+      if (strstr (info->disassembler_options, "32") != NULL)
+	dialect &= ~PPC_OPCODE_64;
+      else if (strstr (info->disassembler_options, "64") != NULL)
+	dialect |= PPC_OPCODE_64;
+    }
+
+  info->private_data = (char *) 0 + dialect;
+  return dialect;
+}
+
+/* Print a big endian PowerPC instruction.  */
+
+int
+print_insn_big_powerpc (bfd_vma memaddr, struct disassemble_info *info)
+{
+  int dialect = (char *) info->private_data - (char *) 0;
+  return print_insn_powerpc (memaddr, info, 1, dialect);
+}
+
+/* Print a little endian PowerPC instruction.  */
 
 int
-print_insn_powerpc (unsigned long insn, unsigned long memaddr)
+print_insn_little_powerpc (bfd_vma memaddr, struct disassemble_info *info)
+{
+  int dialect = (char *) info->private_data - (char *) 0;
+  return print_insn_powerpc (memaddr, info, 0, dialect);
+}
+
+/* Print a POWER (RS/6000) instruction.  */
+
+int
+print_insn_rs6000 (bfd_vma memaddr, struct disassemble_info *info)
+{
+  return print_insn_powerpc (memaddr, info, 1, PPC_OPCODE_POWER);
+}
+
+/* Extract the operand value from the PowerPC or POWER instruction.  */
+
+static long
+operand_value_powerpc (const struct powerpc_operand *operand,
+		       unsigned long insn, int dialect)
+{
+  long value;
+  int invalid;
+  /* Extract the value from the instruction.  */
+  if (operand->extract)
+    value = (*operand->extract) (insn, dialect, &invalid);
+  else
+    {
+      value = (insn >> operand->shift) & operand->bitm;
+      if ((operand->flags & PPC_OPERAND_SIGNED) != 0)
+	{
+	  /* BITM is always some number of zeros followed by some
+	     number of ones, followed by some numer of zeros.  */
+	  unsigned long top = operand->bitm;
+	  /* top & -top gives the rightmost 1 bit, so this
+	     fills in any trailing zeros.  */
+	  top |= (top & -top) - 1;
+	  top &= ~(top >> 1);
+	  value = (value ^ top) - top;
+	}
+    }
+
+  return value;
+}
+
+/* Determine whether the optional operand(s) should be printed.  */
+
+static int
+skip_optional_operands (const unsigned char *opindex,
+			unsigned long insn, int dialect)
+{
+  const struct powerpc_operand *operand;
+
+  for (; *opindex != 0; opindex++)
+    {
+      operand = &powerpc_operands[*opindex];
+      if ((operand->flags & PPC_OPERAND_NEXT) != 0
+	  || ((operand->flags & PPC_OPERAND_OPTIONAL) != 0
+	      && operand_value_powerpc (operand, insn, dialect) != 0))
+	return 0;
+    }
+
+  return 1;
+}
+
+/* Print a PowerPC or POWER instruction.  */
+
+static int
+print_insn_powerpc (bfd_vma memaddr,
+		    struct disassemble_info *info,
+		    int bigendian,
+		    int dialect)
 {
+  bfd_byte buffer[4];
+  int status;
+  unsigned long insn;
   const struct powerpc_opcode *opcode;
   const struct powerpc_opcode *opcode_end;
   unsigned long op;
-  int dialect;
-
-  dialect = PPC_OPCODE_PPC | PPC_OPCODE_CLASSIC | PPC_OPCODE_COMMON
-	      | PPC_OPCODE_64 | PPC_OPCODE_POWER4 | PPC_OPCODE_ALTIVEC;
 
-  if (cpu_has_feature(CPU_FTRS_POWER5))
-    dialect |= PPC_OPCODE_POWER5;
+  if (dialect == 0)
+    dialect = powerpc_dialect (info);
 
-  if (cpu_has_feature(CPU_FTRS_CELL))
-    dialect |= PPC_OPCODE_CELL | PPC_OPCODE_ALTIVEC;
+  status = (*info->read_memory_func) (memaddr, buffer, 4, info);
+  if (status != 0)
+    {
+      (*info->memory_error_func) (status, memaddr, info);
+      return -1;
+    }
 
-  if (cpu_has_feature(CPU_FTRS_POWER6))
-    dialect |= PPC_OPCODE_POWER5 | PPC_OPCODE_POWER6 | PPC_OPCODE_ALTIVEC;
+  if (bigendian)
+    insn = bfd_getb32 (buffer);
+  else
+    insn = bfd_getl32 (buffer);
 
   /* Get the major opcode of the instruction.  */
   op = PPC_OP (insn);
@@ -63,6 +222,7 @@ print_insn_powerpc (unsigned long insn, unsigned long memaddr)
       int invalid;
       int need_comma;
       int need_paren;
+      int skip_optional;
 
       table_op = PPC_OP (opcode->opcode);
       if (op < table_op)
@@ -88,13 +248,15 @@ print_insn_powerpc (unsigned long insn, unsigned long memaddr)
 	continue;
 
       /* The instruction is valid.  */
-      printf("%s", opcode->name);
       if (opcode->operands[0] != 0)
-	printf("\t");
+	(*info->fprintf_func) (info->stream, "%-7s ", opcode->name);
+      else
+	(*info->fprintf_func) (info->stream, "%s", opcode->name);
 
       /* Now extract and print the operands.  */
       need_comma = 0;
       need_paren = 0;
+      skip_optional = -1;
       for (opindex = opcode->operands; *opindex != 0; opindex++)
 	{
 	  long value;
@@ -107,49 +269,44 @@ print_insn_powerpc (unsigned long insn, unsigned long memaddr)
 	  if ((operand->flags & PPC_OPERAND_FAKE) != 0)
 	    continue;
 
-	  /* Extract the value from the instruction.  */
-	  if (operand->extract)
-	    value = (*operand->extract) (insn, dialect, &invalid);
-	  else
+	  /* If all of the optional operands have the value zero,
+	     then don't print any of them.  */
+	  if ((operand->flags & PPC_OPERAND_OPTIONAL) != 0)
 	    {
-	      value = (insn >> operand->shift) & ((1 << operand->bits) - 1);
-	      if ((operand->flags & PPC_OPERAND_SIGNED) != 0
-		  && (value & (1 << (operand->bits - 1))) != 0)
-		value -= 1 << operand->bits;
+	      if (skip_optional < 0)
+		skip_optional = skip_optional_operands (opindex, insn,
+							dialect);
+	      if (skip_optional)
+		continue;
 	    }
 
-	  /* If the operand is optional, and the value is zero, don't
-	     print anything.  */
-	  if ((operand->flags & PPC_OPERAND_OPTIONAL) != 0
-	      && (operand->flags & PPC_OPERAND_NEXT) == 0
-	      && value == 0)
-	    continue;
+	  value = operand_value_powerpc (operand, insn, dialect);
 
 	  if (need_comma)
 	    {
-	      printf(",");
+	      (*info->fprintf_func) (info->stream, ",");
 	      need_comma = 0;
 	    }
 
 	  /* Print the operand as directed by the flags.  */
 	  if ((operand->flags & PPC_OPERAND_GPR) != 0
 	      || ((operand->flags & PPC_OPERAND_GPR_0) != 0 && value != 0))
-	    printf("r%ld", value);
+	    (*info->fprintf_func) (info->stream, "r%ld", value);
 	  else if ((operand->flags & PPC_OPERAND_FPR) != 0)
-	    printf("f%ld", value);
+	    (*info->fprintf_func) (info->stream, "f%ld", value);
 	  else if ((operand->flags & PPC_OPERAND_VR) != 0)
-	    printf("v%ld", value);
+	    (*info->fprintf_func) (info->stream, "v%ld", value);
 	  else if ((operand->flags & PPC_OPERAND_RELATIVE) != 0)
-	    print_address (memaddr + value);
+	    (*info->print_address_func) (memaddr + value, info);
 	  else if ((operand->flags & PPC_OPERAND_ABSOLUTE) != 0)
-	    print_address (value & 0xffffffff);
+	    (*info->print_address_func) ((bfd_vma) value & 0xffffffff, info);
 	  else if ((operand->flags & PPC_OPERAND_CR) == 0
 		   || (dialect & PPC_OPCODE_PPC) == 0)
-	    printf("%ld", value);
+	    (*info->fprintf_func) (info->stream, "%ld", value);
 	  else
 	    {
-	      if (operand->bits == 3)
-		printf("cr%ld", value);
+	      if (operand->bitm == 7)
+		(*info->fprintf_func) (info->stream, "cr%ld", value);
 	      else
 		{
 		  static const char *cbnames[4] = { "lt", "gt", "eq", "so" };
@@ -158,15 +315,15 @@ print_insn_powerpc (unsigned long insn, unsigned long memaddr)
 
 		  cr = value >> 2;
 		  if (cr != 0)
-		    printf("4*cr%d+", cr);
+		    (*info->fprintf_func) (info->stream, "4*cr%d+", cr);
 		  cc = value & 3;
-		  printf("%s", cbnames[cc]);
+		  (*info->fprintf_func) (info->stream, "%s", cbnames[cc]);
 		}
 	    }
 
 	  if (need_paren)
 	    {
-	      printf(")");
+	      (*info->fprintf_func) (info->stream, ")");
 	      need_paren = 0;
 	    }
 
@@ -174,7 +331,7 @@ print_insn_powerpc (unsigned long insn, unsigned long memaddr)
 	    need_comma = 1;
 	  else
 	    {
-	      printf("(");
+	      (*info->fprintf_func) (info->stream, "(");
 	      need_paren = 1;
 	    }
 	}
@@ -190,7 +347,26 @@ print_insn_powerpc (unsigned long insn, unsigned long memaddr)
     }
 
   /* We could not find a match.  */
-  printf(".long 0x%lx", insn);
+  (*info->fprintf_func) (info->stream, ".long 0x%lx", insn);
 
   return 4;
 }
+
+void
+print_ppc_disassembler_options (FILE *stream)
+{
+  fprintf (stream, "\n\
+The following PPC specific disassembler options are supported for use with\n\
+the -M switch:\n");
+
+  fprintf (stream, "  booke|booke32|booke64    Disassemble the BookE instructions\n");
+  fprintf (stream, "  e300                     Disassemble the e300 instructions\n");
+  fprintf (stream, "  e500|e500x2              Disassemble the e500 instructions\n");
+  fprintf (stream, "  440                      Disassemble the 440 instructions\n");
+  fprintf (stream, "  efs                      Disassemble the EFS instructions\n");
+  fprintf (stream, "  power4                   Disassemble the Power4 instructions\n");
+  fprintf (stream, "  power5                   Disassemble the Power5 instructions\n");
+  fprintf (stream, "  power6                   Disassemble the Power6 instructions\n");
+  fprintf (stream, "  32                       Do not disassemble 64-bit instructions\n");
+  fprintf (stream, "  64                       Allow disassembly of 64-bit instructions\n");
+}
diff --git a/arch/powerpc/xmon/ppc-opc.c b/arch/powerpc/xmon/ppc-opc.c
index 6845e91..5995f81 100644
--- a/arch/powerpc/xmon/ppc-opc.c
+++ b/arch/powerpc/xmon/ppc-opc.c
@@ -1,6 +1,6 @@
 /* ppc-opc.c -- PowerPC opcode list
    Copyright 1994, 1995, 1996, 1997, 1998, 2000, 2001, 2002, 2003, 2004,
-   2005 Free Software Foundation, Inc.
+   2005, 2006, 2007 Free Software Foundation, Inc.
    Written by Ian Lance Taylor, Cygnus Support
 
    This file is part of GDB, GAS, and the GNU binutils.
@@ -20,14 +20,10 @@
    Software Foundation, 51 Franklin Street - Fifth Floor, Boston, MA
    02110-1301, USA.  */
 
-#include <linux/stddef.h>
-#include <linux/kernel.h>
-#include <linux/bug.h>
-#include "nonstdio.h"
-#include "ppc.h"
-
-#define ATTRIBUTE_UNUSED
-#define _(x)	x
+#include <stdio.h>
+#include "sysdep.h"
+#include "opcode/ppc.h"
+#include "opintl.h"
 
 /* This file holds the PowerPC opcode table.  The opcode table
    includes almost all of the extended instruction mnemonics.  This
@@ -46,8 +42,6 @@ static unsigned long insert_bat (unsigned long, long, int, const char **);
 static long extract_bat (unsigned long, int, int *);
 static unsigned long insert_bba (unsigned long, long, int, const char **);
 static long extract_bba (unsigned long, int, int *);
-static unsigned long insert_bd (unsigned long, long, int, const char **);
-static long extract_bd (unsigned long, int, int *);
 static unsigned long insert_bdm (unsigned long, long, int, const char **);
 static long extract_bdm (unsigned long, int, int *);
 static unsigned long insert_bdp (unsigned long, long, int, const char **);
@@ -56,23 +50,12 @@ static unsigned long insert_bo (unsigned long, long, int, const char **);
 static long extract_bo (unsigned long, int, int *);
 static unsigned long insert_boe (unsigned long, long, int, const char **);
 static long extract_boe (unsigned long, int, int *);
-static unsigned long insert_dq (unsigned long, long, int, const char **);
-static long extract_dq (unsigned long, int, int *);
-static unsigned long insert_ds (unsigned long, long, int, const char **);
-static long extract_ds (unsigned long, int, int *);
-static unsigned long insert_de (unsigned long, long, int, const char **);
-static long extract_de (unsigned long, int, int *);
-static unsigned long insert_des (unsigned long, long, int, const char **);
-static long extract_des (unsigned long, int, int *);
 static unsigned long insert_fxm (unsigned long, long, int, const char **);
 static long extract_fxm (unsigned long, int, int *);
-static unsigned long insert_li (unsigned long, long, int, const char **);
-static long extract_li (unsigned long, int, int *);
 static unsigned long insert_mbe (unsigned long, long, int, const char **);
 static long extract_mbe (unsigned long, int, int *);
 static unsigned long insert_mb6 (unsigned long, long, int, const char **);
 static long extract_mb6 (unsigned long, int, int *);
-static unsigned long insert_nb (unsigned long, long, int, const char **);
 static long extract_nb (unsigned long, int, int *);
 static unsigned long insert_nsi (unsigned long, long, int, const char **);
 static long extract_nsi (unsigned long, int, int *);
@@ -82,8 +65,6 @@ static unsigned long insert_raq (unsigned long, long, int, const char **);
 static unsigned long insert_ras (unsigned long, long, int, const char **);
 static unsigned long insert_rbs (unsigned long, long, int, const char **);
 static long extract_rbs (unsigned long, int, int *);
-static unsigned long insert_rsq (unsigned long, long, int, const char **);
-static unsigned long insert_rtq (unsigned long, long, int, const char **);
 static unsigned long insert_sh6 (unsigned long, long, int, const char **);
 static long extract_sh6 (unsigned long, int, int *);
 static unsigned long insert_spr (unsigned long, long, int, const char **);
@@ -92,16 +73,10 @@ static unsigned long insert_sprg (unsigned long, long, int, const char **);
 static long extract_sprg (unsigned long, int, int *);
 static unsigned long insert_tbr (unsigned long, long, int, const char **);
 static long extract_tbr (unsigned long, int, int *);
-static unsigned long insert_ev2 (unsigned long, long, int, const char **);
-static long extract_ev2 (unsigned long, int, int *);
-static unsigned long insert_ev4 (unsigned long, long, int, const char **);
-static long extract_ev4 (unsigned long, int, int *);
-static unsigned long insert_ev8 (unsigned long, long, int, const char **);
-static long extract_ev8 (unsigned long, int, int *);
 
 /* The operands table.
 
-   The fields are bits, shift, insert, extract, flags.
+   The fields are bitm, shift, insert, extract, flags.
 
    We used to put parens around the various additions, like the one
    for BA just below.  However, that caused trouble with feeble
@@ -119,302 +94,298 @@ const struct powerpc_operand powerpc_operands[] =
 
   /* The BA field in an XL form instruction.  */
 #define BA UNUSED + 1
-#define BA_MASK (0x1f << 16)
-  { 5, 16, NULL, NULL, PPC_OPERAND_CR },
+  /* The BI field in a B form or XL form instruction.  */
+#define BI BA
+#define BI_MASK (0x1f << 16)
+  { 0x1f, 16, NULL, NULL, PPC_OPERAND_CR },
 
   /* The BA field in an XL form instruction when it must be the same
      as the BT field in the same instruction.  */
 #define BAT BA + 1
-  { 5, 16, insert_bat, extract_bat, PPC_OPERAND_FAKE },
+  { 0x1f, 16, insert_bat, extract_bat, PPC_OPERAND_FAKE },
 
   /* The BB field in an XL form instruction.  */
 #define BB BAT + 1
 #define BB_MASK (0x1f << 11)
-  { 5, 11, NULL, NULL, PPC_OPERAND_CR },
+  { 0x1f, 11, NULL, NULL, PPC_OPERAND_CR },
 
   /* The BB field in an XL form instruction when it must be the same
      as the BA field in the same instruction.  */
 #define BBA BB + 1
-  { 5, 11, insert_bba, extract_bba, PPC_OPERAND_FAKE },
+  { 0x1f, 11, insert_bba, extract_bba, PPC_OPERAND_FAKE },
 
   /* The BD field in a B form instruction.  The lower two bits are
      forced to zero.  */
 #define BD BBA + 1
-  { 16, 0, insert_bd, extract_bd, PPC_OPERAND_RELATIVE | PPC_OPERAND_SIGNED },
+  { 0xfffc, 0, NULL, NULL, PPC_OPERAND_RELATIVE | PPC_OPERAND_SIGNED },
 
   /* The BD field in a B form instruction when absolute addressing is
      used.  */
 #define BDA BD + 1
-  { 16, 0, insert_bd, extract_bd, PPC_OPERAND_ABSOLUTE | PPC_OPERAND_SIGNED },
+  { 0xfffc, 0, NULL, NULL, PPC_OPERAND_ABSOLUTE | PPC_OPERAND_SIGNED },
 
   /* The BD field in a B form instruction when the - modifier is used.
      This sets the y bit of the BO field appropriately.  */
 #define BDM BDA + 1
-  { 16, 0, insert_bdm, extract_bdm,
+  { 0xfffc, 0, insert_bdm, extract_bdm,
       PPC_OPERAND_RELATIVE | PPC_OPERAND_SIGNED },
 
   /* The BD field in a B form instruction when the - modifier is used
      and absolute address is used.  */
 #define BDMA BDM + 1
-  { 16, 0, insert_bdm, extract_bdm,
+  { 0xfffc, 0, insert_bdm, extract_bdm,
       PPC_OPERAND_ABSOLUTE | PPC_OPERAND_SIGNED },
 
   /* The BD field in a B form instruction when the + modifier is used.
      This sets the y bit of the BO field appropriately.  */
 #define BDP BDMA + 1
-  { 16, 0, insert_bdp, extract_bdp,
+  { 0xfffc, 0, insert_bdp, extract_bdp,
       PPC_OPERAND_RELATIVE | PPC_OPERAND_SIGNED },
 
   /* The BD field in a B form instruction when the + modifier is used
      and absolute addressing is used.  */
 #define BDPA BDP + 1
-  { 16, 0, insert_bdp, extract_bdp,
+  { 0xfffc, 0, insert_bdp, extract_bdp,
       PPC_OPERAND_ABSOLUTE | PPC_OPERAND_SIGNED },
 
   /* The BF field in an X or XL form instruction.  */
 #define BF BDPA + 1
-  { 3, 23, NULL, NULL, PPC_OPERAND_CR },
+  /* The CRFD field in an X form instruction.  */
+#define CRFD BF
+  { 0x7, 23, NULL, NULL, PPC_OPERAND_CR },
+
+  /* The BF field in an X or XL form instruction.  */
+#define BFF BF + 1
+  { 0x7, 23, NULL, NULL, 0 },
 
   /* An optional BF field.  This is used for comparison instructions,
      in which an omitted BF field is taken as zero.  */
-#define OBF BF + 1
-  { 3, 23, NULL, NULL, PPC_OPERAND_CR | PPC_OPERAND_OPTIONAL },
+#define OBF BFF + 1
+  { 0x7, 23, NULL, NULL, PPC_OPERAND_CR | PPC_OPERAND_OPTIONAL },
 
   /* The BFA field in an X or XL form instruction.  */
 #define BFA OBF + 1
-  { 3, 18, NULL, NULL, PPC_OPERAND_CR },
-
-  /* The BI field in a B form or XL form instruction.  */
-#define BI BFA + 1
-#define BI_MASK (0x1f << 16)
-  { 5, 16, NULL, NULL, PPC_OPERAND_CR },
+  { 0x7, 18, NULL, NULL, PPC_OPERAND_CR },
 
   /* The BO field in a B form instruction.  Certain values are
      illegal.  */
-#define BO BI + 1
+#define BO BFA + 1
 #define BO_MASK (0x1f << 21)
-  { 5, 21, insert_bo, extract_bo, 0 },
+  { 0x1f, 21, insert_bo, extract_bo, 0 },
 
   /* The BO field in a B form instruction when the + or - modifier is
      used.  This is like the BO field, but it must be even.  */
 #define BOE BO + 1
-  { 5, 21, insert_boe, extract_boe, 0 },
+  { 0x1e, 21, insert_boe, extract_boe, 0 },
 
 #define BH BOE + 1
-  { 2, 11, NULL, NULL, PPC_OPERAND_OPTIONAL },
+  { 0x3, 11, NULL, NULL, PPC_OPERAND_OPTIONAL },
 
   /* The BT field in an X or XL form instruction.  */
 #define BT BH + 1
-  { 5, 21, NULL, NULL, PPC_OPERAND_CR },
+  { 0x1f, 21, NULL, NULL, PPC_OPERAND_CR },
 
   /* The condition register number portion of the BI field in a B form
      or XL form instruction.  This is used for the extended
      conditional branch mnemonics, which set the lower two bits of the
      BI field.  This field is optional.  */
 #define CR BT + 1
-  { 3, 18, NULL, NULL, PPC_OPERAND_CR | PPC_OPERAND_OPTIONAL },
+  { 0x7, 18, NULL, NULL, PPC_OPERAND_CR | PPC_OPERAND_OPTIONAL },
 
   /* The CRB field in an X form instruction.  */
 #define CRB CR + 1
-  { 5, 6, NULL, NULL, 0 },
-
-  /* The CRFD field in an X form instruction.  */
-#define CRFD CRB + 1
-  { 3, 23, NULL, NULL, PPC_OPERAND_CR },
+  /* The MB field in an M form instruction.  */
+#define MB CRB
+#define MB_MASK (0x1f << 6)
+  { 0x1f, 6, NULL, NULL, 0 },
 
   /* The CRFS field in an X form instruction.  */
-#define CRFS CRFD + 1
-  { 3, 0, NULL, NULL, PPC_OPERAND_CR },
+#define CRFS CRB + 1
+  { 0x7, 0, NULL, NULL, PPC_OPERAND_CR },
 
   /* The CT field in an X form instruction.  */
 #define CT CRFS + 1
-  { 5, 21, NULL, NULL, PPC_OPERAND_OPTIONAL },
+  /* The MO field in an mbar instruction.  */
+#define MO CT
+  { 0x1f, 21, NULL, NULL, PPC_OPERAND_OPTIONAL },
 
   /* The D field in a D form instruction.  This is a displacement off
      a register, and implies that the next operand is a register in
      parentheses.  */
 #define D CT + 1
-  { 16, 0, NULL, NULL, PPC_OPERAND_PARENS | PPC_OPERAND_SIGNED },
+  { 0xffff, 0, NULL, NULL, PPC_OPERAND_PARENS | PPC_OPERAND_SIGNED },
 
   /* The DE field in a DE form instruction.  This is like D, but is 12
      bits only.  */
 #define DE D + 1
-  { 14, 0, insert_de, extract_de, PPC_OPERAND_PARENS },
+  { 0xfff, 4, NULL, NULL, PPC_OPERAND_PARENS | PPC_OPERAND_SIGNED },
 
   /* The DES field in a DES form instruction.  This is like DS, but is 14
      bits only (12 stored.)  */
 #define DES DE + 1
-  { 14, 0, insert_des, extract_des, PPC_OPERAND_PARENS | PPC_OPERAND_SIGNED },
+  { 0x3ffc, 2, NULL, NULL, PPC_OPERAND_PARENS | PPC_OPERAND_SIGNED },
 
   /* The DQ field in a DQ form instruction.  This is like D, but the
      lower four bits are forced to zero. */
 #define DQ DES + 1
-  { 16, 0, insert_dq, extract_dq,
-      PPC_OPERAND_PARENS | PPC_OPERAND_SIGNED | PPC_OPERAND_DQ },
+  { 0xfff0, 0, NULL, NULL,
+    PPC_OPERAND_PARENS | PPC_OPERAND_SIGNED | PPC_OPERAND_DQ },
 
   /* The DS field in a DS form instruction.  This is like D, but the
      lower two bits are forced to zero.  */
 #define DS DQ + 1
-  { 16, 0, insert_ds, extract_ds,
-      PPC_OPERAND_PARENS | PPC_OPERAND_SIGNED | PPC_OPERAND_DS },
+  { 0xfffc, 0, NULL, NULL,
+    PPC_OPERAND_PARENS | PPC_OPERAND_SIGNED | PPC_OPERAND_DS },
 
   /* The E field in a wrteei instruction.  */
 #define E DS + 1
-  { 1, 15, NULL, NULL, 0 },
+  { 0x1, 15, NULL, NULL, 0 },
 
   /* The FL1 field in a POWER SC form instruction.  */
 #define FL1 E + 1
-  { 4, 12, NULL, NULL, 0 },
+  /* The U field in an X form instruction.  */
+#define U FL1
+  { 0xf, 12, NULL, NULL, 0 },
 
   /* The FL2 field in a POWER SC form instruction.  */
 #define FL2 FL1 + 1
-  { 3, 2, NULL, NULL, 0 },
+  { 0x7, 2, NULL, NULL, 0 },
 
   /* The FLM field in an XFL form instruction.  */
 #define FLM FL2 + 1
-  { 8, 17, NULL, NULL, 0 },
+  { 0xff, 17, NULL, NULL, 0 },
 
   /* The FRA field in an X or A form instruction.  */
 #define FRA FLM + 1
 #define FRA_MASK (0x1f << 16)
-  { 5, 16, NULL, NULL, PPC_OPERAND_FPR },
+  { 0x1f, 16, NULL, NULL, PPC_OPERAND_FPR },
 
   /* The FRB field in an X or A form instruction.  */
 #define FRB FRA + 1
 #define FRB_MASK (0x1f << 11)
-  { 5, 11, NULL, NULL, PPC_OPERAND_FPR },
+  { 0x1f, 11, NULL, NULL, PPC_OPERAND_FPR },
 
   /* The FRC field in an A form instruction.  */
 #define FRC FRB + 1
 #define FRC_MASK (0x1f << 6)
-  { 5, 6, NULL, NULL, PPC_OPERAND_FPR },
+  { 0x1f, 6, NULL, NULL, PPC_OPERAND_FPR },
 
   /* The FRS field in an X form instruction or the FRT field in a D, X
      or A form instruction.  */
 #define FRS FRC + 1
 #define FRT FRS
-  { 5, 21, NULL, NULL, PPC_OPERAND_FPR },
+  { 0x1f, 21, NULL, NULL, PPC_OPERAND_FPR },
 
   /* The FXM field in an XFX instruction.  */
 #define FXM FRS + 1
-#define FXM_MASK (0xff << 12)
-  { 8, 12, insert_fxm, extract_fxm, 0 },
+  { 0xff, 12, insert_fxm, extract_fxm, 0 },
 
   /* Power4 version for mfcr.  */
 #define FXM4 FXM + 1
-  { 8, 12, insert_fxm, extract_fxm, PPC_OPERAND_OPTIONAL },
+  { 0xff, 12, insert_fxm, extract_fxm, PPC_OPERAND_OPTIONAL },
 
   /* The L field in a D or X form instruction.  */
 #define L FXM4 + 1
-  { 1, 21, NULL, NULL, PPC_OPERAND_OPTIONAL },
+  { 0x1, 21, NULL, NULL, PPC_OPERAND_OPTIONAL },
 
   /* The LEV field in a POWER SVC form instruction.  */
 #define SVC_LEV L + 1
-  { 7, 5, NULL, NULL, 0 },
+  { 0x7f, 5, NULL, NULL, 0 },
 
   /* The LEV field in an SC form instruction.  */
 #define LEV SVC_LEV + 1
-  { 7, 5, NULL, NULL, PPC_OPERAND_OPTIONAL },
+  { 0x7f, 5, NULL, NULL, PPC_OPERAND_OPTIONAL },
 
   /* The LI field in an I form instruction.  The lower two bits are
      forced to zero.  */
 #define LI LEV + 1
-  { 26, 0, insert_li, extract_li, PPC_OPERAND_RELATIVE | PPC_OPERAND_SIGNED },
+  { 0x3fffffc, 0, NULL, NULL, PPC_OPERAND_RELATIVE | PPC_OPERAND_SIGNED },
 
   /* The LI field in an I form instruction when used as an absolute
      address.  */
 #define LIA LI + 1
-  { 26, 0, insert_li, extract_li, PPC_OPERAND_ABSOLUTE | PPC_OPERAND_SIGNED },
+  { 0x3fffffc, 0, NULL, NULL, PPC_OPERAND_ABSOLUTE | PPC_OPERAND_SIGNED },
 
   /* The LS field in an X (sync) form instruction.  */
 #define LS LIA + 1
-  { 2, 21, NULL, NULL, PPC_OPERAND_OPTIONAL },
-
-  /* The MB field in an M form instruction.  */
-#define MB LS + 1
-#define MB_MASK (0x1f << 6)
-  { 5, 6, NULL, NULL, 0 },
+  { 0x3, 21, NULL, NULL, PPC_OPERAND_OPTIONAL },
 
   /* The ME field in an M form instruction.  */
-#define ME MB + 1
+#define ME LS + 1
 #define ME_MASK (0x1f << 1)
-  { 5, 1, NULL, NULL, 0 },
+  { 0x1f, 1, NULL, NULL, 0 },
 
   /* The MB and ME fields in an M form instruction expressed a single
      operand which is a bitmask indicating which bits to select.  This
      is a two operand form using PPC_OPERAND_NEXT.  See the
      description in opcode/ppc.h for what this means.  */
 #define MBE ME + 1
-  { 5, 6, NULL, NULL, PPC_OPERAND_OPTIONAL | PPC_OPERAND_NEXT },
-  { 32, 0, insert_mbe, extract_mbe, 0 },
+  { 0x1f, 6, NULL, NULL, PPC_OPERAND_OPTIONAL | PPC_OPERAND_NEXT },
+  { -1, 0, insert_mbe, extract_mbe, 0 },
 
   /* The MB or ME field in an MD or MDS form instruction.  The high
      bit is wrapped to the low end.  */
 #define MB6 MBE + 2
 #define ME6 MB6
 #define MB6_MASK (0x3f << 5)
-  { 6, 5, insert_mb6, extract_mb6, 0 },
-
-  /* The MO field in an mbar instruction.  */
-#define MO MB6 + 1
-  { 5, 21, NULL, NULL, PPC_OPERAND_OPTIONAL },
+  { 0x3f, 5, insert_mb6, extract_mb6, 0 },
 
   /* The NB field in an X form instruction.  The value 32 is stored as
      0.  */
-#define NB MO + 1
-  { 6, 11, insert_nb, extract_nb, 0 },
+#define NB MB6 + 1
+  { 0x1f, 11, NULL, extract_nb, PPC_OPERAND_PLUS1 },
 
   /* The NSI field in a D form instruction.  This is the same as the
      SI field, only negated.  */
 #define NSI NB + 1
-  { 16, 0, insert_nsi, extract_nsi,
+  { 0xffff, 0, insert_nsi, extract_nsi,
       PPC_OPERAND_NEGATIVE | PPC_OPERAND_SIGNED },
 
   /* The RA field in an D, DS, DQ, X, XO, M, or MDS form instruction.  */
 #define RA NSI + 1
 #define RA_MASK (0x1f << 16)
-  { 5, 16, NULL, NULL, PPC_OPERAND_GPR },
+  { 0x1f, 16, NULL, NULL, PPC_OPERAND_GPR },
 
   /* As above, but 0 in the RA field means zero, not r0.  */
 #define RA0 RA + 1
-  { 5, 16, NULL, NULL, PPC_OPERAND_GPR_0 },
+  { 0x1f, 16, NULL, NULL, PPC_OPERAND_GPR_0 },
 
   /* The RA field in the DQ form lq instruction, which has special
      value restrictions.  */
 #define RAQ RA0 + 1
-  { 5, 16, insert_raq, NULL, PPC_OPERAND_GPR_0 },
+  { 0x1f, 16, insert_raq, NULL, PPC_OPERAND_GPR_0 },
 
   /* The RA field in a D or X form instruction which is an updating
      load, which means that the RA field may not be zero and may not
      equal the RT field.  */
 #define RAL RAQ + 1
-  { 5, 16, insert_ral, NULL, PPC_OPERAND_GPR_0 },
+  { 0x1f, 16, insert_ral, NULL, PPC_OPERAND_GPR_0 },
 
   /* The RA field in an lmw instruction, which has special value
      restrictions.  */
 #define RAM RAL + 1
-  { 5, 16, insert_ram, NULL, PPC_OPERAND_GPR_0 },
+  { 0x1f, 16, insert_ram, NULL, PPC_OPERAND_GPR_0 },
 
   /* The RA field in a D or X form instruction which is an updating
      store or an updating floating point load, which means that the RA
      field may not be zero.  */
 #define RAS RAM + 1
-  { 5, 16, insert_ras, NULL, PPC_OPERAND_GPR_0 },
+  { 0x1f, 16, insert_ras, NULL, PPC_OPERAND_GPR_0 },
 
   /* The RA field of the tlbwe instruction, which is optional.  */
 #define RAOPT RAS + 1
-  { 5, 16, NULL, NULL, PPC_OPERAND_GPR | PPC_OPERAND_OPTIONAL },
+  { 0x1f, 16, NULL, NULL, PPC_OPERAND_GPR | PPC_OPERAND_OPTIONAL },
 
   /* The RB field in an X, XO, M, or MDS form instruction.  */
 #define RB RAOPT + 1
 #define RB_MASK (0x1f << 11)
-  { 5, 11, NULL, NULL, PPC_OPERAND_GPR },
+  { 0x1f, 11, NULL, NULL, PPC_OPERAND_GPR },
 
   /* The RB field in an X form instruction when it must be the same as
      the RS field in the instruction.  This is used for extended
      mnemonics like mr.  */
 #define RBS RB + 1
-  { 5, 1, insert_rbs, extract_rbs, PPC_OPERAND_FAKE },
+  { 0x1f, 11, insert_rbs, extract_rbs, PPC_OPERAND_FAKE },
 
   /* The RS field in a D, DS, X, XFX, XS, M, MD or MDS form
      instruction or the RT field in a D, DS, X, XFX or XO form
@@ -422,188 +393,168 @@ const struct powerpc_operand powerpc_operands[] =
 #define RS RBS + 1
 #define RT RS
 #define RT_MASK (0x1f << 21)
-  { 5, 21, NULL, NULL, PPC_OPERAND_GPR },
+  { 0x1f, 21, NULL, NULL, PPC_OPERAND_GPR },
 
-  /* The RS field of the DS form stq instruction, which has special
-     value restrictions.  */
+  /* The RS and RT fields of the DS form stq instruction, which have
+     special value restrictions.  */
 #define RSQ RS + 1
-  { 5, 21, insert_rsq, NULL, PPC_OPERAND_GPR_0 },
-
-  /* The RT field of the DQ form lq instruction, which has special
-     value restrictions.  */
-#define RTQ RSQ + 1
-  { 5, 21, insert_rtq, NULL, PPC_OPERAND_GPR_0 },
+#define RTQ RSQ
+  { 0x1e, 21, NULL, NULL, PPC_OPERAND_GPR_0 },
 
   /* The RS field of the tlbwe instruction, which is optional.  */
-#define RSO RTQ + 1
+#define RSO RSQ + 1
 #define RTO RSO
-  { 5, 21, NULL, NULL, PPC_OPERAND_GPR | PPC_OPERAND_OPTIONAL },
+  { 0x1f, 21, NULL, NULL, PPC_OPERAND_GPR | PPC_OPERAND_OPTIONAL },
 
   /* The SH field in an X or M form instruction.  */
 #define SH RSO + 1
 #define SH_MASK (0x1f << 11)
-  { 5, 11, NULL, NULL, 0 },
+  /* The other UIMM field in a EVX form instruction.  */
+#define EVUIMM SH
+  { 0x1f, 11, NULL, NULL, 0 },
 
   /* The SH field in an MD form instruction.  This is split.  */
 #define SH6 SH + 1
 #define SH6_MASK ((0x1f << 11) | (1 << 1))
-  { 6, 1, insert_sh6, extract_sh6, 0 },
+  { 0x3f, -1, insert_sh6, extract_sh6, 0 },
 
   /* The SH field of the tlbwe instruction, which is optional.  */
 #define SHO SH6 + 1
-  { 5, 11,NULL, NULL, PPC_OPERAND_OPTIONAL },
+  { 0x1f, 11, NULL, NULL, PPC_OPERAND_OPTIONAL },
 
   /* The SI field in a D form instruction.  */
 #define SI SHO + 1
-  { 16, 0, NULL, NULL, PPC_OPERAND_SIGNED },
+  { 0xffff, 0, NULL, NULL, PPC_OPERAND_SIGNED },
 
   /* The SI field in a D form instruction when we accept a wide range
      of positive values.  */
 #define SISIGNOPT SI + 1
-  { 16, 0, NULL, NULL, PPC_OPERAND_SIGNED | PPC_OPERAND_SIGNOPT },
+  { 0xffff, 0, NULL, NULL, PPC_OPERAND_SIGNED | PPC_OPERAND_SIGNOPT },
 
   /* The SPR field in an XFX form instruction.  This is flipped--the
      lower 5 bits are stored in the upper 5 and vice- versa.  */
 #define SPR SISIGNOPT + 1
 #define PMR SPR
 #define SPR_MASK (0x3ff << 11)
-  { 10, 11, insert_spr, extract_spr, 0 },
+  { 0x3ff, 11, insert_spr, extract_spr, 0 },
 
   /* The BAT index number in an XFX form m[ft]ibat[lu] instruction.  */
 #define SPRBAT SPR + 1
 #define SPRBAT_MASK (0x3 << 17)
-  { 2, 17, NULL, NULL, 0 },
+  { 0x3, 17, NULL, NULL, 0 },
 
   /* The SPRG register number in an XFX form m[ft]sprg instruction.  */
 #define SPRG SPRBAT + 1
-  { 5, 16, insert_sprg, extract_sprg, 0 },
+  { 0x1f, 16, insert_sprg, extract_sprg, 0 },
 
   /* The SR field in an X form instruction.  */
 #define SR SPRG + 1
-  { 4, 16, NULL, NULL, 0 },
+  { 0xf, 16, NULL, NULL, 0 },
 
   /* The STRM field in an X AltiVec form instruction.  */
 #define STRM SR + 1
-#define STRM_MASK (0x3 << 21)
-  { 2, 21, NULL, NULL, 0 },
+  { 0x3, 21, NULL, NULL, 0 },
 
   /* The SV field in a POWER SC form instruction.  */
 #define SV STRM + 1
-  { 14, 2, NULL, NULL, 0 },
+  { 0x3fff, 2, NULL, NULL, 0 },
 
   /* The TBR field in an XFX form instruction.  This is like the SPR
      field, but it is optional.  */
 #define TBR SV + 1
-  { 10, 11, insert_tbr, extract_tbr, PPC_OPERAND_OPTIONAL },
+  { 0x3ff, 11, insert_tbr, extract_tbr, PPC_OPERAND_OPTIONAL },
 
   /* The TO field in a D or X form instruction.  */
 #define TO TBR + 1
 #define TO_MASK (0x1f << 21)
-  { 5, 21, NULL, NULL, 0 },
-
-  /* The U field in an X form instruction.  */
-#define U TO + 1
-  { 4, 12, NULL, NULL, 0 },
+  { 0x1f, 21, NULL, NULL, 0 },
 
   /* The UI field in a D form instruction.  */
-#define UI U + 1
-  { 16, 0, NULL, NULL, 0 },
+#define UI TO + 1
+  { 0xffff, 0, NULL, NULL, 0 },
 
   /* The VA field in a VA, VX or VXR form instruction.  */
 #define VA UI + 1
-#define VA_MASK	(0x1f << 16)
-  { 5, 16, NULL, NULL, PPC_OPERAND_VR },
+  { 0x1f, 16, NULL, NULL, PPC_OPERAND_VR },
 
   /* The VB field in a VA, VX or VXR form instruction.  */
 #define VB VA + 1
-#define VB_MASK (0x1f << 11)
-  { 5, 11, NULL, NULL, PPC_OPERAND_VR },
+  { 0x1f, 11, NULL, NULL, PPC_OPERAND_VR },
 
   /* The VC field in a VA form instruction.  */
 #define VC VB + 1
-#define VC_MASK (0x1f << 6)
-  { 5, 6, NULL, NULL, PPC_OPERAND_VR },
+  { 0x1f, 6, NULL, NULL, PPC_OPERAND_VR },
 
   /* The VD or VS field in a VA, VX, VXR or X form instruction.  */
 #define VD VC + 1
 #define VS VD
-#define VD_MASK (0x1f << 21)
-  { 5, 21, NULL, NULL, PPC_OPERAND_VR },
+  { 0x1f, 21, NULL, NULL, PPC_OPERAND_VR },
 
   /* The SIMM field in a VX form instruction.  */
 #define SIMM VD + 1
-  { 5, 16, NULL, NULL, PPC_OPERAND_SIGNED},
+  { 0x1f, 16, NULL, NULL, PPC_OPERAND_SIGNED},
 
-  /* The UIMM field in a VX form instruction.  */
+  /* The UIMM field in a VX form instruction, and TE in Z form.  */
 #define UIMM SIMM + 1
-  { 5, 16, NULL, NULL, 0 },
+#define TE UIMM
+  { 0x1f, 16, NULL, NULL, 0 },
 
   /* The SHB field in a VA form instruction.  */
 #define SHB UIMM + 1
-  { 4, 6, NULL, NULL, 0 },
-
-  /* The other UIMM field in a EVX form instruction.  */
-#define EVUIMM SHB + 1
-  { 5, 11, NULL, NULL, 0 },
+  { 0xf, 6, NULL, NULL, 0 },
 
   /* The other UIMM field in a half word EVX form instruction.  */
-#define EVUIMM_2 EVUIMM + 1
-  { 32, 11, insert_ev2, extract_ev2, PPC_OPERAND_PARENS },
+#define EVUIMM_2 SHB + 1
+  { 0x3e, 10, NULL, NULL, PPC_OPERAND_PARENS },
 
   /* The other UIMM field in a word EVX form instruction.  */
 #define EVUIMM_4 EVUIMM_2 + 1
-  { 32, 11, insert_ev4, extract_ev4, PPC_OPERAND_PARENS },
+  { 0x7c, 9, NULL, NULL, PPC_OPERAND_PARENS },
 
   /* The other UIMM field in a double EVX form instruction.  */
 #define EVUIMM_8 EVUIMM_4 + 1
-  { 32, 11, insert_ev8, extract_ev8, PPC_OPERAND_PARENS },
+  { 0xf8, 8, NULL, NULL, PPC_OPERAND_PARENS },
 
   /* The WS field.  */
 #define WS EVUIMM_8 + 1
-#define WS_MASK (0x7 << 11)
-  { 3, 11, NULL, NULL, 0 },
-
-  /* The L field in an mtmsrd or A form instruction.  */
-#define MTMSRD_L WS + 1
-#define A_L MTMSRD_L
-  { 1, 16, NULL, NULL, PPC_OPERAND_OPTIONAL },
-
-  /* The DCM field in a Z form instruction.  */
-#define DCM MTMSRD_L + 1
-  { 6, 16, NULL, NULL, 0 },
+  { 0x7, 11, NULL, NULL, 0 },
 
-  /* Likewise, the DGM field in a Z form instruction.  */
-#define DGM DCM + 1
-  { 6, 16, NULL, NULL, 0 },
+  /* The L field in an mtmsrd or A form instruction or W in an X form.  */
+#define A_L WS + 1
+#define W A_L
+  { 0x1, 16, NULL, NULL, PPC_OPERAND_OPTIONAL },
 
-#define TE DGM + 1
-  { 5, 11, NULL, NULL, 0 },
-
-#define RMC TE + 1
-  { 2, 21, NULL, NULL, 0 },
+#define RMC A_L + 1
+  { 0x3, 9, NULL, NULL, 0 },
 
 #define R RMC + 1
-  { 1, 15, NULL, NULL, 0 },
+  { 0x1, 16, NULL, NULL, 0 },
 
 #define SP R + 1
-  { 2, 11, NULL, NULL, 0 },
+  { 0x3, 19, NULL, NULL, 0 },
 
 #define S SP + 1
-  { 1, 11, NULL, NULL, 0 },
+  { 0x1, 20, NULL, NULL, 0 },
 
   /* SH field starting at bit position 16.  */
 #define SH16 S + 1
-  { 6, 10, NULL, NULL, 0 },
-
-  /* The L field in an X form with the RT field fixed instruction.  */
-#define XRT_L SH16 + 1
-  { 2, 21, NULL, NULL, PPC_OPERAND_OPTIONAL },
+  /* The DCM and DGM fields in a Z form instruction.  */
+#define DCM SH16
+#define DGM DCM
+  { 0x3f, 10, NULL, NULL, 0 },
 
   /* The EH field in larx instruction.  */
-#define EH XRT_L + 1
-  { 1, 0, NULL, NULL, PPC_OPERAND_OPTIONAL },
+#define EH SH16 + 1
+  { 0x1, 0, NULL, NULL, PPC_OPERAND_OPTIONAL },
+
+  /* The L field in an mtfsf or XFL form instruction.  */
+#define XFL_L EH + 1
+  { 0x1, 25, NULL, NULL, PPC_OPERAND_OPTIONAL},
 };
 
+const unsigned int num_powerpc_operands = (sizeof (powerpc_operands)
+					   / sizeof (powerpc_operands[0]));
+
 /* The functions used to insert and extract complicated operands.  */
 
 /* The BA field in an XL form instruction when it must be the same as
@@ -656,26 +607,6 @@ extract_bba (unsigned long insn,
   return 0;
 }
 
-/* The BD field in a B form instruction.  The lower two bits are
-   forced to zero.  */
-
-static unsigned long
-insert_bd (unsigned long insn,
-	   long value,
-	   int dialect ATTRIBUTE_UNUSED,
-	   const char **errmsg ATTRIBUTE_UNUSED)
-{
-  return insn | (value & 0xfffc);
-}
-
-static long
-extract_bd (unsigned long insn,
-	    int dialect ATTRIBUTE_UNUSED,
-	    int *invalid ATTRIBUTE_UNUSED)
-{
-  return ((insn & 0xfffc) ^ 0x8000) - 0x8000;
-}
-
 /* The BD field in a B form instruction when the - modifier is used.
    This modifier means that the branch is not expected to be taken.
    For chips built to versions of the architecture prior to version 2
@@ -687,7 +618,11 @@ extract_bd (unsigned long insn,
    the "y" bit.  "at" == 00 => no hint, "at" == 01 => unpredictable,
    "at" == 10 => not taken, "at" == 11 => taken.  The "t" bit is 00001
    in BO field, the "a" bit is 00010 for branch on CR(BI) and 01000
-   for branch on CTR.  We only handle the taken/not-taken hint here.  */
+   for branch on CTR.  We only handle the taken/not-taken hint here.
+   Note that we don't relax the conditions tested here when
+   disassembling with -Many because insns using extract_bdm and
+   extract_bdp always occur in pairs.  One or the other will always
+   be valid.  */
 
 static unsigned long
 insert_bdm (unsigned long insn,
@@ -778,10 +713,11 @@ extract_bdp (unsigned long insn,
 /* Check for legal values of a BO field.  */
 
 static int
-valid_bo (long value, int dialect)
+valid_bo (long value, int dialect, int extract)
 {
   if ((dialect & PPC_OPCODE_POWER4) == 0)
     {
+      int valid;
       /* Certain encodings have bits that are required to be zero.
 	 These are (z must be zero, y may be anything):
 	     001zy
@@ -794,36 +730,43 @@ valid_bo (long value, int dialect)
 	{
 	default:
 	case 0:
-	  return 1;
+	  valid = 1;
+	  break;
 	case 0x4:
-	  return (value & 0x2) == 0;
+	  valid = (value & 0x2) == 0;
+	  break;
 	case 0x10:
-	  return (value & 0x8) == 0;
+	  valid = (value & 0x8) == 0;
+	  break;
 	case 0x14:
-	  return value == 0x14;
+	  valid = value == 0x14;
+	  break;
 	}
+      /* When disassembling with -Many, accept power4 encodings too.  */
+      if (valid
+	  || (dialect & PPC_OPCODE_ANY) == 0
+	  || !extract)
+	return valid;
     }
+
+  /* Certain encodings have bits that are required to be zero.
+     These are (z must be zero, a & t may be anything):
+	 0000z
+	 0001z
+	 0100z
+	 0101z
+	 001at
+	 011at
+	 1a00t
+	 1a01t
+	 1z1zz
+  */
+  if ((value & 0x14) == 0)
+    return (value & 0x1) == 0;
+  else if ((value & 0x14) == 0x14)
+    return value == 0x14;
   else
-    {
-      /* Certain encodings have bits that are required to be zero.
-	 These are (z must be zero, a & t may be anything):
-	     0000z
-	     0001z
-	     0100z
-	     0101z
-	     001at
-	     011at
-	     1a00t
-	     1a01t
-	     1z1zz
-      */
-      if ((value & 0x14) == 0)
-	return (value & 0x1) == 0;
-      else if ((value & 0x14) == 0x14)
-	return value == 0x14;
-      else
-	return 1;
-    }
+    return 1;
 }
 
 /* The BO field in a B form instruction.  Warn about attempts to set
@@ -835,7 +778,7 @@ insert_bo (unsigned long insn,
 	   int dialect,
 	   const char **errmsg)
 {
-  if (!valid_bo (value, dialect))
+  if (!valid_bo (value, dialect, 0))
     *errmsg = _("invalid conditional option");
   return insn | ((value & 0x1f) << 21);
 }
@@ -848,7 +791,7 @@ extract_bo (unsigned long insn,
   long value;
 
   value = (insn >> 21) & 0x1f;
-  if (!valid_bo (value, dialect))
+  if (!valid_bo (value, dialect, 1))
     *invalid = 1;
   return value;
 }
@@ -863,7 +806,7 @@ insert_boe (unsigned long insn,
 	    int dialect,
 	    const char **errmsg)
 {
-  if (!valid_bo (value, dialect))
+  if (!valid_bo (value, dialect, 0))
     *errmsg = _("invalid conditional option");
   else if ((value & 1) != 0)
     *errmsg = _("attempt to set y bit when using + or - modifier");
@@ -879,162 +822,11 @@ extract_boe (unsigned long insn,
   long value;
 
   value = (insn >> 21) & 0x1f;
-  if (!valid_bo (value, dialect))
+  if (!valid_bo (value, dialect, 1))
     *invalid = 1;
   return value & 0x1e;
 }
 
-/* The DQ field in a DQ form instruction.  This is like D, but the
-   lower four bits are forced to zero. */
-
-static unsigned long
-insert_dq (unsigned long insn,
-	   long value,
-	   int dialect ATTRIBUTE_UNUSED,
-	   const char **errmsg)
-{
-  if ((value & 0xf) != 0)
-    *errmsg = _("offset not a multiple of 16");
-  return insn | (value & 0xfff0);
-}
-
-static long
-extract_dq (unsigned long insn,
-	    int dialect ATTRIBUTE_UNUSED,
-	    int *invalid ATTRIBUTE_UNUSED)
-{
-  return ((insn & 0xfff0) ^ 0x8000) - 0x8000;
-}
-
-static unsigned long
-insert_ev2 (unsigned long insn,
-	    long value,
-	    int dialect ATTRIBUTE_UNUSED,
-	    const char **errmsg)
-{
-  if ((value & 1) != 0)
-    *errmsg = _("offset not a multiple of 2");
-  if ((value > 62) != 0)
-    *errmsg = _("offset greater than 62");
-  return insn | ((value & 0x3e) << 10);
-}
-
-static long
-extract_ev2 (unsigned long insn,
-	     int dialect ATTRIBUTE_UNUSED,
-	     int *invalid ATTRIBUTE_UNUSED)
-{
-  return (insn >> 10) & 0x3e;
-}
-
-static unsigned long
-insert_ev4 (unsigned long insn,
-	    long value,
-	    int dialect ATTRIBUTE_UNUSED,
-	    const char **errmsg)
-{
-  if ((value & 3) != 0)
-    *errmsg = _("offset not a multiple of 4");
-  if ((value > 124) != 0)
-    *errmsg = _("offset greater than 124");
-  return insn | ((value & 0x7c) << 9);
-}
-
-static long
-extract_ev4 (unsigned long insn,
-	     int dialect ATTRIBUTE_UNUSED,
-	     int *invalid ATTRIBUTE_UNUSED)
-{
-  return (insn >> 9) & 0x7c;
-}
-
-static unsigned long
-insert_ev8 (unsigned long insn,
-	    long value,
-	    int dialect ATTRIBUTE_UNUSED,
-	    const char **errmsg)
-{
-  if ((value & 7) != 0)
-    *errmsg = _("offset not a multiple of 8");
-  if ((value > 248) != 0)
-    *errmsg = _("offset greater than 248");
-  return insn | ((value & 0xf8) << 8);
-}
-
-static long
-extract_ev8 (unsigned long insn,
-	     int dialect ATTRIBUTE_UNUSED,
-	     int *invalid ATTRIBUTE_UNUSED)
-{
-  return (insn >> 8) & 0xf8;
-}
-
-/* The DS field in a DS form instruction.  This is like D, but the
-   lower two bits are forced to zero.  */
-
-static unsigned long
-insert_ds (unsigned long insn,
-	   long value,
-	   int dialect ATTRIBUTE_UNUSED,
-	   const char **errmsg)
-{
-  if ((value & 3) != 0)
-    *errmsg = _("offset not a multiple of 4");
-  return insn | (value & 0xfffc);
-}
-
-static long
-extract_ds (unsigned long insn,
-	    int dialect ATTRIBUTE_UNUSED,
-	    int *invalid ATTRIBUTE_UNUSED)
-{
-  return ((insn & 0xfffc) ^ 0x8000) - 0x8000;
-}
-
-/* The DE field in a DE form instruction.  */
-
-static unsigned long
-insert_de (unsigned long insn,
-	   long value,
-	   int dialect ATTRIBUTE_UNUSED,
-	   const char **errmsg)
-{
-  if (value > 2047 || value < -2048)
-    *errmsg = _("offset not between -2048 and 2047");
-  return insn | ((value << 4) & 0xfff0);
-}
-
-static long
-extract_de (unsigned long insn,
-	    int dialect ATTRIBUTE_UNUSED,
-	    int *invalid ATTRIBUTE_UNUSED)
-{
-  return (insn & 0xfff0) >> 4;
-}
-
-/* The DES field in a DES form instruction.  */
-
-static unsigned long
-insert_des (unsigned long insn,
-	    long value,
-	    int dialect ATTRIBUTE_UNUSED,
-	    const char **errmsg)
-{
-  if (value > 8191 || value < -8192)
-    *errmsg = _("offset not between -8192 and 8191");
-  else if ((value & 3) != 0)
-    *errmsg = _("offset not a multiple of 4");
-  return insn | ((value << 2) & 0xfff0);
-}
-
-static long
-extract_des (unsigned long insn,
-	     int dialect ATTRIBUTE_UNUSED,
-	     int *invalid ATTRIBUTE_UNUSED)
-{
-  return (((insn >> 2) & 0x3ffc) ^ 0x2000) - 0x2000;
-}
-
 /* FXM mask in mfcr and mtcrf instructions.  */
 
 static unsigned long
@@ -1107,28 +899,6 @@ extract_fxm (unsigned long insn,
   return mask;
 }
 
-/* The LI field in an I form instruction.  The lower two bits are
-   forced to zero.  */
-
-static unsigned long
-insert_li (unsigned long insn,
-	   long value,
-	   int dialect ATTRIBUTE_UNUSED,
-	   const char **errmsg)
-{
-  if ((value & 3) != 0)
-    *errmsg = _("ignoring least significant bits in branch offset");
-  return insn | (value & 0x3fffffc);
-}
-
-static long
-extract_li (unsigned long insn,
-	    int dialect ATTRIBUTE_UNUSED,
-	    int *invalid ATTRIBUTE_UNUSED)
-{
-  return ((insn & 0x3fffffc) ^ 0x2000000) - 0x2000000;
-}
-
 /* The MB and ME fields in an M form instruction expressed as a single
    operand which is itself a bitmask.  The extraction function always
    marks it as invalid, since we never want to recognize an
@@ -1240,19 +1010,6 @@ extract_mb6 (unsigned long insn,
 /* The NB field in an X form instruction.  The value 32 is stored as
    0.  */
 
-static unsigned long
-insert_nb (unsigned long insn,
-	   long value,
-	   int dialect ATTRIBUTE_UNUSED,
-	   const char **errmsg)
-{
-  if (value < 0 || value > 32)
-    *errmsg = _("value out of range");
-  if (value == 32)
-    value = 0;
-  return insn | ((value & 0x1f) << 11);
-}
-
 static long
 extract_nb (unsigned long insn,
 	    int dialect ATTRIBUTE_UNUSED,
@@ -1375,34 +1132,6 @@ extract_rbs (unsigned long insn,
   return 0;
 }
 
-/* The RT field of the DQ form lq instruction, which has special
-   value restrictions.  */
-
-static unsigned long
-insert_rtq (unsigned long insn,
-	    long value,
-	    int dialect ATTRIBUTE_UNUSED,
-	    const char **errmsg)
-{
-  if ((value & 1) != 0)
-    *errmsg = _("target register operand must be even");
-  return insn | ((value & 0x1f) << 21);
-}
-
-/* The RS field of the DS form stq instruction, which has special
-   value restrictions.  */
-
-static unsigned long
-insert_rsq (unsigned long insn,
-	    long value ATTRIBUTE_UNUSED,
-	    int dialect ATTRIBUTE_UNUSED,
-	    const char **errmsg)
-{
-  if ((value & 1) != 0)
-    *errmsg = _("source register operand must be even");
-  return insn | ((value & 0x1f) << 21);
-}
-
 /* The SH field in an MD form instruction.  This is split.  */
 
 static unsigned long
@@ -1675,10 +1404,14 @@ extract_tbr (unsigned long insn,
 
 /* The mask for a Z form instruction.  */
 #define Z_MASK ZRC (0x3f, 0x1ff, 1)
+#define Z2_MASK ZRC (0x3f, 0xff, 1)
 
 /* An X_MASK with the RA field fixed.  */
 #define XRA_MASK (X_MASK | RA_MASK)
 
+/* An XRA_MASK with the W field clear.  */
+#define XWRA_MASK (XRA_MASK & ~((unsigned long) 1 << 16))
+
 /* An X_MASK with the RB field fixed.  */
 #define XRB_MASK (X_MASK | RB_MASK)
 
@@ -1733,7 +1466,7 @@ extract_tbr (unsigned long insn,
 
 /* An XFL form instruction.  */
 #define XFL(op, xop, rc) (OP (op) | ((((unsigned long)(xop)) & 0x3ff) << 1) | (((unsigned long)(rc)) & 1))
-#define XFL_MASK (XFL (0x3f, 0x3ff, 1) | (((unsigned long)1) << 25) | (((unsigned long)1) << 16))
+#define XFL_MASK XFL (0x3f, 0x3ff, 1)
 
 /* An X form isel instruction.  */
 #define XISEL(op, xop)  (OP (op) | ((((unsigned long)(xop)) & 0x1f) << 1))
@@ -1809,7 +1542,7 @@ extract_tbr (unsigned long insn,
 
 /* An XFX form instruction with the SPR field filled in except for the
    SPRG field.  */
-#define XSPRG_MASK (XSPR_MASK & ~(0x17 << 16))
+#define XSPRG_MASK (XSPR_MASK & ~(0x1f << 16))
 
 /* An X form instruction with everything filled in except the E field.  */
 #define XE_MASK (0xffff7fff)
@@ -3240,8 +2973,8 @@ const struct powerpc_opcode powerpc_opcodes[] = {
 { "bcctrl",  XLLK(19,528,1),     XLBH_MASK,   PPCCOM,	{ BO, BI, BH } },
 { "bcc",     XLLK(19,528,0),     XLBB_MASK,   PWRCOM,	{ BO, BI } },
 { "bccl",    XLLK(19,528,1),     XLBB_MASK,   PWRCOM,	{ BO, BI } },
-{ "bcctre",  XLLK(19,529,0),     XLYBB_MASK,  BOOKE64,	{ BO, BI } },
-{ "bcctrel", XLLK(19,529,1),     XLYBB_MASK,  BOOKE64,	{ BO, BI } },
+{ "bcctre",  XLLK(19,529,0),     XLBB_MASK,   BOOKE64,	{ BO, BI } },
+{ "bcctrel", XLLK(19,529,1),     XLBB_MASK,   BOOKE64,	{ BO, BI } },
 
 { "rlwimi",  M(20,0),	M_MASK,		PPCCOM,		{ RA,RS,SH,MBE,ME } },
 { "rlimi",   M(20,0),	M_MASK,		PWRCOM,		{ RA,RS,SH,MBE,ME } },
@@ -3486,7 +3219,7 @@ const struct powerpc_opcode powerpc_opcodes[] = {
 { "ldarx",   X(31,84),	XEH_MASK,	PPC64,		{ RT, RA0, RB, EH } },
 
 { "dcbfl",   XOPL(31,86,1), XRT_MASK,	POWER5,		{ RA, RB } },
-{ "dcbf",    X(31,86),	XLRT_MASK,	PPC,		{ RA, RB, XRT_L } },
+{ "dcbf",    X(31,86),	XLRT_MASK,	PPC,		{ RA, RB, L } },
 
 { "lbzx",    X(31,87),	X_MASK,		COM,		{ RT, RA0, RB } },
 
@@ -3575,7 +3308,7 @@ const struct powerpc_opcode powerpc_opcodes[] = {
 { "dcbtls",  X(31,166),	X_MASK,		PPCCHLK,	{ CT, RA, RB }},
 { "dcbtlse", X(31,174),	X_MASK,		PPCCHLK64,	{ CT, RA, RB }},
 
-{ "mtmsrd",  X(31,178),	XRLARB_MASK,	PPC64,		{ RS, MTMSRD_L } },
+{ "mtmsrd",  X(31,178),	XRLARB_MASK,	PPC64,		{ RS, A_L } },
 
 { "stdux",   X(31,181),	X_MASK,		PPC64,		{ RS, RAS, RB } },
 
@@ -4026,6 +3759,13 @@ const struct powerpc_opcode powerpc_opcodes[] = {
 
 { "sthuxe",  X(31,447),	X_MASK,		BOOKE64,	{ RS, RAS, RB } },
 
+{ "cctpl",   0x7c210b78,    0xffffffff,	CELL,		{ 0 }},
+{ "cctpm",   0x7c421378,    0xffffffff,	CELL,		{ 0 }},
+{ "cctph",   0x7c631b78,    0xffffffff,	CELL,		{ 0 }},
+{ "db8cyc",  0x7f9ce378,    0xffffffff,	CELL,		{ 0 }},
+{ "db10cyc", 0x7fbdeb78,    0xffffffff,	CELL,		{ 0 }},
+{ "db12cyc", 0x7fdef378,    0xffffffff,	CELL,		{ 0 }},
+{ "db16cyc", 0x7ffffb78,    0xffffffff,	CELL,		{ 0 }},
 { "mr",	     XRC(31,444,0), X_MASK,	COM,		{ RA, RS, RBS } },
 { "or",      XRC(31,444,0), X_MASK,	COM,		{ RA, RS, RB } },
 { "mr.",     XRC(31,444,1), X_MASK,	COM,		{ RA, RS, RBS } },
@@ -4446,8 +4186,8 @@ const struct powerpc_opcode powerpc_opcodes[] = {
 
 { "tlbsx",   XRC(31,914,0), X_MASK, 	PPC403|BOOKE,	{ RTO, RA, RB } },
 { "tlbsx.",  XRC(31,914,1), X_MASK, 	PPC403|BOOKE,	{ RTO, RA, RB } },
-{ "tlbsxe",  XRC(31,915,0), X_MASK,	BOOKE64,	{ RA, RB } },
-{ "tlbsxe.", XRC(31,915,1), X_MASK,	BOOKE64,	{ RA, RB } },
+{ "tlbsxe",  XRC(31,915,0), X_MASK,	BOOKE64,	{ RTO, RA, RB } },
+{ "tlbsxe.", XRC(31,915,1), X_MASK,	BOOKE64,	{ RTO, RA, RB } },
 
 { "slbmfee", X(31,915), XRA_MASK,	PPC64,		{ RT, RB } },
 
@@ -4624,8 +4364,8 @@ const struct powerpc_opcode powerpc_opcodes[] = {
 { "dadd",    XRC(59,2,0), X_MASK,	POWER6,		{ FRT, FRA, FRB } },
 { "dadd.",   XRC(59,2,1), X_MASK,	POWER6,		{ FRT, FRA, FRB } },
 
-{ "dqua",    ZRC(59,3,0), Z_MASK,	POWER6,		{ FRT, FRA, FRB, RMC } },
-{ "dqua.",   ZRC(59,3,1), Z_MASK,	POWER6,		{ FRT, FRA, FRB, RMC } },
+{ "dqua",    ZRC(59,3,0), Z2_MASK,	POWER6,		{ FRT, FRA, FRB, RMC } },
+{ "dqua.",   ZRC(59,3,1), Z2_MASK,	POWER6,		{ FRT, FRA, FRB, RMC } },
 
 { "fdivs",   A(59,18,0), AFRC_MASK,	PPC,		{ FRT, FRA, FRB } },
 { "fdivs.",  A(59,18,1), AFRC_MASK,	PPC,		{ FRT, FRA, FRB } },
@@ -4663,20 +4403,20 @@ const struct powerpc_opcode powerpc_opcodes[] = {
 { "dmul",    XRC(59,34,0), X_MASK,	POWER6,		{ FRT, FRA, FRB } },
 { "dmul.",   XRC(59,34,1), X_MASK,	POWER6,		{ FRT, FRA, FRB } },
 
-{ "drrnd",   ZRC(59,35,0), Z_MASK,	POWER6,		{ FRT, FRA, FRB, RMC } },
-{ "drrnd.",  ZRC(59,35,1), Z_MASK,	POWER6,		{ FRT, FRA, FRB, RMC } },
+{ "drrnd",   ZRC(59,35,0), Z2_MASK,	POWER6,		{ FRT, FRA, FRB, RMC } },
+{ "drrnd.",  ZRC(59,35,1), Z2_MASK,	POWER6,		{ FRT, FRA, FRB, RMC } },
 
 { "dscli",   ZRC(59,66,0), Z_MASK,	POWER6,		{ FRT, FRA, SH16 } },
 { "dscli.",  ZRC(59,66,1), Z_MASK,	POWER6,		{ FRT, FRA, SH16 } },
 
-{ "dquai",   ZRC(59,67,0), Z_MASK,	POWER6,		{ TE,  FRT, FRB, RMC } },
-{ "dquai.",  ZRC(59,67,1), Z_MASK,	POWER6,		{ TE,  FRT, FRB, RMC } },
+{ "dquai",   ZRC(59,67,0), Z2_MASK,	POWER6,		{ TE,  FRT, FRB, RMC } },
+{ "dquai.",  ZRC(59,67,1), Z2_MASK,	POWER6,		{ TE,  FRT, FRB, RMC } },
 
 { "dscri",   ZRC(59,98,0), Z_MASK,	POWER6,		{ FRT, FRA, SH16 } },
 { "dscri.",  ZRC(59,98,1), Z_MASK,	POWER6,		{ FRT, FRA, SH16 } },
 
-{ "drintx",  ZRC(59,99,0), Z_MASK,	POWER6,		{ R, FRT, FRB, RMC } },
-{ "drintx.", ZRC(59,99,1), Z_MASK,	POWER6,		{ R, FRT, FRB, RMC } },
+{ "drintx",  ZRC(59,99,0), Z2_MASK,	POWER6,		{ R, FRT, FRB, RMC } },
+{ "drintx.", ZRC(59,99,1), Z2_MASK,	POWER6,		{ R, FRT, FRB, RMC } },
 
 { "dcmpo",   X(59,130),	   X_MASK,	POWER6,		{ BF,  FRA, FRB } },
 
@@ -4684,8 +4424,8 @@ const struct powerpc_opcode powerpc_opcodes[] = {
 { "dtstdc",  Z(59,194),	   Z_MASK,	POWER6,		{ BF,  FRA, DCM } },
 { "dtstdg",  Z(59,226),	   Z_MASK,	POWER6,		{ BF,  FRA, DGM } },
 
-{ "drintn",  ZRC(59,227,0), Z_MASK,	POWER6,		{ R, FRT, FRB, RMC } },
-{ "drintn.", ZRC(59,227,1), Z_MASK,	POWER6,		{ R, FRT, FRB, RMC } },
+{ "drintn",  ZRC(59,227,0), Z2_MASK,	POWER6,		{ R, FRT, FRB, RMC } },
+{ "drintn.", ZRC(59,227,1), Z2_MASK,	POWER6,		{ R, FRT, FRB, RMC } },
 
 { "dctdp",   XRC(59,258,0), X_MASK,	POWER6,		{ FRT, FRB } },
 { "dctdp.",  XRC(59,258,1), X_MASK,	POWER6,		{ FRT, FRB } },
@@ -4751,8 +4491,8 @@ const struct powerpc_opcode powerpc_opcodes[] = {
 { "daddq",   XRC(63,2,0), X_MASK,	POWER6,		{ FRT, FRA, FRB } },
 { "daddq.",  XRC(63,2,1), X_MASK,	POWER6,		{ FRT, FRA, FRB } },
 
-{ "dquaq",   ZRC(63,3,0), Z_MASK,	POWER6,		{ FRT, FRA, FRB, RMC } },
-{ "dquaq.",  ZRC(63,3,1), Z_MASK,	POWER6,		{ FRT, FRA, FRB, RMC } },
+{ "dquaq",   ZRC(63,3,0), Z2_MASK,	POWER6,		{ FRT, FRA, FRB, RMC } },
+{ "dquaq.",  ZRC(63,3,1), Z2_MASK,	POWER6,		{ FRT, FRA, FRB, RMC } },
 
 { "fcpsgn",  XRC(63,8,0), X_MASK,	POWER6,		{ FRT, FRA, FRB } },
 { "fcpsgn.", XRC(63,8,1), X_MASK,	POWER6,		{ FRT, FRA, FRB } },
@@ -4827,8 +4567,8 @@ const struct powerpc_opcode powerpc_opcodes[] = {
 { "dmulq",   XRC(63,34,0), X_MASK,	POWER6,		{ FRT, FRA, FRB } },
 { "dmulq.",  XRC(63,34,1), X_MASK,	POWER6,		{ FRT, FRA, FRB } },
 
-{ "drrndq",  ZRC(63,35,0), Z_MASK,	POWER6,		{ FRT, FRA, FRB, RMC } },
-{ "drrndq.", ZRC(63,35,1), Z_MASK,	POWER6,		{ FRT, FRA, FRB, RMC } },
+{ "drrndq",  ZRC(63,35,0), Z2_MASK,	POWER6,		{ FRT, FRA, FRB, RMC } },
+{ "drrndq.", ZRC(63,35,1), Z2_MASK,	POWER6,		{ FRT, FRA, FRB, RMC } },
 
 { "mtfsb1",  XRC(63,38,0), XRARB_MASK,	COM,		{ BT } },
 { "mtfsb1.", XRC(63,38,1), XRARB_MASK,	COM,		{ BT } },
@@ -4841,8 +4581,8 @@ const struct powerpc_opcode powerpc_opcodes[] = {
 { "dscliq",  ZRC(63,66,0), Z_MASK,	POWER6,		{ FRT, FRA, SH16 } },
 { "dscliq.", ZRC(63,66,1), Z_MASK,	POWER6,		{ FRT, FRA, SH16 } },
 
-{ "dquaiq",  ZRC(63,67,0), Z_MASK,	POWER6,		{ TE,  FRT, FRB, RMC } },
-{ "dquaiq.", ZRC(63,67,1), Z_MASK,	POWER6,		{ FRT, FRA, FRB, RMC } },
+{ "dquaiq",  ZRC(63,67,0), Z2_MASK,	POWER6,		{ TE,  FRT, FRB, RMC } },
+{ "dquaiq.", ZRC(63,67,1), Z2_MASK,	POWER6,		{ FRT, FRA, FRB, RMC } },
 
 { "mtfsb0",  XRC(63,70,0), XRARB_MASK,	COM,		{ BT } },
 { "mtfsb0.", XRC(63,70,1), XRARB_MASK,	COM,		{ BT } },
@@ -4853,13 +4593,13 @@ const struct powerpc_opcode powerpc_opcodes[] = {
 { "dscriq",  ZRC(63,98,0), Z_MASK,	POWER6,		{ FRT, FRA, SH16 } },
 { "dscriq.", ZRC(63,98,1), Z_MASK,	POWER6,		{ FRT, FRA, SH16 } },
 
-{ "drintxq", ZRC(63,99,0), Z_MASK,	POWER6,		{ R, FRT, FRB, RMC } },
-{ "drintxq.",ZRC(63,99,1), Z_MASK,	POWER6,		{ R, FRT, FRB, RMC } },
+{ "drintxq", ZRC(63,99,0), Z2_MASK,	POWER6,		{ R, FRT, FRB, RMC } },
+{ "drintxq.",ZRC(63,99,1), Z2_MASK,	POWER6,		{ R, FRT, FRB, RMC } },
 
 { "dcmpoq",  X(63,130),	   X_MASK,	POWER6,		{ BF,  FRA, FRB } },
 
-{ "mtfsfi",  XRC(63,134,0), XRA_MASK|(3<<21)|(1<<11), COM, { BF, U } },
-{ "mtfsfi.", XRC(63,134,1), XRA_MASK|(3<<21)|(1<<11), COM, { BF, U } },
+{ "mtfsfi",  XRC(63,134,0), XWRA_MASK|(3<<21)|(1<<11), COM, { BFF, U, W } },
+{ "mtfsfi.", XRC(63,134,1), XWRA_MASK|(3<<21)|(1<<11), COM, { BFF, U, W } },
 
 { "fnabs",   XRC(63,136,0), XRA_MASK,	COM,		{ FRT, FRB } },
 { "fnabs.",  XRC(63,136,1), XRA_MASK,	COM,		{ FRT, FRB } },
@@ -4868,8 +4608,8 @@ const struct powerpc_opcode powerpc_opcodes[] = {
 { "dtstdcq", Z(63,194),	    Z_MASK,	POWER6,		{ BF,  FRA, DCM } },
 { "dtstdgq", Z(63,226),	    Z_MASK,	POWER6,		{ BF,  FRA, DGM } },
 
-{ "drintnq", ZRC(63,227,0), Z_MASK,	POWER6,		{ R, FRT, FRB, RMC } },
-{ "drintnq.",ZRC(63,227,1), Z_MASK,	POWER6,		{ R, FRT, FRB, RMC } },
+{ "drintnq", ZRC(63,227,0), Z2_MASK,	POWER6,		{ R, FRT, FRB, RMC } },
+{ "drintnq.",ZRC(63,227,1), Z2_MASK,	POWER6,		{ R, FRT, FRB, RMC } },
 
 { "dctqpq",  XRC(63,258,0), X_MASK,	POWER6,		{ FRT, FRB } },
 { "dctqpq.", XRC(63,258,1), X_MASK,	POWER6,		{ FRT, FRB } },
@@ -4908,8 +4648,8 @@ const struct powerpc_opcode powerpc_opcodes[] = {
 
 { "dtstsfq", X(63,674),	    X_MASK,	POWER6,		{ BF,  FRA, FRB } },
 
-{ "mtfsf",   XFL(63,711,0), XFL_MASK,	COM,		{ FLM, FRB } },
-{ "mtfsf.",  XFL(63,711,1), XFL_MASK,	COM,		{ FLM, FRB } },
+{ "mtfsf",   XFL(63,711,0), XFL_MASK,	COM,		{ FLM, FRB, XFL_L, W } },
+{ "mtfsf.",  XFL(63,711,1), XFL_MASK,	COM,		{ FLM, FRB, XFL_L, W } },
 
 { "drdpq",   XRC(63,770,0), X_MASK,	POWER6,		{ FRT, FRB } },
 { "drdpq.",  XRC(63,770,1), X_MASK,	POWER6,		{ FRT, FRB } },
@@ -4934,7 +4674,8 @@ const struct powerpc_opcode powerpc_opcodes[] = {
 
 };
 
-const int powerpc_num_opcodes = ARRAY_SIZE(powerpc_opcodes);
+const int powerpc_num_opcodes =
+  sizeof (powerpc_opcodes) / sizeof (powerpc_opcodes[0]);
 
 /* The macro table.  This is only used by the assembler.  */
 
@@ -4990,4 +4731,5 @@ const struct powerpc_macro powerpc_macros[] = {
 { "clrlslwi.",4,  PPCCOM,	"rlwinm. %0,%1,%3,(%2)-(%3),31-(%3)" },
 };
 
-const int powerpc_num_macros = ARRAY_SIZE(powerpc_macros);
+const int powerpc_num_macros =
+  sizeof (powerpc_macros) / sizeof (powerpc_macros[0]);
diff --git a/arch/powerpc/xmon/ppc.h b/arch/powerpc/xmon/ppc.h
index 110df96..6771856 100644
--- a/arch/powerpc/xmon/ppc.h
+++ b/arch/powerpc/xmon/ppc.h
@@ -1,6 +1,6 @@
 /* ppc.h -- Header file for PowerPC opcode table
-   Copyright 1994, 1995, 1999, 2000, 2001, 2002, 2003, 2004, 2005, 2006
-   Free Software Foundation, Inc.
+   Copyright 1994, 1995, 1999, 2000, 2001, 2002, 2003, 2004, 2005, 2006,
+   2007 Free Software Foundation, Inc.
    Written by Ian Lance Taylor, Cygnus Support
 
 This file is part of GDB, GAS, and the GNU binutils.
@@ -153,20 +153,21 @@ extern const int powerpc_num_opcodes;
 
 struct powerpc_operand
 {
-  /* The number of bits in the operand.  */
-  int bits;
+  /* A bitmask of bits in the operand.  */
+  unsigned int bitm;
 
-  /* How far the operand is left shifted in the instruction.  */
+  /* How far the operand is left shifted in the instruction.
+     -1 to indicate that BITM and SHIFT cannot be used to determine
+     where the operand goes in the insn.  */
   int shift;
 
   /* Insertion function.  This is used by the assembler.  To insert an
      operand value into an instruction, check this field.
 
      If it is NULL, execute
-         i |= (op & ((1 << o->bits) - 1)) << o->shift;
+	 i |= (op & o->bitm) << o->shift;
      (i is the instruction which we are filling in, o is a pointer to
-     this structure, and op is the opcode value; this assumes twos
-     complement arithmetic).
+     this structure, and op is the operand value).
 
      If this field is not NULL, then simply call it with the
      instruction and the operand value.  It will return the new value
@@ -182,12 +183,11 @@ struct powerpc_operand
      extract this operand type from an instruction, check this field.
 
      If it is NULL, compute
-         op = ((i) >> o->shift) & ((1 << o->bits) - 1);
-	 if ((o->flags & PPC_OPERAND_SIGNED) != 0
-	     && (op & (1 << (o->bits - 1))) != 0)
-	   op -= 1 << o->bits;
+	 op = (i >> o->shift) & o->bitm;
+	 if ((o->flags & PPC_OPERAND_SIGNED) != 0)
+	   sign_extend (op);
      (i is the instruction, o is a pointer to this structure, and op
-     is the result; this assumes twos complement arithmetic).
+     is the result).
 
      If this field is not NULL, then simply call it with the
      instruction value.  It will return the value of the operand.  If
@@ -205,17 +205,18 @@ struct powerpc_operand
    the operands field of the powerpc_opcodes table.  */
 
 extern const struct powerpc_operand powerpc_operands[];
+extern const unsigned int num_powerpc_operands;
 
 /* Values defined for the flags field of a struct powerpc_operand.  */
 
 /* This operand takes signed values.  */
-#define PPC_OPERAND_SIGNED (01)
+#define PPC_OPERAND_SIGNED (0x1)
 
 /* This operand takes signed values, but also accepts a full positive
    range of values when running in 32 bit mode.  That is, if bits is
    16, it takes any value from -0x8000 to 0xffff.  In 64 bit mode,
    this flag is ignored.  */
-#define PPC_OPERAND_SIGNOPT (02)
+#define PPC_OPERAND_SIGNOPT (0x2)
 
 /* This operand does not actually exist in the assembler input.  This
    is used to support extended mnemonics such as mr, for which two
@@ -223,14 +224,14 @@ extern const struct powerpc_operand powerpc_operands[];
    insert function with any op value.  The disassembler should call
    the extract function, ignore the return value, and check the value
    placed in the valid argument.  */
-#define PPC_OPERAND_FAKE (04)
+#define PPC_OPERAND_FAKE (0x4)
 
 /* The next operand should be wrapped in parentheses rather than
    separated from this one by a comma.  This is used for the load and
    store instructions which want their operands to look like
        reg,displacement(reg)
    */
-#define PPC_OPERAND_PARENS (010)
+#define PPC_OPERAND_PARENS (0x8)
 
 /* This operand may use the symbolic names for the CR fields, which
    are
@@ -239,26 +240,26 @@ extern const struct powerpc_operand powerpc_operands[];
        cr4 4	cr5 5	cr6 6	cr7 7
    These may be combined arithmetically, as in cr2*4+gt.  These are
    only supported on the PowerPC, not the POWER.  */
-#define PPC_OPERAND_CR (020)
+#define PPC_OPERAND_CR (0x10)
 
 /* This operand names a register.  The disassembler uses this to print
    register names with a leading 'r'.  */
-#define PPC_OPERAND_GPR (040)
+#define PPC_OPERAND_GPR (0x20)
 
 /* Like PPC_OPERAND_GPR, but don't print a leading 'r' for r0.  */
-#define PPC_OPERAND_GPR_0 (0100)
+#define PPC_OPERAND_GPR_0 (0x40)
 
 /* This operand names a floating point register.  The disassembler
    prints these with a leading 'f'.  */
-#define PPC_OPERAND_FPR (0200)
+#define PPC_OPERAND_FPR (0x80)
 
 /* This operand is a relative branch displacement.  The disassembler
    prints these symbolically if possible.  */
-#define PPC_OPERAND_RELATIVE (0400)
+#define PPC_OPERAND_RELATIVE (0x100)
 
 /* This operand is an absolute branch address.  The disassembler
    prints these symbolically if possible.  */
-#define PPC_OPERAND_ABSOLUTE (01000)
+#define PPC_OPERAND_ABSOLUTE (0x200)
 
 /* This operand is optional, and is zero if omitted.  This is used for
    example, in the optional BF field in the comparison instructions.  The
@@ -266,7 +267,7 @@ extern const struct powerpc_operand powerpc_operands[];
    and the number of operands remaining for the opcode, and decide
    whether this operand is present or not.  The disassembler should
    print this operand out only if it is not zero.  */
-#define PPC_OPERAND_OPTIONAL (02000)
+#define PPC_OPERAND_OPTIONAL (0x400)
 
 /* This flag is only used with PPC_OPERAND_OPTIONAL.  If this operand
    is omitted, then for the next operand use this operand value plus
@@ -274,24 +275,27 @@ extern const struct powerpc_operand powerpc_operands[];
    hack is needed because the Power rotate instructions can take
    either 4 or 5 operands.  The disassembler should print this operand
    out regardless of the PPC_OPERAND_OPTIONAL field.  */
-#define PPC_OPERAND_NEXT (04000)
+#define PPC_OPERAND_NEXT (0x800)
 
 /* This operand should be regarded as a negative number for the
    purposes of overflow checking (i.e., the normal most negative
    number is disallowed and one more than the normal most positive
    number is allowed).  This flag will only be set for a signed
    operand.  */
-#define PPC_OPERAND_NEGATIVE (010000)
+#define PPC_OPERAND_NEGATIVE (0x1000)
 
 /* This operand names a vector unit register.  The disassembler
    prints these with a leading 'v'.  */
-#define PPC_OPERAND_VR (020000)
+#define PPC_OPERAND_VR (0x2000)
 
 /* This operand is for the DS field in a DS form instruction.  */
-#define PPC_OPERAND_DS (040000)
+#define PPC_OPERAND_DS (0x4000)
 
 /* This operand is for the DQ field in a DQ form instruction.  */
-#define PPC_OPERAND_DQ (0100000)
+#define PPC_OPERAND_DQ (0x8000)
+
+/* Valid range of operand is 0..n rather than 0..n-1.  */
+#define PPC_OPERAND_PLUS1 (0x10000)
 
 /* The POWER and PowerPC assemblers use a few macros.  We keep them
    with the operands table for simplicity.  The macro table is an
-- 
2.9.3
