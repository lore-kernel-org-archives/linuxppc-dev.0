Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 385BD67CDC
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Nov 2006 13:46:04 +1100 (EST)
Subject: [PATCH] powerpc: Fix IDE build with ARCH=ppc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Tue, 21 Nov 2006 13:45:56 +1100
Message-Id: <1164077156.8207.0.camel@localhost.localdomain>
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

The recent IO accessor changes broke IDE on arch/ppc due to the IDE
stream IO macros using the new reads/writes{b,w,l} accessors that
are only defined for arch/powerpc. This adds them to arch/ppc.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-cell/include/asm-ppc/io.h
===================================================================
--- linux-cell.orig/include/asm-ppc/io.h	2006-11-21 11:01:12.000000000 +1100
+++ linux-cell/include/asm-ppc/io.h	2006-11-21 13:39:44.000000000 +1100
@@ -231,6 +231,14 @@ static inline void __raw_writel(__u32 b,
 #define insl(port, buf, nl)	_insl_ns((port)+___IO_BASE, (buf), (nl))
 #define outsl(port, buf, nl)	_outsl_ns((port)+___IO_BASE, (buf), (nl))
 
+#define readsb(a, b, n)		_insb((a), (b), (n))
+#define readsw(a, b, n)		_insw_ns((a), (b), (n))
+#define readsl(a, b, n)		_insl_ns((a), (b), (n))
+#define writesb(a, b, n)	_outsb((a),(b),(n))
+#define writesw(a, b, n)	_outsw_ns((a),(b),(n))
+#define writesl(a, b, n)	_outsl_ns((a),(b),(n))
+
+
 /*
  * On powermacs and 8xx we will get a machine check exception 
  * if we try to read data from a non-existent I/O port. Because
