Return-Path: <srs0=fjvl=cn=linux.vnet.ibm.com=hbathini@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ycSfr1HrFzDqlF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Nov 2017 02:17:40 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3ycSfr0ZMRz8t1V
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Nov 2017 02:17:40 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3ycSfq3HvMz9s7C
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Nov 2017 02:17:39 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vAFFH7NB049512
 for <linuxppc-dev@ozlabs.org>; Wed, 15 Nov 2017 10:17:36 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2e8mqxjy6e-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 15 Nov 2017 10:17:35 -0500
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Wed, 15 Nov 2017 15:17:33 -0000
Subject: [PATCH v9 3/8] lib/cmdline.c: add backslash support to kernel
 commandline parsing
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 lkml <linux-kernel@vger.kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Ankit Kumar <ankit@linux.vnet.ibm.com>,
 Michal =?utf-8?b?U3VjaMOhbmVr?= <msuchanek@suse.de>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Wed, 15 Nov 2017 20:47:25 +0530
In-Reply-To: <151075897205.14434.9005256552409420263.stgit@hbathini.in.ibm.com>
References: <151075897205.14434.9005256552409420263.stgit@hbathini.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <151075904367.14434.5164139208561977016.stgit@hbathini.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Michal Suchanek <msuchanek@suse.de>

This allows passing quotes in kernel arguments. It is useful for passing
nested arguemnts and might be useful if somebody wanted to pass a double
quote directly as part of an argument. It is also useful to have quoting
grammar more similar to shells and bootloaders.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
---
 lib/cmdline.c |   41 ++++++++++++++++++++---------------------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/lib/cmdline.c b/lib/cmdline.c
index 6d398a8..d98bdc0 100644
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
