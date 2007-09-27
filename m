Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C30D3DDE29
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Sep 2007 04:39:19 +1000 (EST)
Date: Thu, 27 Sep 2007 13:38:55 -0500
From: Scott Wood <scottwood@freescale.com>
To: paulus@samba.org
Subject: [PATCH v4] Make instruction dumping work in real mode.
Message-ID: <20070927183855.GA18226@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On non-book-E-or-4xx, exceptions execute in real mode.  If a fault happens
that leads to a register dump, the kernel currently prints XXXXXXXX because
it doesn't realize that PC is a physical address.

This patch checks the state of the IMMU, and if necessary converts PC into a
virtual address.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
OK, just CONFIG_BOOKE this time. :-P

 arch/powerpc/kernel/process.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 57c589c..6dbde7f 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -354,6 +354,14 @@ static void show_instructions(struct pt_regs *regs)
 		if (!(i % 8))
 			printk("\n");
 
+#if !defined(CONFIG_BOOKE)
+		/* If executing with the IMMU off, adjust pc rather
+		 * than print XXXXXXXX.
+		 */
+		if (!(regs->msr & MSR_IR))
+			pc = (unsigned long)phys_to_virt(pc);
+#endif
+
 		/* We use __get_user here *only* to avoid an OOPS on a
 		 * bad address because the pc *should* only be a
 		 * kernel address.
-- 
1.5.3.1
