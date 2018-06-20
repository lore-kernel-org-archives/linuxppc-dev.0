Return-Path: <leitao@debian.org>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41B0SC6hnszF0wk
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jun 2018 08:51:23 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w5KMmwq1095524
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jun 2018 18:51:20 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2jqx5qura2-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jun 2018 18:51:20 -0400
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <leitao@debian.org>;
 Wed, 20 Jun 2018 18:51:19 -0400
From: Breno Leitao <leitao@debian.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Breno Leitao <leitao@debian.org>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: [PATCH] selftests/powerpc: Fix strncpy usage
Date: Wed, 20 Jun 2018 19:51:11 -0300
Message-Id: <1529535071-14555-1-git-send-email-leitao@debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There is a buffer overflow in dscr_inherit_test.c test. In main(), strncpy()'s
third argument is the lengh of the source, not the size of the destination
buffer, which makes strncpy() behaves like strcpy(), causing a buffer overflow
if argv[0] is bigger than LEN_MAX (100).

This patch simply limit the string copy to sizeof(prog) less 1 (space for \0).

CC: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 tools/testing/selftests/powerpc/dscr/dscr_inherit_exec_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/powerpc/dscr/dscr_inherit_exec_test.c b/tools/testing/selftests/powerpc/dscr/dscr_inherit_exec_test.c
index 08a8b95e3bc1..638e0dc717d5 100644
--- a/tools/testing/selftests/powerpc/dscr/dscr_inherit_exec_test.c
+++ b/tools/testing/selftests/powerpc/dscr/dscr_inherit_exec_test.c
@@ -104,6 +104,6 @@ int main(int argc, char *argv[])
 		exit(1);
 	}
 
-	strncpy(prog, argv[0], strlen(argv[0]));
+	strncpy(prog, argv[0], sizeof(prog) - 1);
 	return test_harness(dscr_inherit_exec, "dscr_inherit_exec_test");
 }
-- 
2.17.1
