Return-Path: <kim.phillips@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id AB6E467C45
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Sep 2006 08:46:55 +1000 (EST)
Date: Tue, 26 Sep 2006 17:46:51 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/2] enable generic rtc hook for the MPC8349 mITX
Message-Id: <20060926174651.032a474e.kim.phillips@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

enable generic rtc hook for the MPC8349 mITX.

Signed-off-by: Kim Phillips <kim.phillips@freescale.com>

---
 arch/powerpc/platforms/83xx/mpc834x_itx.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/83xx/mpc834x_itx.c b/arch/powerpc/platforms/83xx/mpc834x_itx.c
index 969fbb6..8c676d7 100644
--- a/arch/powerpc/platforms/83xx/mpc834x_itx.c
+++ b/arch/powerpc/platforms/83xx/mpc834x_itx.c
@@ -109,6 +109,10 @@ static int __init mpc834x_itx_probe(void
 	return 1;
 }
 
+#ifdef CONFIG_RTC_CLASS
+late_initcall(rtc_class_hookup);
+#endif
+
 define_machine(mpc834x_itx) {
 	.name			= "MPC834x ITX",
 	.probe			= mpc834x_itx_probe,
-- 
1.4.2.1
