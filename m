Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rf3h509c9zDqpR
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 21:37:40 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5SBTCtf041145
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 07:37:38 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23snxv4r2p-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 07:37:38 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ravi.bangoria@linux.vnet.ibm.com>;
 Tue, 28 Jun 2016 21:37:34 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 5232F2BB0059
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 21:37:03 +1000 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5SBb3lP62324940
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 21:37:03 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5SBb2O9003046
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 21:37:03 +1000
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, acme@kernel.org,
 linuxppc-dev@lists.ozlabs.org
Cc: anton@ozlabs.org, mpe@ellerman.id.au, ananth@in.ibm.com, dja@axtens.net,
 naveen.n.rao@linux.vnet.ibm.com,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: [PATCH 3/4] perf annotate: add powerpc support
Date: Tue, 28 Jun 2016 17:06:46 +0530
In-Reply-To: <1467113807-29571-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
References: <1467113807-29571-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
Message-Id: <1467113807-29571-4-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>

Powerpc has long list of branch instructions and hardcoding them in table
appears to be error-prone. So, add new function to find instruction
instead of creating table.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
---
 tools/perf/util/annotate.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 36a5825..96c6610 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -476,6 +476,68 @@ static int ins__cmp(const void *a, const void *b)
 	return strcmp(ia->name, ib->name);
 }
 
+static struct ins *ins__find_powerpc(const char *name)
+{
+	int i;
+	struct ins *ins;
+
+	ins = zalloc(sizeof(struct ins));
+	if (!ins)
+		return NULL;
+
+	ins->name = strdup(name);
+	if (!ins->name)
+		return NULL;
+
+	if (name[0] == 'b') {
+		/* branch instructions */
+		ins->ops = &jump_ops;
+
+		/*
+		 * - Few start with 'b', but aren't branch instructions.
+		 * - Let's also ignore instructions involving 'ctr' and
+		 *   'tar' since target branch addresses for those can't
+		 *   be determined statically.
+		 */
+		if (!strncmp(name, "bcd", 3)   ||
+		    !strncmp(name, "brinc", 5) ||
+		    !strncmp(name, "bper", 4)  ||
+		    strstr(name, "ctr")        ||
+		    strstr(name, "tar"))
+			return NULL;
+
+		i = strlen(name) - 1;
+		if (i < 0)
+			return NULL;
+
+		/* ignore optional hints at the end of the instructions */
+		if (name[i] == '+' || name[i] == '-')
+			i--;
+
+		if (name[i] == 'l' || (name[i] == 'a' && name[i-1] == 'l')) {
+			/*
+			 * if the instruction ends up with 'l' or 'la', then
+			 * those are considered 'calls' since they update LR.
+			 * ... except for 'bnl' which is branch if not less than
+			 * and the absolute form of the same.
+			 */
+			if (strcmp(name, "bnl") && strcmp(name, "bnl+") &&
+			    strcmp(name, "bnl-") && strcmp(name, "bnla") &&
+			    strcmp(name, "bnla+") && strcmp(name, "bnla-"))
+				ins->ops = &call_ops;
+		}
+		if (name[i] == 'r' && name[i-1] == 'l')
+			/*
+			 * instructions ending with 'lr' are considered to be
+			 * return instructions
+			 */
+			ins->ops = &ret_ops;
+
+		return ins;
+	}
+	return NULL;
+}
+
 static void ins__sort(struct ins *instructions, int nmemb)
 {
 	qsort(instructions, nmemb, sizeof(struct ins), ins__cmp);
@@ -511,6 +573,8 @@ static struct ins *ins__find(const char *name, const char *norm_arch)
 	} else if (!strcmp(norm_arch, "arm")) {
 		instructions = instructions_arm;
 		nmemb = ARRAY_SIZE(instructions_arm);
+	} else if (!strcmp(norm_arch, "powerpc")) {
+		return ins__find_powerpc(name);
 	} else {
 		pr_err("perf annotate not supported by %s arch\n", norm_arch);
 		return NULL;
-- 
2.5.5
