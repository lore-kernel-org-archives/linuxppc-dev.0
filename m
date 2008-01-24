Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C0393DDD0A
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jan 2008 17:10:09 +1100 (EST)
Date: Thu, 24 Jan 2008 00:07:32 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Greg KH <greg@kroah.com>
Subject: [PATCH] [POWERPC] Always build setup-bus.c on powerpc
Message-ID: <Pine.LNX.4.64.0801240006380.21347@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-pci@atrey.karlin.mff.cuni.cz,
	Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The common arch/powerpc code calls in to functions in setup-bus.c
so some builds of ppc32 would fail.

Note, ppc32 usage of setup-irq.c is limited to arch/ppc and should be
removed when arch/ppc goes away.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---

Greg, recent changes that BenH has made to the arch/powerpc pci code make
this necessary. If you don't have an issue I'd like this patch to go via
the paulus's powerpc.git tree.

- k

 drivers/pci/Makefile |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 945bf02..869d689 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -31,8 +31,8 @@ obj-$(CONFIG_ALPHA) += setup-bus.o setup-irq.o
 obj-$(CONFIG_ARM) += setup-bus.o setup-irq.o
 obj-$(CONFIG_PARISC) += setup-bus.o
 obj-$(CONFIG_SUPERH) += setup-bus.o setup-irq.o
-obj-$(CONFIG_PPC32) += setup-irq.o setup-bus.o
-obj-$(CONFIG_PPC64) += setup-bus.o
+obj-$(CONFIG_PPC) += setup-bus.o
+obj-$(CONFIG_PPC32) += setup-irq.o
 obj-$(CONFIG_MIPS) += setup-bus.o setup-irq.o
 obj-$(CONFIG_X86_VISWS) += setup-irq.o

-- 
1.5.3.7
