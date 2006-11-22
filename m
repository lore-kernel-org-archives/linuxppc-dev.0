Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Wed, 22 Nov 2006 18:55:35 +1100
Subject: [PATCH 9/9] Import updated version of ppc disassembly code for xmon
In-Reply-To: <1164182122.302443.256192350213.qpush@cradle>
Message-Id: <20061122075540.D4F2167CCC@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd.bergmann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This includes:
 * version 1.24 of ppc-dis.c
 * version 1.88 of ppc-opc.c
 * version 1.23 of ppc.h

I can't vouch for the accuracy etc. of these changes, but it brings
us into line with binutils - and from a cursory test appears to work
fine.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/xmon/ppc-dis.c |   20 -
 arch/powerpc/xmon/ppc-opc.c |  778 ++++++++++++++++++++++++++++++++------------
 arch/powerpc/xmon/ppc.h     |   39 +-
 3 files changed, 618 insertions(+), 219 deletions(-)

Index: cell/arch/powerpc/xmon/ppc-dis.c
===================================================================
--- cell.orig/arch/powerpc/xmon/ppc-dis.c
+++ cell/arch/powerpc/xmon/ppc-dis.c
@@ -1,5 +1,6 @@
 /* ppc-dis.c -- Disassemble PowerPC instructions
-   Copyright 1994 Free Software Foundation, Inc.
+   Copyright 1994, 1995, 2000, 2001, 2002, 2003, 2004, 2005, 2006
+   Free Software Foundation, Inc.
    Written by Ian Lance Taylor, Cygnus Support
 
 This file is part of GDB, GAS, and the GNU binutils.
@@ -16,8 +17,9 @@ the GNU General Public License for more 
 
 You should have received a copy of the GNU General Public License
 along with this file; see the file COPYING.  If not, write to the Free
-Software Foundation, 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.  */
+Software Foundation, 51 Franklin Street - Fifth Floor, Boston, MA 02110-1301, USA.  */
 
+#include <asm/cputable.h>
 #include "nonstdio.h"
 #include "ansidecl.h"
 #include "ppc.h"
