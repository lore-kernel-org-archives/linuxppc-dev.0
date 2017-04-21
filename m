Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w8ZtW56pYzDqHv
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Apr 2017 22:34:27 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3LCYCrD038037
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Apr 2017 08:34:26 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29y0hehrtb-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Apr 2017 08:34:22 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Fri, 21 Apr 2017 22:34:20 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3LCYA9q6947284
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Apr 2017 22:34:18 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3LCXkaa013110
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Apr 2017 22:33:46 +1000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Masami Hiramatsu <mhiramat@kernel.org>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Ingo Molnar <mingo@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/7] powerpc/kprobes: Use safer string functions in
 kprobe_lookup_name()
Date: Fri, 21 Apr 2017 18:03:20 +0530
In-Reply-To: <6e14d22994530fb5200c74d1593e73541d3b8028.1492604782.git.naveen.n.rao@linux.vnet.ibm.com>
References: <6e14d22994530fb5200c74d1593e73541d3b8028.1492604782.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <20170421123320.7344-1-naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Convert usage of strchr()/strncpy()/strncat() to
strnchr()/memcpy()/strlcat() for simpler and safer string manipulation.

Reported-by: David Laight <David.Laight@ACULAB.COM>
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
Changes: Additionally convert the strchr().


 arch/powerpc/kernel/kprobes.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
index 97b5eed1f76d..c73fb6e3b43f 100644
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -65,28 +65,27 @@ kprobe_opcode_t *kprobe_lookup_name(const char *name, unsigned int offset)
 	char dot_name[MODULE_NAME_LEN + 1 + KSYM_NAME_LEN];
 	const char *modsym;
 	bool dot_appended = false;
-	if ((modsym = strchr(name, ':')) != NULL) {
+	if ((modsym = strnchr(name, ':', MODULE_NAME_LEN)) != NULL) {
 		modsym++;
 		if (*modsym != '\0' && *modsym != '.') {
 			/* Convert to <module:.symbol> */
-			strncpy(dot_name, name, modsym - name);
+			memcpy(dot_name, name, modsym - name);
 			dot_name[modsym - name] = '.';
 			dot_name[modsym - name + 1] = '\0';
-			strncat(dot_name, modsym,
-				sizeof(dot_name) - (modsym - name) - 2);
+			strlcat(dot_name, modsym, sizeof(dot_name));
 			dot_appended = true;
 		} else {
 			dot_name[0] = '\0';
-			strncat(dot_name, name, sizeof(dot_name) - 1);
+			strlcat(dot_name, name, sizeof(dot_name));
 		}
 	} else if (name[0] != '.') {
 		dot_name[0] = '.';
 		dot_name[1] = '\0';
-		strncat(dot_name, name, KSYM_NAME_LEN - 2);
+		strlcat(dot_name, name, sizeof(dot_name));
 		dot_appended = true;
 	} else {
 		dot_name[0] = '\0';
-		strncat(dot_name, name, KSYM_NAME_LEN - 1);
+		strlcat(dot_name, name, sizeof(dot_name));
 	}
 	addr = (kprobe_opcode_t *)kallsyms_lookup_name(dot_name);
 	if (!addr && dot_appended) {
-- 
2.12.1
