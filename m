Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CC7F1A004C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2015 22:26:18 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 4/5] powerpc/rtas: Use rtas_call_unlocked() in
 call_rtas_display_status()
Date: Tue, 24 Nov 2015 22:26:11 +1100
Message-Id: <1448364372-28065-4-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1448364372-28065-1-git-send-email-mpe@ellerman.id.au>
References: <1448364372-28065-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Although call_rtas_display_status() does actually want to use the
regular RTAS locking, it doesn't want the extra logic that is in
rtas_call(), so currently it open codes the logic.

Instead we can use rtas_call_unlocked(), after taking the RTAS lock.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/rtas.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
index fcf2d653a6fe..f4fa137292c4 100644
--- a/arch/powerpc/kernel/rtas.c
+++ b/arch/powerpc/kernel/rtas.c
@@ -93,21 +93,13 @@ static void unlock_rtas(unsigned long flags)
  */
 static void call_rtas_display_status(unsigned char c)
 {
-	struct rtas_args *args = &rtas.args;
 	unsigned long s;
 
 	if (!rtas.base)
 		return;
-	s = lock_rtas();
-
-	args->token = cpu_to_be32(10);
-	args->nargs = cpu_to_be32(1);
-	args->nret  = cpu_to_be32(1);
-	args->rets  = &(args->args[1]);
-	args->args[0] = cpu_to_be32(c);
-
-	enter_rtas(__pa(args));
 
+	s = lock_rtas();
+	rtas_call_unlocked(&rtas.args, 10, 1, 1, NULL, c);
 	unlock_rtas(s);
 }
 
-- 
2.5.0
