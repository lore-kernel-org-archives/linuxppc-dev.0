Return-Path: <msuchanek@suse.de>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xv1tg1T4DzDrZX
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Sep 2017 03:03:07 +1000 (AEST)
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
Subject: [PATCH 5/6] lib/cmdline.c: Implement single quotes in commandline
 argument parsing
Date: Fri, 15 Sep 2017 19:02:50 +0200
Message-Id: <286201ef5be4f48110b8ec6ed02b12f01315333d.1505494668.git.msuchanek@suse.de>
In-Reply-To: <28da60231eb848981e858fa33e3b7e33f8547111.1505494668.git.msuchanek@suse.de>
References: <28da60231eb848981e858fa33e3b7e33f8547111.1505494668.git.msuchanek@suse.de>
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

This brings the kernel parser about on par with bourne shell, grub, and
other tools that chew the arguments before kernel does.

This should make it easier to deal with multiple levels of
nesting/quoting. With same quoting grammar on each level there is less
room for confusion.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 lib/cmdline.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/lib/cmdline.c b/lib/cmdline.c
index d98bdc017545..c5335a79a177 100644
--- a/lib/cmdline.c
+++ b/lib/cmdline.c
@@ -191,34 +191,45 @@ bool parse_option_str(const char *str, const char *option)
 	return false;
 }
 
+#define squash_char { \
+	memmove(args + 1, args, i); \
+	args++; \
+	i--; \
+}
+
 /*
  * Parse a string to get a param value pair.
- * You can use " around spaces, and you can escape with \
+ * You can use " or ' around spaces, and you can escape with \
  * Hyphens and underscores equivalent in parameter names.
  */
 char *next_arg(char *args, char **param, char **val)
 {
 	unsigned int i, equals = 0;
-	int in_quote = 0, backslash = 0;
+	int in_quote = 0, backslash = 0, in_single = 0;
 	char *next;
 
 	for (i = 0; args[i]; i++) {
-		if (isspace(args[i]) && !in_quote && !backslash)
+		if (isspace(args[i]) && !in_quote && !backslash && !in_single)
 			break;
 
 		if ((equals == 0) && (args[i] == '='))
 			equals = i;
 
-		if (!backslash) {
-			if ((args[i] == '"') || (args[i] == '\\')) {
+		if (in_single) {
+			if (args[i] == '\'') {
+				in_single = 0;
+				squash_char;
+			}
+		} else if (!backslash) {
+			if ((args[i] == '"') || (args[i] == '\\') ||
+					(args[i] == '\'')) {
 				if (args[i] == '"')
 					in_quote = !in_quote;
 				if (args[i] == '\\')
 					backslash = 1;
-
-				memmove(args + 1, args, i);
-				args++;
-				i--;
+				if (args[i] == '\'')
+					in_single = 1;
+				squash_char;
 			}
 		} else {
 			backslash = 0;
-- 
2.10.2
