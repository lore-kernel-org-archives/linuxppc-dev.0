Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-fastnet.sasl.smtp.pobox.com
	[207.106.133.19]) by ozlabs.org (Postfix) with ESMTP id 667ECDDFFC
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Dec 2008 11:28:49 +1100 (EST)
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id
	47BA885523
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Dec 2008 19:28:44 -0500 (EST)
Received: from thinkcentre (unknown [67.9.156.46]) by
	a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPA id 0383A85522
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Dec 2008 19:28:43 -0500 (EST)
From: Nathan Lynch <ntl@pobox.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powermac: use set_hard_smp_processor_id() instead of
	smp_hw_index
Date: Wed, 10 Dec 2008 18:28:42 -0600
Message-Id: <1228955322-16995-2-git-send-email-ntl@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The hard_smp_processor_id functions are the appropriate interfaces for
managing physical CPU ids.

Signed-off-by: Nathan Lynch <ntl@pobox.com>
---
 arch/powerpc/platforms/powermac/smp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/powermac/smp.c b/arch/powerpc/platforms/powermac/smp.c
index 40f72c2..6b0711c 100644
--- a/arch/powerpc/platforms/powermac/smp.c
+++ b/arch/powerpc/platforms/powermac/smp.c
@@ -739,7 +739,7 @@ static void __init smp_core99_setup(int ncpus)
 
 		/* XXX should get this from reg properties */
 		for (i = 1; i < ncpus; ++i)
-			smp_hw_index[i] = i;
+			set_hard_smp_processor_id(i, i);
 	}
 #endif
 
-- 
1.5.5
