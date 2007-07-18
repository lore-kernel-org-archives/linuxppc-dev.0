Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8A451DDFCA
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 11:35:42 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l6I1ZbRV019080
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 18:35:37 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.83.16.18])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l6I1ZaGW001478
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:35:36 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l6I1AttQ007917
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:10:55 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id 94DA8AEFC9
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:35:35 -0500 (CDT)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l6I1ZZPQ015370
	for linuxppc-dev@ozlabs.org; Tue, 17 Jul 2007 20:35:35 -0500
Date: Tue, 17 Jul 2007 20:35:35 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 28/61] Add cpm2_set_pin().
Message-ID: <20070718013535.GZ15238@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070718013137.GA15217@ld0162-tx32.am.freescale.net>
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
 arch/powerpc/sysdev/cpm2_common.c |   28 ++++++++++++++++++++++++++++
 include/asm-ppc/cpm2.h            |    8 ++++++++
 2 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/sysdev/cpm2_common.c b/arch/powerpc/sysdev/cpm2_common.c
index 7e3a983..0a62df7 100644
--- a/arch/powerpc/sysdev/cpm2_common.c
+++ b/arch/powerpc/sysdev/cpm2_common.c
@@ -338,3 +338,31 @@ void *cpm_dpram_addr(unsigned long offset)
 	return (void *)(im_dprambase + offset);
 }
 EXPORT_SYMBOL(cpm_dpram_addr);
+
+struct cpm2_ioports {
+	u32	dir, par, sor, odr, dat;
+	u32	res[3];
+};
+
+void cpm2_set_pin(int port, int pin, int flags)
+{
+	struct cpm2_ioports __iomem *iop =
+		(struct cpm_ioports __iomem *)&cpm2_immr->im_ioport;
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
+}
diff --git a/include/asm-ppc/cpm2.h b/include/asm-ppc/cpm2.h
index 12a2860..0e7ffb6 100644
--- a/include/asm-ppc/cpm2.h
+++ b/include/asm-ppc/cpm2.h
@@ -1244,5 +1244,13 @@ enum cpm_clk {
 
 extern int cpm2_clk_setup(enum cpm_clk_target target, int clock, int mode);
 
+#define CPM_PIN_INPUT     0
+#define CPM_PIN_OUTPUT    1
+#define CPM_PIN_PRIMARY   0
+#define CPM_PIN_SECONDARY 2
+#define CPM_PIN_GPIO      4
+
+void cpm2_set_pin(int port, int pin, int flags);
+
 #endif /* __CPM2__ */
 #endif /* __KERNEL__ */
-- 
1.5.0.3
