Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t8XNP11fMzDt31
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Nov 2016 15:41:09 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: anton@samba.org
Subject: [PATCH 2/2] selftests/powerpc: Fail load_unaligned_zeropad on
 miscompare
Date: Thu,  3 Nov 2016 15:41:01 +1100
Message-Id: <1478148061-5724-2-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1478148061-5724-1-git-send-email-mpe@ellerman.id.au>
References: <1478148061-5724-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If the result returned by load_unaligned_zeropad() doesn't match what we
expect we should fail the test!

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 tools/testing/selftests/powerpc/primitives/load_unaligned_zeropad.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/powerpc/primitives/load_unaligned_zeropad.c b/tools/testing/selftests/powerpc/primitives/load_unaligned_zeropad.c
index cf7a4a114a90..cd7af4e1b65a 100644
--- a/tools/testing/selftests/powerpc/primitives/load_unaligned_zeropad.c
+++ b/tools/testing/selftests/powerpc/primitives/load_unaligned_zeropad.c
@@ -118,8 +118,10 @@ static int do_one_test(char *p, int page_offset)
 
 	got = load_unaligned_zeropad(p);
 
-	if (should != got)
+	if (should != got) {
 		printf("offset %u load_unaligned_zeropad returned 0x%lx, should be 0x%lx\n", page_offset, got, should);
+		return 1;
+	}
 
 	return 0;
 }
-- 
2.7.4
