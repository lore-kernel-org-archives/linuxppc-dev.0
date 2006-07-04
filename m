Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B880D67B7D
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Jul 2006 14:07:52 +1000 (EST)
Subject: [PATCH] powerpc: Fix 32 bits warning in prom_init.c
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Tue, 04 Jul 2006 14:07:42 +1000
Message-Id: <1151986063.13828.32.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

A warning is hurting my eyes when building 32 bits kernels

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-irq-work/arch/powerpc/kernel/prom_init.c
===================================================================
--- linux-irq-work.orig/arch/powerpc/kernel/prom_init.c	2006-07-04 12:59:33.000000000 +1000
+++ linux-irq-work/arch/powerpc/kernel/prom_init.c	2006-07-04 13:00:13.000000000 +1000
@@ -557,7 +557,9 @@
 static void __init early_cmdline_parse(void)
 {
 	struct prom_t *_prom = &RELOC(prom);
+#ifdef CONFIG_PPC64
 	const char *opt;
+#endif
 	char *p;
 	int l = 0;
 
