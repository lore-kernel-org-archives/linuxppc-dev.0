Return-Path: <bsingharora@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vDSbg09sfzDqJ0
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Feb 2017 16:04:47 +1100 (AEDT)
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vDSbf1Y9qz9s7G
 for <linuxppc-dev@ozlabs.org>; Thu,  2 Feb 2017 16:04:46 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id 194so713808pgd.0
 for <linuxppc-dev@ozlabs.org>; Wed, 01 Feb 2017 21:04:46 -0800 (PST)
From: Balbir Singh <bsingharora@gmail.com>
To: mpe@ellerman.id.au,
	linuxppc-dev@ozlabs.org
Cc: Balbir Singh <bsingharora@gmail.com>, Peter Bergner <bergner@vnet.ibm.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH 3/3] powerpc/xmon: Enable disassembly files (compilation
 changes)
Date: Thu,  2 Feb 2017 10:33:44 +0530
Message-Id: <20170202050344.6825-4-bsingharora@gmail.com>
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

After updating ppc-dis.c, ppc-opc.c and ppc.h
the following changes were made to enable compilation
and working of xmon

1. Remove all disasmebler_info
2. Use xmon's printf/print_address to output data and
   addresses respectively
3. All bfd_* types and casts have been removed
4. Optimizations related to opcd_indices have been removed
5. The dialect is set based on cpu features
6. PPC_OPCODE_CLASSIC is no longer supported in the new
   disassembler
7. VLE opcode parsing and printing has been stripped
8. Coding style conventions used for those routines has
   been retained and it does not match our CodingStyle
9. The highest supported dialect is POWER9
10. Defined ATTRIBUTE_UNUSED in ppc-dis.c
11. Defined _(x) in ppc-dis.c

Cc: Peter Bergner <bergner@vnet.ibm.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---
 arch/powerpc/xmon/ppc-dis.c | 592 ++++----------------------------------------
 arch/powerpc/xmon/ppc-opc.c |  12 +-
 arch/powerpc/xmon/ppc.h     |   2 -
 3 files changed, 60 insertions(+), 546 deletions(-)

diff --git a/arch/powerpc/xmon/ppc-dis.c b/arch/powerpc/xmon/ppc-dis.c
index c382d13..31db8c0 100644
--- a/arch/powerpc/xmon/ppc-dis.c
+++ b/arch/powerpc/xmon/ppc-dis.c
@@ -18,418 +18,18 @@ You should have received a copy of the GNU General Public License
 along with this file; see the file COPYING.  If not, write to the Free
 Software Foundation, 51 Franklin Street - Fifth Floor, Boston, MA 02110-1301, USA.  */
 
-#include "sysdep.h"
-#include <stdio.h>
+#include <asm/cputable.h>
+#include <asm/cpu_has_feature.h>
+#include "nonstdio.h"
+#include "ansidecl.h"
+#include "ppc.h"
 #include "dis-asm.h"
-#include "elf-bfd.h"
-#include "elf/ppc.h"
-#include "opintl.h"
-#include "opcode/ppc.h"
 
 /* This file provides several disassembler functions, all of which use
    the disassembler interface defined in dis-asm.h.  Several functions
    are provided because this file handles disassembly for the PowerPC
    in both big and little endian mode and also for the POWER (RS/6000)
    chip.  */
