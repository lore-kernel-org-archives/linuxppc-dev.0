Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 57EF3B71AC
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Jun 2009 14:08:20 +1000 (EST)
To: <linuxppc-dev@ozlabs.org>
Message-Id: <56982642b8954ea193ae48c5d02e8dbd84d72f17.1244779685.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH] powerpc: Make RTAS instantiation depend on CONFIG_PPC_RTAS
Date: Fri, 12 Jun 2009 14:08:20 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently prom_init.c always instantiates RTAS, even if the kernel
is built without RTAS support - that seems wrong.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/kernel/prom_init.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 2f0e64b..6c2dc59 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -1052,6 +1052,7 @@ static void __init prom_init_mem(void)
 }
 
 
+#ifdef CONFIG_PPC_RTAS
 /*
  * Allocate room for and instantiate RTAS
  */
@@ -1109,6 +1110,9 @@ static void __init prom_instantiate_rtas(void)
 
 	prom_debug("prom_instantiate_rtas: end...\n");
 }
+#else
+static inline void prom_instantiate_rtas(void) { }
+#endif /* CONFIG_PPC_RTAS */
 
 #ifdef CONFIG_PPC64
 /*
-- 
1.6.2.1
