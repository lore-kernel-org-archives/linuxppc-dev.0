Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao12.cox.net (fed1rmmtao12.cox.net [68.230.241.27])
	by ozlabs.org (Postfix) with ESMTP id A93AB2BDA5
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 27 Oct 2004 06:58:59 +1000 (EST)
Date: Tue, 26 Oct 2004 13:58:47 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: akpm@osdl.org
Message-ID: <20041026135847.A16409@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
Subject: [PATCH][PPC32] Disable broken L2 cache on all 440GX revs
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Always disable L2 cache on PPC440GX. All revs/speeds of silicon
have parity error problems despite errata claims to the contrary.                                                                                 
Signed-off-by: Matt Porter <mporter@kernel.crashing.org>

===== arch/ppc/platforms/4xx/ocotea.c 1.8 vs edited =====
--- 1.8/arch/ppc/platforms/4xx/ocotea.c	2004-10-18 22:26:41 -07:00
+++ edited/arch/ppc/platforms/4xx/ocotea.c	2004-10-26 13:40:44 -07:00
@@ -350,8 +350,12 @@
 	ibm440gx_get_clocks(&clocks, 33333333, 6 * 1843200);
 	ocp_sys_info.opb_bus_freq = clocks.opb;
 
-	/* Disable L2-Cache on broken hardware, enable it otherwise */
-	ibm440gx_l2c_setup(&clocks);
+	/*
+	 * Always disable L2 cache. All revs/speeds of silicon
+	 * have parity error problems despite errata claims to
+	 * the contrary.
+	 */
+	ibm440gx_l2c_disable();
 
 	ibm44x_platform_init();
 