-static int print_insn_powerpc (bfd_vma, struct disassemble_info *, int,
-			       ppc_cpu_t);
-
-struct dis_private
-{
-  /* Stash the result of parsing disassembler_options here.  */
-  ppc_cpu_t dialect;
-} private;
-
-#define POWERPC_DIALECT(INFO) \
-  (((struct dis_private *) ((INFO)->private_data))->dialect)
-
-struct ppc_mopt {
-  const char *opt;
-  ppc_cpu_t cpu;
-  ppc_cpu_t sticky;
-};
-
-struct ppc_mopt ppc_opts[] = {
-  { "403",     PPC_OPCODE_PPC | PPC_OPCODE_403,
-    0 },
-  { "405",     PPC_OPCODE_PPC | PPC_OPCODE_403 | PPC_OPCODE_405,
-    0 },
-  { "440",     (PPC_OPCODE_PPC | PPC_OPCODE_BOOKE | PPC_OPCODE_440
-		| PPC_OPCODE_ISEL | PPC_OPCODE_RFMCI),
-    0 },
-  { "464",     (PPC_OPCODE_PPC | PPC_OPCODE_BOOKE | PPC_OPCODE_440
-		| PPC_OPCODE_ISEL | PPC_OPCODE_RFMCI),
-    0 },
-  { "476",     (PPC_OPCODE_PPC | PPC_OPCODE_ISEL | PPC_OPCODE_440
-		| PPC_OPCODE_476 | PPC_OPCODE_POWER4 | PPC_OPCODE_POWER5),
-    0 },
-  { "601",     PPC_OPCODE_PPC | PPC_OPCODE_601,
-    0 },
-  { "603",     PPC_OPCODE_PPC,
-    0 },
-  { "604",     PPC_OPCODE_PPC,
-    0 },
-  { "620",     PPC_OPCODE_PPC | PPC_OPCODE_64,
-    0 },
-  { "7400",    PPC_OPCODE_PPC | PPC_OPCODE_ALTIVEC,
-    0 },
-  { "7410",    PPC_OPCODE_PPC | PPC_OPCODE_ALTIVEC,
-    0 },
-  { "7450",    PPC_OPCODE_PPC | PPC_OPCODE_7450 | PPC_OPCODE_ALTIVEC,
-    0 },
-  { "7455",    PPC_OPCODE_PPC | PPC_OPCODE_ALTIVEC,
-    0 },
-  { "750cl",   PPC_OPCODE_PPC | PPC_OPCODE_750 | PPC_OPCODE_PPCPS
-    , 0 },
-  { "821",     PPC_OPCODE_PPC | PPC_OPCODE_860,
-    0 },
-  { "850",     PPC_OPCODE_PPC | PPC_OPCODE_860,
-    0 },
-  { "860",     PPC_OPCODE_PPC | PPC_OPCODE_860,
-    0 },
-  { "a2",      (PPC_OPCODE_PPC | PPC_OPCODE_ISEL | PPC_OPCODE_POWER4
-		| PPC_OPCODE_POWER5 | PPC_OPCODE_CACHELCK | PPC_OPCODE_64
-		| PPC_OPCODE_A2),
-    0 },
-  { "altivec", PPC_OPCODE_PPC,
-    PPC_OPCODE_ALTIVEC | PPC_OPCODE_ALTIVEC2 },
-  { "any",     0,
-    PPC_OPCODE_ANY },
-  { "booke",   PPC_OPCODE_PPC | PPC_OPCODE_BOOKE,
-    0 },
-  { "booke32", PPC_OPCODE_PPC | PPC_OPCODE_BOOKE,
-    0 },
-  { "cell",    (PPC_OPCODE_PPC | PPC_OPCODE_64 | PPC_OPCODE_POWER4
-		| PPC_OPCODE_CELL | PPC_OPCODE_ALTIVEC),
-    0 },
-  { "com",     PPC_OPCODE_COMMON,
-    0 },
-  { "e200z4",  (PPC_OPCODE_PPC | PPC_OPCODE_BOOKE| PPC_OPCODE_SPE
-		| PPC_OPCODE_ISEL | PPC_OPCODE_EFS | PPC_OPCODE_BRLOCK
-		| PPC_OPCODE_PMR | PPC_OPCODE_CACHELCK | PPC_OPCODE_RFMCI
-		| PPC_OPCODE_E500 | PPC_OPCODE_E200Z4),
-    PPC_OPCODE_VLE },
-  { "e300",    PPC_OPCODE_PPC | PPC_OPCODE_E300,
-    0 },
-  { "e500",    (PPC_OPCODE_PPC | PPC_OPCODE_BOOKE | PPC_OPCODE_SPE
-		| PPC_OPCODE_ISEL | PPC_OPCODE_EFS | PPC_OPCODE_BRLOCK
-		| PPC_OPCODE_PMR | PPC_OPCODE_CACHELCK | PPC_OPCODE_RFMCI
-		| PPC_OPCODE_E500),
-    0 },
-  { "e500mc",  (PPC_OPCODE_PPC | PPC_OPCODE_BOOKE | PPC_OPCODE_ISEL
-		| PPC_OPCODE_PMR | PPC_OPCODE_CACHELCK | PPC_OPCODE_RFMCI
-		| PPC_OPCODE_E500MC),
-    0 },
-  { "e500mc64",  (PPC_OPCODE_PPC | PPC_OPCODE_BOOKE | PPC_OPCODE_ISEL
-		| PPC_OPCODE_PMR | PPC_OPCODE_CACHELCK | PPC_OPCODE_RFMCI
-		| PPC_OPCODE_E500MC | PPC_OPCODE_64 | PPC_OPCODE_POWER5
-		| PPC_OPCODE_POWER6 | PPC_OPCODE_POWER7),
-    0 },
-  { "e5500",    (PPC_OPCODE_PPC | PPC_OPCODE_BOOKE | PPC_OPCODE_ISEL
-		| PPC_OPCODE_PMR | PPC_OPCODE_CACHELCK | PPC_OPCODE_RFMCI
-		| PPC_OPCODE_E500MC | PPC_OPCODE_64 | PPC_OPCODE_POWER4
-		| PPC_OPCODE_POWER5 | PPC_OPCODE_POWER6
-		| PPC_OPCODE_POWER7),
-    0 },
-  { "e6500",   (PPC_OPCODE_PPC | PPC_OPCODE_BOOKE | PPC_OPCODE_ISEL
-		| PPC_OPCODE_PMR | PPC_OPCODE_CACHELCK | PPC_OPCODE_RFMCI
-		| PPC_OPCODE_E500MC | PPC_OPCODE_64 | PPC_OPCODE_ALTIVEC
-		| PPC_OPCODE_ALTIVEC2 | PPC_OPCODE_E6500 | PPC_OPCODE_POWER4
-		| PPC_OPCODE_POWER5 | PPC_OPCODE_POWER6 | PPC_OPCODE_POWER7),
-    0 },
-  { "e500x2",  (PPC_OPCODE_PPC | PPC_OPCODE_BOOKE | PPC_OPCODE_SPE
-		| PPC_OPCODE_ISEL | PPC_OPCODE_EFS | PPC_OPCODE_BRLOCK
-		| PPC_OPCODE_PMR | PPC_OPCODE_CACHELCK | PPC_OPCODE_RFMCI
-		| PPC_OPCODE_E500),
-    0 },
-  { "efs",     PPC_OPCODE_PPC | PPC_OPCODE_EFS,
-    0 },
-  { "power4",  PPC_OPCODE_PPC | PPC_OPCODE_64 | PPC_OPCODE_POWER4,
-    0 },
-  { "power5",  (PPC_OPCODE_PPC | PPC_OPCODE_64 | PPC_OPCODE_POWER4
-		| PPC_OPCODE_POWER5),
-    0 },
-  { "power6",  (PPC_OPCODE_PPC | PPC_OPCODE_64 | PPC_OPCODE_POWER4
-		| PPC_OPCODE_POWER5 | PPC_OPCODE_POWER6 | PPC_OPCODE_ALTIVEC),
-    0 },
-  { "power7",  (PPC_OPCODE_PPC | PPC_OPCODE_ISEL | PPC_OPCODE_64
-		| PPC_OPCODE_POWER4 | PPC_OPCODE_POWER5 | PPC_OPCODE_POWER6
-		| PPC_OPCODE_POWER7 | PPC_OPCODE_ALTIVEC | PPC_OPCODE_VSX),
-    0 },
-  { "power8",  (PPC_OPCODE_PPC | PPC_OPCODE_ISEL | PPC_OPCODE_64
-		| PPC_OPCODE_POWER4 | PPC_OPCODE_POWER5 | PPC_OPCODE_POWER6
-		| PPC_OPCODE_POWER7 | PPC_OPCODE_POWER8 | PPC_OPCODE_HTM
-		| PPC_OPCODE_ALTIVEC | PPC_OPCODE_ALTIVEC2 | PPC_OPCODE_VSX),
-    0 },
-  { "power9",  (PPC_OPCODE_PPC | PPC_OPCODE_ISEL | PPC_OPCODE_64
-		| PPC_OPCODE_POWER4 | PPC_OPCODE_POWER5 | PPC_OPCODE_POWER6
-		| PPC_OPCODE_POWER7 | PPC_OPCODE_POWER8 | PPC_OPCODE_POWER9
-		| PPC_OPCODE_HTM | PPC_OPCODE_ALTIVEC | PPC_OPCODE_ALTIVEC2
-		| PPC_OPCODE_VSX | PPC_OPCODE_VSX3 ),
-    0 },
-  { "ppc",     PPC_OPCODE_PPC,
-    0 },
-  { "ppc32",   PPC_OPCODE_PPC,
-    0 },
-  { "ppc64",   PPC_OPCODE_PPC | PPC_OPCODE_64,
-    0 },
-  { "ppc64bridge", PPC_OPCODE_PPC | PPC_OPCODE_64_BRIDGE,
-    0 },
-  { "ppcps",   PPC_OPCODE_PPC | PPC_OPCODE_PPCPS,
-    0 },
-  { "pwr",     PPC_OPCODE_POWER,
-    0 },
-  { "pwr2",    PPC_OPCODE_POWER | PPC_OPCODE_POWER2,
-    0 },
-  { "pwr4",    PPC_OPCODE_PPC | PPC_OPCODE_64 | PPC_OPCODE_POWER4,
-    0 },
-  { "pwr5",    (PPC_OPCODE_PPC | PPC_OPCODE_64 | PPC_OPCODE_POWER4
-		| PPC_OPCODE_POWER5),
-    0 },
-  { "pwr5x",   (PPC_OPCODE_PPC | PPC_OPCODE_64 | PPC_OPCODE_POWER4
-		| PPC_OPCODE_POWER5),
-    0 },
-  { "pwr6",    (PPC_OPCODE_PPC | PPC_OPCODE_64 | PPC_OPCODE_POWER4
-		| PPC_OPCODE_POWER5 | PPC_OPCODE_POWER6 | PPC_OPCODE_ALTIVEC),
-    0 },
-  { "pwr7",    (PPC_OPCODE_PPC | PPC_OPCODE_ISEL | PPC_OPCODE_64
-		| PPC_OPCODE_POWER4 | PPC_OPCODE_POWER5 | PPC_OPCODE_POWER6
-		| PPC_OPCODE_POWER7 | PPC_OPCODE_ALTIVEC | PPC_OPCODE_VSX),
-    0 },
-  { "pwr8",    (PPC_OPCODE_PPC | PPC_OPCODE_ISEL | PPC_OPCODE_64
-		| PPC_OPCODE_POWER4 | PPC_OPCODE_POWER5 | PPC_OPCODE_POWER6
-		| PPC_OPCODE_POWER7 | PPC_OPCODE_POWER8 | PPC_OPCODE_HTM
-		| PPC_OPCODE_ALTIVEC | PPC_OPCODE_ALTIVEC2 | PPC_OPCODE_VSX),
-    0 },
-  { "pwr9",    (PPC_OPCODE_PPC | PPC_OPCODE_ISEL | PPC_OPCODE_64
-		| PPC_OPCODE_POWER4 | PPC_OPCODE_POWER5 | PPC_OPCODE_POWER6
-		| PPC_OPCODE_POWER7 | PPC_OPCODE_POWER8 | PPC_OPCODE_POWER9
-		| PPC_OPCODE_HTM | PPC_OPCODE_ALTIVEC | PPC_OPCODE_ALTIVEC2
-		| PPC_OPCODE_VSX | PPC_OPCODE_VSX3 ),
-    0 },
-  { "pwrx",    PPC_OPCODE_POWER | PPC_OPCODE_POWER2,
-    0 },
-  { "spe",     PPC_OPCODE_PPC | PPC_OPCODE_EFS,
-    PPC_OPCODE_SPE },
-  { "titan",   (PPC_OPCODE_PPC | PPC_OPCODE_BOOKE | PPC_OPCODE_PMR
-		| PPC_OPCODE_RFMCI | PPC_OPCODE_TITAN),
-    0 },
-  { "vle",     (PPC_OPCODE_PPC | PPC_OPCODE_BOOKE| PPC_OPCODE_SPE
-		| PPC_OPCODE_ISEL | PPC_OPCODE_EFS | PPC_OPCODE_BRLOCK
-		| PPC_OPCODE_PMR | PPC_OPCODE_CACHELCK | PPC_OPCODE_RFMCI
-		| PPC_OPCODE_E500),
-    PPC_OPCODE_VLE },
-  { "vsx",     PPC_OPCODE_PPC,
-    PPC_OPCODE_VSX | PPC_OPCODE_VSX3 },
-  { "htm",     PPC_OPCODE_PPC,
-    PPC_OPCODE_HTM },
-};
-
-/* Switch between Booke and VLE dialects for interlinked dumps.  */
-static ppc_cpu_t
-get_powerpc_dialect (struct disassemble_info *info)
-{
-  ppc_cpu_t dialect = 0;
-
-  dialect = POWERPC_DIALECT (info);
-
-  /* Disassemble according to the section headers flags for VLE-mode.  */
-  if (dialect & PPC_OPCODE_VLE
-      && info->section->owner != NULL
-      && bfd_get_flavour (info->section->owner) == bfd_target_elf_flavour
-      && elf_object_id (info->section->owner) == PPC32_ELF_DATA
-      && (elf_section_flags (info->section) & SHF_PPC_VLE) != 0)
-    return dialect;
-  else
-    return dialect & ~ PPC_OPCODE_VLE;
-}
-
-/* Handle -m and -M options that set cpu type, and .machine arg.  */
-
-ppc_cpu_t
-ppc_parse_cpu (ppc_cpu_t ppc_cpu, ppc_cpu_t *sticky, const char *arg)
-{
-  unsigned int i;
-
-  for (i = 0; i < sizeof (ppc_opts) / sizeof (ppc_opts[0]); i++)
-    if (strcmp (ppc_opts[i].opt, arg) == 0)
-      {
-	if (ppc_opts[i].sticky)
-	  {
-	    *sticky |= ppc_opts[i].sticky;
-	    if ((ppc_cpu & ~*sticky) != 0)
-	      break;
-	  }
-	ppc_cpu = ppc_opts[i].cpu;
-	break;
-      }
-  if (i >= sizeof (ppc_opts) / sizeof (ppc_opts[0]))
-    return 0;
-
-  ppc_cpu |= *sticky;
-  return ppc_cpu;
-}
-
-/* Determine which set of machines to disassemble for.  */
-
-static void
-powerpc_init_dialect (struct disassemble_info *info)
-{
-  ppc_cpu_t dialect = 0;
-  ppc_cpu_t sticky = 0;
-  char *arg;
-  struct dis_private *priv = calloc (sizeof (*priv), 1);
-
-  if (priv == NULL)
-    priv = &private;
-
-  switch (info->mach)
-    {
-    case bfd_mach_ppc_403:
-    case bfd_mach_ppc_403gc:
-      dialect = ppc_parse_cpu (dialect, &sticky, "403");
-      break;
-    case bfd_mach_ppc_405:
-      dialect = ppc_parse_cpu (dialect, &sticky, "405");
-      break;
-    case bfd_mach_ppc_601:
-      dialect = ppc_parse_cpu (dialect, &sticky, "601");
-      break;
-    case bfd_mach_ppc_a35:
-    case bfd_mach_ppc_rs64ii:
-    case bfd_mach_ppc_rs64iii:
-      dialect = ppc_parse_cpu (dialect, &sticky, "pwr2") | PPC_OPCODE_64;
-      break;
-    case bfd_mach_ppc_e500:
-      dialect = ppc_parse_cpu (dialect, &sticky, "e500");
-      break;
-    case bfd_mach_ppc_e500mc:
-      dialect = ppc_parse_cpu (dialect, &sticky, "e500mc");
-      break;
-    case bfd_mach_ppc_e500mc64:
-      dialect = ppc_parse_cpu (dialect, &sticky, "e500mc64");
-      break;
-    case bfd_mach_ppc_e5500:
-      dialect = ppc_parse_cpu (dialect, &sticky, "e5500");
-      break;
-    case bfd_mach_ppc_e6500:
-      dialect = ppc_parse_cpu (dialect, &sticky, "e6500");
-      break;
-    case bfd_mach_ppc_titan:
-      dialect = ppc_parse_cpu (dialect, &sticky, "titan");
-      break;
-    case bfd_mach_ppc_vle:
-      dialect = ppc_parse_cpu (dialect, &sticky, "vle");
-      break;
-    default:
-      dialect = ppc_parse_cpu (dialect, &sticky, "power9") | PPC_OPCODE_ANY;
-    }
-
-  arg = info->disassembler_options;
-  while (arg != NULL)
-    {
-      ppc_cpu_t new_cpu = 0;
-      char *end = strchr (arg, ',');
-
-      if (end != NULL)
-	*end = 0;
-
-      if ((new_cpu = ppc_parse_cpu (dialect, &sticky, arg)) != 0)
-	dialect = new_cpu;
-      else if (strcmp (arg, "32") == 0)
-	dialect &= ~(ppc_cpu_t) PPC_OPCODE_64;
-      else if (strcmp (arg, "64") == 0)
-	dialect |= PPC_OPCODE_64;
-      else
-	fprintf (stderr, _("warning: ignoring unknown -M%s option\n"), arg);
-
-      if (end != NULL)
-	*end++ = ',';
-      arg = end;
-    }
-
-  info->private_data = priv;
-  POWERPC_DIALECT(info) = dialect;
-}
-
-#define PPC_OPCD_SEGS 64
-static unsigned short powerpc_opcd_indices[PPC_OPCD_SEGS+1];
-#define VLE_OPCD_SEGS 32
-static unsigned short vle_opcd_indices[VLE_OPCD_SEGS+1];
-
-/* Calculate opcode table indices to speed up disassembly,
-   and init dialect.  */
-
-void
-disassemble_init_powerpc (struct disassemble_info *info)
-{
-  int i;
-  unsigned short last;
-
-  if (powerpc_opcd_indices[PPC_OPCD_SEGS] == 0)
-    {
-
-      i = powerpc_num_opcodes;
-      while (--i >= 0)
-        {
-          unsigned op = PPC_OP (powerpc_opcodes[i].opcode);
-
-          powerpc_opcd_indices[op] = i;
-        }
-
-      last = powerpc_num_opcodes;
-      for (i = PPC_OPCD_SEGS; i > 0; --i)
-        {
-          if (powerpc_opcd_indices[i] == 0)
-	    powerpc_opcd_indices[i] = last;
-          last = powerpc_opcd_indices[i];
-        }
-
-      i = vle_num_opcodes;
-      while (--i >= 0)
-        {
-          unsigned op = VLE_OP (vle_opcodes[i].opcode, vle_opcodes[i].mask);
-          unsigned seg = VLE_OP_TO_SEG (op);
-
-          vle_opcd_indices[seg] = i;
-        }
-
-      last = vle_num_opcodes;
-      for (i = VLE_OPCD_SEGS; i > 0; --i)
-        {
-          if (vle_opcd_indices[i] == 0)
-	    vle_opcd_indices[i] = last;
-          last = vle_opcd_indices[i];
-        }
-    }
-
-  if (info->arch == bfd_arch_powerpc)
-    powerpc_init_dialect (info);
-}
-
-/* Print a big endian PowerPC instruction.  */
-
-int
-print_insn_big_powerpc (bfd_vma memaddr, struct disassemble_info *info)
-{
-  return print_insn_powerpc (memaddr, info, 1, get_powerpc_dialect (info));
-}
-
-/* Print a little endian PowerPC instruction.  */
-
-int
-print_insn_little_powerpc (bfd_vma memaddr, struct disassemble_info *info)
-{
-  return print_insn_powerpc (memaddr, info, 0, get_powerpc_dialect (info));
-}
-
-/* Print a POWER (RS/6000) instruction.  */
-
-int
-print_insn_rs6000 (bfd_vma memaddr, struct disassemble_info *info)
-{
-  return print_insn_powerpc (memaddr, info, 1, PPC_OPCODE_POWER);
-}
 
 /* Extract the operand value from the PowerPC or POWER instruction.  */
 
