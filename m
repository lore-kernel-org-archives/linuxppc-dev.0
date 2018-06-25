Return-Path: <leitao@debian.org>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41F2R81knGzF1JL
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jun 2018 07:30:59 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w5PLUcB9144055
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2018 17:30:57 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ju8cer0g6-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2018 17:30:57 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <leitao@debian.org>;
 Mon, 25 Jun 2018 15:30:56 -0600
From: Breno Leitao <leitao@debian.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Breno Leitao <leitao@debian.org>,
 Segher Boessenkool <segher@kernel.crashing.org>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: [PATCH v2] selftests/powerpc: Fix strncpy usage
Date: Mon, 25 Jun 2018 18:30:49 -0300
In-Reply-To: <1529535071-14555-1-git-send-email-leitao@debian.org>
References: <1529535071-14555-1-git-send-email-leitao@debian.org>
Message-Id: <1529962249-24774-1-git-send-email-leitao@debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There is a buffer overflow in dscr_inherit_test.c test. In main(), strncpy()'s
third argument is the length of the source, not the size of the destination
buffer, which makes strncpy() behaves like strcpy(), causing a buffer overflow
if argv[0] is bigger than LEN_MAX (100).

This patch allocates 'prog' according to the argv[0] length, avoiding LEN_MAX
restriction.

CC: Segher Boessenkool <segher@kernel.crashing.org>
CC: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 tools/testing/selftests/powerpc/dscr/dscr_inherit_exec_test.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/powerpc/dscr/dscr_inherit_exec_test.c b/tools/testing/selftests/powerpc/dscr/dscr_inherit_exec_test.c
index 08a8b95e3bc1..ecac4900c7dd 100644
--- a/tools/testing/selftests/powerpc/dscr/dscr_inherit_exec_test.c
+++ b/tools/testing/selftests/powerpc/dscr/dscr_inherit_exec_test.c
@@ -19,7 +19,7 @@
  */
 #include "dscr.h"
 
-static char prog[LEN_MAX];
+static char *prog;
 
 static void do_exec(unsigned long parent_dscr)
 {
@@ -104,6 +104,13 @@ int main(int argc, char *argv[])
 		exit(1);
 	}
 
-	strncpy(prog, argv[0], strlen(argv[0]));
+	prog = malloc(strlen(argv[0]) + 1);
+	if (prog == NULL) {
+		fprintf(stderr, "Unable to allocate enough memory\n");
+		exit(1);
+	}
+
+	strcpy(prog, argv[0]);
+
 	return test_harness(dscr_inherit_exec, "dscr_inherit_exec_test");
 }
-- 
2.16.3
