Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17037.34726.616824.592288@cargo.ozlabs.ibm.com>
Date: Fri, 20 May 2005 16:45:58 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org, torvalds@osdl.org
Cc: linuxppc-dev@ozlabs.org, trini@kernel.crashing.org
Subject: [PATCH] ppx32: Fix uninitialized variable in set_preferred_console
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch fixes an uninitialized variable warning in
arch/ppc/kernel/setup.c, and this time gcc is actually right, there is
a path that could result in offset being uninitialized.  Zero is a
sane default in this instance.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---

diff -urN linux-2.6/arch/ppc/kernel/setup.c pmac-2.5/arch/ppc/kernel/setup.c
--- linux-2.6/arch/ppc/kernel/setup.c	2005-05-18 10:53:54.000000000 +1000
+++ pmac-2.5/arch/ppc/kernel/setup.c	2005-05-18 14:11:33.000000000 +1000
@@ -499,7 +499,7 @@
 {
 	struct device_node *prom_stdout;
 	char *name;
-	int offset;
+	int offset = 0;
 
 	if (of_stdout_device == NULL)
 		return -ENODEV;