@@ -498,11 +98,9 @@ lookup_powerpc (unsigned long insn, ppc_cpu_t dialect)
   /* Get the major opcode of the instruction.  */
   op = PPC_OP (insn);
 
+  opcode_end = powerpc_opcodes + powerpc_num_opcodes;
   /* Find the first match in the opcode table for this major opcode.  */
-  opcode_end = powerpc_opcodes + powerpc_opcd_indices[op + 1];
-  for (opcode = powerpc_opcodes + powerpc_opcd_indices[op];
-       opcode < opcode_end;
-       ++opcode)
+  for (opcode = powerpc_opcodes; opcode < opcode_end; ++opcode)
     {
       const unsigned char *opindex;
       const struct powerpc_operand *operand;
@@ -531,110 +129,45 @@ lookup_powerpc (unsigned long insn, ppc_cpu_t dialect)
   return NULL;
 }
 
-/* Find a match for INSN in the VLE opcode table.  */
+/* Print a PowerPC or POWER instruction.  */
 
-static const struct powerpc_opcode *
-lookup_vle (unsigned long insn)
+int print_insn_powerpc (unsigned long insn, unsigned long memaddr)
 {
   const struct powerpc_opcode *opcode;
-  const struct powerpc_opcode *opcode_end;
-  unsigned op, seg;
-
-  op = PPC_OP (insn);
-  if (op >= 0x20 && op <= 0x37)
-    {
-      /* This insn has a 4-bit opcode.  */
-      op &= 0x3c;
-    }
-  seg = VLE_OP_TO_SEG (op);
-
-  /* Find the first match in the opcode table for this major opcode.  */
-  opcode_end = vle_opcodes + vle_opcd_indices[seg + 1];
-  for (opcode = vle_opcodes + vle_opcd_indices[seg];
-       opcode < opcode_end;
-       ++opcode)
-    {
-      unsigned long table_opcd = opcode->opcode;
-      unsigned long table_mask = opcode->mask;
-      bfd_boolean table_op_is_short = PPC_OP_SE_VLE(table_mask);
-      unsigned long insn2;
-      const unsigned char *opindex;
-      const struct powerpc_operand *operand;
-      int invalid;
-
-      insn2 = insn;
-      if (table_op_is_short)
-	insn2 >>= 16;
-      if ((insn2 & table_mask) != table_opcd)
-	continue;
+  bool insn_is_short;
+  ppc_cpu_t dialect;
 
-      /* Check validity of operands.  */
-      invalid = 0;
-      for (opindex = opcode->operands; *opindex != 0; ++opindex)
-	{
-	  operand = powerpc_operands + *opindex;
-	  if (operand->extract)
-	    (*operand->extract) (insn, (ppc_cpu_t)0, &invalid);
-	}
-      if (invalid)
-	continue;
+  dialect = PPC_OPCODE_PPC | PPC_OPCODE_COMMON
+            | PPC_OPCODE_64 | PPC_OPCODE_POWER4 | PPC_OPCODE_ALTIVEC;
 
-      return opcode;
-    }
+  if (cpu_has_feature(CPU_FTRS_POWER5))
+    dialect |= PPC_OPCODE_POWER5;
 
-  return NULL;
-}
+  if (cpu_has_feature(CPU_FTRS_CELL))
+    dialect |= (PPC_OPCODE_CELL | PPC_OPCODE_ALTIVEC);
 
