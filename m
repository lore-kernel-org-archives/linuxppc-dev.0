Return-Path: <galak@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id C35DB67A64
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Apr 2005 16:03:54 +1000 (EST)
Date: Tue, 12 Apr 2005 01:03:44 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
To: Paul Mackerras <paulus@samba.org>
Message-ID: <Pine.LNX.4.61.0504120101210.10781@blarg.somerset.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
Subject: [PATCH] ppc32: Fix alignment exception checking on load/store
 multiple instructions
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paulus,

Can you take a look and ack this patch before I send to akpm.

The handling of misaligned load/store multiplies did not check to see if 
the address were ok to access before __{get,put}_user().


Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
diff -Nru a/arch/ppc/kernel/align.c b/arch/ppc/kernel/align.c
--- a/arch/ppc/kernel/align.c	2005-04-12 01:00:10 -05:00
+++ b/arch/ppc/kernel/align.c	2005-04-12 01:00:10 -05:00
@@ -290,6 +290,10 @@
 			/* lwm, stmw */
 			nb = (32 - reg) * 4;
 		}
+
+		if (!access_ok((flags & ST? VERIFY_WRITE: VERIFY_READ), addr, nb+nb0))
+			return -EFAULT;	/* bad address */
+
 		rptr = (unsigned char *) &regs->gpr[reg];
 		if (flags & LD) {
 			for (i = 0; i < nb; ++i)
