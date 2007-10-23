Return-Path: <aurel32@hall.aurel32.net>
Received: from hall.aurel32.net (hall.aurel32.net [88.191.38.19])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C6C69DDEDF
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Oct 2007 23:40:08 +1000 (EST)
Date: Tue, 23 Oct 2007 15:06:38 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] [PPC/POWERPC] i8259: Add disable method
Message-ID: <20071023130638.GA736@hall.aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Sender: "aurel32,,," <aurel32@hall.aurel32.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Since commit 76d2160147f43f982dfe881404cfde9fd0a9da21, the NE2000 card
is not working anymore on PPC and POWERPC and produces WATCHDOG 
timeouts.

The patch below fixes that the same way it has been done on x86, x86_64 
and MIPS.

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>

diff --git a/arch/powerpc/sysdev/i8259.c b/arch/powerpc/sysdev/i8259.c
index 7c1b27a..216c0f5 100644
--- a/arch/powerpc/sysdev/i8259.c
+++ b/arch/powerpc/sysdev/i8259.c
@@ -137,6 +137,7 @@ static void i8259_unmask_irq(unsigned int irq_nr)
 static struct irq_chip i8259_pic = {
 	.typename	= " i8259    ",
 	.mask		= i8259_mask_irq,
+	.disable	= i8259_mask_irq,
 	.unmask		= i8259_unmask_irq,
 	.mask_ack	= i8259_mask_and_ack_irq,
 };
diff --git a/arch/ppc/syslib/i8259.c b/arch/ppc/syslib/i8259.c
index 1e5a00a..559f27c 100644
--- a/arch/ppc/syslib/i8259.c
+++ b/arch/ppc/syslib/i8259.c
@@ -127,6 +127,7 @@ static void i8259_unmask_irq(unsigned int irq_nr)
 static struct irq_chip i8259_pic = {
 	.typename	= " i8259    ",
 	.mask		= i8259_mask_irq,
+	.disable	= i8259_mask_irq,
 	.unmask		= i8259_unmask_irq,
 	.mask_ack	= i8259_mask_and_ack_irq,
 };

-- 
  .''`.  Aurelien Jarno	            | GPG: 1024D/F1BCDB73
 : :' :  Debian developer           | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
