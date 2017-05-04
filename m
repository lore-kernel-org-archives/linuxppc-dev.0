Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wJWQN1D0nzDqBJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 May 2017 20:26:03 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v44ANv51104080
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 May 2017 06:25:53 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2a7j1780ac-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 May 2017 06:25:53 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 4 May 2017 20:25:50 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v44APemx63963252
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 May 2017 20:25:48 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v44APF8r014477
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 May 2017 20:25:16 +1000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: David Laight <David.Laight@ACULAB.COM>, Paul Clarke <pc@us.ibm.com>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2] powerpc/kprobes: refactor kprobe_lookup_name for safer
 string operations
Date: Thu,  4 May 2017 15:54:52 +0530
Message-Id: <20170504102452.9701-1-naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use safer string manipulation functions when dealing with a
user-provided string in kprobe_lookup_name().

Reported-by: David Laight <David.Laight@ACULAB.COM>
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
Changed to ignore return value of 0 from strscpy(), as suggested by
Masami.

- Naveen

 arch/powerpc/kernel/kprobes.c | 47 ++++++++++++++++++-------------------------
 1 file changed, 20 insertions(+), 27 deletions(-)

diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
index 160ae0fa7d0d..255d28d31ca1 100644
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -53,7 +53,7 @@ bool arch_within_kprobe_blacklist(unsigned long addr)
 
 kprobe_opcode_t *kprobe_lookup_name(const char *name, unsigned int offset)
 {
-	kprobe_opcode_t *addr;
+	kprobe_opcode_t *addr = NULL;
 
 #ifdef PPC64_ELF_ABI_v2
 	/* PPC64 ABIv2 needs local entry point */
@@ -85,36 +85,29 @@ kprobe_opcode_t *kprobe_lookup_name(const char *name, unsigned int offset)
 	 * Also handle <module:symbol> format.
 	 */
 	char dot_name[MODULE_NAME_LEN + 1 + KSYM_NAME_LEN];
-	const char *modsym;
 	bool dot_appended = false;
-	if ((modsym = strchr(name, ':')) != NULL) {
-		modsym++;
-		if (*modsym != '\0' && *modsym != '.') {
-			/* Convert to <module:.symbol> */
-			strncpy(dot_name, name, modsym - name);
-			dot_name[modsym - name] = '.';
-			dot_name[modsym - name + 1] = '\0';
-			strncat(dot_name, modsym,
-				sizeof(dot_name) - (modsym - name) - 2);
-			dot_appended = true;
-		} else {
-			dot_name[0] = '\0';
-			strncat(dot_name, name, sizeof(dot_name) - 1);
-		}
-	} else if (name[0] != '.') {
-		dot_name[0] = '.';
-		dot_name[1] = '\0';
-		strncat(dot_name, name, KSYM_NAME_LEN - 2);
+	const char *c;
+	ssize_t ret = 0;
+	int len = 0;
+
+	if ((c = strnchr(name, MODULE_NAME_LEN, ':')) != NULL) {
+		c++;
+		len = c - name;
+		memcpy(dot_name, name, len);
+	} else
+		c = name;
+
+	if (*c != '\0' && *c != '.') {
+		dot_name[len++] = '.';
 		dot_appended = true;
-	} else {
-		dot_name[0] = '\0';
-		strncat(dot_name, name, KSYM_NAME_LEN - 1);
 	}
-	addr = (kprobe_opcode_t *)kallsyms_lookup_name(dot_name);
-	if (!addr && dot_appended) {
-		/* Let's try the original non-dot symbol lookup	*/
+	ret = strscpy(dot_name + len, c, KSYM_NAME_LEN);
+	if (ret > 0)
+		addr = (kprobe_opcode_t *)kallsyms_lookup_name(dot_name);
+
+	/* Fallback to the original non-dot symbol lookup */
+	if (!addr && dot_appended)
 		addr = (kprobe_opcode_t *)kallsyms_lookup_name(name);
-	}
 #else
 	addr = (kprobe_opcode_t *)kallsyms_lookup_name(name);
 #endif
-- 
2.12.2
