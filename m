Return-Path: <mauricfo@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zyfSW6xLbzF1ZN
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Mar 2018 07:42:03 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w29KdVgI134946
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Mar 2018 15:42:01 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2gkyv73mkn-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 09 Mar 2018 15:42:00 -0500
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mauricfo@linux.vnet.ibm.com>;
 Fri, 9 Mar 2018 15:42:00 -0500
From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, mpe@ellerman.id.au, jeyu@kernel.org
Cc: npiggin@gmail.com, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/64: Fix section mismatch warnings for early boot
 symbols
Date: Fri,  9 Mar 2018 17:41:51 -0300
Message-Id: <1520628111-1361-1-git-send-email-mauricfo@linux.vnet.ibm.com>
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

Signed-off-by: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
---
 scripts/mod/modpost.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 9917f92..c65d5e2 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1174,8 +1174,15 @@ static const struct sectioncheck *section_mismatch(
  *   fromsec = text section
  *   refsymname = *.constprop.*
  *
+ * Pattern 6:
+ *   powerpc64 has boot functions that reference init, but must remain in text.
+ *   This pattern is identified by
+ *   tosec   = init section
+ *   fromsym = <function list>
+ *
  **/
-static int secref_whitelist(const struct sectioncheck *mismatch,
+static int secref_whitelist(const struct elf_info *elf,
+			    const struct sectioncheck *mismatch,
 			    const char *fromsec, const char *fromsym,
 			    const char *tosec, const char *tosym)
 {
@@ -1212,6 +1219,17 @@ static int secref_whitelist(const struct sectioncheck *mismatch,
 	    match(fromsym, optim_symbols))
 		return 0;
 
+	/* Check for pattern 6 */
+	if (elf->hdr->e_machine == EM_PPC64)
+		if (match(tosec, init_sections) &&
+		    (!strncmp(fromsym, "__boot_from_prom",
+				strlen("__boot_from_prom")) ||
+		     !strncmp(fromsym, "start_here_multiplatform",
+				strlen("start_here_multiplatform")) ||
+		     !strncmp(fromsym, "start_here_common",
+				strlen("start_here_common")))
+			return 0;
+
 	return 1;
 }
 
@@ -1552,7 +1570,7 @@ static void default_mismatch_handler(const char *modname, struct elf_info *elf,
 	tosym = sym_name(elf, to);
 
 	/* check whitelist - we may ignore it */
-	if (secref_whitelist(mismatch,
+	if (secref_whitelist(elf, mismatch,
 			     fromsec, fromsym, tosec, tosym)) {
 		report_sec_mismatch(modname, mismatch,
 				    fromsec, r->r_offset, fromsym,
-- 
1.8.3.1
