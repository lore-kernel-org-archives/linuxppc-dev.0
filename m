Return-Path: <mauricfo@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40H6k438JFzDrnp
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Apr 2018 01:50:51 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w35Fo5sS075430
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Apr 2018 11:50:49 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2h5k0jv4n4-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Apr 2018 11:50:49 -0400
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mauricfo@linux.vnet.ibm.com>;
 Thu, 5 Apr 2018 11:50:48 -0400
From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, jeyu@kernel.org
Cc: jeyu@redhat.com, akpm@linux-foundation.org, mpe@ellerman.id.au,
 npiggin@gmail.com, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3] powerpc/64: Fix section mismatch warnings for early boot
 symbols
Date: Thu,  5 Apr 2018 12:50:39 -0300
Message-Id: <1522943439-26235-1-git-send-email-mauricfo@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some of the boot code located at the start of kernel text is "init"
class, in that it only runs at boot time, however marking it as normal
init code is problematic because that puts it into a different section
located at the very end of kernel text.

e.g., in case the TOC is not set up, we may not be able to tolerate a
branch trampoline to reach the init function.

Credits: code and message are based on 2016 patch by Nicholas Piggin,
and slightly modified so not to rename the powerpc code/symbol names.

    Subject: [PATCH] powerpc/64: quieten section mismatch warnings
    From: Nicholas Piggin <npiggin at gmail.com>
    Date: Fri Dec 23 00:14:19 AEDT 2016

This resolves the following section mismatch warnings:

    WARNING: vmlinux.o(.text+0x2fa8): Section mismatch in reference from the variable __boot_from_prom to the function .init.text:prom_init()
    The function __boot_from_prom() references
    the function __init prom_init().
    This is often because __boot_from_prom lacks a __init
    annotation or the annotation of prom_init is wrong.

    WARNING: vmlinux.o(.text+0x3238): Section mismatch in reference from the variable start_here_multiplatform to the function .init.text:early_setup()
    The function start_here_multiplatform() references
    the function __init early_setup().
    This is often because start_here_multiplatform lacks a __init
    annotation or the annotation of early_setup is wrong.

    WARNING: vmlinux.o(.text+0x326c): Section mismatch in reference from the variable start_here_common to the function .init.text:start_kernel()
    The function start_here_common() references
    the function __init start_kernel().
    This is often because start_here_common lacks a __init
    annotation or the annotation of start_kernel is wrong.

Signed-off-by: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
---
v3: reword some comments and include errors in commit message
v2: fix build error due to missing parenthesis
 scripts/mod/modpost.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 4ff08a0..d10c9d8 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1173,8 +1173,15 @@ static const struct sectioncheck *section_mismatch(
  *   fromsec = text section
  *   refsymname = *.constprop.*
  *
+ * Pattern 6:
+ *   powerpc64 has boot functions that reference init, but must remain in text.
+ *   This pattern is identified by
+ *   tosec   = init section
+ *   fromsym = __boot_from_prom, start_here_common, start_here_multiplatform
+ *
  **/
-static int secref_whitelist(const struct sectioncheck *mismatch,
+static int secref_whitelist(const struct elf_info *elf,
+			    const struct sectioncheck *mismatch,
 			    const char *fromsec, const char *fromsym,
 			    const char *tosec, const char *tosym)
 {
@@ -1211,6 +1218,17 @@ static int secref_whitelist(const struct sectioncheck *mismatch,
 	    match(fromsym, optim_symbols))
 		return 0;
 
+	/* Check for pattern 6 */
+	if (elf->hdr->e_machine == EM_PPC64)
+		if (match(tosec, init_sections) &&
+		    (!strncmp(fromsym, "__boot_from_prom",
+				strlen("__boot_from_prom")) ||
+		     !strncmp(fromsym, "start_here_common",
+				strlen("start_here_common")) ||
+		     !strncmp(fromsym, "start_here_multiplatform",
+				strlen("start_here_multiplatform"))))
+			return 0;
+
 	return 1;
 }
 
@@ -1551,7 +1569,7 @@ static void default_mismatch_handler(const char *modname, struct elf_info *elf,
 	tosym = sym_name(elf, to);
 
 	/* check whitelist - we may ignore it */
-	if (secref_whitelist(mismatch,
+	if (secref_whitelist(elf, mismatch,
 			     fromsec, fromsym, tosec, tosym)) {
 		report_sec_mismatch(modname, mismatch,
 				    fromsec, r->r_offset, fromsym,
-- 
1.8.3.1
