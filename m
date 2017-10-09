Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y9cXM18RjzDrCR
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Oct 2017 21:52:51 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: bauerman@linux.vnet.ibm.com
Subject: [PATCH] powerpc/perf/hv-24x7: Fix incorrect comparison in memord
Date: Mon,  9 Oct 2017 21:52:44 +1100
Message-Id: <1507546364-27628-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In the hv-24x7 code there is a function memord() which tries to
implement a sort function return -1, 0, 1. However one of the
conditions is incorrect, such that it can never be true, because we
will have already returned.

I don't believe there is a bug in practice though, because the
comparisons are an optimisation prior to calling memcmp().

Fix it by swapping the second comparision, so it can be true.

Reported-by: David Binderman <dcb314@hotmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/perf/hv-24x7.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
index 9c88b82f6229..72238eedc360 100644
--- a/arch/powerpc/perf/hv-24x7.c
+++ b/arch/powerpc/perf/hv-24x7.c
@@ -540,7 +540,7 @@ static int memord(const void *d1, size_t s1, const void *d2, size_t s2)
 {
 	if (s1 < s2)
 		return 1;
-	if (s2 > s1)
+	if (s1 > s2)
 		return -1;
 
 	return memcmp(d1, d2, s1);
-- 
2.7.4