@@ -36,6 +38,15 @@ print_insn_powerpc (unsigned long insn, 
   dialect = PPC_OPCODE_PPC | PPC_OPCODE_CLASSIC | PPC_OPCODE_COMMON
 	      | PPC_OPCODE_64 | PPC_OPCODE_POWER4 | PPC_OPCODE_ALTIVEC;
 
+  if (cpu_has_feature(CPU_FTRS_POWER5))
+    dialect |= PPC_OPCODE_POWER5;
+
+  if (cpu_has_feature(CPU_FTRS_CELL))
+    dialect |= PPC_OPCODE_CELL | PPC_OPCODE_ALTIVEC;
+
+  if (cpu_has_feature(CPU_FTRS_POWER6))
+    dialect |= PPC_OPCODE_POWER5 | PPC_OPCODE_POWER6 | PPC_OPCODE_ALTIVEC;
+
   /* Get the major opcode of the instruction.  */
   op = PPC_OP (insn);
 
@@ -120,7 +131,8 @@ print_insn_powerpc (unsigned long insn, 
 	    }
 
 	  /* Print the operand as directed by the flags.  */
-	  if ((operand->flags & PPC_OPERAND_GPR) != 0)
+	  if ((operand->flags & PPC_OPERAND_GPR) != 0
+	      || ((operand->flags & PPC_OPERAND_GPR_0) != 0 && value != 0))
 	    printf("r%ld", value);
 	  else if ((operand->flags & PPC_OPERAND_FPR) != 0)
 	    printf("f%ld", value);
@@ -136,7 +148,7 @@ print_insn_powerpc (unsigned long insn, 
 	  else
 	    {
 	      if (operand->bits == 3)
-		printf("cr%d", value);
+		printf("cr%ld", value);
 	      else
 		{
 		  static const char *cbnames[4] = { "lt", "gt", "eq", "so" };
Index: cell/arch/powerpc/xmon/ppc-opc.c
===================================================================
--- cell.orig/arch/powerpc/xmon/ppc-opc.c
+++ cell/arch/powerpc/xmon/ppc-opc.c
@@ -1,6 +1,6 @@
 /* ppc-opc.c -- PowerPC opcode list
-   Copyright 1994, 1995, 1996, 1997, 1998, 2000, 2001, 2002, 2003
-   Free Software Foundation, Inc.
+   Copyright 1994, 1995, 1996, 1997, 1998, 2000, 2001, 2002, 2003, 2004,
+   2005 Free Software Foundation, Inc.
    Written by Ian Lance Taylor, Cygnus Support
 
    This file is part of GDB, GAS, and the GNU binutils.
@@ -17,8 +17,8 @@
 
    You should have received a copy of the GNU General Public License
    along with this file; see the file COPYING.  If not, write to the Free
-   Software Foundation, 59 Temple Place - Suite 330, Boston, MA
-   02111-1307, USA.  */
+   Software Foundation, 51 Franklin Street - Fifth Floor, Boston, MA
+   02110-1301, USA.  */
 
 #include <linux/stddef.h>
 #include "nonstdio.h"
@@ -86,6 +86,8 @@ static unsigned long insert_sh6 (unsigne
 static long extract_sh6 (unsigned long, int, int *);
 static unsigned long insert_spr (unsigned long, long, int, const char **);
 static long extract_spr (unsigned long, int, int *);
+static unsigned long insert_sprg (unsigned long, long, int, const char **);
+static long extract_sprg (unsigned long, int, int *);
 static unsigned long insert_tbr (unsigned long, long, int, const char **);
 static long extract_tbr (unsigned long, int, int *);
 static unsigned long insert_ev2 (unsigned long, long, int, const char **);
@@ -196,8 +198,11 @@ const struct powerpc_operand powerpc_ope
 #define BOE BO + 1
   { 5, 21, insert_boe, extract_boe, 0 },
 
+#define BH BOE + 1
+  { 2, 11, NULL, NULL, PPC_OPERAND_OPTIONAL },
+
   /* The BT field in an X or XL form instruction.  */
-#define BT BOE + 1
+#define BT BH + 1
   { 5, 21, NULL, NULL, PPC_OPERAND_CR },
 
   /* The condition register number portion of the BI field in a B form
@@ -301,10 +306,14 @@ const struct powerpc_operand powerpc_ope
 #define L FXM4 + 1
   { 1, 21, NULL, NULL, PPC_OPERAND_OPTIONAL },
 
-  /* The LEV field in a POWER SC form instruction.  */
-#define LEV L + 1
+  /* The LEV field in a POWER SVC form instruction.  */
+#define SVC_LEV L + 1
   { 7, 5, NULL, NULL, 0 },
 
+  /* The LEV field in an SC form instruction.  */
+#define LEV SVC_LEV + 1
+  { 7, 5, NULL, NULL, PPC_OPERAND_OPTIONAL },
+
   /* The LI field in an I form instruction.  The lower two bits are
      forced to zero.  */
 #define LI LEV + 1
@@ -346,7 +355,7 @@ const struct powerpc_operand powerpc_ope
 
   /* The MO field in an mbar instruction.  */
 #define MO MB6 + 1
-  { 5, 21, NULL, NULL, 0 },
+  { 5, 21, NULL, NULL, PPC_OPERAND_OPTIONAL },
 
   /* The NB field in an X form instruction.  The value 32 is stored as
      0.  */
@@ -364,30 +373,38 @@ const struct powerpc_operand powerpc_ope
 #define RA_MASK (0x1f << 16)
   { 5, 16, NULL, NULL, PPC_OPERAND_GPR },
 
+  /* As above, but 0 in the RA field means zero, not r0.  */
+#define RA0 RA + 1
+  { 5, 16, NULL, NULL, PPC_OPERAND_GPR_0 },
+
   /* The RA field in the DQ form lq instruction, which has special
      value restrictions.  */
-#define RAQ RA + 1
-  { 5, 16, insert_raq, NULL, PPC_OPERAND_GPR },
+#define RAQ RA0 + 1
+  { 5, 16, insert_raq, NULL, PPC_OPERAND_GPR_0 },
 
   /* The RA field in a D or X form instruction which is an updating
      load, which means that the RA field may not be zero and may not
      equal the RT field.  */
 #define RAL RAQ + 1
-  { 5, 16, insert_ral, NULL, PPC_OPERAND_GPR },
+  { 5, 16, insert_ral, NULL, PPC_OPERAND_GPR_0 },
 
   /* The RA field in an lmw instruction, which has special value
      restrictions.  */
 #define RAM RAL + 1
-  { 5, 16, insert_ram, NULL, PPC_OPERAND_GPR },
+  { 5, 16, insert_ram, NULL, PPC_OPERAND_GPR_0 },
 
   /* The RA field in a D or X form instruction which is an updating
      store or an updating floating point load, which means that the RA
      field may not be zero.  */
 #define RAS RAM + 1
-  { 5, 16, insert_ras, NULL, PPC_OPERAND_GPR },
+  { 5, 16, insert_ras, NULL, PPC_OPERAND_GPR_0 },
+
+  /* The RA field of the tlbwe instruction, which is optional.  */
+#define RAOPT RAS + 1
+  { 5, 16, NULL, NULL, PPC_OPERAND_GPR | PPC_OPERAND_OPTIONAL },
 
   /* The RB field in an X, XO, M, or MDS form instruction.  */
-#define RB RAS + 1
+#define RB RAOPT + 1
 #define RB_MASK (0x1f << 11)
   { 5, 11, NULL, NULL, PPC_OPERAND_GPR },
 
@@ -408,15 +425,20 @@ const struct powerpc_operand powerpc_ope
   /* The RS field of the DS form stq instruction, which has special
      value restrictions.  */
 #define RSQ RS + 1
-  { 5, 21, insert_rsq, NULL, PPC_OPERAND_GPR },
+  { 5, 21, insert_rsq, NULL, PPC_OPERAND_GPR_0 },
 
   /* The RT field of the DQ form lq instruction, which has special
      value restrictions.  */
 #define RTQ RSQ + 1
-  { 5, 21, insert_rtq, NULL, PPC_OPERAND_GPR },
+  { 5, 21, insert_rtq, NULL, PPC_OPERAND_GPR_0 },
+
+  /* The RS field of the tlbwe instruction, which is optional.  */
+#define RSO RTQ + 1
+#define RTO RSO
+  { 5, 21, NULL, NULL, PPC_OPERAND_GPR | PPC_OPERAND_OPTIONAL },
 
   /* The SH field in an X or M form instruction.  */
-#define SH RTQ + 1
+#define SH RSO + 1
 #define SH_MASK (0x1f << 11)
   { 5, 11, NULL, NULL, 0 },
 
@@ -425,8 +447,12 @@ const struct powerpc_operand powerpc_ope
 #define SH6_MASK ((0x1f << 11) | (1 << 1))
   { 6, 1, insert_sh6, extract_sh6, 0 },
 
+  /* The SH field of the tlbwe instruction, which is optional.  */
+#define SHO SH6 + 1
+  { 5, 11,NULL, NULL, PPC_OPERAND_OPTIONAL },
+
   /* The SI field in a D form instruction.  */
-#define SI SH6 + 1
+#define SI SHO + 1
   { 16, 0, NULL, NULL, PPC_OPERAND_SIGNED },
 
   /* The SI field in a D form instruction when we accept a wide range
@@ -448,8 +474,7 @@ const struct powerpc_operand powerpc_ope
 
   /* The SPRG register number in an XFX form m[ft]sprg instruction.  */
 #define SPRG SPRBAT + 1
-#define SPRG_MASK (0x3 << 16)
-  { 2, 16, NULL, NULL, 0 },
+  { 5, 16, insert_sprg, extract_sprg, 0 },
 
   /* The SR field in an X form instruction.  */
 #define SR SPRG + 1
@@ -536,10 +561,45 @@ const struct powerpc_operand powerpc_ope
 #define WS_MASK (0x7 << 11)
   { 3, 11, NULL, NULL, 0 },
 
-  /* The L field in an mtmsrd instruction */
+  /* The L field in an mtmsrd or A form instruction.  */
 #define MTMSRD_L WS + 1
+#define A_L MTMSRD_L
   { 1, 16, NULL, NULL, PPC_OPERAND_OPTIONAL },
 
+  /* The DCM field in a Z form instruction.  */
+#define DCM MTMSRD_L + 1
+  { 6, 16, NULL, NULL, 0 },
+
+  /* Likewise, the DGM field in a Z form instruction.  */
+#define DGM DCM + 1
+  { 6, 16, NULL, NULL, 0 },
+
+#define TE DGM + 1
+  { 5, 11, NULL, NULL, 0 },
+
+#define RMC TE + 1
+  { 2, 21, NULL, NULL, 0 },
+
+#define R RMC + 1
+  { 1, 15, NULL, NULL, 0 },
+
+#define SP R + 1
+  { 2, 11, NULL, NULL, 0 },
+
+#define S SP + 1
+  { 1, 11, NULL, NULL, 0 },
+
+  /* SH field starting at bit position 16.  */
+#define SH16 S + 1
+  { 6, 10, NULL, NULL, 0 },
+
+  /* The L field in an X form with the RT field fixed instruction.  */
+#define XRT_L SH16 + 1
+  { 2, 21, NULL, NULL, PPC_OPERAND_OPTIONAL },
+
+  /* The EH field in larx instruction.  */
+#define EH XRT_L + 1
+  { 1, 0, NULL, NULL, PPC_OPERAND_OPTIONAL },
 };
 
 /* The functions used to insert and extract complicated operands.  */
@@ -550,7 +610,6 @@ const struct powerpc_operand powerpc_ope
    and the extraction function just checks that the fields are the
    same.  */
 
-/*ARGSUSED*/
 static unsigned long
 insert_bat (unsigned long insn,
 	    long value ATTRIBUTE_UNUSED,
@@ -576,7 +635,6 @@ extract_bat (unsigned long insn,
    and the extraction function just checks that the fields are the
    same.  */
 
-/*ARGSUSED*/
 static unsigned long
 insert_bba (unsigned long insn,
 	    long value ATTRIBUTE_UNUSED,
@@ -599,7 +657,6 @@ extract_bba (unsigned long insn,
 /* The BD field in a B form instruction.  The lower two bits are
    forced to zero.  */
 
-/*ARGSUSED*/
 static unsigned long
 insert_bd (unsigned long insn,
 	   long value,
@@ -609,7 +666,6 @@ insert_bd (unsigned long insn,
   return insn | (value & 0xfffc);
 }
 
-/*ARGSUSED*/
 static long
 extract_bd (unsigned long insn,
 	    int dialect ATTRIBUTE_UNUSED,
@@ -631,7 +687,6 @@ extract_bd (unsigned long insn,
    in BO field, the "a" bit is 00010 for branch on CR(BI) and 01000
    for branch on CTR.  We only handle the taken/not-taken hint here.  */
 
-/*ARGSUSED*/
 static unsigned long
 insert_bdm (unsigned long insn,
 	    long value,
@@ -677,7 +732,6 @@ extract_bdm (unsigned long insn,
    This is like BDM, above, except that the branch is expected to be
    taken.  */
 
-/*ARGSUSED*/
 static unsigned long
 insert_bdp (unsigned long insn,
 	    long value,
@@ -831,7 +885,6 @@ extract_boe (unsigned long insn,
 /* The DQ field in a DQ form instruction.  This is like D, but the
    lower four bits are forced to zero. */
 
-/*ARGSUSED*/
 static unsigned long
 insert_dq (unsigned long insn,
 	   long value,
@@ -843,7 +896,6 @@ insert_dq (unsigned long insn,
   return insn | (value & 0xfff0);
 }
 
-/*ARGSUSED*/
 static long
 extract_dq (unsigned long insn,
 	    int dialect ATTRIBUTE_UNUSED,
@@ -918,7 +970,6 @@ extract_ev8 (unsigned long insn,
 /* The DS field in a DS form instruction.  This is like D, but the
    lower two bits are forced to zero.  */
 
-/*ARGSUSED*/
 static unsigned long
 insert_ds (unsigned long insn,
 	   long value,
@@ -930,7 +981,6 @@ insert_ds (unsigned long insn,
   return insn | (value & 0xfffc);
 }
 
-/*ARGSUSED*/
 static long
 extract_ds (unsigned long insn,
 	    int dialect ATTRIBUTE_UNUSED,
@@ -941,7 +991,6 @@ extract_ds (unsigned long insn,
 
 /* The DE field in a DE form instruction.  */
 
-/*ARGSUSED*/
 static unsigned long
 insert_de (unsigned long insn,
 	   long value,
@@ -953,7 +1002,6 @@ insert_de (unsigned long insn,
   return insn | ((value << 4) & 0xfff0);
 }
 
-/*ARGSUSED*/
 static long
 extract_de (unsigned long insn,
 	    int dialect ATTRIBUTE_UNUSED,
@@ -964,7 +1012,6 @@ extract_de (unsigned long insn,
 
 /* The DES field in a DES form instruction.  */
 
-/*ARGSUSED*/
 static unsigned long
 insert_des (unsigned long insn,
 	    long value,
@@ -978,7 +1025,6 @@ insert_des (unsigned long insn,
   return insn | ((value << 2) & 0xfff0);
 }
 
-/*ARGSUSED*/
 static long
 extract_des (unsigned long insn,
 	     int dialect ATTRIBUTE_UNUSED,
@@ -995,17 +1041,33 @@ insert_fxm (unsigned long insn,
 	    int dialect,
 	    const char **errmsg)
 {
+  /* If we're handling the mfocrf and mtocrf insns ensure that exactly
+     one bit of the mask field is set.  */
+  if ((insn & (1 << 20)) != 0)
+    {
+      if (value == 0 || (value & -value) != value)
+	{
+	  *errmsg = _("invalid mask field");
+	  value = 0;
+	}
+    }
+
   /* If the optional field on mfcr is missing that means we want to use
      the old form of the instruction that moves the whole cr.  In that
      case we'll have VALUE zero.  There doesn't seem to be a way to
      distinguish this from the case where someone writes mfcr %r3,0.  */
-  if (value == 0)
+  else if (value == 0)
     ;
 
   /* If only one bit of the FXM field is set, we can use the new form
      of the instruction, which is faster.  Unlike the Power4 branch hint
-     encoding, this is not backward compatible.  */
-  else if ((dialect & PPC_OPCODE_POWER4) != 0 && (value & -value) == value)
+     encoding, this is not backward compatible.  Do not generate the
+     new form unless -mpower4 has been given, or -many and the two
+     operand form of mfcr was used.  */
+  else if ((value & -value) == value
+	   && ((dialect & PPC_OPCODE_POWER4) != 0
+	       || ((dialect & PPC_OPCODE_ANY) != 0
+		   && (insn & (0x3ff << 1)) == 19 << 1)))
     insn |= 1 << 20;
 
   /* Any other value on mfcr is an error.  */
@@ -1020,7 +1082,7 @@ insert_fxm (unsigned long insn,
 
 static long
 extract_fxm (unsigned long insn,
-	     int dialect,
+	     int dialect ATTRIBUTE_UNUSED,
 	     int *invalid)
 {
   long mask = (insn >> 12) & 0xff;
@@ -1028,14 +1090,9 @@ extract_fxm (unsigned long insn,
   /* Is this a Power4 insn?  */
   if ((insn & (1 << 20)) != 0)
     {
-      if ((dialect & PPC_OPCODE_POWER4) == 0)
+      /* Exactly one bit of MASK should be set.  */
+      if (mask == 0 || (mask & -mask) != mask)
 	*invalid = 1;
-      else
-	{
-	  /* Exactly one bit of MASK should be set.  */
-	  if (mask == 0 || (mask & -mask) != mask)
-	    *invalid = 1;
-	}
     }
 
   /* Check that non-power4 form of mfcr has a zero MASK.  */
@@ -1051,7 +1108,6 @@ extract_fxm (unsigned long insn,
 /* The LI field in an I form instruction.  The lower two bits are
    forced to zero.  */
 
-/*ARGSUSED*/
 static unsigned long
 insert_li (unsigned long insn,
 	   long value,
@@ -1063,7 +1119,6 @@ insert_li (unsigned long insn,
   return insn | (value & 0x3fffffc);
 }
 
-/*ARGSUSED*/
 static long
 extract_li (unsigned long insn,
 	    int dialect ATTRIBUTE_UNUSED,
@@ -1163,7 +1218,6 @@ extract_mbe (unsigned long insn,
 /* The MB or ME field in an MD or MDS form instruction.  The high bit
    is wrapped to the low end.  */
 
-/*ARGSUSED*/
 static unsigned long
 insert_mb6 (unsigned long insn,
 	    long value,
@@ -1173,7 +1227,6 @@ insert_mb6 (unsigned long insn,
   return insn | ((value & 0x1f) << 6) | (value & 0x20);
 }
 
-/*ARGSUSED*/
 static long
 extract_mb6 (unsigned long insn,
 	     int dialect ATTRIBUTE_UNUSED,
@@ -1198,7 +1251,6 @@ insert_nb (unsigned long insn,
   return insn | ((value & 0x1f) << 11);
 }
 
-/*ARGSUSED*/
 static long
 extract_nb (unsigned long insn,
 	    int dialect ATTRIBUTE_UNUSED,
@@ -1217,7 +1269,6 @@ extract_nb (unsigned long insn,
    invalid, since we never want to recognize an instruction which uses
    a field of this type.  */
 
-/*ARGSUSED*/
 static unsigned long
 insert_nsi (unsigned long insn,
 	    long value,
@@ -1269,7 +1320,6 @@ insert_ram (unsigned long insn,
 /* The RA field in the DQ form lq instruction, which has special
    value restrictions.  */
 
-/*ARGSUSED*/
 static unsigned long
 insert_raq (unsigned long insn,
 	    long value,
@@ -1304,7 +1354,6 @@ insert_ras (unsigned long insn,
    function just copies the BT field into the BA field, and the
    extraction function just checks that the fields are the same.  */
 
-/*ARGSUSED*/
 static unsigned long
 insert_rbs (unsigned long insn,
 	    long value ATTRIBUTE_UNUSED,
@@ -1327,7 +1376,6 @@ extract_rbs (unsigned long insn,
 /* The RT field of the DQ form lq instruction, which has special
    value restrictions.  */
 
-/*ARGSUSED*/
 static unsigned long
 insert_rtq (unsigned long insn,
 	    long value,
@@ -1342,7 +1390,6 @@ insert_rtq (unsigned long insn,
 /* The RS field of the DS form stq instruction, which has special
    value restrictions.  */
 
-/*ARGSUSED*/
 static unsigned long
 insert_rsq (unsigned long insn,
 	    long value ATTRIBUTE_UNUSED,
@@ -1356,7 +1403,6 @@ insert_rsq (unsigned long insn,
 
 /* The SH field in an MD form instruction.  This is split.  */
 
-/*ARGSUSED*/
 static unsigned long
 insert_sh6 (unsigned long insn,
 	    long value,
@@ -1366,7 +1412,6 @@ insert_sh6 (unsigned long insn,
   return insn | ((value & 0x1f) << 11) | ((value & 0x20) >> 4);
 }
 
-/*ARGSUSED*/
 static long
 extract_sh6 (unsigned long insn,
 	     int dialect ATTRIBUTE_UNUSED,
@@ -1395,6 +1440,47 @@ extract_spr (unsigned long insn,
   return ((insn >> 16) & 0x1f) | ((insn >> 6) & 0x3e0);
 }
 
+/* Some dialects have 8 SPRG registers instead of the standard 4.  */
+
+static unsigned long
+insert_sprg (unsigned long insn,
+	     long value,
+	     int dialect,
+	     const char **errmsg)
+{
+  /* This check uses PPC_OPCODE_403 because PPC405 is later defined
+     as a synonym.  If ever a 405 specific dialect is added this
+     check should use that instead.  */
+  if (value > 7
+      || (value > 3
+	  && (dialect & (PPC_OPCODE_BOOKE | PPC_OPCODE_403)) == 0))
+    *errmsg = _("invalid sprg number");
+
+  /* If this is mfsprg4..7 then use spr 260..263 which can be read in
+     user mode.  Anything else must use spr 272..279.  */
+  if (value <= 3 || (insn & 0x100) != 0)
+    value |= 0x10;
+
+  return insn | ((value & 0x17) << 16);
+}
+
+static long
+extract_sprg (unsigned long insn,
+	      int dialect,
+	      int *invalid)
+{
+  unsigned long val = (insn >> 16) & 0x1f;
+
+  /* mfsprg can use 260..263 and 272..279.  mtsprg only uses spr 272..279
+     If not BOOKE or 405, then both use only 272..275.  */
+  if (val <= 3
+      || (val < 0x10 && (insn & 0x100) != 0)
+      || (val - 0x10 > 3
+	  && (dialect & (PPC_OPCODE_BOOKE | PPC_OPCODE_403)) == 0))
+    *invalid = 1;
+  return val & 7;
+}
+
 /* The TBR field in an XFX instruction.  This is just like SPR, but it
    is optional.  When TBR is omitted, it must be inserted as 268 (the
    magic number of the TB register).  These functions treat 0
@@ -1460,6 +1546,9 @@ extract_tbr (unsigned long insn,
 /* An A_MASK with the FRA and FRC fields fixed.  */
 #define AFRAFRC_MASK (A_MASK | FRA_MASK | FRC_MASK)
 
+/* An AFRAFRC_MASK, but with L bit clear.  */
+#define AFRALFRC_MASK (AFRAFRC_MASK & ~((unsigned long) 1 << 16))
+
 /* A B form instruction.  */
 #define B(op, aa, lk) (OP (op) | ((((unsigned long)(aa)) & 1) << 1) | ((lk) & 1))
 #define B_MASK B (0x3f, 1, 1)
@@ -1494,11 +1583,11 @@ extract_tbr (unsigned long insn,
 
 /* An Context form instruction.  */
 #define CTX(op, xop)   (OP (op) | (((unsigned long)(xop)) & 0x7))
-#define CTX_MASK       CTX(0x3f, 0x7)
+#define CTX_MASK CTX(0x3f, 0x7)
 
 /* An User Context form instruction.  */
 #define UCTX(op, xop)  (OP (op) | (((unsigned long)(xop)) & 0x1f))
-#define UCTX_MASK      UCTX(0x3f, 0x1f)
+#define UCTX_MASK UCTX(0x3f, 0x1f)
 
 /* The main opcode mask with the RA field clear.  */
 #define DRA_MASK (OP_MASK | RA_MASK)
@@ -1570,12 +1659,21 @@ extract_tbr (unsigned long insn,
 /* An X form instruction.  */
 #define X(op, xop) (OP (op) | ((((unsigned long)(xop)) & 0x3ff) << 1))
 
+/* A Z form instruction.  */
+#define Z(op, xop) (OP (op) | ((((unsigned long)(xop)) & 0x1ff) << 1))
+
 /* An X form instruction with the RC bit specified.  */
 #define XRC(op, xop, rc) (X ((op), (xop)) | ((rc) & 1))
 
+/* A Z form instruction with the RC bit specified.  */
+#define ZRC(op, xop, rc) (Z ((op), (xop)) | ((rc) & 1))
+
 /* The mask for an X form instruction.  */
 #define X_MASK XRC (0x3f, 0x3ff, 1)
 
+/* The mask for a Z form instruction.  */
+#define Z_MASK ZRC (0x3f, 0x1ff, 1)
+
 /* An X_MASK with the RA field fixed.  */
 #define XRA_MASK (X_MASK | RA_MASK)
 
@@ -1585,6 +1683,9 @@ extract_tbr (unsigned long insn,
 /* An X_MASK with the RT field fixed.  */
 #define XRT_MASK (X_MASK | RT_MASK)
 
+/* An XRT_MASK mask with the L bits clear.  */
+#define XLRT_MASK (XRT_MASK & ~((unsigned long) 0x3 << 21))
+
 /* An X_MASK with the RA and RB fields fixed.  */
 #define XRARB_MASK (X_MASK | RA_MASK | RB_MASK)
 
@@ -1597,8 +1698,8 @@ extract_tbr (unsigned long insn,
 /* An XRTRA_MASK, but with L bit clear.  */
 #define XRTLRA_MASK (XRTRA_MASK & ~((unsigned long) 1 << 21))
 
-/* An X form comparison instruction.  */
-#define XCMPL(op, xop, l) (X ((op), (xop)) | ((((unsigned long)(l)) & 1) << 21))
+/* An X form instruction with the L bit specified.  */
+#define XOPL(op, xop, l) (X ((op), (xop)) | ((((unsigned long)(l)) & 1) << 21))
 
 /* The mask for an X form comparison instruction.  */
 #define XCMP_MASK (X_MASK | (((unsigned long)1) << 22))
@@ -1621,6 +1722,9 @@ extract_tbr (unsigned long insn,
 /* An X form sync instruction with everything filled in except the LS field.  */
 #define XSYNC_MASK (0xff9fffff)
 
+/* An X_MASK, but with the EH bit clear.  */
+#define XEH_MASK (X_MASK & ~((unsigned long )1))
+
 /* An X form AltiVec dss instruction.  */
 #define XDSS(op, xop, a) (X ((op), (xop)) | ((((unsigned long)(a)) & 1) << 25))
 #define XDSS_MASK XDSS(0x3f, 0x3ff, 1)
@@ -1663,6 +1767,9 @@ extract_tbr (unsigned long insn,
 #define XLYBB_MASK (XLYLK_MASK | BB_MASK)
 #define XLBOCBBB_MASK (XLOCB_MASK | BB_MASK)
 
+/* A mask for branch instructions using the BH field.  */
+#define XLBH_MASK (XL_MASK | (0x1c << 11))
+
 /* An XL_MASK with the BO and BB fields fixed.  */
 #define XLBOBB_MASK (XL_MASK | BO_MASK | BB_MASK)
 
@@ -1682,11 +1789,12 @@ extract_tbr (unsigned long insn,
 #define XS_MASK XS (0x3f, 0x1ff, 1)
 
 /* A mask for the FXM version of an XFX form instruction.  */
-#define XFXFXM_MASK (X_MASK | (1 << 11))
+#define XFXFXM_MASK (X_MASK | (1 << 11) | (1 << 20))
 
 /* An XFX form instruction with the FXM field filled in.  */
-#define XFXM(op, xop, fxm) \
-  (X ((op), (xop)) | ((((unsigned long)(fxm)) & 0xff) << 12))
+#define XFXM(op, xop, fxm, p4) \
+  (X ((op), (xop)) | ((((unsigned long)(fxm)) & 0xff) << 12) \
+   | ((unsigned long)(p4) << 20))
 
 /* An XFX form instruction with the SPR field filled in.  */
 #define XSPR(op, xop, spr) \
@@ -1699,7 +1807,7 @@ extract_tbr (unsigned long insn,
 
 /* An XFX form instruction with the SPR field filled in except for the
    SPRG field.  */
-#define XSPRG_MASK (XSPR_MASK &~ SPRG_MASK)
+#define XSPRG_MASK (XSPR_MASK & ~(0x17 << 16))
 
 /* An X form instruction with everything filled in except the E field.  */
 #define XE_MASK (0xffff7fff)
@@ -1769,6 +1877,9 @@ extract_tbr (unsigned long insn,
 #define PPCCOM	PPC_OPCODE_PPC | PPC_OPCODE_COMMON
 #define NOPOWER4 PPC_OPCODE_NOPOWER4 | PPCCOM
 #define POWER4	PPC_OPCODE_POWER4
+#define POWER5	PPC_OPCODE_POWER5
+#define POWER6	PPC_OPCODE_POWER6
+#define CELL	PPC_OPCODE_CELL
 #define PPC32   PPC_OPCODE_32 | PPC_OPCODE_PPC
 #define PPC64   PPC_OPCODE_64 | PPC_OPCODE_PPC
 #define PPC403	PPC_OPCODE_403
@@ -1776,7 +1887,7 @@ extract_tbr (unsigned long insn,
 #define PPC440	PPC_OPCODE_440
 #define PPC750	PPC
 #define PPC860	PPC
-#define PPCVEC	PPC_OPCODE_ALTIVEC | PPC_OPCODE_PPC
+#define PPCVEC	PPC_OPCODE_ALTIVEC
 #define	POWER   PPC_OPCODE_POWER
 #define	POWER2	PPC_OPCODE_POWER | PPC_OPCODE_POWER2
 #define PPCPWR2	PPC_OPCODE_PPC | PPC_OPCODE_POWER | PPC_OPCODE_POWER2
@@ -1790,6 +1901,7 @@ extract_tbr (unsigned long insn,
 #define BOOKE	PPC_OPCODE_BOOKE
 #define BOOKE64	PPC_OPCODE_BOOKE64
 #define CLASSIC	PPC_OPCODE_CLASSIC
+#define PPCE300 PPC_OPCODE_E300
 #define PPCSPE	PPC_OPCODE_SPE
 #define PPCISEL	PPC_OPCODE_ISEL
 #define PPCEFS	PPC_OPCODE_EFS
@@ -1952,6 +2064,41 @@ const struct powerpc_opcode powerpc_opco
 { "nmaclhwso.",	XO(4,494,1,1), XO_MASK,	PPC405|PPC440,	{ RT, RA, RB } },
 { "mfvscr",  VX(4, 1540), VX_MASK,	PPCVEC,		{ VD } },
 { "mtvscr",  VX(4, 1604), VX_MASK,	PPCVEC,		{ VB } },
+
+  /* Double-precision opcodes.  */
+  /* Some of these conflict with AltiVec, so move them before, since
+     PPCVEC includes the PPC_OPCODE_PPC set.  */
+{ "efscfd",   VX(4, 719), VX_MASK,	PPCEFS,		{ RS, RB } },
+{ "efdabs",   VX(4, 740), VX_MASK,	PPCEFS,		{ RS, RA } },
+{ "efdnabs",  VX(4, 741), VX_MASK,	PPCEFS,		{ RS, RA } },
+{ "efdneg",   VX(4, 742), VX_MASK,	PPCEFS,		{ RS, RA } },
+{ "efdadd",   VX(4, 736), VX_MASK,	PPCEFS,		{ RS, RA, RB } },
+{ "efdsub",   VX(4, 737), VX_MASK,	PPCEFS,		{ RS, RA, RB } },
+{ "efdmul",   VX(4, 744), VX_MASK,	PPCEFS,		{ RS, RA, RB } },
+{ "efddiv",   VX(4, 745), VX_MASK,	PPCEFS,		{ RS, RA, RB } },
+{ "efdcmpgt", VX(4, 748), VX_MASK,	PPCEFS,		{ CRFD, RA, RB } },
+{ "efdcmplt", VX(4, 749), VX_MASK,	PPCEFS,		{ CRFD, RA, RB } },
+{ "efdcmpeq", VX(4, 750), VX_MASK,	PPCEFS,		{ CRFD, RA, RB } },
+{ "efdtstgt", VX(4, 764), VX_MASK,	PPCEFS,		{ CRFD, RA, RB } },
+{ "efdtstlt", VX(4, 765), VX_MASK,	PPCEFS,		{ CRFD, RA, RB } },
+{ "efdtsteq", VX(4, 766), VX_MASK,	PPCEFS,		{ CRFD, RA, RB } },
+{ "efdcfsi",  VX(4, 753), VX_MASK,	PPCEFS,		{ RS, RB } },
+{ "efdcfsid", VX(4, 739), VX_MASK,	PPCEFS,		{ RS, RB } },
+{ "efdcfui",  VX(4, 752), VX_MASK,	PPCEFS,		{ RS, RB } },
+{ "efdcfuid", VX(4, 738), VX_MASK,	PPCEFS,		{ RS, RB } },
+{ "efdcfsf",  VX(4, 755), VX_MASK,	PPCEFS,		{ RS, RB } },
+{ "efdcfuf",  VX(4, 754), VX_MASK,	PPCEFS,		{ RS, RB } },
+{ "efdctsi",  VX(4, 757), VX_MASK,	PPCEFS,		{ RS, RB } },
+{ "efdctsidz",VX(4, 747), VX_MASK,	PPCEFS,		{ RS, RB } },
+{ "efdctsiz", VX(4, 762), VX_MASK,	PPCEFS,		{ RS, RB } },
+{ "efdctui",  VX(4, 756), VX_MASK,	PPCEFS,		{ RS, RB } },
+{ "efdctuidz",VX(4, 746), VX_MASK,	PPCEFS,		{ RS, RB } },
+{ "efdctuiz", VX(4, 760), VX_MASK,	PPCEFS,		{ RS, RB } },
+{ "efdctsf",  VX(4, 759), VX_MASK,	PPCEFS,		{ RS, RB } },
+{ "efdctuf",  VX(4, 758), VX_MASK,	PPCEFS,		{ RS, RB } },
+{ "efdcfs",   VX(4, 751), VX_MASK,	PPCEFS,		{ RS, RB } },
+  /* End of double-precision opcodes.  */
+
 { "vaddcuw", VX(4,  384), VX_MASK,	PPCVEC,		{ VD, VA, VB } },
 { "vaddfp",  VX(4,   10), VX_MASK, 	PPCVEC,		{ VD, VA, VB } },
 { "vaddsbs", VX(4,  768), VX_MASK,	PPCVEC,		{ VD, VA, VB } },
@@ -2389,16 +2536,16 @@ const struct powerpc_opcode powerpc_opco
 
 { "li",	     OP(14),	DRA_MASK,	PPCCOM,		{ RT, SI } },
 { "lil",     OP(14),	DRA_MASK,	PWRCOM,		{ RT, SI } },
-{ "addi",    OP(14),	OP_MASK,	PPCCOM,		{ RT, RA, SI } },
-{ "cal",     OP(14),	OP_MASK,	PWRCOM,		{ RT, D, RA } },
-{ "subi",    OP(14),	OP_MASK,	PPCCOM,		{ RT, RA, NSI } },
-{ "la",	     OP(14),	OP_MASK,	PPCCOM,		{ RT, D, RA } },
+{ "addi",    OP(14),	OP_MASK,	PPCCOM,		{ RT, RA0, SI } },
+{ "cal",     OP(14),	OP_MASK,	PWRCOM,		{ RT, D, RA0 } },
+{ "subi",    OP(14),	OP_MASK,	PPCCOM,		{ RT, RA0, NSI } },
+{ "la",	     OP(14),	OP_MASK,	PPCCOM,		{ RT, D, RA0 } },
 
 { "lis",     OP(15),	DRA_MASK,	PPCCOM,		{ RT, SISIGNOPT } },
 { "liu",     OP(15),	DRA_MASK,	PWRCOM,		{ RT, SISIGNOPT } },
-{ "addis",   OP(15),	OP_MASK,	PPCCOM,		{ RT,RA,SISIGNOPT } },
-{ "cau",     OP(15),	OP_MASK,	PWRCOM,		{ RT,RA,SISIGNOPT } },
-{ "subis",   OP(15),	OP_MASK,	PPCCOM,		{ RT, RA, NSI } },
+{ "addis",   OP(15),	OP_MASK,	PPCCOM,		{ RT,RA0,SISIGNOPT } },
+{ "cau",     OP(15),	OP_MASK,	PWRCOM,		{ RT,RA0,SISIGNOPT } },
+{ "subis",   OP(15),	OP_MASK,	PPCCOM,		{ RT, RA0, NSI } },
 
 { "bdnz-",   BBO(16,BODNZ,0,0),      BBOATBI_MASK, PPCCOM,	{ BDM } },
 { "bdnz+",   BBO(16,BODNZ,0,0),      BBOATBI_MASK, PPCCOM,	{ BDP } },
@@ -2665,9 +2812,9 @@ const struct powerpc_opcode powerpc_opco
 { "bcla+",   B(16,1,1),	B_MASK,		PPCCOM,		{ BOE, BI, BDPA } },
 { "bcla",    B(16,1,1),	B_MASK,		COM,		{ BO, BI, BDA } },
 
-{ "sc",      SC(17,1,0), 0xffffffff,	PPC,		{ 0 } },
-{ "svc",     SC(17,0,0), SC_MASK,	POWER,		{ LEV, FL1, FL2 } },
-{ "svcl",    SC(17,0,1), SC_MASK,	POWER,		{ LEV, FL1, FL2 } },
+{ "sc",      SC(17,1,0), SC_MASK,	PPC,		{ LEV } },
+{ "svc",     SC(17,0,0), SC_MASK,	POWER,		{ SVC_LEV, FL1, FL2 } },
+{ "svcl",    SC(17,0,1), SC_MASK,	POWER,		{ SVC_LEV, FL1, FL2 } },
 { "svca",    SC(17,1,0), SC_MASK,	PWRCOM,		{ SV } },
 { "svcla",   SC(17,1,1), SC_MASK,	POWER,		{ SV } },
 
@@ -2890,12 +3037,12 @@ const struct powerpc_opcode powerpc_opco
 { "bdzflrl", XLO(19,BODZF,16,1), XLBOBB_MASK, PPCCOM,	{ BI } },
 { "bdzflrl-",XLO(19,BODZF,16,1), XLBOBB_MASK, NOPOWER4,	{ BI } },
 { "bdzflrl+",XLO(19,BODZFP,16,1), XLBOBB_MASK, NOPOWER4, { BI } },
-{ "bclr",    XLLK(19,16,0), XLYBB_MASK,	PPCCOM,		{ BO, BI } },
-{ "bclrl",   XLLK(19,16,1), XLYBB_MASK,	PPCCOM,		{ BO, BI } },
 { "bclr+",   XLYLK(19,16,1,0), XLYBB_MASK, PPCCOM,	{ BOE, BI } },
 { "bclrl+",  XLYLK(19,16,1,1), XLYBB_MASK, PPCCOM,	{ BOE, BI } },
 { "bclr-",   XLYLK(19,16,0,0), XLYBB_MASK, PPCCOM,	{ BOE, BI } },
 { "bclrl-",  XLYLK(19,16,0,1), XLYBB_MASK, PPCCOM,	{ BOE, BI } },
+{ "bclr",    XLLK(19,16,0), XLBH_MASK,	PPCCOM,		{ BO, BI, BH } },
+{ "bclrl",   XLLK(19,16,1), XLBH_MASK,	PPCCOM,		{ BO, BI, BH } },
 { "bcr",     XLLK(19,16,0), XLBB_MASK,	PWRCOM,		{ BO, BI } },
 { "bcrl",    XLLK(19,16,1), XLBB_MASK,	PWRCOM,		{ BO, BI } },
 { "bclre",   XLLK(19,17,0), XLBB_MASK,	BOOKE64,	{ BO, BI } },
@@ -2924,14 +3071,23 @@ const struct powerpc_opcode powerpc_opco
 
 { "crand",   XL(19,257), XL_MASK,	COM,		{ BT, BA, BB } },
 
+{ "hrfid",   XL(19,274), 0xffffffff,	POWER5 | CELL,	{ 0 } },
+
 { "crset",   XL(19,289), XL_MASK,	PPCCOM,		{ BT, BAT, BBA } },
 { "creqv",   XL(19,289), XL_MASK,	COM,		{ BT, BA, BB } },
 
+{ "doze",    XL(19,402), 0xffffffff,	POWER6,		{ 0 } },
+
 { "crorc",   XL(19,417), XL_MASK,	COM,		{ BT, BA, BB } },
 
+{ "nap",     XL(19,434), 0xffffffff,	POWER6,		{ 0 } },
+
 { "crmove",  XL(19,449), XL_MASK,	PPCCOM,		{ BT, BA, BBA } },
 { "cror",    XL(19,449), XL_MASK,	COM,		{ BT, BA, BB } },
 
+{ "sleep",   XL(19,466), 0xffffffff,	POWER6,		{ 0 } },
+{ "rvwinkle", XL(19,498), 0xffffffff,	POWER6,		{ 0 } },
+
 { "bctr",    XLO(19,BOU,528,0), XLBOBIBB_MASK, COM,	{ 0 } },
 { "bctrl",   XLO(19,BOU,528,1), XLBOBIBB_MASK, COM,	{ 0 } },
 { "bltctr",  XLOCB(19,BOT,CBLT,528,0),  XLBOCBBB_MASK, PPCCOM,	{ CR } },
@@ -3074,12 +3230,12 @@ const struct powerpc_opcode powerpc_opco
 { "bfctrl-", XLO(19,BOFM4,528,1), XLBOBB_MASK, POWER4, { BI } },
 { "bfctrl+", XLO(19,BOFP,528,1), XLBOBB_MASK, NOPOWER4, { BI } },
 { "bfctrl+", XLO(19,BOFP4,528,1), XLBOBB_MASK, POWER4, { BI } },
-{ "bcctr",   XLLK(19,528,0),     XLYBB_MASK,  PPCCOM,	{ BO, BI } },
 { "bcctr-",  XLYLK(19,528,0,0),  XLYBB_MASK,  PPCCOM,	{ BOE, BI } },
 { "bcctr+",  XLYLK(19,528,1,0),  XLYBB_MASK,  PPCCOM,	{ BOE, BI } },
-{ "bcctrl",  XLLK(19,528,1),     XLYBB_MASK,  PPCCOM,	{ BO, BI } },
 { "bcctrl-", XLYLK(19,528,0,1),  XLYBB_MASK,  PPCCOM,	{ BOE, BI } },
 { "bcctrl+", XLYLK(19,528,1,1),  XLYBB_MASK,  PPCCOM,	{ BOE, BI } },
+{ "bcctr",   XLLK(19,528,0),     XLBH_MASK,   PPCCOM,	{ BO, BI, BH } },
+{ "bcctrl",  XLLK(19,528,1),     XLBH_MASK,   PPCCOM,	{ BO, BI, BH } },
 { "bcc",     XLLK(19,528,0),     XLBB_MASK,   PWRCOM,	{ BO, BI } },
 { "bccl",    XLLK(19,528,1),     XLBB_MASK,   PWRCOM,	{ BO, BI } },
 { "bcctre",  XLLK(19,529,0),     XLYBB_MASK,  BOOKE64,	{ BO, BI } },
@@ -3158,8 +3314,8 @@ const struct powerpc_opcode powerpc_opco
 { "rldcr",   MDS(30,9,0), MDS_MASK,	PPC64,		{ RA, RS, RB, ME6 } },
 { "rldcr.",  MDS(30,9,1), MDS_MASK,	PPC64,		{ RA, RS, RB, ME6 } },
 
-{ "cmpw",    XCMPL(31,0,0), XCMPL_MASK, PPCCOM,		{ OBF, RA, RB } },
-{ "cmpd",    XCMPL(31,0,1), XCMPL_MASK, PPC64,		{ OBF, RA, RB } },
+{ "cmpw",    XOPL(31,0,0), XCMPL_MASK, PPCCOM,		{ OBF, RA, RB } },
+{ "cmpd",    XOPL(31,0,1), XCMPL_MASK, PPC64,		{ OBF, RA, RB } },
 { "cmp",     X(31,0),	XCMP_MASK,	PPC,		{ BF, L, RA, RB } },
 { "cmp",     X(31,0),	XCMPL_MASK,	PWRCOM,		{ BF, RA, RB } },
 
@@ -3228,17 +3384,18 @@ const struct powerpc_opcode powerpc_opco
 { "iseleq",  X(31,79),      X_MASK,	PPCISEL,	{ RT, RA, RB } },
 { "isel",    XISEL(31,15),  XISEL_MASK,	PPCISEL,	{ RT, RA, RB, CRB } },
 
-{ "mfcr",    X(31,19),	XRARB_MASK,	NOPOWER4,	{ RT } },
+{ "mfocrf",  XFXM(31,19,0,1), XFXFXM_MASK, COM,		{ RT, FXM } },
+{ "mfcr",    X(31,19),	XRARB_MASK,	NOPOWER4 | COM,	{ RT } },
 { "mfcr",    X(31,19),	XFXFXM_MASK,	POWER4,		{ RT, FXM4 } },
 
-{ "lwarx",   X(31,20),	X_MASK,		PPC,		{ RT, RA, RB } },
+{ "lwarx",   X(31,20),	XEH_MASK,	PPC,		{ RT, RA0, RB, EH } },
 
-{ "ldx",     X(31,21),	X_MASK,		PPC64,		{ RT, RA, RB } },
+{ "ldx",     X(31,21),	X_MASK,		PPC64,		{ RT, RA0, RB } },
 
-{ "icbt",    X(31,22),	X_MASK,		BOOKE,		{ CT, RA, RB } },
+{ "icbt",    X(31,22),	X_MASK,		BOOKE|PPCE300,	{ CT, RA, RB } },
 { "icbt",    X(31,262),	XRT_MASK,	PPC403,		{ RA, RB } },
 
-{ "lwzx",    X(31,23),	X_MASK,		PPCCOM,		{ RT, RA, RB } },
+{ "lwzx",    X(31,23),	X_MASK,		PPCCOM,		{ RT, RA0, RB } },
 { "lx",      X(31,23),	X_MASK,		PWRCOM,		{ RT, RA, RB } },
 
 { "slw",     XRC(31,24,0), X_MASK,	PPCCOM,		{ RA, RS, RB } },
@@ -3262,10 +3419,10 @@ const struct powerpc_opcode powerpc_opco
 
 { "icbte",   X(31,30),	X_MASK,		BOOKE64,	{ CT, RA, RB } },
 
-{ "lwzxe",   X(31,31),	X_MASK,		BOOKE64,	{ RT, RA, RB } },
+{ "lwzxe",   X(31,31),	X_MASK,		BOOKE64,	{ RT, RA0, RB } },
 
-{ "cmplw",   XCMPL(31,32,0), XCMPL_MASK, PPCCOM,	{ OBF, RA, RB } },
-{ "cmpld",   XCMPL(31,32,1), XCMPL_MASK, PPC64,		{ OBF, RA, RB } },
+{ "cmplw",   XOPL(31,32,0), XCMPL_MASK, PPCCOM,	{ OBF, RA, RB } },
+{ "cmpld",   XOPL(31,32,1), XCMPL_MASK, PPC64,		{ OBF, RA, RB } },
 { "cmpl",    X(31,32),	XCMP_MASK,	 PPC,		{ BF, L, RA, RB } },
 { "cmpl",    X(31,32),	XCMPL_MASK,	 PWRCOM,	{ BF, RA, RB } },
 
@@ -3324,15 +3481,16 @@ const struct powerpc_opcode powerpc_opco
 
 { "mfmsr",   X(31,83),	XRARB_MASK,	COM,		{ RT } },
 
-{ "ldarx",   X(31,84),	X_MASK,		PPC64,		{ RT, RA, RB } },
+{ "ldarx",   X(31,84),	XEH_MASK,	PPC64,		{ RT, RA0, RB, EH } },
 
-{ "dcbf",    X(31,86),	XRT_MASK,	PPC,		{ RA, RB } },
+{ "dcbfl",   XOPL(31,86,1), XRT_MASK,	POWER5,		{ RA, RB } },
+{ "dcbf",    X(31,86),	XLRT_MASK,	PPC,		{ RA, RB, XRT_L } },
 
-{ "lbzx",    X(31,87),	X_MASK,		COM,		{ RT, RA, RB } },
+{ "lbzx",    X(31,87),	X_MASK,		COM,		{ RT, RA0, RB } },
 
 { "dcbfe",   X(31,94),	XRT_MASK,	BOOKE64,	{ RA, RB } },
 
-{ "lbzxe",   X(31,95),	X_MASK,		BOOKE64,	{ RT, RA, RB } },
+{ "lbzxe",   X(31,95),	X_MASK,		BOOKE64,	{ RT, RA0, RB } },
 
 { "neg",     XO(31,104,0,0), XORB_MASK,	COM,		{ RT, RA } },
 { "neg.",    XO(31,104,0,1), XORB_MASK,	COM,		{ RT, RA } },
@@ -3350,12 +3508,14 @@ const struct powerpc_opcode powerpc_opco
 
 { "lbzux",   X(31,119),	X_MASK,		COM,		{ RT, RAL, RB } },
 
+{ "popcntb", X(31,122), XRB_MASK,	POWER5,		{ RA, RS } },
+
 { "not",     XRC(31,124,0), X_MASK,	COM,		{ RA, RS, RBS } },
 { "nor",     XRC(31,124,0), X_MASK,	COM,		{ RA, RS, RB } },
 { "not.",    XRC(31,124,1), X_MASK,	COM,		{ RA, RS, RBS } },
 { "nor.",    XRC(31,124,1), X_MASK,	COM,		{ RA, RS, RB } },
 
-{ "lwarxe",  X(31,126),	X_MASK,		BOOKE64,	{ RT, RA, RB } },
+{ "lwarxe",  X(31,126),	X_MASK,		BOOKE64,	{ RT, RA0, RB } },
 
 { "lbzuxe",  X(31,127),	X_MASK,		BOOKE64,	{ RT, RAL, RB } },
 
@@ -3383,21 +3543,22 @@ const struct powerpc_opcode powerpc_opco
 
 { "dcbtstlse",X(31,142),X_MASK,		PPCCHLK64,	{ CT, RA, RB }},
 
-{ "mtcr",    XFXM(31,144,0xff), XRARB_MASK, COM,	{ RS }},
+{ "mtocrf",  XFXM(31,144,0,1), XFXFXM_MASK, COM,	{ FXM, RS } },
+{ "mtcr",    XFXM(31,144,0xff,0), XRARB_MASK, COM,	{ RS }},
 { "mtcrf",   X(31,144),	XFXFXM_MASK,	COM,		{ FXM, RS } },
 
 { "mtmsr",   X(31,146),	XRARB_MASK,	COM,		{ RS } },
 
-{ "stdx",    X(31,149), X_MASK,		PPC64,		{ RS, RA, RB } },
+{ "stdx",    X(31,149), X_MASK,		PPC64,		{ RS, RA0, RB } },
 
-{ "stwcx.",  XRC(31,150,1), X_MASK,	PPC,		{ RS, RA, RB } },
+{ "stwcx.",  XRC(31,150,1), X_MASK,	PPC,		{ RS, RA0, RB } },
 
-{ "stwx",    X(31,151), X_MASK,		PPCCOM,		{ RS, RA, RB } },
+{ "stwx",    X(31,151), X_MASK,		PPCCOM,		{ RS, RA0, RB } },
 { "stx",     X(31,151), X_MASK,		PWRCOM,		{ RS, RA, RB } },
 
-{ "stwcxe.", XRC(31,158,1), X_MASK,	BOOKE64,	{ RS, RA, RB } },
+{ "stwcxe.", XRC(31,158,1), X_MASK,	BOOKE64,	{ RS, RA0, RB } },
 
-{ "stwxe",   X(31,159), X_MASK,		BOOKE64,	{ RS, RA, RB } },
+{ "stwxe",   X(31,159), X_MASK,		BOOKE64,	{ RS, RA0, RB } },
 
 { "slq",     XRC(31,152,0), X_MASK,	M601,		{ RA, RS, RB } },
 { "slq.",    XRC(31,152,1), X_MASK,	M601,		{ RA, RS, RB } },
@@ -3405,6 +3566,8 @@ const struct powerpc_opcode powerpc_opco
 { "sle",     XRC(31,153,0), X_MASK,	M601,		{ RA, RS, RB } },
 { "sle.",    XRC(31,153,1), X_MASK,	M601,		{ RA, RS, RB } },
 
+{ "prtyw",   X(31,154),	XRB_MASK,	POWER6,		{ RA, RS } },
+
 { "wrteei",  X(31,163),	XE_MASK,	PPC403 | BOOKE,	{ E } },
 
 { "dcbtls",  X(31,166),	X_MASK,		PPCCHLK,	{ CT, RA, RB }},
@@ -3415,11 +3578,13 @@ const struct powerpc_opcode powerpc_opco
 { "stdux",   X(31,181),	X_MASK,		PPC64,		{ RS, RAS, RB } },
 
 { "stwux",   X(31,183),	X_MASK,		PPCCOM,		{ RS, RAS, RB } },
-{ "stux",    X(31,183),	X_MASK,		PWRCOM,		{ RS, RA, RB } },
+{ "stux",    X(31,183),	X_MASK,		PWRCOM,		{ RS, RA0, RB } },
 
 { "sliq",    XRC(31,184,0), X_MASK,	M601,		{ RA, RS, SH } },
 { "sliq.",   XRC(31,184,1), X_MASK,	M601,		{ RA, RS, SH } },
 
+{ "prtyd",   X(31,186),	XRB_MASK,	POWER6,		{ RA, RS } },
+
 { "stwuxe",  X(31,191),	X_MASK,		BOOKE64,	{ RS, RAS, RB } },
 
 { "subfze",  XO(31,200,0,0), XORB_MASK, PPCCOM,		{ RT, RA } },
@@ -3442,9 +3607,9 @@ const struct powerpc_opcode powerpc_opco
 
 { "mtsr",    X(31,210),	XRB_MASK|(1<<20), COM32,	{ SR, RS } },
 
-{ "stdcx.",  XRC(31,214,1), X_MASK,	PPC64,		{ RS, RA, RB } },
+{ "stdcx.",  XRC(31,214,1), X_MASK,	PPC64,		{ RS, RA0, RB } },
 
-{ "stbx",    X(31,215),	X_MASK,		COM,		{ RS, RA, RB } },
+{ "stbx",    X(31,215),	X_MASK,		COM,		{ RS, RA0, RB } },
 
 { "sllq",    XRC(31,216,0), X_MASK,	M601,		{ RA, RS, RB } },
 { "sllq.",   XRC(31,216,1), X_MASK,	M601,		{ RA, RS, RB } },
@@ -3452,7 +3617,7 @@ const struct powerpc_opcode powerpc_opco
 { "sleq",    XRC(31,217,0), X_MASK,	M601,		{ RA, RS, RB } },
 { "sleq.",   XRC(31,217,1), X_MASK,	M601,		{ RA, RS, RB } },
 
-{ "stbxe",   X(31,223),	X_MASK,		BOOKE64,	{ RS, RA, RB } },
+{ "stbxe",   X(31,223),	X_MASK,		BOOKE64,	{ RS, RA0, RB } },
 
 { "icblc",   X(31,230),	X_MASK,		PPCCHLK,	{ CT, RA, RB }},
 
@@ -3492,7 +3657,7 @@ const struct powerpc_opcode powerpc_opco
 { "mtsrin",  X(31,242),	XRA_MASK,	PPC32,		{ RS, RB } },
 { "mtsri",   X(31,242),	XRA_MASK,	POWER32,	{ RS, RB } },
 
-{ "dcbtst",  X(31,246),	XRT_MASK,	PPC,		{ CT, RA, RB } },
+{ "dcbtst",  X(31,246),	X_MASK,	PPC,			{ CT, RA, RB } },
 
 { "stbux",   X(31,247),	X_MASK,		COM,		{ RS, RAS, RB } },
 
@@ -3519,26 +3684,26 @@ const struct powerpc_opcode powerpc_opco
 { "addo.",   XO(31,266,1,1), XO_MASK,	PPCCOM,		{ RT, RA, RB } },
 { "caxo.",   XO(31,266,1,1), XO_MASK,	PWRCOM,		{ RT, RA, RB } },
 
-{ "tlbiel",  X(31,274), XRTRA_MASK,	POWER4,		{ RB } },
+{ "tlbiel",  X(31,274), XRTLRA_MASK,	POWER4,		{ RB, L } },
 
 { "mfapidi", X(31,275), X_MASK,		BOOKE,		{ RT, RA } },
 
 { "lscbx",   XRC(31,277,0), X_MASK,	M601,		{ RT, RA, RB } },
 { "lscbx.",  XRC(31,277,1), X_MASK,	M601,		{ RT, RA, RB } },
 
-{ "dcbt",    X(31,278),	XRT_MASK,	PPC,		{ CT, RA, RB } },
+{ "dcbt",    X(31,278),	X_MASK,		PPC,		{ CT, RA, RB } },
 
-{ "lhzx",    X(31,279),	X_MASK,		COM,		{ RT, RA, RB } },
+{ "lhzx",    X(31,279),	X_MASK,		COM,		{ RT, RA0, RB } },
 
 { "eqv",     XRC(31,284,0), X_MASK,	COM,		{ RA, RS, RB } },
 { "eqv.",    XRC(31,284,1), X_MASK,	COM,		{ RA, RS, RB } },
 
 { "dcbte",   X(31,286),	X_MASK,		BOOKE64,	{ CT, RA, RB } },
 
-{ "lhzxe",   X(31,287),	X_MASK,		BOOKE64,	{ RT, RA, RB } },
+{ "lhzxe",   X(31,287),	X_MASK,		BOOKE64,	{ RT, RA0, RB } },
 
 { "tlbie",   X(31,306),	XRTLRA_MASK,	PPC,		{ RB, L } },
-{ "tlbi",    X(31,306),	XRT_MASK,	POWER,		{ RA, RB } },
+{ "tlbi",    X(31,306),	XRT_MASK,	POWER,		{ RA0, RB } },
 
 { "eciwx",   X(31,310), X_MASK,		PPC,		{ RT, RA, RB } },
 
@@ -3607,6 +3772,7 @@ const struct powerpc_opcode powerpc_opco
 { "mfsdr1",     XSPR(31,339,25),   XSPR_MASK, COM,	{ RT } },
 { "mfsrr0",     XSPR(31,339,26),   XSPR_MASK, COM,	{ RT } },
 { "mfsrr1",     XSPR(31,339,27),   XSPR_MASK, COM,	{ RT } },
+{ "mfcfar",     XSPR(31,339,28),   XSPR_MASK, POWER6,	{ RT } },
 { "mfpid",      XSPR(31,339,48),   XSPR_MASK, BOOKE,    { RT } },
 { "mfpid",      XSPR(31,339,945),  XSPR_MASK, PPC403,	{ RT } },
 { "mfcsrr0",    XSPR(31,339,58),   XSPR_MASK, BOOKE,    { RT } },
@@ -3634,21 +3800,21 @@ const struct powerpc_opcode powerpc_opco
 { "mfbar",      XSPR(31,339,159),  XSPR_MASK, PPC860,	{ RT } },
 { "mfvrsave",   XSPR(31,339,256),  XSPR_MASK, PPCVEC,	{ RT } },
 { "mfusprg0",   XSPR(31,339,256),  XSPR_MASK, BOOKE,    { RT } },
-{ "mfsprg4",    XSPR(31,339,260),  XSPR_MASK, PPC405,	{ RT } },
-{ "mfsprg5",    XSPR(31,339,261),  XSPR_MASK, PPC405,	{ RT } },
-{ "mfsprg6",    XSPR(31,339,262),  XSPR_MASK, PPC405,	{ RT } },
-{ "mfsprg7",    XSPR(31,339,263),  XSPR_MASK, PPC405,	{ RT } },
 { "mftb",       X(31,371),	   X_MASK,    CLASSIC,	{ RT, TBR } },
 { "mftb",       XSPR(31,339,268),  XSPR_MASK, BOOKE,    { RT } },
 { "mftbl",      XSPR(31,371,268),  XSPR_MASK, CLASSIC,	{ RT } },
 { "mftbl",      XSPR(31,339,268),  XSPR_MASK, BOOKE,    { RT } },
 { "mftbu",      XSPR(31,371,269),  XSPR_MASK, CLASSIC,	{ RT } },
 { "mftbu",      XSPR(31,339,269),  XSPR_MASK, BOOKE,    { RT } },
-{ "mfsprg",     XSPR(31,339,272),  XSPRG_MASK, PPC,	{ RT, SPRG } },
+{ "mfsprg",     XSPR(31,339,256),  XSPRG_MASK, PPC,	{ RT, SPRG } },
 { "mfsprg0",    XSPR(31,339,272),  XSPR_MASK, PPC,	{ RT } },
 { "mfsprg1",    XSPR(31,339,273),  XSPR_MASK, PPC,	{ RT } },
 { "mfsprg2",    XSPR(31,339,274),  XSPR_MASK, PPC,	{ RT } },
 { "mfsprg3",    XSPR(31,339,275),  XSPR_MASK, PPC,	{ RT } },
+{ "mfsprg4",    XSPR(31,339,260),  XSPR_MASK, PPC405 | BOOKE,	{ RT } },
+{ "mfsprg5",    XSPR(31,339,261),  XSPR_MASK, PPC405 | BOOKE,	{ RT } },
+{ "mfsprg6",    XSPR(31,339,262),  XSPR_MASK, PPC405 | BOOKE,	{ RT } },
+{ "mfsprg7",    XSPR(31,339,263),  XSPR_MASK, PPC405 | BOOKE,	{ RT } },
 { "mfasr",      XSPR(31,339,280),  XSPR_MASK, PPC64,	{ RT } },
 { "mfear",      XSPR(31,339,282),  XSPR_MASK, PPC,	{ RT } },
 { "mfpir",      XSPR(31,339,286),  XSPR_MASK, BOOKE,    { RT } },
@@ -3699,6 +3865,10 @@ const struct powerpc_opcode powerpc_opco
 { "mfspefscr",  XSPR(31,339,512),  XSPR_MASK, PPCSPE,	{ RT } },
 { "mfbbear",    XSPR(31,339,513),  XSPR_MASK, PPCBRLK,  { RT } },
 { "mfbbtar",    XSPR(31,339,514),  XSPR_MASK, PPCBRLK,  { RT } },
+{ "mfivor32",   XSPR(31,339,528),  XSPR_MASK, PPCSPE,	{ RT } },
+{ "mfivor33",   XSPR(31,339,529),  XSPR_MASK, PPCSPE,	{ RT } },
+{ "mfivor34",   XSPR(31,339,530),  XSPR_MASK, PPCSPE,	{ RT } },
+{ "mfivor35",   XSPR(31,339,531),  XSPR_MASK, PPCPMR,	{ RT } },
 { "mfibatu",    XSPR(31,339,528),  XSPRBAT_MASK, PPC,	{ RT, SPRBAT } },
 { "mfibatl",    XSPR(31,339,529),  XSPRBAT_MASK, PPC,	{ RT, SPRBAT } },
 { "mfdbatu",    XSPR(31,339,536),  XSPRBAT_MASK, PPC,	{ RT, SPRBAT } },
@@ -3708,10 +3878,11 @@ const struct powerpc_opcode powerpc_opco
 { "mfic_dat",   XSPR(31,339,562),  XSPR_MASK, PPC860,	{ RT } },
 { "mfdc_cst",   XSPR(31,339,568),  XSPR_MASK, PPC860,	{ RT } },
 { "mfdc_adr",   XSPR(31,339,569),  XSPR_MASK, PPC860,	{ RT } },
-{ "mfdc_dat",   XSPR(31,339,570),  XSPR_MASK, PPC860,	{ RT } },
 { "mfmcsrr0",   XSPR(31,339,570),  XSPR_MASK, PPCRFMCI, { RT } },
+{ "mfdc_dat",   XSPR(31,339,570),  XSPR_MASK, PPC860,	{ RT } },
 { "mfmcsrr1",   XSPR(31,339,571),  XSPR_MASK, PPCRFMCI, { RT } },
 { "mfmcsr",     XSPR(31,339,572),  XSPR_MASK, PPCRFMCI, { RT } },
+{ "mfmcar",     XSPR(31,339,573),  XSPR_MASK, PPCRFMCI, { RT } },
 { "mfdpdr",     XSPR(31,339,630),  XSPR_MASK, PPC860,	{ RT } },
 { "mfdpir",     XSPR(31,339,631),  XSPR_MASK, PPC860,	{ RT } },
 { "mfimmr",     XSPR(31,339,638),  XSPR_MASK, PPC860,	{ RT } },
@@ -3775,14 +3946,14 @@ const struct powerpc_opcode powerpc_opco
 { "mfpbu2",     XSPR(31,339,1023), XSPR_MASK, PPC403,	{ RT } },
 { "mfspr",      X(31,339),	   X_MASK,    COM,	{ RT, SPR } },
 
-{ "lwax",    X(31,341),	X_MASK,		PPC64,		{ RT, RA, RB } },
+{ "lwax",    X(31,341),	X_MASK,		PPC64,		{ RT, RA0, RB } },
 
 { "dst",     XDSS(31,342,0), XDSS_MASK,	PPCVEC,		{ RA, RB, STRM } },
 { "dstt",    XDSS(31,342,1), XDSS_MASK,	PPCVEC,		{ RA, RB, STRM } },
 
-{ "lhax",    X(31,343),	X_MASK,		COM,		{ RT, RA, RB } },
+{ "lhax",    X(31,343),	X_MASK,		COM,		{ RT, RA0, RB } },
 
-{ "lhaxe",   X(31,351),	X_MASK,		BOOKE64,	{ RT, RA, RB } },
+{ "lhaxe",   X(31,351),	X_MASK,		BOOKE64,	{ RT, RA0, RB } },
 
 { "dstst",   XDSS(31,374,0), XDSS_MASK,	PPCVEC,		{ RA, RB, STRM } },
 { "dststt",  XDSS(31,374,1), XDSS_MASK,	PPCVEC,		{ RA, RB, STRM } },
@@ -3821,14 +3992,20 @@ const struct powerpc_opcode powerpc_opco
 
 { "slbmte",  X(31,402), XRA_MASK,	PPC64,		{ RS, RB } },
 
-{ "sthx",    X(31,407),	X_MASK,		COM,		{ RS, RA, RB } },
+{ "sthx",    X(31,407),	X_MASK,		COM,		{ RS, RA0, RB } },
+
+{ "cmpb",    X(31,508),	X_MASK,		POWER6,		{ RA, RS, RB } },
 
 { "lfqx",    X(31,791),	X_MASK,		POWER2,		{ FRT, RA, RB } },
 
+{ "lfdpx",   X(31,791),	X_MASK,		POWER6,		{ FRT, RA, RB } },
+
 { "lfqux",   X(31,823),	X_MASK,		POWER2,		{ FRT, RA, RB } },
 
 { "stfqx",   X(31,919),	X_MASK,		POWER2,		{ FRS, RA, RB } },
 
+{ "stfdpx",  X(31,919),	X_MASK,		POWER6,		{ FRS, RA, RB } },
+
 { "stfqux",  X(31,951),	X_MASK,		POWER2,		{ FRS, RA, RB } },
 
 { "orc",     XRC(31,412,0), X_MASK,	COM,		{ RA, RS, RB } },
@@ -3837,7 +4014,7 @@ const struct powerpc_opcode powerpc_opco
 { "sradi",   XS(31,413,0), XS_MASK,	PPC64,		{ RA, RS, SH6 } },
 { "sradi.",  XS(31,413,1), XS_MASK,	PPC64,		{ RA, RS, SH6 } },
 
-{ "sthxe",   X(31,415),	X_MASK,		BOOKE64,	{ RS, RA, RB } },
+{ "sthxe",   X(31,415),	X_MASK,		BOOKE64,	{ RS, RA0, RB } },
 
 { "slbie",   X(31,434),	XRTRA_MASK,	PPC64,		{ RB } },
 
@@ -3918,6 +4095,7 @@ const struct powerpc_opcode powerpc_opco
 { "mtsdr1",    XSPR(31,467,25),   XSPR_MASK, COM,	{ RS } },
 { "mtsrr0",    XSPR(31,467,26),   XSPR_MASK, COM,	{ RS } },
 { "mtsrr1",    XSPR(31,467,27),   XSPR_MASK, COM,	{ RS } },
+{ "mtcfar",    XSPR(31,467,28),   XSPR_MASK, POWER6,	{ RS } },
 { "mtpid",     XSPR(31,467,48),   XSPR_MASK, BOOKE,     { RS } },
 { "mtpid",     XSPR(31,467,945),  XSPR_MASK, PPC403,	{ RS } },
 { "mtdecar",   XSPR(31,467,54),   XSPR_MASK, BOOKE,     { RS } },
@@ -3946,7 +4124,7 @@ const struct powerpc_opcode powerpc_opco
 { "mtbar",     XSPR(31,467,159),  XSPR_MASK, PPC860,	{ RS } },
 { "mtvrsave",  XSPR(31,467,256),  XSPR_MASK, PPCVEC,	{ RS } },
 { "mtusprg0",  XSPR(31,467,256),  XSPR_MASK, BOOKE,     { RS } },
-{ "mtsprg",    XSPR(31,467,272),  XSPRG_MASK,PPC,	{ SPRG, RS } },
+{ "mtsprg",    XSPR(31,467,256),  XSPRG_MASK,PPC,	{ SPRG, RS } },
 { "mtsprg0",   XSPR(31,467,272),  XSPR_MASK, PPC,	{ RS } },
 { "mtsprg1",   XSPR(31,467,273),  XSPR_MASK, PPC,	{ RS } },
 { "mtsprg2",   XSPR(31,467,274),  XSPR_MASK, PPC,	{ RS } },
@@ -4005,6 +4183,10 @@ const struct powerpc_opcode powerpc_opco
 { "mtspefscr",  XSPR(31,467,512),  XSPR_MASK, PPCSPE,   { RS } },
 { "mtbbear",   XSPR(31,467,513),  XSPR_MASK, PPCBRLK,   { RS } },
 { "mtbbtar",   XSPR(31,467,514),  XSPR_MASK, PPCBRLK,  { RS } },
+{ "mtivor32",  XSPR(31,467,528),  XSPR_MASK, PPCSPE,	{ RS } },
+{ "mtivor33",  XSPR(31,467,529),  XSPR_MASK, PPCSPE,	{ RS } },
+{ "mtivor34",  XSPR(31,467,530),  XSPR_MASK, PPCSPE,	{ RS } },
+{ "mtivor35",  XSPR(31,467,531),  XSPR_MASK, PPCPMR,	{ RS } },
 { "mtibatu",   XSPR(31,467,528),  XSPRBAT_MASK, PPC,	{ SPRBAT, RS } },
 { "mtibatl",   XSPR(31,467,529),  XSPRBAT_MASK, PPC,	{ SPRBAT, RS } },
 { "mtdbatu",   XSPR(31,467,536),  XSPRBAT_MASK, PPC,	{ SPRBAT, RS } },
@@ -4101,13 +4283,15 @@ const struct powerpc_opcode powerpc_opco
 
 { "clcs",    X(31,531), XRB_MASK,	M601,		{ RT, RA } },
 
-{ "lswx",    X(31,533),	X_MASK,		PPCCOM,		{ RT, RA, RB } },
+{ "ldbrx",   X(31,532),	X_MASK,		CELL,		{ RT, RA0, RB } },
+
+{ "lswx",    X(31,533),	X_MASK,		PPCCOM,		{ RT, RA0, RB } },
 { "lsx",     X(31,533),	X_MASK,		PWRCOM,		{ RT, RA, RB } },
 
-{ "lwbrx",   X(31,534),	X_MASK,		PPCCOM,		{ RT, RA, RB } },
+{ "lwbrx",   X(31,534),	X_MASK,		PPCCOM,		{ RT, RA0, RB } },
 { "lbrx",    X(31,534),	X_MASK,		PWRCOM,		{ RT, RA, RB } },
 
-{ "lfsx",    X(31,535),	X_MASK,		COM,		{ FRT, RA, RB } },
+{ "lfsx",    X(31,535),	X_MASK,		COM,		{ FRT, RA0, RB } },
 
 { "srw",     XRC(31,536,0), X_MASK,	PPCCOM,		{ RA, RS, RB } },
 { "sr",      XRC(31,536,0), X_MASK,	PWRCOM,		{ RA, RS, RB } },
@@ -4123,11 +4307,12 @@ const struct powerpc_opcode powerpc_opco
 { "maskir",  XRC(31,541,0), X_MASK,	M601,		{ RA, RS, RB } },
 { "maskir.", XRC(31,541,1), X_MASK,	M601,		{ RA, RS, RB } },
 
-{ "lwbrxe",  X(31,542),	X_MASK,		BOOKE64,	{ RT, RA, RB } },
+{ "lwbrxe",  X(31,542),	X_MASK,		BOOKE64,	{ RT, RA0, RB } },
 
-{ "lfsxe",   X(31,543),	X_MASK,		BOOKE64,	{ FRT, RA, RB } },
+{ "lfsxe",   X(31,543),	X_MASK,		BOOKE64,	{ FRT, RA0, RB } },
 
 { "bbelr",   X(31,550),	X_MASK,		PPCBRLK,	{ 0 }},
+
 { "tlbsync", X(31,566),	0xffffffff,	PPC,		{ 0 } },
 
 { "lfsux",   X(31,567),	X_MASK,		COM,		{ FRT, RAS, RB } },
@@ -4136,8 +4321,8 @@ const struct powerpc_opcode powerpc_opco
 
 { "mfsr",    X(31,595),	XRB_MASK|(1<<20), COM32,	{ RT, SR } },
 
-{ "lswi",    X(31,597),	X_MASK,		PPCCOM,		{ RT, RA, NB } },
-{ "lsi",     X(31,597),	X_MASK,		PWRCOM,		{ RT, RA, NB } },
+{ "lswi",    X(31,597),	X_MASK,		PPCCOM,		{ RT, RA0, NB } },
+{ "lsi",     X(31,597),	X_MASK,		PWRCOM,		{ RT, RA0, NB } },
 
 { "lwsync",  XSYNC(31,598,1), 0xffffffff, PPC,		{ 0 } },
 { "ptesync", XSYNC(31,598,2), 0xffffffff, PPC64,	{ 0 } },
@@ -4145,9 +4330,11 @@ const struct powerpc_opcode powerpc_opco
 { "sync",    X(31,598), XSYNC_MASK,	PPCCOM,		{ LS } },
 { "dcs",     X(31,598), 0xffffffff,	PWRCOM,		{ 0 } },
 
-{ "lfdx",    X(31,599), X_MASK,		COM,		{ FRT, RA, RB } },
+{ "lfdx",    X(31,599), X_MASK,		COM,		{ FRT, RA0, RB } },
 
-{ "lfdxe",   X(31,607), X_MASK,		BOOKE64,	{ FRT, RA, RB } },
+{ "lfdxe",   X(31,607), X_MASK,		BOOKE64,	{ FRT, RA0, RB } },
+
+{ "mffgpr",  XRC(31,607,0), XRA_MASK,	POWER6,		{ FRT, RB } },
 
 { "mfsri",   X(31,627), X_MASK,		PWRCOM,		{ RT, RA, RB } },
 
@@ -4159,13 +4346,15 @@ const struct powerpc_opcode powerpc_opco
 
 { "mfsrin",  X(31,659), XRA_MASK,	PPC32,		{ RT, RB } },
 
-{ "stswx",   X(31,661), X_MASK,		PPCCOM,		{ RS, RA, RB } },
-{ "stsx",    X(31,661), X_MASK,		PWRCOM,		{ RS, RA, RB } },
+{ "stdbrx",  X(31,660), X_MASK,		CELL,		{ RS, RA0, RB } },
+
+{ "stswx",   X(31,661), X_MASK,		PPCCOM,		{ RS, RA0, RB } },
+{ "stsx",    X(31,661), X_MASK,		PWRCOM,		{ RS, RA0, RB } },
 
-{ "stwbrx",  X(31,662), X_MASK,		PPCCOM,		{ RS, RA, RB } },
-{ "stbrx",   X(31,662), X_MASK,		PWRCOM,		{ RS, RA, RB } },
+{ "stwbrx",  X(31,662), X_MASK,		PPCCOM,		{ RS, RA0, RB } },
+{ "stbrx",   X(31,662), X_MASK,		PWRCOM,		{ RS, RA0, RB } },
 
-{ "stfsx",   X(31,663), X_MASK,		COM,		{ FRS, RA, RB } },
+{ "stfsx",   X(31,663), X_MASK,		COM,		{ FRS, RA0, RB } },
 
 { "srq",     XRC(31,664,0), X_MASK,	M601,		{ RA, RS, RB } },
 { "srq.",    XRC(31,664,1), X_MASK,	M601,		{ RA, RS, RB } },
@@ -4173,9 +4362,9 @@ const struct powerpc_opcode powerpc_opco
 { "sre",     XRC(31,665,0), X_MASK,	M601,		{ RA, RS, RB } },
 { "sre.",    XRC(31,665,1), X_MASK,	M601,		{ RA, RS, RB } },
 
-{ "stwbrxe", X(31,670), X_MASK,		BOOKE64,	{ RS, RA, RB } },
+{ "stwbrxe", X(31,670), X_MASK,		BOOKE64,	{ RS, RA0, RB } },
 
-{ "stfsxe",  X(31,671), X_MASK,		BOOKE64,	{ FRS, RA, RB } },
+{ "stfsxe",  X(31,671), X_MASK,		BOOKE64,	{ FRS, RA0, RB } },
 
 { "stfsux",  X(31,695),	X_MASK,		COM,		{ FRS, RAS, RB } },
 
@@ -4184,10 +4373,10 @@ const struct powerpc_opcode powerpc_opco
 
 { "stfsuxe", X(31,703),	X_MASK,		BOOKE64,	{ FRS, RAS, RB } },
 
-{ "stswi",   X(31,725),	X_MASK,		PPCCOM,		{ RS, RA, NB } },
-{ "stsi",    X(31,725),	X_MASK,		PWRCOM,		{ RS, RA, NB } },
+{ "stswi",   X(31,725),	X_MASK,		PPCCOM,		{ RS, RA0, NB } },
+{ "stsi",    X(31,725),	X_MASK,		PWRCOM,		{ RS, RA0, NB } },
 
-{ "stfdx",   X(31,727),	X_MASK,		COM,		{ FRS, RA, RB } },
+{ "stfdx",   X(31,727),	X_MASK,		COM,		{ FRS, RA0, RB } },
 
 { "srlq",    XRC(31,728,0), X_MASK,	M601,		{ RA, RS, RB } },
 { "srlq.",   XRC(31,728,1), X_MASK,	M601,		{ RA, RS, RB } },
@@ -4195,7 +4384,9 @@ const struct powerpc_opcode powerpc_opco
 { "sreq",    XRC(31,729,0), X_MASK,	M601,		{ RA, RS, RB } },
 { "sreq.",   XRC(31,729,1), X_MASK,	M601,		{ RA, RS, RB } },
 
-{ "stfdxe",  X(31,735),	X_MASK,		BOOKE64,	{ FRS, RA, RB } },
+{ "stfdxe",  X(31,735),	X_MASK,		BOOKE64,	{ FRS, RA0, RB } },
+
+{ "mftgpr",  XRC(31,735,0), XRA_MASK,	POWER6,		{ RT, FRB } },
 
 { "dcba",    X(31,758),	XRT_MASK,	PPC405 | BOOKE,	{ RA, RB } },
 
@@ -4211,7 +4402,9 @@ const struct powerpc_opcode powerpc_opco
 { "tlbivax", X(31,786),	XRT_MASK,	BOOKE,		{ RA, RB } },
 { "tlbivaxe",X(31,787),	XRT_MASK,	BOOKE64,	{ RA, RB } },
 
-{ "lhbrx",   X(31,790),	X_MASK,		COM,		{ RT, RA, RB } },
+{ "lwzcix",  X(31,789),	X_MASK,		POWER6,		{ RT, RA0, RB } },
+
+{ "lhbrx",   X(31,790),	X_MASK,		COM,		{ RT, RA0, RB } },
 
 { "sraw",    XRC(31,792,0), X_MASK,	PPCCOM,		{ RA, RS, RB } },
 { "sra",     XRC(31,792,0), X_MASK,	PWRCOM,		{ RA, RS, RB } },
@@ -4221,13 +4414,15 @@ const struct powerpc_opcode powerpc_opco
 { "srad",    XRC(31,794,0), X_MASK,	PPC64,		{ RA, RS, RB } },
 { "srad.",   XRC(31,794,1), X_MASK,	PPC64,		{ RA, RS, RB } },
 
-{ "lhbrxe",  X(31,798),	X_MASK,		BOOKE64,	{ RT, RA, RB } },
+{ "lhbrxe",  X(31,798),	X_MASK,		BOOKE64,	{ RT, RA0, RB } },
 
-{ "ldxe",    X(31,799),	X_MASK,		BOOKE64,	{ RT, RA, RB } },
-{ "lduxe",   X(31,831),	X_MASK,		BOOKE64,	{ RT, RA, RB } },
+{ "ldxe",    X(31,799),	X_MASK,		BOOKE64,	{ RT, RA0, RB } },
+{ "lduxe",   X(31,831),	X_MASK,		BOOKE64,	{ RT, RA0, RB } },
 
 { "rac",     X(31,818),	X_MASK,		PWRCOM,		{ RT, RA, RB } },
 
+{ "lhzcix",  X(31,821),	X_MASK,		POWER6,		{ RT, RA0, RB } },
+
 { "dss",     XDSS(31,822,0), XDSS_MASK,	PPCVEC,		{ STRM } },
 { "dssall",  XDSS(31,822,1), XDSS_MASK,	PPCVEC,		{ 0 } },
 
@@ -4238,19 +4433,25 @@ const struct powerpc_opcode powerpc_opco
 
 { "slbmfev", X(31,851), XRA_MASK,	PPC64,		{ RT, RB } },
 
+{ "lbzcix",  X(31,853),	X_MASK,		POWER6,		{ RT, RA0, RB } },
+
 { "mbar",    X(31,854),	X_MASK,		BOOKE,		{ MO } },
 { "eieio",   X(31,854),	0xffffffff,	PPC,		{ 0 } },
 
-{ "tlbsx",   XRC(31,914,0), X_MASK,	BOOKE,		{ RA, RB } },
-{ "tlbsx",   XRC(31,914,0), X_MASK, 	PPC403,		{ RT, RA, RB } },
-{ "tlbsx.",  XRC(31,914,1), X_MASK,	BOOKE,		{ RA, RB } },
-{ "tlbsx.",  XRC(31,914,1), X_MASK, 	PPC403,		{ RT, RA, RB } },
+{ "lfiwax",  X(31,855),	X_MASK,		POWER6,		{ FRT, RA0, RB } },
+
+{ "ldcix",   X(31,885),	X_MASK,		POWER6,		{ RT, RA0, RB } },
+
+{ "tlbsx",   XRC(31,914,0), X_MASK, 	PPC403|BOOKE,	{ RTO, RA, RB } },
+{ "tlbsx.",  XRC(31,914,1), X_MASK, 	PPC403|BOOKE,	{ RTO, RA, RB } },
 { "tlbsxe",  XRC(31,915,0), X_MASK,	BOOKE64,	{ RA, RB } },
 { "tlbsxe.", XRC(31,915,1), X_MASK,	BOOKE64,	{ RA, RB } },
 
 { "slbmfee", X(31,915), XRA_MASK,	PPC64,		{ RT, RB } },
 
-{ "sthbrx",  X(31,918),	X_MASK,		COM,		{ RS, RA, RB } },
+{ "stwcix",  X(31,917),	X_MASK,		POWER6,		{ RS, RA0, RB } },
+
+{ "sthbrx",  X(31,918),	X_MASK,		COM,		{ RS, RA0, RB } },
 
 { "sraq",    XRC(31,920,0), X_MASK,	M601,		{ RA, RS, RB } },
 { "sraq.",   XRC(31,920,1), X_MASK,	M601,		{ RA, RS, RB } },
@@ -4263,14 +4464,15 @@ const struct powerpc_opcode powerpc_opco
 { "extsh.",  XRC(31,922,1), XRB_MASK,	PPCCOM,		{ RA, RS } },
 { "exts.",   XRC(31,922,1), XRB_MASK,	PWRCOM,		{ RA, RS } },
 
-{ "sthbrxe", X(31,926),	X_MASK,		BOOKE64,	{ RS, RA, RB } },
+{ "sthbrxe", X(31,926),	X_MASK,		BOOKE64,	{ RS, RA0, RB } },
 
-{ "stdxe",   X(31,927), X_MASK,		BOOKE64,	{ RS, RA, RB } },
+{ "stdxe",   X(31,927), X_MASK,		BOOKE64,	{ RS, RA0, RB } },
 
 { "tlbrehi", XTLB(31,946,0), XTLB_MASK,	PPC403,		{ RT, RA } },
 { "tlbrelo", XTLB(31,946,1), XTLB_MASK,	PPC403,		{ RT, RA } },
-{ "tlbre",   X(31,946),	X_MASK,		BOOKE,		{ 0 } },
-{ "tlbre",   X(31,946),	X_MASK,		PPC403,		{ RS, RA, SH } },
+{ "tlbre",   X(31,946),	X_MASK,		PPC403|BOOKE,	{ RSO, RAOPT, SHO } },
+
+{ "sthcix",  X(31,949),	X_MASK,		POWER6,		{ RS, RA0, RB } },
 
 { "sraiq",   XRC(31,952,0), X_MASK,	M601,		{ RA, RS, SH } },
 { "sraiq.",  XRC(31,952,1), X_MASK,	M601,		{ RA, RS, SH } },
@@ -4284,13 +4486,14 @@ const struct powerpc_opcode powerpc_opco
 
 { "tlbwehi", XTLB(31,978,0), XTLB_MASK,	PPC403,		{ RT, RA } },
 { "tlbwelo", XTLB(31,978,1), XTLB_MASK,	PPC403,		{ RT, RA } },
-{ "tlbwe",   X(31,978),	X_MASK,		BOOKE,		{ 0 } },
-{ "tlbwe",   X(31,978),	X_MASK,		PPC403,		{ RS, RA, SH } },
+{ "tlbwe",   X(31,978),	X_MASK,		PPC403|BOOKE,	{ RSO, RAOPT, SHO } },
 { "tlbld",   X(31,978),	XRTRA_MASK,	PPC,		{ RB } },
 
+{ "stbcix",  X(31,981),	X_MASK,		POWER6,		{ RS, RA0, RB } },
+
 { "icbi",    X(31,982),	XRT_MASK,	PPC,		{ RA, RB } },
 
-{ "stfiwx",  X(31,983),	X_MASK,		PPC,		{ FRS, RA, RB } },
+{ "stfiwx",  X(31,983),	X_MASK,		PPC,		{ FRS, RA0, RB } },
 
 { "extsw",   XRC(31,986,0), XRB_MASK,	PPC64 | BOOKE64,{ RA, RS } },
 { "extsw.",  XRC(31,986,1), XRB_MASK,	PPC64,		{ RA, RS } },
@@ -4298,10 +4501,13 @@ const struct powerpc_opcode powerpc_opco
 { "icread",  X(31,998),	XRT_MASK,	PPC403|PPC440,	{ RA, RB } },
 
 { "icbie",   X(31,990),	XRT_MASK,	BOOKE64,	{ RA, RB } },
-{ "stfiwxe", X(31,991),	X_MASK,		BOOKE64,	{ FRS, RA, RB } },
+{ "stfiwxe", X(31,991),	X_MASK,		BOOKE64,	{ FRS, RA0, RB } },
 
 { "tlbli",   X(31,1010), XRTRA_MASK,	PPC,		{ RB } },
 
+{ "stdcix",  X(31,1013), X_MASK,	POWER6,		{ RS, RA0, RB } },
+
+{ "dcbzl",   XOPL(31,1014,1), XRT_MASK,POWER4,            { RA, RB } },
 { "dcbz",    X(31,1014), XRT_MASK,	PPC,		{ RA, RB } },
 { "dclz",    X(31,1014), XRT_MASK,	PPC,		{ RA, RB } },
 
@@ -4320,86 +4526,104 @@ const struct powerpc_opcode powerpc_opco
 { "stvx",    X(31, 231), X_MASK,	PPCVEC,		{ VS, RA, RB } },
 { "stvxl",   X(31, 487), X_MASK,	PPCVEC,		{ VS, RA, RB } },
 
-{ "lwz",     OP(32),	OP_MASK,	PPCCOM,		{ RT, D, RA } },
-{ "l",	     OP(32),	OP_MASK,	PWRCOM,		{ RT, D, RA } },
+/* New load/store left/right index vector instructions that are in the Cell only.  */
+{ "lvlx",    X(31, 519), X_MASK,	CELL,		{ VD, RA0, RB } },
+{ "lvlxl",   X(31, 775), X_MASK,	CELL,		{ VD, RA0, RB } },
+{ "lvrx",    X(31, 551), X_MASK,	CELL,		{ VD, RA0, RB } },
+{ "lvrxl",   X(31, 807), X_MASK,	CELL,		{ VD, RA0, RB } },
+{ "stvlx",   X(31, 647), X_MASK,	CELL,		{ VS, RA0, RB } },
+{ "stvlxl",  X(31, 903), X_MASK,	CELL,		{ VS, RA0, RB } },
+{ "stvrx",   X(31, 679), X_MASK,	CELL,		{ VS, RA0, RB } },
+{ "stvrxl",  X(31, 935), X_MASK,	CELL,		{ VS, RA0, RB } },
+
+{ "lwz",     OP(32),	OP_MASK,	PPCCOM,		{ RT, D, RA0 } },
+{ "l",	     OP(32),	OP_MASK,	PWRCOM,		{ RT, D, RA0 } },
 
 { "lwzu",    OP(33),	OP_MASK,	PPCCOM,		{ RT, D, RAL } },
-{ "lu",      OP(33),	OP_MASK,	PWRCOM,		{ RT, D, RA } },
+{ "lu",      OP(33),	OP_MASK,	PWRCOM,		{ RT, D, RA0 } },
 
-{ "lbz",     OP(34),	OP_MASK,	COM,		{ RT, D, RA } },
+{ "lbz",     OP(34),	OP_MASK,	COM,		{ RT, D, RA0 } },
 
 { "lbzu",    OP(35),	OP_MASK,	COM,		{ RT, D, RAL } },
 
-{ "stw",     OP(36),	OP_MASK,	PPCCOM,		{ RS, D, RA } },
-{ "st",      OP(36),	OP_MASK,	PWRCOM,		{ RS, D, RA } },
+{ "stw",     OP(36),	OP_MASK,	PPCCOM,		{ RS, D, RA0 } },
+{ "st",      OP(36),	OP_MASK,	PWRCOM,		{ RS, D, RA0 } },
 
 { "stwu",    OP(37),	OP_MASK,	PPCCOM,		{ RS, D, RAS } },
-{ "stu",     OP(37),	OP_MASK,	PWRCOM,		{ RS, D, RA } },
+{ "stu",     OP(37),	OP_MASK,	PWRCOM,		{ RS, D, RA0 } },
 
-{ "stb",     OP(38),	OP_MASK,	COM,		{ RS, D, RA } },
+{ "stb",     OP(38),	OP_MASK,	COM,		{ RS, D, RA0 } },
 
 { "stbu",    OP(39),	OP_MASK,	COM,		{ RS, D, RAS } },
 
-{ "lhz",     OP(40),	OP_MASK,	COM,		{ RT, D, RA } },
+{ "lhz",     OP(40),	OP_MASK,	COM,		{ RT, D, RA0 } },
 
 { "lhzu",    OP(41),	OP_MASK,	COM,		{ RT, D, RAL } },
 
-{ "lha",     OP(42),	OP_MASK,	COM,		{ RT, D, RA } },
+{ "lha",     OP(42),	OP_MASK,	COM,		{ RT, D, RA0 } },
 
 { "lhau",    OP(43),	OP_MASK,	COM,		{ RT, D, RAL } },
 
-{ "sth",     OP(44),	OP_MASK,	COM,		{ RS, D, RA } },
+{ "sth",     OP(44),	OP_MASK,	COM,		{ RS, D, RA0 } },
 
 { "sthu",    OP(45),	OP_MASK,	COM,		{ RS, D, RAS } },
 
 { "lmw",     OP(46),	OP_MASK,	PPCCOM,		{ RT, D, RAM } },
-{ "lm",      OP(46),	OP_MASK,	PWRCOM,		{ RT, D, RA } },
+{ "lm",      OP(46),	OP_MASK,	PWRCOM,		{ RT, D, RA0 } },
 
-{ "stmw",    OP(47),	OP_MASK,	PPCCOM,		{ RS, D, RA } },
-{ "stm",     OP(47),	OP_MASK,	PWRCOM,		{ RS, D, RA } },
+{ "stmw",    OP(47),	OP_MASK,	PPCCOM,		{ RS, D, RA0 } },
+{ "stm",     OP(47),	OP_MASK,	PWRCOM,		{ RS, D, RA0 } },
 
-{ "lfs",     OP(48),	OP_MASK,	COM,		{ FRT, D, RA } },
+{ "lfs",     OP(48),	OP_MASK,	COM,		{ FRT, D, RA0 } },
 
 { "lfsu",    OP(49),	OP_MASK,	COM,		{ FRT, D, RAS } },
 
-{ "lfd",     OP(50),	OP_MASK,	COM,		{ FRT, D, RA } },
+{ "lfd",     OP(50),	OP_MASK,	COM,		{ FRT, D, RA0 } },
 
 { "lfdu",    OP(51),	OP_MASK,	COM,		{ FRT, D, RAS } },
 
-{ "stfs",    OP(52),	OP_MASK,	COM,		{ FRS, D, RA } },
+{ "stfs",    OP(52),	OP_MASK,	COM,		{ FRS, D, RA0 } },
 
 { "stfsu",   OP(53),	OP_MASK,	COM,		{ FRS, D, RAS } },
 
-{ "stfd",    OP(54),	OP_MASK,	COM,		{ FRS, D, RA } },
+{ "stfd",    OP(54),	OP_MASK,	COM,		{ FRS, D, RA0 } },
 
 { "stfdu",   OP(55),	OP_MASK,	COM,		{ FRS, D, RAS } },
 
 { "lq",      OP(56),	OP_MASK,	POWER4,		{ RTQ, DQ, RAQ } },
 
-{ "lfq",     OP(56),	OP_MASK,	POWER2,		{ FRT, D, RA } },
+{ "lfq",     OP(56),	OP_MASK,	POWER2,		{ FRT, D, RA0 } },
 
-{ "lfqu",    OP(57),	OP_MASK,	POWER2,		{ FRT, D, RA } },
+{ "lfqu",    OP(57),	OP_MASK,	POWER2,		{ FRT, D, RA0 } },
 
-{ "lbze",    DEO(58,0), DE_MASK,	BOOKE64,	{ RT, DE, RA } },
+{ "lfdp",    OP(57),	OP_MASK,	POWER6,		{ FRT, D, RA0 } },
+
+{ "lbze",    DEO(58,0), DE_MASK,	BOOKE64,	{ RT, DE, RA0 } },
 { "lbzue",   DEO(58,1), DE_MASK,	BOOKE64,	{ RT, DE, RAL } },
-{ "lhze",    DEO(58,2), DE_MASK,	BOOKE64,	{ RT, DE, RA } },
+{ "lhze",    DEO(58,2), DE_MASK,	BOOKE64,	{ RT, DE, RA0 } },
 { "lhzue",   DEO(58,3), DE_MASK,	BOOKE64,	{ RT, DE, RAL } },
-{ "lhae",    DEO(58,4), DE_MASK,	BOOKE64,	{ RT, DE, RA } },
+{ "lhae",    DEO(58,4), DE_MASK,	BOOKE64,	{ RT, DE, RA0 } },
 { "lhaue",   DEO(58,5), DE_MASK,	BOOKE64,	{ RT, DE, RAL } },
-{ "lwze",    DEO(58,6), DE_MASK,	BOOKE64,	{ RT, DE, RA } },
+{ "lwze",    DEO(58,6), DE_MASK,	BOOKE64,	{ RT, DE, RA0 } },
 { "lwzue",   DEO(58,7), DE_MASK,	BOOKE64,	{ RT, DE, RAL } },
-{ "stbe",    DEO(58,8), DE_MASK,	BOOKE64,	{ RS, DE, RA } },
+{ "stbe",    DEO(58,8), DE_MASK,	BOOKE64,	{ RS, DE, RA0 } },
 { "stbue",   DEO(58,9), DE_MASK,	BOOKE64,	{ RS, DE, RAS } },
-{ "sthe",    DEO(58,10), DE_MASK,	BOOKE64,	{ RS, DE, RA } },
+{ "sthe",    DEO(58,10), DE_MASK,	BOOKE64,	{ RS, DE, RA0 } },
 { "sthue",   DEO(58,11), DE_MASK,	BOOKE64,	{ RS, DE, RAS } },
-{ "stwe",    DEO(58,14), DE_MASK,	BOOKE64,	{ RS, DE, RA } },
+{ "stwe",    DEO(58,14), DE_MASK,	BOOKE64,	{ RS, DE, RA0 } },
 { "stwue",   DEO(58,15), DE_MASK,	BOOKE64,	{ RS, DE, RAS } },
 
-{ "ld",      DSO(58,0),	DS_MASK,	PPC64,		{ RT, DS, RA } },
+{ "ld",      DSO(58,0),	DS_MASK,	PPC64,		{ RT, DS, RA0 } },
 
 { "ldu",     DSO(58,1), DS_MASK,	PPC64,		{ RT, DS, RAL } },
 
-{ "lwa",     DSO(58,2), DS_MASK,	PPC64,		{ RT, DS, RA } },
+{ "lwa",     DSO(58,2), DS_MASK,	PPC64,		{ RT, DS, RA0 } },
+
+{ "dadd",    XRC(59,2,0), X_MASK,	POWER6,		{ FRT, FRA, FRB } },
+{ "dadd.",   XRC(59,2,1), X_MASK,	POWER6,		{ FRT, FRA, FRB } },
+
+{ "dqua",    ZRC(59,3,0), Z_MASK,	POWER6,		{ FRT, FRA, FRB, RMC } },
+{ "dqua.",   ZRC(59,3,1), Z_MASK,	POWER6,		{ FRT, FRA, FRB, RMC } },
 
 { "fdivs",   A(59,18,0), AFRC_MASK,	PPC,		{ FRT, FRA, FRB } },
 { "fdivs.",  A(59,18,1), AFRC_MASK,	PPC,		{ FRT, FRA, FRB } },
@@ -4413,12 +4637,15 @@ const struct powerpc_opcode powerpc_opco
 { "fsqrts",  A(59,22,0), AFRAFRC_MASK,	PPC,		{ FRT, FRB } },
 { "fsqrts.", A(59,22,1), AFRAFRC_MASK,	PPC,		{ FRT, FRB } },
 
-{ "fres",    A(59,24,0), AFRAFRC_MASK,	PPC,		{ FRT, FRB } },
-{ "fres.",   A(59,24,1), AFRAFRC_MASK,	PPC,		{ FRT, FRB } },
+{ "fres",    A(59,24,0), AFRALFRC_MASK,	PPC,		{ FRT, FRB, A_L } },
+{ "fres.",   A(59,24,1), AFRALFRC_MASK,	PPC,		{ FRT, FRB, A_L } },
 
 { "fmuls",   A(59,25,0), AFRB_MASK,	PPC,		{ FRT, FRA, FRC } },
 { "fmuls.",  A(59,25,1), AFRB_MASK,	PPC,		{ FRT, FRA, FRC } },
 
+{ "frsqrtes", A(59,26,0), AFRALFRC_MASK,POWER5,		{ FRT, FRB, A_L } },
+{ "frsqrtes.",A(59,26,1), AFRALFRC_MASK,POWER5,		{ FRT, FRB, A_L } },
+
 { "fmsubs",  A(59,28,0), A_MASK,	PPC,		{ FRT,FRA,FRC,FRB } },
 { "fmsubs.", A(59,28,1), A_MASK,	PPC,		{ FRT,FRA,FRC,FRB } },
 
@@ -4431,31 +4658,103 @@ const struct powerpc_opcode powerpc_opco
 { "fnmadds", A(59,31,0), A_MASK,	PPC,		{ FRT,FRA,FRC,FRB } },
 { "fnmadds.",A(59,31,1), A_MASK,	PPC,		{ FRT,FRA,FRC,FRB } },
 
+{ "dmul",    XRC(59,34,0), X_MASK,	POWER6,		{ FRT, FRA, FRB } },
+{ "dmul.",   XRC(59,34,1), X_MASK,	POWER6,		{ FRT, FRA, FRB } },
+
+{ "drrnd",   ZRC(59,35,0), Z_MASK,	POWER6,		{ FRT, FRA, FRB, RMC } },
+{ "drrnd.",  ZRC(59,35,1), Z_MASK,	POWER6,		{ FRT, FRA, FRB, RMC } },
+
+{ "dscli",   ZRC(59,66,0), Z_MASK,	POWER6,		{ FRT, FRA, SH16 } },
+{ "dscli.",  ZRC(59,66,1), Z_MASK,	POWER6,		{ FRT, FRA, SH16 } },
+
+{ "dquai",   ZRC(59,67,0), Z_MASK,	POWER6,		{ TE,  FRT, FRB, RMC } },
+{ "dquai.",  ZRC(59,67,1), Z_MASK,	POWER6,		{ TE,  FRT, FRB, RMC } },
+
+{ "dscri",   ZRC(59,98,0), Z_MASK,	POWER6,		{ FRT, FRA, SH16 } },
+{ "dscri.",  ZRC(59,98,1), Z_MASK,	POWER6,		{ FRT, FRA, SH16 } },
+
+{ "drintx",  ZRC(59,99,0), Z_MASK,	POWER6,		{ R, FRT, FRB, RMC } },
+{ "drintx.", ZRC(59,99,1), Z_MASK,	POWER6,		{ R, FRT, FRB, RMC } },
+
+{ "dcmpo",   X(59,130),	   X_MASK,	POWER6,		{ BF,  FRA, FRB } },
+
+{ "dtstex",  X(59,162),	   X_MASK,	POWER6,		{ BF,  FRA, FRB } },
+{ "dtstdc",  Z(59,194),	   Z_MASK,	POWER6,		{ BF,  FRA, DCM } },
+{ "dtstdg",  Z(59,226),	   Z_MASK,	POWER6,		{ BF,  FRA, DGM } },
+
+{ "drintn",  ZRC(59,227,0), Z_MASK,	POWER6,		{ R, FRT, FRB, RMC } },
+{ "drintn.", ZRC(59,227,1), Z_MASK,	POWER6,		{ R, FRT, FRB, RMC } },
+
+{ "dctdp",   XRC(59,258,0), X_MASK,	POWER6,		{ FRT, FRB } },
+{ "dctdp.",  XRC(59,258,1), X_MASK,	POWER6,		{ FRT, FRB } },
+
+{ "dctfix",  XRC(59,290,0), X_MASK,	POWER6,		{ FRT, FRB } },
+{ "dctfix.", XRC(59,290,1), X_MASK,	POWER6,		{ FRT, FRB } },
+
+{ "ddedpd",  XRC(59,322,0), X_MASK,	POWER6,		{ SP, FRT, FRB } }, 
+{ "ddedpd.", XRC(59,322,1), X_MASK,	POWER6,		{ SP, FRT, FRB } }, 
+
+{ "dxex",    XRC(59,354,0), X_MASK,	POWER6,		{ FRT, FRB } },
+{ "dxex.",   XRC(59,354,1), X_MASK,	POWER6,		{ FRT, FRB } },
+
+{ "dsub",    XRC(59,514,0), X_MASK,	POWER6,		{ FRT, FRA, FRB } },
+{ "dsub.",   XRC(59,514,1), X_MASK,	POWER6,		{ FRT, FRA, FRB } },
+
+{ "ddiv",    XRC(59,546,0), X_MASK,	POWER6,		{ FRT, FRA, FRB } },
+{ "ddiv.",   XRC(59,546,1), X_MASK,	POWER6,		{ FRT, FRA, FRB } },
+
+{ "dcmpu",   X(59,642),	    X_MASK,	POWER6,		{ BF,  FRA, FRB } },
+
+{ "dtstsf",  X(59,674),	   X_MASK,	POWER6,		{ BF,  FRA, FRB } },
+
+{ "drsp",    XRC(59,770,0), X_MASK,	POWER6,		{ FRT, FRB } },
+{ "drsp.",   XRC(59,770,1), X_MASK,	POWER6,		{ FRT, FRB } },
+
+{ "dcffix",  XRC(59,802,0), X_MASK,	POWER6,		{ FRT, FRB } },
+{ "dcffix.", XRC(59,802,1), X_MASK,	POWER6,		{ FRT, FRB } },
+
+{ "denbcd",  XRC(59,834,0), X_MASK,	POWER6,		{ S, FRT, FRB } },
+{ "denbcd.", XRC(59,834,1), X_MASK,	POWER6,		{ S, FRT, FRB } },
+
+{ "diex",    XRC(59,866,0), X_MASK,	POWER6,		{ FRT, FRA, FRB } },
+{ "diex.",   XRC(59,866,1), X_MASK,	POWER6,		{ FRT, FRA, FRB } },
+
 { "stfq",    OP(60),	OP_MASK,	POWER2,		{ FRS, D, RA } },
 
 { "stfqu",   OP(61),	OP_MASK,	POWER2,		{ FRS, D, RA } },
 
-{ "lde",     DEO(62,0), DE_MASK,	BOOKE64,	{ RT, DES, RA } },
-{ "ldue",    DEO(62,1), DE_MASK,	BOOKE64,	{ RT, DES, RA } },
-{ "lfse",    DEO(62,4), DE_MASK,	BOOKE64,	{ FRT, DES, RA } },
+{ "stfdp",   OP(61),	OP_MASK,	POWER6,		{ FRT, D, RA0 } },
+
+{ "lde",     DEO(62,0), DE_MASK,	BOOKE64,	{ RT, DES, RA0 } },
+{ "ldue",    DEO(62,1), DE_MASK,	BOOKE64,	{ RT, DES, RA0 } },
+{ "lfse",    DEO(62,4), DE_MASK,	BOOKE64,	{ FRT, DES, RA0 } },
 { "lfsue",   DEO(62,5), DE_MASK,	BOOKE64,	{ FRT, DES, RAS } },
-{ "lfde",    DEO(62,6), DE_MASK,	BOOKE64,	{ FRT, DES, RA } },
+{ "lfde",    DEO(62,6), DE_MASK,	BOOKE64,	{ FRT, DES, RA0 } },
 { "lfdue",   DEO(62,7), DE_MASK,	BOOKE64,	{ FRT, DES, RAS } },
-{ "stde",    DEO(62,8), DE_MASK,	BOOKE64,	{ RS, DES, RA } },
+{ "stde",    DEO(62,8), DE_MASK,	BOOKE64,	{ RS, DES, RA0 } },
 { "stdue",   DEO(62,9), DE_MASK,	BOOKE64,	{ RS, DES, RAS } },
-{ "stfse",   DEO(62,12), DE_MASK,	BOOKE64,	{ FRS, DES, RA } },
+{ "stfse",   DEO(62,12), DE_MASK,	BOOKE64,	{ FRS, DES, RA0 } },
 { "stfsue",  DEO(62,13), DE_MASK,	BOOKE64,	{ FRS, DES, RAS } },
-{ "stfde",   DEO(62,14), DE_MASK,	BOOKE64,	{ FRS, DES, RA } },
+{ "stfde",   DEO(62,14), DE_MASK,	BOOKE64,	{ FRS, DES, RA0 } },
 { "stfdue",  DEO(62,15), DE_MASK,	BOOKE64,	{ FRS, DES, RAS } },
 
-{ "std",     DSO(62,0),	DS_MASK,	PPC64,		{ RS, DS, RA } },
+{ "std",     DSO(62,0),	DS_MASK,	PPC64,		{ RS, DS, RA0 } },
 
 { "stdu",    DSO(62,1),	DS_MASK,	PPC64,		{ RS, DS, RAS } },
 
-{ "stq",     DSO(62,2),	DS_MASK,	POWER4,		{ RSQ, DS, RA } },
+{ "stq",     DSO(62,2),	DS_MASK,	POWER4,		{ RSQ, DS, RA0 } },
 
 { "fcmpu",   X(63,0),	X_MASK|(3<<21),	COM,		{ BF, FRA, FRB } },
 
+{ "daddq",   XRC(63,2,0), X_MASK,	POWER6,		{ FRT, FRA, FRB } },
+{ "daddq.",  XRC(63,2,1), X_MASK,	POWER6,		{ FRT, FRA, FRB } },
+
+{ "dquaq",   ZRC(63,3,0), Z_MASK,	POWER6,		{ FRT, FRA, FRB, RMC } },
+{ "dquaq.",  ZRC(63,3,1), Z_MASK,	POWER6,		{ FRT, FRA, FRB, RMC } },
+
+{ "fcpsgn",  XRC(63,8,0), X_MASK,	POWER6,		{ FRT, FRA, FRB } },
+{ "fcpsgn.", XRC(63,8,1), X_MASK,	POWER6,		{ FRT, FRA, FRB } },
+
 { "frsp",    XRC(63,12,0), XRA_MASK,	COM,		{ FRT, FRB } },
 { "frsp.",   XRC(63,12,1), XRA_MASK,	COM,		{ FRT, FRB } },
 
@@ -4490,13 +4789,16 @@ const struct powerpc_opcode powerpc_opco
 { "fsel",    A(63,23,0), A_MASK,	PPC,		{ FRT,FRA,FRC,FRB } },
 { "fsel.",   A(63,23,1), A_MASK,	PPC,		{ FRT,FRA,FRC,FRB } },
 
+{ "fre",     A(63,24,0), AFRALFRC_MASK,	POWER5,		{ FRT, FRB, A_L } },
+{ "fre.",    A(63,24,1), AFRALFRC_MASK,	POWER5,		{ FRT, FRB, A_L } },
+
 { "fmul",    A(63,25,0), AFRB_MASK,	PPCCOM,		{ FRT, FRA, FRC } },
 { "fm",      A(63,25,0), AFRB_MASK,	PWRCOM,		{ FRT, FRA, FRC } },
 { "fmul.",   A(63,25,1), AFRB_MASK,	PPCCOM,		{ FRT, FRA, FRC } },
 { "fm.",     A(63,25,1), AFRB_MASK,	PWRCOM,		{ FRT, FRA, FRC } },
 
-{ "frsqrte", A(63,26,0), AFRAFRC_MASK,	PPC,		{ FRT, FRB } },
-{ "frsqrte.",A(63,26,1), AFRAFRC_MASK,	PPC,		{ FRT, FRB } },
+{ "frsqrte", A(63,26,0), AFRALFRC_MASK,	PPC,		{ FRT, FRB, A_L } },
+{ "frsqrte.",A(63,26,1), AFRALFRC_MASK,	PPC,		{ FRT, FRB, A_L } },
 
 { "fmsub",   A(63,28,0), A_MASK,	PPCCOM,		{ FRT,FRA,FRC,FRB } },
 { "fms",     A(63,28,0), A_MASK,	PWRCOM,		{ FRT,FRA,FRC,FRB } },
@@ -4520,6 +4822,12 @@ const struct powerpc_opcode powerpc_opco
 
 { "fcmpo",   X(63,32),	X_MASK|(3<<21),	COM,		{ BF, FRA, FRB } },
 
+{ "dmulq",   XRC(63,34,0), X_MASK,	POWER6,		{ FRT, FRA, FRB } },
+{ "dmulq.",  XRC(63,34,1), X_MASK,	POWER6,		{ FRT, FRA, FRB } },
+
+{ "drrndq",  ZRC(63,35,0), Z_MASK,	POWER6,		{ FRT, FRA, FRB, RMC } },
+{ "drrndq.", ZRC(63,35,1), Z_MASK,	POWER6,		{ FRT, FRA, FRB, RMC } },
+
 { "mtfsb1",  XRC(63,38,0), XRARB_MASK,	COM,		{ BT } },
 { "mtfsb1.", XRC(63,38,1), XRARB_MASK,	COM,		{ BT } },
 
@@ -4528,36 +4836,100 @@ const struct powerpc_opcode powerpc_opco
 
 { "mcrfs",   X(63,64),	XRB_MASK|(3<<21)|(3<<16), COM,	{ BF, BFA } },
 
+{ "dscliq",  ZRC(63,66,0), Z_MASK,	POWER6,		{ FRT, FRA, SH16 } },
+{ "dscliq.", ZRC(63,66,1), Z_MASK,	POWER6,		{ FRT, FRA, SH16 } },
+
+{ "dquaiq",  ZRC(63,67,0), Z_MASK,	POWER6,		{ TE,  FRT, FRB, RMC } },
+{ "dquaiq.", ZRC(63,67,1), Z_MASK,	POWER6,		{ FRT, FRA, FRB, RMC } },
+
 { "mtfsb0",  XRC(63,70,0), XRARB_MASK,	COM,		{ BT } },
 { "mtfsb0.", XRC(63,70,1), XRARB_MASK,	COM,		{ BT } },
 
 { "fmr",     XRC(63,72,0), XRA_MASK,	COM,		{ FRT, FRB } },
 { "fmr.",    XRC(63,72,1), XRA_MASK,	COM,		{ FRT, FRB } },
 
+{ "dscriq",  ZRC(63,98,0), Z_MASK,	POWER6,		{ FRT, FRA, SH16 } },
+{ "dscriq.", ZRC(63,98,1), Z_MASK,	POWER6,		{ FRT, FRA, SH16 } },
+
+{ "drintxq", ZRC(63,99,0), Z_MASK,	POWER6,		{ R, FRT, FRB, RMC } },
+{ "drintxq.",ZRC(63,99,1), Z_MASK,	POWER6,		{ R, FRT, FRB, RMC } },
+
+{ "dcmpoq",  X(63,130),	   X_MASK,	POWER6,		{ BF,  FRA, FRB } },
+
 { "mtfsfi",  XRC(63,134,0), XRA_MASK|(3<<21)|(1<<11), COM, { BF, U } },
 { "mtfsfi.", XRC(63,134,1), XRA_MASK|(3<<21)|(1<<11), COM, { BF, U } },
 
 { "fnabs",   XRC(63,136,0), XRA_MASK,	COM,		{ FRT, FRB } },
 { "fnabs.",  XRC(63,136,1), XRA_MASK,	COM,		{ FRT, FRB } },
 
+{ "dtstexq", X(63,162),	    X_MASK,	POWER6,		{ BF,  FRA, FRB } },
+{ "dtstdcq", Z(63,194),	    Z_MASK,	POWER6,		{ BF,  FRA, DCM } },
+{ "dtstdgq", Z(63,226),	    Z_MASK,	POWER6,		{ BF,  FRA, DGM } },
+
+{ "drintnq", ZRC(63,227,0), Z_MASK,	POWER6,		{ R, FRT, FRB, RMC } },
+{ "drintnq.",ZRC(63,227,1), Z_MASK,	POWER6,		{ R, FRT, FRB, RMC } },
+
+{ "dctqpq",  XRC(63,258,0), X_MASK,	POWER6,		{ FRT, FRB } },
+{ "dctqpq.", XRC(63,258,1), X_MASK,	POWER6,		{ FRT, FRB } },
+
 { "fabs",    XRC(63,264,0), XRA_MASK,	COM,		{ FRT, FRB } },
 { "fabs.",   XRC(63,264,1), XRA_MASK,	COM,		{ FRT, FRB } },
 
+{ "dctfixq", XRC(63,290,0), X_MASK,	POWER6,		{ FRT, FRB } },
+{ "dctfixq.",XRC(63,290,1), X_MASK,	POWER6,		{ FRT, FRB } },
+
+{ "ddedpdq", XRC(63,322,0), X_MASK,	POWER6,		{ SP, FRT, FRB } },
+{ "ddedpdq.",XRC(63,322,1), X_MASK,	POWER6,		{ SP, FRT, FRB } },
+
+{ "dxexq",   XRC(63,354,0), X_MASK,	POWER6,		{ FRT, FRB } },
+{ "dxexq.",  XRC(63,354,1), X_MASK,	POWER6,		{ FRT, FRB } },
+
+{ "frin",    XRC(63,392,0), XRA_MASK,	POWER5,		{ FRT, FRB } },
+{ "frin.",   XRC(63,392,1), XRA_MASK,	POWER5,		{ FRT, FRB } },
+{ "friz",    XRC(63,424,0), XRA_MASK,	POWER5,		{ FRT, FRB } },
+{ "friz.",   XRC(63,424,1), XRA_MASK,	POWER5,		{ FRT, FRB } },
+{ "frip",    XRC(63,456,0), XRA_MASK,	POWER5,		{ FRT, FRB } },
+{ "frip.",   XRC(63,456,1), XRA_MASK,	POWER5,		{ FRT, FRB } },
+{ "frim",    XRC(63,488,0), XRA_MASK,	POWER5,		{ FRT, FRB } },
+{ "frim.",   XRC(63,488,1), XRA_MASK,	POWER5,		{ FRT, FRB } },
+
+{ "dsubq",   XRC(63,514,0), X_MASK,	POWER6,		{ FRT, FRA, FRB } },
+{ "dsubq.",  XRC(63,514,1), X_MASK,	POWER6,		{ FRT, FRA, FRB } },
+
+{ "ddivq",   XRC(63,546,0), X_MASK,	POWER6,		{ FRT, FRA, FRB } },
+{ "ddivq.",  XRC(63,546,1), X_MASK,	POWER6,		{ FRT, FRA, FRB } },
+
 { "mffs",    XRC(63,583,0), XRARB_MASK,	COM,		{ FRT } },
 { "mffs.",   XRC(63,583,1), XRARB_MASK,	COM,		{ FRT } },
 
+{ "dcmpuq",  X(63,642),	    X_MASK,	POWER6,		{ BF,  FRA, FRB } },
+
+{ "dtstsfq", X(63,674),	    X_MASK,	POWER6,		{ BF,  FRA, FRB } },
+
 { "mtfsf",   XFL(63,711,0), XFL_MASK,	COM,		{ FLM, FRB } },
 { "mtfsf.",  XFL(63,711,1), XFL_MASK,	COM,		{ FLM, FRB } },
 
+{ "drdpq",   XRC(63,770,0), X_MASK,	POWER6,		{ FRT, FRB } },
+{ "drdpq.",  XRC(63,770,1), X_MASK,	POWER6,		{ FRT, FRB } },
+
+{ "dcffixq", XRC(63,802,0), X_MASK,	POWER6,		{ FRT, FRB } },
+{ "dcffixq.",XRC(63,802,1), X_MASK,	POWER6,		{ FRT, FRB } },
+
 { "fctid",   XRC(63,814,0), XRA_MASK,	PPC64,		{ FRT, FRB } },
 { "fctid.",  XRC(63,814,1), XRA_MASK,	PPC64,		{ FRT, FRB } },
 
 { "fctidz",  XRC(63,815,0), XRA_MASK,	PPC64,		{ FRT, FRB } },
 { "fctidz.", XRC(63,815,1), XRA_MASK,	PPC64,		{ FRT, FRB } },
 
+{ "denbcdq", XRC(63,834,0), X_MASK,	POWER6,		{ S, FRT, FRB } },
+{ "denbcdq.",XRC(63,834,1), X_MASK,	POWER6,		{ S, FRT, FRB } },
+
 { "fcfid",   XRC(63,846,0), XRA_MASK,	PPC64,		{ FRT, FRB } },
 { "fcfid.",  XRC(63,846,1), XRA_MASK,	PPC64,		{ FRT, FRB } },
 
+{ "diexq",   XRC(63,866,0), X_MASK,	POWER6,		{ FRT, FRA, FRB } },
+{ "diexq.",  XRC(63,866,1), X_MASK,	POWER6,		{ FRT, FRA, FRB } },
+
 };
 
 const int powerpc_num_opcodes =
Index: cell/arch/powerpc/xmon/ppc.h
===================================================================
--- cell.orig/arch/powerpc/xmon/ppc.h
+++ cell/arch/powerpc/xmon/ppc.h
@@ -1,5 +1,5 @@
 /* ppc.h -- Header file for PowerPC opcode table
-   Copyright 1994, 1995, 1999, 2000, 2001, 2002, 2003
+   Copyright 1994, 1995, 1999, 2000, 2001, 2002, 2003, 2004, 2005, 2006
    Free Software Foundation, Inc.
    Written by Ian Lance Taylor, Cygnus Support
 
@@ -17,7 +17,7 @@ the GNU General Public License for more 
 
 You should have received a copy of the GNU General Public License
 along with this file; see the file COPYING.  If not, write to the Free
-Software Foundation, 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.  */
+Software Foundation, 51 Franklin Street - Fifth Floor, Boston, MA 02110-1301, USA.  */
 
 #ifndef PPC_H
 #define PPC_H
@@ -134,6 +134,18 @@ extern const int powerpc_num_opcodes;
 /* Opcode is supported by machine check APU.  */
 #define PPC_OPCODE_RFMCI	  0x800000
 
+/* Opcode is only supported by Power5 architecture.  */
+#define PPC_OPCODE_POWER5	 0x1000000
+
+/* Opcode is supported by PowerPC e300 family.  */
+#define PPC_OPCODE_E300          0x2000000
+
+/* Opcode is only supported by Power6 architecture.  */
+#define PPC_OPCODE_POWER6	 0x4000000
+
+/* Opcode is only supported by PowerPC Cell family.  */
+#define PPC_OPCODE_CELL		 0x8000000
+
 /* A macro to extract the major opcode from an instruction.  */
 #define PPC_OP(i) (((i) >> 26) & 0x3f)
 
@@ -233,25 +245,28 @@ extern const struct powerpc_operand powe
    register names with a leading 'r'.  */
 #define PPC_OPERAND_GPR (040)
 
+/* Like PPC_OPERAND_GPR, but don't print a leading 'r' for r0.  */
+#define PPC_OPERAND_GPR_0 (0100)
+
 /* This operand names a floating point register.  The disassembler
    prints these with a leading 'f'.  */
-#define PPC_OPERAND_FPR (0100)
+#define PPC_OPERAND_FPR (0200)
 
 /* This operand is a relative branch displacement.  The disassembler
    prints these symbolically if possible.  */
-#define PPC_OPERAND_RELATIVE (0200)
+#define PPC_OPERAND_RELATIVE (0400)
 
 /* This operand is an absolute branch address.  The disassembler
    prints these symbolically if possible.  */
-#define PPC_OPERAND_ABSOLUTE (0400)
+#define PPC_OPERAND_ABSOLUTE (01000)
 
 /* This operand is optional, and is zero if omitted.  This is used for
-   the optional BF and L fields in the comparison instructions.  The
+   example, in the optional BF field in the comparison instructions.  The
    assembler must count the number of operands remaining on the line,
    and the number of operands remaining for the opcode, and decide
    whether this operand is present or not.  The disassembler should
    print this operand out only if it is not zero.  */
-#define PPC_OPERAND_OPTIONAL (01000)
+#define PPC_OPERAND_OPTIONAL (02000)
 
 /* This flag is only used with PPC_OPERAND_OPTIONAL.  If this operand
    is omitted, then for the next operand use this operand value plus
@@ -259,24 +274,24 @@ extern const struct powerpc_operand powe
    hack is needed because the Power rotate instructions can take
    either 4 or 5 operands.  The disassembler should print this operand
    out regardless of the PPC_OPERAND_OPTIONAL field.  */
-#define PPC_OPERAND_NEXT (02000)
+#define PPC_OPERAND_NEXT (04000)
 
 /* This operand should be regarded as a negative number for the
    purposes of overflow checking (i.e., the normal most negative
    number is disallowed and one more than the normal most positive
    number is allowed).  This flag will only be set for a signed
    operand.  */
-#define PPC_OPERAND_NEGATIVE (04000)
+#define PPC_OPERAND_NEGATIVE (010000)
 
 /* This operand names a vector unit register.  The disassembler
    prints these with a leading 'v'.  */
-#define PPC_OPERAND_VR (010000)
+#define PPC_OPERAND_VR (020000)
 
 /* This operand is for the DS field in a DS form instruction.  */
-#define PPC_OPERAND_DS (020000)
+#define PPC_OPERAND_DS (040000)
 
 /* This operand is for the DQ field in a DQ form instruction.  */
-#define PPC_OPERAND_DQ (040000)
+#define PPC_OPERAND_DQ (0100000)
 
 /* The POWER and PowerPC assemblers use a few macros.  We keep them
    with the operands table for simplicity.  The macro table is an
