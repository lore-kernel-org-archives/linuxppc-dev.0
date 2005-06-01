Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AF9A0679A6
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Jun 2005 17:02:38 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 01 Jun 2005 17:02:22 +1000
Message-Id: <1117609342.5409.1.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] ppc32: Apple device-tree bug fix
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi !

This is the ppc32 patch equivalent to the just posted ppc64 one working
around a bug in Apple device-trees regarding the "cpus" nodes.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/arch/ppc/syslib/prom_init.c
===================================================================
--- linux-work.orig/arch/ppc/syslib/prom_init.c	2005-05-02 10:48:08.000000000 +1000
+++ linux-work/arch/ppc/syslib/prom_init.c	2005-06-01 16:09:27.000000000 +1000
@@ -626,8 +626,18 @@
 	l = call_prom("package-to-path", 3, 1, node,
 		      mem_start, mem_end - mem_start);
 	if (l >= 0) {
+		char *p, *ep;
+
 		np->full_name = PTRUNRELOC((char *) mem_start);
 		*(char *)(mem_start + l) = 0;
+		/* Fixup an Apple bug where they have bogus \0 chars in the
+		 * middle of the path in some properties
+		 */
+		for (p = (char *)mem_start, ep = p + l; p < ep; p++)
+			if ((*p) == '\0') {
+				memmove(p, p+1, ep - p);
+				ep--;
+			}
 		mem_start = ALIGNUL(mem_start + l + 1);
 	}
 
