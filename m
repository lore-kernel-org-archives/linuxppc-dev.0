Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 142AA67A88
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 19 Feb 2005 07:38:38 +1100 (EST)
Date: Fri, 18 Feb 2005 12:38:36 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Andrew Morton <akpm@osdl.org>
Message-ID: <20050218203836.GB18041@gate.ebshome.net>
References: <20050218203455.GA18041@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MfFXiAuoTsnnDAfZ"
In-Reply-To: <20050218203455.GA18041@gate.ebshome.net>
Cc: linuxppc-embedded@ozlabs.org
Subject: [PATCH][PPC32] PPC4xx PIC: ack parent UIC in disable_irq
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--MfFXiAuoTsnnDAfZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Andrew,

this patch fixes bug in PPC4xx disable_irq implementation. We need to 
ACK parent UIC to prevent false triggering in case IRQ we just 
disabled was already pending.

Signed-off-by: Eugene Surovegin <ebs@ebshome.net>


--MfFXiAuoTsnnDAfZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="ppc4xx_pic_disable_irq_ack_parent.diff"

diff -Nru a/arch/ppc/syslib/ppc4xx_pic.c b/arch/ppc/syslib/ppc4xx_pic.c
--- a/arch/ppc/syslib/ppc4xx_pic.c	2005-02-18 12:12:54 -08:00
+++ b/arch/ppc/syslib/ppc4xx_pic.c	2005-02-18 12:12:54 -08:00
@@ -4,7 +4,7 @@
  * Interrupt controller driver for PowerPC 4xx-based processors.
  *
  * Eugene Surovegin <eugene.surovegin@zultys.com> or <ebs@ebshome.net>
- * Copyright (c) 2004 Zultys Technologies
+ * Copyright (c) 2004, 2005 Zultys Technologies
  *
  * Based on original code by
  *    Copyright (c) 1999 Grant Erickson <grant@lcse.umn.edu>
@@ -49,6 +49,7 @@
 {									\
 	ppc_cached_irq_mask[n] &= ~IRQ_MASK_UIC##n(irq);		\
 	mtdcr(DCRN_UIC_ER(UIC##n), ppc_cached_irq_mask[n]);		\
+	ACK_UIC##n##_PARENT						\
 }									\
 									\
 static void ppc4xx_uic##n##_ack(unsigned int irq)			\

--MfFXiAuoTsnnDAfZ--
