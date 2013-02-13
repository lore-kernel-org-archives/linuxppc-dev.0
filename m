Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (www.linutronix.de [62.245.132.108])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 4F5052C008E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Feb 2013 09:39:04 +1100 (EST)
Date: Wed, 13 Feb 2013 23:38:51 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: Mark low level irq handlers NO_THREAD
Message-ID: <alpine.LFD.2.02.1302132337080.22263@ionos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: leroy christophe <christophe.leroy@c-s.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These low level handlers cannot be threaded. Mark them NO_THREAD

Reported-by: leroy christophe <christophe.leroy@c-s.fr>
Tested-by: leroy christophe <christophe.leroy@c-s.fr>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/powerpc/platforms/8xx/m8xx_setup.c |    1 +
 arch/powerpc/sysdev/cpm1.c              |    1 +
 2 files changed, 2 insertions(+)

Index: linux-stable/arch/powerpc/platforms/8xx/m8xx_setup.c
===================================================================
--- linux-stable.orig/arch/powerpc/platforms/8xx/m8xx_setup.c
+++ linux-stable/arch/powerpc/platforms/8xx/m8xx_setup.c
@@ -43,6 +43,7 @@ static irqreturn_t timebase_interrupt(in
 
 static struct irqaction tbint_irqaction = {
 	.handler = timebase_interrupt,
+	.flags = IRQF_NO_THREAD,
 	.name = "tbint",
 };
 
Index: linux-stable/arch/powerpc/sysdev/cpm1.c
===================================================================
--- linux-stable.orig/arch/powerpc/sysdev/cpm1.c
+++ linux-stable/arch/powerpc/sysdev/cpm1.c
@@ -120,6 +120,7 @@ static irqreturn_t cpm_error_interrupt(i
 
 static struct irqaction cpm_error_irqaction = {
 	.handler = cpm_error_interrupt,
+	.flags = IRQF_NO_THREAD,
 	.name = "error",
 };
 
