Return-Path: <msuchanek@suse.de>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xv1td5KF9zDrYl
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Sep 2017 03:02:58 +1000 (AEST)
From: Michal Suchanek <msuchanek@suse.de>
To: Jonathan Corbet <corbet@lwn.net>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Jani Nikula <jani.nikula@intel.com>, Michal Suchanek <msuchanek@suse.de>,
 Kamlakant Patel <kamlakant.patel@broadcom.com>,
 Bamvor Jian Zhang <bamvor.zhangjian@linaro.org>,
 Tamara Diaconita <diaconitatamara@gmail.com>,
 Trond Myklebust <trond.myklebust@primarydata.com>,
 Hari Bathini <hbathini@linux.vnet.ibm.com>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Nicholas Piggin <npiggin@gmail.com>, Baoquan He <bhe@redhat.com>,
 Ilya Matveychikov <matvejchikov@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/6] lib/cmdline.c: Add backslash support to kernel
 commandline parsing.
Date: Fri, 15 Sep 2017 19:02:46 +0200
Message-Id: <28da60231eb848981e858fa33e3b7e33f8547111.1505494668.git.msuchanek@suse.de>
In-Reply-To: <4fabdf584ad18d6aae61e331f783a5020567f634.1505231820.git.msuchanek@suse.de>
References: <4fabdf584ad18d6aae61e331f783a5020567f634.1505231820.git.msuchanek@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This allows passing quotes in kernel arguments. It is useful for passing
fadump nested arguemnts in fadump_extra_args and might be useful if
somebody wanted to pass a double quote directly as part of an argument.

It is also useful to have quoting grammar more similar to shells and
bootloaders.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 lib/cmdline.c | 41 ++++++++++++++++++++---------------------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/lib/cmdline.c b/lib/cmdline.c
index 6d398a8b63fc..d98bdc017545 100644
--- a/lib/cmdline.c
+++ b/lib/cmdline.c
@@ -193,30 +193,36 @@ bool parse_option_str(const char *str, const char *option)
 
 /*
  * Parse a string to get a param value pair.
- * You can use " around spaces, but can't escape ".
+ * You can use " around spaces, and you can escape with \
  * Hyphens and underscores equivalent in parameter names.
  */
 char *next_arg(char *args, char **param, char **val)
 {
 	unsigned int i, equals = 0;
-	int in_quote = 0, quoted = 0;
+	int in_quote = 0, backslash = 0;
 	char *next;
 
-	if (*args == '"') {
-		args++;
-		in_quote = 1;
-		quoted = 1;
-	}
-
 	for (i = 0; args[i]; i++) {
-		if (isspace(args[i]) && !in_quote)
+		if (isspace(args[i]) && !in_quote && !backslash)
 			break;
-		if (equals == 0) {
-			if (args[i] == '=')
-				equals = i;
+
+		if ((equals == 0) && (args[i] == '='))
+			equals = i;
+
+		if (!backslash) {
+			if ((args[i] == '"') || (args[i] == '\\')) {
+				if (args[i] == '"')
+					in_quote = !in_quote;
+				if (args[i] == '\\')
+					backslash = 1;
+
+				memmove(args + 1, args, i);
+				args++;
+				i--;
+			}
+		} else {
+			backslash = 0;
 		}
-		if (args[i] == '"')
-			in_quote = !in_quote;
 	}
 
 	*param = args;
@@ -225,13 +231,6 @@ char *next_arg(char *args, char **param, char **val)
 	else {
 		args[equals] = '\0';
 		*val = args + equals + 1;
-
-		/* Don't include quotes in value. */
-		if ((args[i-1] == '"') && ((quoted) || (**val == '"'))) {
-			args[i-1] = '\0';
-			if (!quoted)
-				(*val)++;
-		}
 	}
 
 	if (args[i]) {
-- 
2.10.2
