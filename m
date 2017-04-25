Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wC28F1Sq1zDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Apr 2017 22:09:49 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: bhsharma@redhat.com,
	keescook@chromium.org,
	bsingharora@gmail.com
Subject: [PATCH] powerpc/mm: Fix possible out-of-bounds shift in
 arch_mmap_rnd()
Date: Tue, 25 Apr 2017 22:09:41 +1000
Message-Id: <1493122181-20921-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The recent patch to add runtime configuration of the ASLR limits added a bug in
arch_mmap_rnd() where we may shift an integer (32-bits) by up to 33 bits,
leading to undefined behaviour.

In practice it exhibits as every process seg faulting instantly, presumably
because the rnd value hasn't been restricited by the modulus at all. We didn't
notice because it only happens under certain kernel configurations and if the
number of bits is actually set to a large value.

Fix it by switching to unsigned long.

Fixes: 9fea59bd7ca5 ("powerpc/mm: Add support for runtime configuration of ASLR limits")
Reported-by: Balbir Singh <bsingharora@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/mm/mmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/mmap.c b/arch/powerpc/mm/mmap.c
index 005aa8a44915..9dbd2a733d6b 100644
--- a/arch/powerpc/mm/mmap.c
+++ b/arch/powerpc/mm/mmap.c
@@ -66,7 +66,7 @@ unsigned long arch_mmap_rnd(void)
 	if (is_32bit_task())
 		shift = mmap_rnd_compat_bits;
 #endif
-	rnd = get_random_long() % (1 << shift);
+	rnd = get_random_long() % (1ul << shift);
 
 	return rnd << PAGE_SHIFT;
 }
-- 
2.7.4
