Return-Path: <galak@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 6B69567A65
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  3 Mar 2005 15:34:20 +1100 (EST)
Date: Wed, 2 Mar 2005 22:34:08 -0600 (CST)
From: Kumar Gala <galak@freescale.com>
To: akpm@osdl.org
Message-ID: <Pine.LNX.4.61.0503022231450.28697@blarg.somerset.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
Subject: [PATCH] ppc32: Trivial bug fix in CRITICAL_EXCEPTION macro
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Andrew,

This patch fixes a trival bug in the CRITICAL_EXCEPTION macro

Signed-off-by: Takeharu KATO <kato.takeharu@jp.fujitsu.com>
Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
diff -Nru a/arch/ppc/kernel/head_booke.h b/arch/ppc/kernel/head_booke.h
--- a/arch/ppc/kernel/head_booke.h	2005-03-02 22:20:28 -06:00
+++ b/arch/ppc/kernel/head_booke.h	2005-03-02 22:20:28 -06:00
@@ -194,8 +194,8 @@
 	CRITICAL_EXCEPTION_PROLOG;				\
 	addi	r3,r1,STACK_FRAME_OVERHEAD;			\
 	EXC_XFER_TEMPLATE(hdlr, n+2, (MSR_KERNEL & ~(MSR_ME|MSR_DE|MSR_CE)), \
-			  NOCOPY, transfer_to_handler_full, \
-			  ret_from_except_full)
+			  NOCOPY, crit_transfer_to_handler, \
+			  ret_from_crit_exc)
 
 #define MCHECK_EXCEPTION(n, label, hdlr)			\
 	START_EXCEPTION(label);					\
