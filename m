Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1B9D0B7D69
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  1 Feb 2010 13:33:33 +1100 (EST)
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id o112XSGu006826
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 Jan 2010 20:33:29 -0600
Subject: [PATCH] powerpc/pseries: Fix xics build without CONFIG_SMP
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 01 Feb 2010 13:33:28 +1100
Message-ID: <1264991608.8287.16.camel@pasglop>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

desc->affinity doesn't exit in that case. Let's use a macro for
the UP variant of get_irq_server(), it's the easiest way, avoids
evaluating arguments.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/platforms/pseries/xics.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/xics.c b/arch/powerpc/platforms/pseries/xics.c
index d80f193..1ee66db 100644
--- a/arch/powerpc/platforms/pseries/xics.c
+++ b/arch/powerpc/platforms/pseries/xics.c
@@ -191,11 +191,7 @@ static int get_irq_server(unsigned int virq, cpumask_t cpumask,
 	return default_server;
 }
 #else
-static int get_irq_server(unsigned int virq, cpumask_t cpumask,
-			  unsigned int strict_check)
-{
-	return default_server;
-}
+#define get_irq_server(virq, cpumask, strict_check) (default_server)
 #endif
 
 static void xics_unmask_irq(unsigned int virq)
