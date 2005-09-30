Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D76916842C
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Oct 2005 09:23:49 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Content-Type: text/plain
Date: Sat, 01 Oct 2005 09:21:25 +1000
Message-Id: <1128122486.31197.61.camel@gaston>
Mime-Version: 1.0
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: [PATCH] pmac: fix cpufreq for old tipb 550Mhz
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The old 550Mhz titanium powerbook can switch to a lower frequency
(500Mhz). A user has been repeately reporting overtemp conditions on his
machine at high speed so this simple patch adds support to PowerMac
cpufreq for this machine. The difference in frequency isn't big but seem
enough to fix that user's problems. The patch has been around for some
time now and doesn't seem to cause any problem, so I suppose it could go
in now.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Alain RICHARD <alain.richard@equation.fr>

Index: linux-work/arch/ppc/platforms/pmac_cpufreq.c
===================================================================
--- linux-work.orig/arch/ppc/platforms/pmac_cpufreq.c	2005-09-22 14:06:18.000000000 +1000
+++ linux-work/arch/ppc/platforms/pmac_cpufreq.c	2005-10-01 09:17:32.000000000 +1000
@@ -695,6 +695,13 @@
 		set_speed_proc = pmu_set_cpu_speed;
 		is_pmu_based = 1;
 	}
+	/* Else check for TiPb 550 */
+	else if (machine_is_compatible("PowerBook3,3") && cur_freq == 550000) {
+		hi_freq = cur_freq;
+		low_freq = 500000;
+		set_speed_proc = pmu_set_cpu_speed;
+		is_pmu_based = 1;
+	}
 	/* Else check for TiPb 400 & 500 */
 	else if (machine_is_compatible("PowerBook3,2")) {
 		/* We only know about the 400 MHz and the 500Mhz model
