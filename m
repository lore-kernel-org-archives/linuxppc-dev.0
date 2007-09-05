Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 19702E02D9
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Sep 2007 05:29:21 +1000 (EST)
Date: Wed, 5 Sep 2007 14:29:13 -0500
From: Scott Wood <scottwood@freescale.com>
To: galak@kernel.crashing.org
Subject: [PATCH 04/10] cpm2: Add cpm2_set_pin().
Message-ID: <20070905192913.GC32462@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070905192841.GA32441@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This provides a generic way for board code to set up CPM pins, rather
than directly poking magic values into registers.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/sysdev/cpm2_common.c |   33 +++++++++++++++++++++++++++++++++
 include/asm-powerpc/cpm2.h        |    9 +++++++++
 2 files changed, 42 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/sysdev/cpm2_common.c b/arch/powerpc/sysdev/cpm2_common.c
index 549da4b..41acbbf 100644
--- a/arch/powerpc/sysdev/cpm2_common.c
+++ b/arch/powerpc/sysdev/cpm2_common.c
@@ -418,3 +418,36 @@ void *cpm_dpram_addr(unsigned long offset)
 	return (void __force *)(im_dprambase + offset);
 }
 EXPORT_SYMBOL(cpm_dpram_addr);
+
+struct cpm2_ioports {
+	u32 dir, par, sor, odr, dat;
+	u32 res[3];
+};
+
+void cpm2_set_pin(int port, int pin, int flags)
+{
+	struct cpm2_ioports __iomem *iop =
+		(struct cpm2_ioports __iomem *)&cpm2_immr->im_ioport;
+
+	pin = 1 << (31 - pin);
+
+	if (flags & CPM_PIN_OUTPUT)
+		setbits32(&iop[port].dir, pin);
+	else
+		clrbits32(&iop[port].dir, pin);
+
+	if (!(flags & CPM_PIN_GPIO))
+		setbits32(&iop[port].par, pin);
+	else
+		clrbits32(&iop[port].par, pin);
+
+	if (flags & CPM_PIN_SECONDARY)
+		setbits32(&iop[port].sor, pin);
+	else
+		clrbits32(&iop[port].sor, pin);
+
+	if (flags & CPM_PIN_OPENDRAIN)
+		setbits32(&iop[port].odr, pin);
+	else
+		clrbits32(&iop[port].odr, pin);
+}
diff --git a/include/asm-powerpc/cpm2.h b/include/asm-powerpc/cpm2.h
index 41a45db..d7b57ac 100644
--- a/include/asm-powerpc/cpm2.h
+++ b/include/asm-powerpc/cpm2.h
@@ -1247,5 +1247,14 @@ enum cpm_clk {
 extern int cpm2_clk_setup(enum cpm_clk_target target, int clock, int mode);
 extern int cpm2_smc_clk_setup(enum cpm_clk_target target, int clock);
 
+#define CPM_PIN_INPUT     0
+#define CPM_PIN_OUTPUT    1
+#define CPM_PIN_PRIMARY   0
+#define CPM_PIN_SECONDARY 2
+#define CPM_PIN_GPIO      4
+#define CPM_PIN_OPENDRAIN 8
+
+void cpm2_set_pin(int port, int pin, int flags);
+
 #endif /* __CPM2__ */
 #endif /* __KERNEL__ */
-- 
1.5.3
