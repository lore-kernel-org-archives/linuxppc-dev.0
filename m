Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 76C561A01E6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 17:31:42 +1000 (EST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 02/10] selftests/powerpc: Fix parse_proc_maps()
Date: Wed, 23 Jul 2014 17:31:32 +1000
Message-Id: <1406100700-9702-2-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1406100700-9702-1-git-send-email-mpe@ellerman.id.au>
References: <1406100700-9702-1-git-send-email-mpe@ellerman.id.au>
Cc: sam.bobroff@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

start and end should be unsigned long.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 tools/testing/selftests/powerpc/pmu/lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/powerpc/pmu/lib.c b/tools/testing/selftests/powerpc/pmu/lib.c
index 0f6a4731d546..11e26e8cf33a 100644
--- a/tools/testing/selftests/powerpc/pmu/lib.c
+++ b/tools/testing/selftests/powerpc/pmu/lib.c
@@ -177,8 +177,8 @@ struct addr_range libc, vdso;
 
 int parse_proc_maps(void)
 {
+	unsigned long start, end;
 	char execute, name[128];
-	uint64_t start, end;
 	FILE *f;
 	int rc;
 
-- 
1.9.1
