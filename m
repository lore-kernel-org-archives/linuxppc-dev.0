Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qysRH5Yp1zDqCG
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 May 2016 14:54:35 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: aneesh.kumar@linux.vnet.ibm.com
Subject: [PATCH] selftests/powerpc: Fix subpage_prot test to return !0 on
 failure
Date: Mon,  2 May 2016 14:54:29 +1000
Message-Id: <1462164869-16406-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It's helpful for automated testing if the test returns error codes back
to the calling program.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 tools/testing/selftests/powerpc/mm/subpage_prot.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/powerpc/mm/subpage_prot.c b/tools/testing/selftests/powerpc/mm/subpage_prot.c
index 440180ff8089..7ccdc96b977d 100644
--- a/tools/testing/selftests/powerpc/mm/subpage_prot.c
+++ b/tools/testing/selftests/powerpc/mm/subpage_prot.c
@@ -207,14 +207,16 @@ int test_file(void)
 
 int main(int argc, char *argv[])
 {
-	test_harness(test_anon, "subpage_prot_anon");
+	int rc;
+
+	rc = test_harness(test_anon, "subpage_prot_anon");
+	if (rc)
+		return rc;
 
 	if (argc > 1)
 		file_name = argv[1];
 	else
 		file_name = "tempfile";
 
-	test_harness(test_file, "subpage_prot_file");
-
-	return 0;
+	return test_harness(test_file, "subpage_prot_file");
 }
-- 
2.5.0
