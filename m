Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp01.au.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7E34CB726D
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  3 Feb 2011 14:27:45 +1100 (EST)
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp01.au.ibm.com (8.14.4/8.13.1) with ESMTP id p133O8sc032697
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Feb 2011 14:24:08 +1100
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p133RiFs1785930
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Feb 2011 14:27:44 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p133RhOh018249
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Feb 2011 14:27:44 +1100
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] ftrace syscalls: Allow arch specific syscall symbol
	matching
Date: Thu,  3 Feb 2011 14:27:23 +1100
Message-Id: <1296703645-18718-5-git-send-email-imunsie@au1.ibm.com>
In-Reply-To: <1296703645-18718-1-git-send-email-imunsie@au1.ibm.com>
References: <1296703645-18718-1-git-send-email-imunsie@au1.ibm.com>
Cc: Andreas Dilger <adilger@dilger.ca>, Andreas Schwab <schwab@linux-m68k.org>,
	Dave Kleikamp <shaggy@linux.vnet.ibm.com>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	Namhyung Kim <namhyung@gmail.com>, Jiri Kosina <jkosina@suse.cz>,
	Jason Baron <jbaron@redhat.com>, Alexander Graf <agraf@suse.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	David Gibson <dwg@au1.ibm.com>, Ingo Molnar <mingo@redhat.com>,
	Paul Mackerras <paulus@samba.org>, Ian Munsie <imunsie@au1.ibm.com>,
	KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Scott Wood <scottwood@freescale.com>, Nathan Lynch <ntl@pobox.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Avantika Mathur <mathur@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ian Munsie <imunsie@au1.ibm.com>

Some architectures have unusual symbol names and the generic code to
match the symbol name with the function name for the syscall metadata
will fail. For example, symbols on PPC64 start with a period and the
generic code will fail to match them.

This patch moves the match logic out into a separate function which an
arch can override by defining ARCH_HAS_SYSCALL_MATCH_SYM_NAME in
asm/ftrace.h and implementing arch_syscall_match_sym_name.

Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
---
 Documentation/trace/ftrace-design.txt |    4 ++++
 kernel/trace/trace_syscalls.c         |   21 ++++++++++++++-------
 2 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/Documentation/trace/ftrace-design.txt b/Documentation/trace/ftrace-design.txt
index 6fca17b..79fcafc 100644
--- a/Documentation/trace/ftrace-design.txt
+++ b/Documentation/trace/ftrace-design.txt
@@ -250,6 +250,10 @@ You need very few things to get the syscalls tracing in an arch.
 - If the system call table on this arch is more complicated than a simple array
   of addresses of the system calls, implement an arch_syscall_addr to return
   the address of a given system call.
+- If the symbol names of the system calls do not match the function names on
+  this arch, define ARCH_HAS_SYSCALL_MATCH_SYM_NAME in asm/ftrace.h and
+  implement arch_syscall_match_sym_name with the appropriate logic to return
+  true if the function name corresponds with the symbol name.
 - Tag this arch as HAVE_SYSCALL_TRACEPOINTS.
 
 
diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index 33360b9..7b76a65 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -60,6 +60,19 @@ extern unsigned long __stop_syscalls_metadata[];
 
 static struct syscall_metadata **syscalls_metadata;
 
+#ifndef ARCH_HAS_SYSCALL_MATCH_SYM_NAME
+static inline bool arch_syscall_match_sym_name(const char *sym, const char *name)
+{
+	/*
+	 * Only compare after the "sys" prefix. Archs that use
+	 * syscall wrappers may have syscalls symbols aliases prefixed
+	 * with "SyS" instead of "sys", leading to an unwanted
+	 * mismatch.
+	 */
+	return !strcmp(sym + 3, name + 3);
+}
+#endif
+
 static struct syscall_metadata *find_syscall_meta(unsigned long syscall)
 {
 	struct syscall_metadata *start;
@@ -72,13 +85,7 @@ static struct syscall_metadata *find_syscall_meta(unsigned long syscall)
 	kallsyms_lookup(syscall, NULL, NULL, NULL, str);
 
 	for ( ; start < stop; start++) {
-		/*
-		 * Only compare after the "sys" prefix. Archs that use
-		 * syscall wrappers may have syscalls symbols aliases prefixed
-		 * with "SyS" instead of "sys", leading to an unwanted
-		 * mismatch.
-		 */
-		if (start->name && !strcmp(start->name + 3, str + 3))
+		if (start->name && arch_syscall_match_sym_name(str, start->name))
 			return start;
 	}
 	return NULL;
-- 
1.7.2.3
