Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rf3gZ2rCczDqpK
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 21:37:14 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5SBTBhG087544
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 07:37:11 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23sm3uxc8x-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 07:37:11 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ravi.bangoria@linux.vnet.ibm.com>;
 Tue, 28 Jun 2016 21:37:08 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 784BE2BB005A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 21:37:06 +1000 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5SBb6ix21954662
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 21:37:06 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5SBb5j0003103
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 21:37:06 +1000
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, acme@kernel.org,
 linuxppc-dev@lists.ozlabs.org
Cc: anton@ozlabs.org, mpe@ellerman.id.au, ananth@in.ibm.com, dja@axtens.net,
 naveen.n.rao@linux.vnet.ibm.com,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: [PATCH 4/4] perf annotate: Define macro for arch names
Date: Tue, 28 Jun 2016 17:06:47 +0530
In-Reply-To: <1467113807-29571-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
References: <1467113807-29571-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
Message-Id: <1467113807-29571-5-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Define macro for each arch name and use them instead of using arch
name as string.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
---
 tools/perf/arch/common.c           | 36 ++++++++++++++++++------------------
 tools/perf/arch/common.h           | 11 +++++++++++
 tools/perf/util/annotate.c         | 10 +++++-----
 tools/perf/util/unwind-libunwind.c |  4 ++--
 4 files changed, 36 insertions(+), 25 deletions(-)

diff --git a/tools/perf/arch/common.c b/tools/perf/arch/common.c
index ee69668..feb2113 100644
--- a/tools/perf/arch/common.c
+++ b/tools/perf/arch/common.c
@@ -122,25 +122,25 @@ static int lookup_triplets(const char *const *triplets, const char *name)
 const char *normalize_arch(char *arch)
 {
 	if (!strcmp(arch, "x86_64"))
-		return "x86";
+		return NORM_X86;
 	if (arch[0] == 'i' && arch[2] == '8' && arch[3] == '6')
-		return "x86";
+		return NORM_X86;
 	if (!strcmp(arch, "sun4u") || !strncmp(arch, "sparc", 5))
-		return "sparc";
+		return NORM_SPARC;
 	if (!strcmp(arch, "aarch64") || !strcmp(arch, "arm64"))
-		return "arm64";
+		return NORM_ARM64;
 	if (!strncmp(arch, "arm", 3) || !strcmp(arch, "sa110"))
-		return "arm";
+		return NORM_ARM;
 	if (!strncmp(arch, "s390", 4))
-		return "s390";
+		return NORM_S390;
 	if (!strncmp(arch, "parisc", 6))
-		return "parisc";
+		return NORM_PARISC;
 	if (!strncmp(arch, "powerpc", 7) || !strncmp(arch, "ppc", 3))
-		return "powerpc";
+		return NORM_POWERPC;
 	if (!strncmp(arch, "mips", 4))
-		return "mips";
+		return NORM_MIPS;
 	if (!strncmp(arch, "sh", 2) && isdigit(arch[2]))
-		return "sh";
+		return NORM_SH;
 
 	return arch;
 }
@@ -180,21 +180,21 @@ static int perf_env__lookup_binutils_path(struct perf_env *env,
 		zfree(&buf);
 	}
 
-	if (!strcmp(arch, "arm"))
+	if (!strcmp(arch, NORM_ARM))
 		path_list = arm_triplets;
-	else if (!strcmp(arch, "arm64"))
+	else if (!strcmp(arch, NORM_ARM64))
 		path_list = arm64_triplets;
-	else if (!strcmp(arch, "powerpc"))
+	else if (!strcmp(arch, NORM_POWERPC))
 		path_list = powerpc_triplets;
-	else if (!strcmp(arch, "sh"))
+	else if (!strcmp(arch, NORM_SH))
 		path_list = sh_triplets;
-	else if (!strcmp(arch, "s390"))
+	else if (!strcmp(arch, NORM_S390))
 		path_list = s390_triplets;
