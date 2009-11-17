Return-Path: <mel@csn.ul.ie>
Received: from gir.skynet.ie (gir.skynet.ie [193.1.99.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BE8F8B7B65
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Nov 2009 23:16:53 +1100 (EST)
From: Mel Gorman <mel@csn.ul.ie>
To: Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 3/4] powerpc: Only define smp_pSeries_cpu_bootable when
	CONFIG_XICS is set
Date: Tue, 17 Nov 2009 12:07:38 +0000
Message-Id: <1258459659-11770-4-git-send-email-mel@csn.ul.ie>
In-Reply-To: <1258459659-11770-1-git-send-email-mel@csn.ul.ie>
References: <1258459659-11770-1-git-send-email-mel@csn.ul.ie>
Cc: Mel Gorman <mel@csn.ul.ie>, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If CONFIG_XICS is set, then smp_pSeries_cpu_bootable() is unnecessary.
As warnings are treated as errors, this fails to build.

This patch only defines smp_pSeries_cpu_bootable() when CONFIG_XICS is
set.

Signed-off-by: Mel Gorman <mel@csn.ul.ie>
---
 arch/powerpc/platforms/pseries/smp.c |   19 ++++++++++---------
 1 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/smp.c b/arch/powerpc/platforms/pseries/smp.c
index da78ea5..62b1141 100644
--- a/arch/powerpc/platforms/pseries/smp.c
+++ b/arch/powerpc/platforms/pseries/smp.c
@@ -130,6 +130,15 @@ static void __devinit smp_pSeries_kick_cpu(int nr)
 	paca[nr].cpu_start = 1;
 }
 
+#ifdef CONFIG_MPIC
+static struct smp_ops_t pSeries_mpic_smp_ops = {
+	.message_pass	= smp_mpic_message_pass,
+	.probe		= smp_mpic_probe,
+	.kick_cpu	= smp_pSeries_kick_cpu,
+	.setup_cpu	= smp_mpic_setup_cpu,
+};
+#endif
+#ifdef CONFIG_XICS
 static int smp_pSeries_cpu_bootable(unsigned int nr)
 {
 	/* Special case - we inhibit secondary thread startup
@@ -142,15 +151,7 @@ static int smp_pSeries_cpu_bootable(unsigned int nr)
 
 	return 1;
 }
-#ifdef CONFIG_MPIC
-static struct smp_ops_t pSeries_mpic_smp_ops = {
-	.message_pass	= smp_mpic_message_pass,
-	.probe		= smp_mpic_probe,
-	.kick_cpu	= smp_pSeries_kick_cpu,
-	.setup_cpu	= smp_mpic_setup_cpu,
-};
-#endif
-#ifdef CONFIG_XICS
+
 static struct smp_ops_t pSeries_xics_smp_ops = {
 	.message_pass	= smp_xics_message_pass,
 	.probe		= smp_xics_probe,
-- 
1.6.5
