Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id BE87E67C60
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Sep 2006 13:57:26 +1000 (EST)
Date: Tue, 26 Sep 2006 13:57:21 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [POWERPC] iSeries has no legacy I/O
Message-Id: <20060926135721.50f7f1b0.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/platforms/iseries/setup.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/platforms/iseries/setup.c b/arch/powerpc/platforms/iseries/setup.c
index 7cb6b5f..a0ff7ba 100644
--- a/arch/powerpc/platforms/iseries/setup.c
+++ b/arch/powerpc/platforms/iseries/setup.c
@@ -649,6 +649,15 @@ #ifndef CONFIG_PCI
 void __init iSeries_init_IRQ(void) { }
 #endif
 
+/*
+ * iSeries has no legacy IO, anything calling this function has to
+ * fail or bad things will happen
+ */
+static int iseries_check_legacy_ioport(unsigned int baseport)
+{
+	return -ENODEV;
+}
+
 static int __init iseries_probe(void)
 {
 	unsigned long root = of_get_flat_dt_root();
@@ -677,6 +686,7 @@ define_machine(iseries) {
 	.calibrate_decr	= generic_calibrate_decr,
 	.progress	= iSeries_progress,
 	.probe		= iseries_probe,
+	.check_legacy_ioport	= iseries_check_legacy_ioport,
 	/* XXX Implement enable_pmcs for iSeries */
 };
 
-- 
1.4.2.1
