Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 13EEB1A004C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2015 22:26:17 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 2/5] powerpc/xmon: Use rtas_call_unlocked() in xmon
Date: Tue, 24 Nov 2015 22:26:09 +1100
Message-Id: <1448364372-28065-2-git-send-email-mpe@ellerman.id.au>
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

Avoid open coding the logic by using rtas_call_unlocked().

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/xmon/xmon.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 786bf01691c9..ff31e70b81e8 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -320,6 +320,7 @@ static inline void disable_surveillance(void)
 #ifdef CONFIG_PPC_PSERIES
 	/* Since this can't be a module, args should end up below 4GB. */
 	static struct rtas_args args;
+	int token;
 
 	/*
 	 * At this point we have got all the cpus we can into
@@ -328,17 +329,12 @@ static inline void disable_surveillance(void)
 	 * If we did try to take rtas.lock there would be a
 	 * real possibility of deadlock.
 	 */
-	args.token = rtas_token("set-indicator");
-	if (args.token == RTAS_UNKNOWN_SERVICE)
+	token = rtas_token("set-indicator");
+	if (token == RTAS_UNKNOWN_SERVICE)
 		return;
-	args.token = cpu_to_be32(args.token);
-	args.nargs = cpu_to_be32(3);
-	args.nret = cpu_to_be32(1);
-	args.rets = &args.args[3];
-	args.args[0] = cpu_to_be32(SURVEILLANCE_TOKEN);
-	args.args[1] = 0;
-	args.args[2] = 0;
-	enter_rtas(__pa(&args));
+
+	rtas_call_unlocked(&args, token, 3, 1, NULL, SURVEILLANCE_TOKEN, 0, 0);
+
 #endif /* CONFIG_PPC_PSERIES */
 }
 
-- 
2.5.0
