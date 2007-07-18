Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 22E79DDF35
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 11:33:10 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l6I1X5ib027042
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 18:33:06 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.83.16.18])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l6I1X5uO001167
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:33:05 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l6I18OIL007832
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:08:24 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id 72092AEFC9
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:33:04 -0500 (CDT)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l6I1X4Sk015267
	for linuxppc-dev@ozlabs.org; Tue, 17 Jul 2007 20:33:04 -0500
Date: Tue, 17 Jul 2007 20:33:04 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 07/61] bootwrapper: Set timebase_period_ns from
	dt_fixup_cpu_clocks.
Message-ID: <20070718013304.GF15238@ld0162-tx32.am.freescale.net>
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

This lets udelay() work properly on platforms which use dt_fixup_cpu_clocks.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/devtree.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/devtree.c b/arch/powerpc/boot/devtree.c
index c995155..3465d3f 100644
--- a/arch/powerpc/boot/devtree.c
+++ b/arch/powerpc/boot/devtree.c
@@ -61,6 +61,7 @@ void dt_fixup_memory(u64 start, u64 size)
 
 void dt_fixup_cpu_clocks(u32 cpu, u32 tb, u32 bus)
 {
+	extern unsigned long timebase_period_ns;
 	void *devp = NULL;
 
 	printf("CPU clock-frequency <- 0x%x (%dMHz)\n\r", cpu, MHZ(cpu));
@@ -74,6 +75,8 @@ void dt_fixup_cpu_clocks(u32 cpu, u32 tb, u32 bus)
 		if (bus > 0)
 			setprop_val(devp, "bus-frequency", bus);
 	}
+
+	timebase_period_ns = 1000000000 / tb;
 }
 
 void dt_fixup_clock(const char *path, u32 freq)
-- 
1.5.0.3
