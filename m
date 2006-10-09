Return-Path: <viro@ftp.linux.org.uk>
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [195.92.253.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AC5BE67B93
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Oct 2006 01:26:51 +1000 (EST)
Date: Mon, 9 Oct 2006 16:26:47 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] mv64630_pic NULL noise removal
Message-ID: <20061009152647.GR29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/ppc/syslib/mv64360_pic.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/ppc/syslib/mv64360_pic.c b/arch/ppc/syslib/mv64360_pic.c
index 3f6d162..5104386 100644
--- a/arch/ppc/syslib/mv64360_pic.c
+++ b/arch/ppc/syslib/mv64360_pic.c
@@ -380,7 +380,7 @@ mv64360_register_hdlrs(void)
 	/* Clear old errors and register CPU interface error intr handler */
 	mv64x60_write(&bh, MV64x60_CPU_ERR_CAUSE, 0);
 	if ((rc = request_irq(MV64x60_IRQ_CPU_ERR + mv64360_irq_base,
-		mv64360_cpu_error_int_handler, IRQF_DISABLED, CPU_INTR_STR, 0)))
+		mv64360_cpu_error_int_handler, IRQF_DISABLED, CPU_INTR_STR, NULL)))
 		printk(KERN_WARNING "Can't register cpu error handler: %d", rc);
 
 	mv64x60_write(&bh, MV64x60_CPU_ERR_MASK, 0);
@@ -389,7 +389,7 @@ mv64360_register_hdlrs(void)
 	/* Clear old errors and register internal SRAM error intr handler */
 	mv64x60_write(&bh, MV64360_SRAM_ERR_CAUSE, 0);
 	if ((rc = request_irq(MV64360_IRQ_SRAM_PAR_ERR + mv64360_irq_base,
-		mv64360_sram_error_int_handler,IRQF_DISABLED,SRAM_INTR_STR, 0)))
+		mv64360_sram_error_int_handler,IRQF_DISABLED,SRAM_INTR_STR, NULL)))
 		printk(KERN_WARNING "Can't register SRAM error handler: %d",rc);
 
 	/* Clear old errors and register PCI 0 error intr handler */
-- 
1.4.2.GIT