-/* Print a PowerPC or POWER instruction.  */
+  if (cpu_has_feature(CPU_FTRS_POWER6))
+    dialect |= (PPC_OPCODE_POWER5 | PPC_OPCODE_POWER6 | PPC_OPCODE_ALTIVEC);
 
-static int
-print_insn_powerpc (bfd_vma memaddr,
-		    struct disassemble_info *info,
-		    int bigendian,
-		    ppc_cpu_t dialect)
-{
-  bfd_byte buffer[4];
-  int status;
-  unsigned long insn;
-  const struct powerpc_opcode *opcode;
-  bfd_boolean insn_is_short;
+  if (cpu_has_feature(CPU_FTRS_POWER7))
+    dialect |= (PPC_OPCODE_POWER5 | PPC_OPCODE_POWER6 | PPC_OPCODE_POWER7
+                | PPC_OPCODE_ALTIVEC | PPC_OPCODE_VSX);
 
-  status = (*info->read_memory_func) (memaddr, buffer, 4, info);
-  if (status != 0)
-    {
-      /* The final instruction may be a 2-byte VLE insn.  */
-      if ((dialect & PPC_OPCODE_VLE) != 0)
-        {
-          /* Clear buffer so unused bytes will not have garbage in them.  */
-          buffer[0] = buffer[1] = buffer[2] = buffer[3] = 0;
-          status = (*info->read_memory_func) (memaddr, buffer, 2, info);
-          if (status != 0)
-            {
-              (*info->memory_error_func) (status, memaddr, info);
-              return -1;
-            }
-        }
-      else
-        {
-          (*info->memory_error_func) (status, memaddr, info);
-          return -1;
-        }
-    }
+  if (cpu_has_feature(CPU_FTRS_POWER8))
+    dialect |= (PPC_OPCODE_POWER5 | PPC_OPCODE_POWER6 | PPC_OPCODE_POWER7
+		| PPC_OPCODE_POWER8 | PPC_OPCODE_HTM
+		| PPC_OPCODE_ALTIVEC | PPC_OPCODE_ALTIVEC2 | PPC_OPCODE_VSX);
 
-  if (bigendian)
-    insn = bfd_getb32 (buffer);
-  else
-    insn = bfd_getl32 (buffer);
+  if (cpu_has_feature(CPU_FTRS_POWER9))
+    dialect |= (PPC_OPCODE_POWER5 | PPC_OPCODE_POWER6 | PPC_OPCODE_POWER7
+		| PPC_OPCODE_POWER8 | PPC_OPCODE_POWER9 | PPC_OPCODE_HTM
+		| PPC_OPCODE_ALTIVEC | PPC_OPCODE_ALTIVEC2
+		| PPC_OPCODE_VSX | PPC_OPCODE_VSX3),
 
   /* Get the major opcode of the insn.  */
   opcode = NULL;
-  insn_is_short = FALSE;
-  if ((dialect & PPC_OPCODE_VLE) != 0)
-    {
-      opcode = lookup_vle (insn);
-      if (opcode != NULL)
-	insn_is_short = PPC_OP_SE_VLE(opcode->mask);
-    }
+  insn_is_short = false;
+
   if (opcode == NULL)
     opcode = lookup_powerpc (insn, dialect);
   if (opcode == NULL && (dialect & PPC_OPCODE_ANY) != 0)
@@ -649,9 +182,9 @@ print_insn_powerpc (bfd_vma memaddr,
       int skip_optional;
 
       if (opcode->operands[0] != 0)
-	(*info->fprintf_func) (info->stream, "%-7s ", opcode->name);
+	printf("%-7s ", opcode->name);
       else
-	(*info->fprintf_func) (info->stream, "%s", opcode->name);
+	printf("%s", opcode->name);
 
       if (insn_is_short)
         /* The operands will be fetched out of the 16-bit instruction.  */
@@ -688,34 +221,34 @@ print_insn_powerpc (bfd_vma memaddr,
 
 	  if (need_comma)
 	    {
-	      (*info->fprintf_func) (info->stream, ",");
+	      printf(",");
 	      need_comma = 0;
 	    }
 
 	  /* Print the operand as directed by the flags.  */
 	  if ((operand->flags & PPC_OPERAND_GPR) != 0
 	      || ((operand->flags & PPC_OPERAND_GPR_0) != 0 && value != 0))
-	    (*info->fprintf_func) (info->stream, "r%ld", value);
+	    printf("r%ld", value);
 	  else if ((operand->flags & PPC_OPERAND_FPR) != 0)
-	    (*info->fprintf_func) (info->stream, "f%ld", value);
+	    printf("f%ld", value);
 	  else if ((operand->flags & PPC_OPERAND_VR) != 0)
-	    (*info->fprintf_func) (info->stream, "v%ld", value);
+	    printf("v%ld", value);
 	  else if ((operand->flags & PPC_OPERAND_VSR) != 0)
-	    (*info->fprintf_func) (info->stream, "vs%ld", value);
+	    printf("vs%ld", value);
 	  else if ((operand->flags & PPC_OPERAND_RELATIVE) != 0)
-	    (*info->print_address_func) (memaddr + value, info);
+	    print_address(memaddr + value);
 	  else if ((operand->flags & PPC_OPERAND_ABSOLUTE) != 0)
-	    (*info->print_address_func) ((bfd_vma) value & 0xffffffff, info);
+	    print_address(value & 0xffffffff);
 	  else if ((operand->flags & PPC_OPERAND_FSL) != 0)
-	    (*info->fprintf_func) (info->stream, "fsl%ld", value);
+	    printf("fsl%ld", value);
 	  else if ((operand->flags & PPC_OPERAND_FCR) != 0)
-	    (*info->fprintf_func) (info->stream, "fcr%ld", value);
+	    printf("fcr%ld", value);
 	  else if ((operand->flags & PPC_OPERAND_UDI) != 0)
-	    (*info->fprintf_func) (info->stream, "%ld", value);
+	    printf("%ld", value);
 	  else if ((operand->flags & PPC_OPERAND_CR_REG) != 0
 		   && (((dialect & PPC_OPCODE_PPC) != 0)
 		       || ((dialect & PPC_OPCODE_VLE) != 0)))
-	    (*info->fprintf_func) (info->stream, "cr%ld", value);
+	    printf("cr%ld", value);
 	  else if (((operand->flags & PPC_OPERAND_CR_BIT) != 0)
 		   && (((dialect & PPC_OPCODE_PPC) != 0)
 		       || ((dialect & PPC_OPCODE_VLE) != 0)))
@@ -726,16 +259,16 @@ print_insn_powerpc (bfd_vma memaddr,
 
 	      cr = value >> 2;
 	      if (cr != 0)
-		(*info->fprintf_func) (info->stream, "4*cr%d+", cr);
+		printf("4*cr%d+", cr);
 	      cc = value & 3;
-	      (*info->fprintf_func) (info->stream, "%s", cbnames[cc]);
+	      printf("%s", cbnames[cc]);
 	    }
 	  else
-	    (*info->fprintf_func) (info->stream, "%d", (int) value);
+	    printf("%d", (int) value);
 
 	  if (need_paren)
 	    {
-	      (*info->fprintf_func) (info->stream, ")");
+	      printf(")");
 	      need_paren = 0;
 	    }
 
@@ -743,7 +276,7 @@ print_insn_powerpc (bfd_vma memaddr,
 	    need_comma = 1;
 	  else
 	    {
-	      (*info->fprintf_func) (info->stream, "(");
+	      printf("(");
 	      need_paren = 1;
 	    }
 	}
@@ -761,28 +294,7 @@ print_insn_powerpc (bfd_vma memaddr,
     }
 
   /* We could not find a match.  */
-  (*info->fprintf_func) (info->stream, ".long 0x%lx", insn);
+  printf(".long 0x%lx", insn);
 
   return 4;
 }
-
-void
-print_ppc_disassembler_options (FILE *stream)
-{
-  unsigned int i, col;
-
-  fprintf (stream, _("\n\
-The following PPC specific disassembler options are supported for use with\n\
-the -M switch:\n"));
-
-  for (col = 0, i = 0; i < sizeof (ppc_opts) / sizeof (ppc_opts[0]); i++)
-    {
-      col += fprintf (stream, " %s,", ppc_opts[i].opt);
-      if (col > 66)
-	{
-	  fprintf (stream, "\n");
-	  col = 0;
-	}
-    }
-  fprintf (stream, " 32, 64\n");
-}
diff --git a/arch/powerpc/xmon/ppc-opc.c b/arch/powerpc/xmon/ppc-opc.c
index e3ad69c..f2a49d2 100644
--- a/arch/powerpc/xmon/ppc-opc.c
+++ b/arch/powerpc/xmon/ppc-opc.c
@@ -19,10 +19,14 @@
    Software Foundation, 51 Franklin Street - Fifth Floor, Boston, MA
    02110-1301, USA.  */
 
-#include "sysdep.h"
-#include <stdio.h>
-#include "opcode/ppc.h"
-#include "opintl.h"
+#include <linux/stddef.h>
+#include <linux/kernel.h>
+#include <linux/bug.h>
+#include "nonstdio.h"
+#include "ppc.h"
+
+#define ATTRIBUTE_UNUSED
+#define _(x)	x
 
 /* This file holds the PowerPC opcode table.  The opcode table
    includes almost all of the extended instruction mnemonics.  This
diff --git a/arch/powerpc/xmon/ppc.h b/arch/powerpc/xmon/ppc.h
index 29c385f..d00f33d 100644
--- a/arch/powerpc/xmon/ppc.h
+++ b/arch/powerpc/xmon/ppc.h
@@ -21,8 +21,6 @@ Software Foundation, 51 Franklin Street - Fifth Floor, Boston, MA 02110-1301, US
 #ifndef PPC_H
 #define PPC_H
 
-#include "bfd_stdint.h"
-
 #ifdef __cplusplus
 extern "C" {
 #endif
-- 
2.9.3
