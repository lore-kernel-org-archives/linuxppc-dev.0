Return-Path: <srs0=fjvl=cn=linux.vnet.ibm.com=hbathini@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ycSgw6q26zDql8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Nov 2017 02:18:36 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3ycSgw3r2mz8t1V
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Nov 2017 02:18:36 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3ycSgv67shz9s7C
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Nov 2017 02:18:35 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vAFFFXGP127569
 for <linuxppc-dev@ozlabs.org>; Wed, 15 Nov 2017 10:18:33 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2e8qqhhm01-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 15 Nov 2017 10:18:33 -0500
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Wed, 15 Nov 2017 15:18:31 -0000
Subject: [PATCH v9 5/8] lib/cmdline.c: implement single quotes in
 commandline argument parsing
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 lkml <linux-kernel@vger.kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Ankit Kumar <ankit@linux.vnet.ibm.com>,
 Michal =?utf-8?b?U3VjaMOhbmVr?= <msuchanek@suse.de>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Wed, 15 Nov 2017 20:48:25 +0530
In-Reply-To: <151075897205.14434.9005256552409420263.stgit@hbathini.in.ibm.com>
References: <151075897205.14434.9005256552409420263.stgit@hbathini.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <151075906562.14434.17655499193254963975.stgit@hbathini.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Michal Suchanek <msuchanek@suse.de>

This brings the kernel parser about on par with bourne shell, grub, and
other tools that chew the arguments before kernel does.

This should make it easier to deal with multiple levels of
nesting/quoting. With same quoting grammar on each level there is less
room for confusion.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 lib/cmdline.c |   29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/lib/cmdline.c b/lib/cmdline.c
index d98bdc0..c5335a7 100644
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