-	else if (!strcmp(arch, "sparc"))
+	else if (!strcmp(arch, NORM_SPARC))
 		path_list = sparc_triplets;
-	else if (!strcmp(arch, "x86"))
+	else if (!strcmp(arch, NORM_X86))
 		path_list = x86_triplets;
-	else if (!strcmp(arch, "mips"))
+	else if (!strcmp(arch, NORM_MIPS))
 		path_list = mips_triplets;
 	else {
 		ui__error("binutils for %s not supported.\n", arch);
diff --git a/tools/perf/arch/common.h b/tools/perf/arch/common.h
index 6b01c73..14ca8ca 100644
--- a/tools/perf/arch/common.h
+++ b/tools/perf/arch/common.h
@@ -5,6 +5,17 @@
 
 extern const char *objdump_path;
 
+/* Macro for normalized arch names */
+#define NORM_X86	"x86"
+#define NORM_SPARC	"sparc"
+#define NORM_ARM64	"arm64"
+#define NORM_ARM	"arm"
+#define NORM_S390	"s390"
+#define NORM_PARISC	"parisc"
+#define NORM_POWERPC	"powerpc"
+#define NORM_MIPS	"mips"
+#define NORM_SH		"sh"
+
 int perf_env__lookup_objdump(struct perf_env *env);
 const char *normalize_arch(char *arch);
 
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 96c6610..8146a25 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -68,7 +68,7 @@ static int call__parse(struct ins_operands *ops,
 
 	name++;
 
-	if (!strcmp(norm_arch, "arm") && strchr(name, '+'))
+	if (!strcmp(norm_arch, NORM_ARM) && strchr(name, '+'))
 		return -1;
 
 	tok = strchr(name, '>');
@@ -255,7 +255,7 @@ static int mov__parse(struct ins_operands *ops,
 
 	target = ++s;
 
-	if (!strcmp(norm_arch, "arm"))
+	if (!strcmp(norm_arch, NORM_ARM))
 		comment = strchr(s, ';');
 	else
 		comment = strchr(s, '#');
@@ -567,13 +567,13 @@ static struct ins *ins__find(const char *name, const char *norm_arch)
 		sorted = true;
 	}
 
-	if (!strcmp(norm_arch, "x86")) {
+	if (!strcmp(norm_arch, NORM_X86)) {
 		instructions = instructions_x86;
 		nmemb = ARRAY_SIZE(instructions_x86);
-	} else if (!strcmp(norm_arch, "arm")) {
+	} else if (!strcmp(norm_arch, NORM_ARM)) {
 		instructions = instructions_arm;
 		nmemb = ARRAY_SIZE(instructions_arm);
-	} else if (!strcmp(norm_arch, "powerpc")) {
+	} else if (!strcmp(norm_arch, NORM_POWERPC)) {
 		return ins__find_powerpc(name);
 	} else {
 		pr_err("perf annotate not supported by %s arch\n", norm_arch);
diff --git a/tools/perf/util/unwind-libunwind.c b/tools/perf/util/unwind-libunwind.c
index 8547119..8d4a53f 100644
--- a/tools/perf/util/unwind-libunwind.c
+++ b/tools/perf/util/unwind-libunwind.c
@@ -36,10 +36,10 @@ int unwind__prepare_access(struct thread *thread, struct map *map)
 
 	arch = normalize_arch(thread->mg->machine->env->arch);
 
-	if (!strcmp(arch, "x86")) {
+	if (!strcmp(arch, NORM_X86)) {
 		if (dso_type != DSO__TYPE_64BIT)
 			ops = x86_32_unwind_libunwind_ops;
-	} else if (!strcmp(arch, "arm64") || !strcmp(arch, "arm")) {
+	} else if (!strcmp(arch, NORM_ARM64) || !strcmp(arch, NORM_ARM)) {
 		if (dso_type == DSO__TYPE_64BIT)
 			ops = arm64_unwind_libunwind_ops;
 	}
-- 
2.5.5
