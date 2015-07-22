Return-Path: <thuth@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 09BAC1A1DF6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2015 02:56:53 +1000 (AEST)
From: Thomas Huth <thuth@redhat.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Subject: [PATCH] powerpc/rtas: Replace magic values with defines
Date: Wed, 22 Jul 2015 18:56:47 +0200
Message-Id: <1437584207-20677-1-git-send-email-thuth@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

rtas.h already has some nice #defines for RTAS return status
codes - let's use them instead of hard-coded "magic" values!

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 arch/powerpc/kernel/rtas.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
index 7a488c1..10fb402 100644
--- a/arch/powerpc/kernel/rtas.c
+++ b/arch/powerpc/kernel/rtas.c
@@ -478,8 +478,9 @@ unsigned int rtas_busy_delay_time(int status)
 
 	if (status == RTAS_BUSY) {
 		ms = 1;
-	} else if (status >= 9900 && status <= 9905) {
-		order = status - 9900;
+	} else if (status >= RTAS_EXTENDED_DELAY_MIN &&
+		   status <= RTAS_EXTENDED_DELAY_MAX) {
+		order = status - RTAS_EXTENDED_DELAY_MIN;
 		for (ms = 1; order > 0; order--)
 			ms *= 10;
 	}
@@ -641,7 +642,8 @@ int rtas_set_indicator_fast(int indicator, int index, int new_value)
 
 	rc = rtas_call(token, 3, 1, NULL, indicator, index, new_value);
 
-	WARN_ON(rc == -2 || (rc >= 9900 && rc <= 9905));
+	WARN_ON(rc == RTAS_BUSY || (rc >= RTAS_EXTENDED_DELAY_MIN &&
+				    rc <= RTAS_EXTENDED_DELAY_MAX));
 
 	if (rc < 0)
 		return rtas_error_rc(rc);
-- 
1.8.3.1
