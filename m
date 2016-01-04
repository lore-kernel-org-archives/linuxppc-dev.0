Return-Path: <hemant@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A59721A0045
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Jan 2016 20:49:33 +1100 (AEDT)
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hemant@linux.vnet.ibm.com>;
 Mon, 4 Jan 2016 19:49:31 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id A31552CE8058
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Jan 2016 20:49:29 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u049nNON21561488
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 4 Jan 2016 20:49:31 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u049musf015782
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 4 Jan 2016 20:48:57 +1100
From: Hemant Kumar <hemant@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mjw@redhat.com, masami.hiramatsu.pt@hitachi.com,
 sukadev@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 srikar@linux.vnet.ibm.com, acme@kernel.org
Subject: [PATCH v2] perf/probe: Search both .eh_frame and .debug_frame
 sections for probe location
Date: Mon,  4 Jan 2016 15:18:38 +0530
Message-Id: <1451900918-6710-1-git-send-email-hemant@linux.vnet.ibm.com>
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
of these sections is present. Depending on distro, toolchain defaults,
architetcutre, build flags, etc., CFI might be found in either .eh_frame
and/or .debug_frame. Sometimes, it may happen that, .eh_frame, even if
present, may not be complete and may miss some descriptions. Therefore,
to be sure, to find the CFI covering an address we will always have to
investigate both if available.

For e.g., in powerpc, this may happen :
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
Changes since v1:
- pf->cfi is now cached as pf->cfi_eh and pf->cfi_dbg depending on the source of CFI
  (Suggested by Mark Wielard).

 tools/perf/util/probe-finder.c | 63 +++++++++++++++++++++++++-----------------
 tools/perf/util/probe-finder.h |  5 +++-
 2 files changed, 42 insertions(+), 26 deletions(-)

diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index 05012bb..71bf27e 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -685,9 +685,10 @@ static int call_probe_finder(Dwarf_Die *sc_die, struct probe_finder *pf)
 		pf->fb_ops = NULL;
 #if _ELFUTILS_PREREQ(0, 142)
 	} else if (nops == 1 && pf->fb_ops[0].atom == DW_OP_call_frame_cfa &&
-		   pf->cfi != NULL) {
+		   (pf->cfi_eh != NULL || pf->cfi_dbg != NULL)) {
 		Dwarf_Frame *frame;
-		if (dwarf_cfi_addrframe(pf->cfi, pf->addr, &frame) != 0 ||
+		if ((dwarf_cfi_addrframe(pf->cfi_eh, pf->addr, &frame) != 0 &&
+		     (dwarf_cfi_addrframe(pf->cfi_dbg, pf->addr, &frame) != 0)) ||
 		    dwarf_frame_cfa(frame, &pf->fb_ops, &nops) != 0) {
 			pr_warning("Failed to get call frame on 0x%jx\n",
 				   (uintmax_t)pf->addr);
@@ -1013,8 +1014,7 @@ static int pubname_search_cb(Dwarf *dbg, Dwarf_Global *gl, void *data)
 	return DWARF_CB_OK;
 }
 
-/* Find probe points from debuginfo */
-static int debuginfo__find_probes(struct debuginfo *dbg,
+static int debuginfo__find_probe_location(struct debuginfo *dbg,
 				  struct probe_finder *pf)
 {
 	struct perf_probe_point *pp = &pf->pev->point;
@@ -1023,27 +1023,6 @@ static int debuginfo__find_probes(struct debuginfo *dbg,
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
@@ -1106,6 +1085,40 @@ found:
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
+	if (pf->cfi_eh || pf->cfi_dbg)
+		return debuginfo__find_probe_location(dbg, pf);
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
+		pf->cfi_eh = dwarf_getcfi_elf(elf);
+	} else {
+		pf->cfi_dbg = dwarf_getcfi(dbg->dbg);
+	}
+#endif
+
+	ret = debuginfo__find_probe_location(dbg, pf);
+	return ret;
+}
+
 struct local_vars_finder {
 	struct probe_finder *pf;
 	struct perf_probe_arg *args;
diff --git a/tools/perf/util/probe-finder.h b/tools/perf/util/probe-finder.h
index bed8271..0aec770 100644
--- a/tools/perf/util/probe-finder.h
+++ b/tools/perf/util/probe-finder.h
@@ -76,7 +76,10 @@ struct probe_finder {
 
 	/* For variable searching */
 #if _ELFUTILS_PREREQ(0, 142)
-	Dwarf_CFI		*cfi;		/* Call Frame Information */
+	/* Call Frame Information from .eh_frame */
+	Dwarf_CFI		*cfi_eh;
+	/* Call Frame Information from .debug_frame */
+	Dwarf_CFI		*cfi_dbg;
 #endif
 	Dwarf_Op		*fb_ops;	/* Frame base attribute */
 	struct perf_probe_arg	*pvar;		/* Current target variable */
-- 
1.9.3
