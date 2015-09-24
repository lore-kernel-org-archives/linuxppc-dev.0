Return-Path: <hemant@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D39671A0026
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2015 12:17:27 +1000 (AEST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hemant@linux.vnet.ibm.com>;
 Thu, 24 Sep 2015 12:17:26 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 427483578052
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2015 12:17:24 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8O2HHsd39256238
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2015 12:17:25 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8O2GopH023830
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2015 12:16:51 +1000
From: Hemant Kumar <hemant@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: acme@kernel.org, masami.hiramatsu.pt@hitachi.com, mjw@redhat.com,
 sukadev@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 srikar@linux.vnet.ibm.com, naveen.n.rao@linux.vnet.ibm.com,
 hemant@linux.vnet.ibm.com
Subject: [PATCH] perf/probe: Search both .eh_frame and .debug_frame sections
 for probe location
Date: Thu, 24 Sep 2015 07:46:30 +0530
Message-Id: <1443060990-10313-1-git-send-email-hemant@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

perf probe through debuginfo__find_probes() in util/probe-finder.c
checks for the functions' frame descriptions in either .eh_frame section
of an ELF or the .debug_frame. The check is based on whether either one
of these sections is present. But sometimes, it may happen that,
.eh_frame, even if present, may not be complete and may miss some
descriptions. For e.g., in powerpc, this may happen :
 $ gcc -g bin.c -o bin

 $ objdump --dwarf ./bin
 <1><145>: Abbrev Number: 7 (DW_TAG_subprogram)
    <146>   DW_AT_external    : 1
    <146>   DW_AT_name        : (indirect string, offset: 0x9e): main
    <14a>   DW_AT_decl_file   : 1
    <14b>   DW_AT_decl_line   : 39
    <14c>   DW_AT_prototyped  : 1
    <14c>   DW_AT_type        : <0x57>
    <150>   DW_AT_low_pc      : 0x100007b8

If the .eh_frame and .debug_frame are checked for the same binary, we
will find that, .eh_frame (although present) doesn't contain a
description for "main" function.
But, .debug_frame has a description :

000000d8 00000024 00000000 FDE cie=00000000 pc=100007b8..10000838
  DW_CFA_advance_loc: 16 to 100007c8
  DW_CFA_def_cfa_offset: 144
  DW_CFA_offset_extended_sf: r65 at cfa+16
...

Due to this (since, perf checks whether .eh_frame is present and goes on
searching for that address inside that frame), perf is unable to process
the probes :
 # perf probe -x ./bin main
Failed to get call frame on 0x100007b8
  Error: Failed to add events.

To avoid this issue, we need to check both the sections (.eh_frame and
.debug_frame), which is done in this patch.

Note that, we can always force everything into both .eh_frame and
.debug_frame by :
 $ gcc bin.c -fasynchronous-unwind-tables  -fno-dwarf2-cfi-asm -g -o bin

Signed-off-by: Hemant Kumar <hemant@linux.vnet.ibm.com>
---
 tools/perf/util/probe-finder.c | 59 +++++++++++++++++++++++++-----------------
 1 file changed, 35 insertions(+), 24 deletions(-)

diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index 2da65a7..7ce02b9 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -1022,9 +1022,8 @@ static int pubname_search_cb(Dwarf *dbg, Dwarf_Global *gl, void *data)
 	return DWARF_CB_OK;
 }
 
-/* Find probe points from debuginfo */
-static int debuginfo__find_probes(struct debuginfo *dbg,
-				  struct probe_finder *pf)
+static int debuginfo__find_probe_location(struct debuginfo *dbg,
+					  struct probe_finder *pf)
 {
 	struct perf_probe_point *pp = &pf->pev->point;
 	Dwarf_Off off, noff;
@@ -1032,27 +1031,6 @@ static int debuginfo__find_probes(struct debuginfo *dbg,
 	Dwarf_Die *diep;
 	int ret = 0;
 
-#if _ELFUTILS_PREREQ(0, 142)
-	Elf *elf;
-	GElf_Ehdr ehdr;
-	GElf_Shdr shdr;
-
-	/* Get the call frame information from this dwarf */
-	elf = dwarf_getelf(dbg->dbg);
-	if (elf == NULL)
-		return -EINVAL;
-
-	if (gelf_getehdr(elf, &ehdr) == NULL)
-		return -EINVAL;
-
-	if (elf_section_by_name(elf, &ehdr, &shdr, ".eh_frame", NULL) &&
-	    shdr.sh_type == SHT_PROGBITS) {
-		pf->cfi = dwarf_getcfi_elf(elf);
-	} else {
-		pf->cfi = dwarf_getcfi(dbg->dbg);
-	}
-#endif
-
 	off = 0;
 	pf->lcache = intlist__new(NULL);
 	if (!pf->lcache)
@@ -1115,6 +1093,39 @@ found:
 	return ret;
 }
 
+/* Find probe points from debuginfo */
+static int debuginfo__find_probes(struct debuginfo *dbg,
+				  struct probe_finder *pf)
+{
+	int ret = 0;
+
+#if _ELFUTILS_PREREQ(0, 142)
+	Elf *elf;
+	GElf_Ehdr ehdr;
+	GElf_Shdr shdr;
+
+	/* Get the call frame information from this dwarf */
+	elf = dwarf_getelf(dbg->dbg);
+	if (elf == NULL)
+		return -EINVAL;
+
+	if (gelf_getehdr(elf, &ehdr) == NULL)
+		return -EINVAL;
+
+	if (elf_section_by_name(elf, &ehdr, &shdr, ".eh_frame", NULL) &&
+	    shdr.sh_type == SHT_PROGBITS) {
+		pf->cfi = dwarf_getcfi_elf(elf);
+		ret = debuginfo__find_probe_location(dbg, pf);
+		if (ret >= 0)
+			return ret;
+	}
+	pf->cfi = dwarf_getcfi(dbg->dbg);
+#endif
+
+	ret = debuginfo__find_probe_location(dbg, pf);
+	return ret;
+}
+
 struct local_vars_finder {
 	struct probe_finder *pf;
 	struct perf_probe_arg *args;
-- 
1.9.3
