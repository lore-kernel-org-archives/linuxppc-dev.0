Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A89F21A004C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2015 22:26:17 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 3/5] powerpc/pseries: Use rtas_call_unlocked() in pseries
 hotplug
Date: Tue, 24 Nov 2015 22:26:10 +1100
Message-Id: <1448364372-28065-3-git-send-email-mpe@ellerman.id.au>
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
 arch/powerpc/platforms/pseries/hotplug-cpu.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index 62475440fd45..86d2ecacb237 100644
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -88,13 +88,7 @@ void set_default_offline_state(int cpu)
 
 static void rtas_stop_self(void)
 {
-	static struct rtas_args args = {
-		.nargs = 0,
-		.nret = cpu_to_be32(1),
-		.rets = &args.args[0],
-	};
-
-	args.token = cpu_to_be32(rtas_stop_self_token);
+	static struct rtas_args args;
 
 	local_irq_disable();
 
@@ -102,7 +96,8 @@ static void rtas_stop_self(void)
 
 	printk("cpu %u (hwid %u) Ready to die...\n",
 	       smp_processor_id(), hard_smp_processor_id());
-	enter_rtas(__pa(&args));
+
+	rtas_call_unlocked(&args, rtas_stop_self_token, 0, 1, NULL);
 
 	panic("Alas, I survived.\n");
 }
-- 
2.5.0
