Return-Path: <adrian@humboldt.co.uk>
Received: from mail.humboldt.co.uk (mail.humboldt.co.uk [80.68.93.146])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3202A679E6
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Mar 2006 09:28:21 +1100 (EST)
Subject: [PATCH] Fix platform_notify functions marked __init
From: Adrian Cox <adrian@humboldt.co.uk>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain
Date: Wed, 08 Mar 2006 22:10:20 +0000
Message-Id: <1141855821.28095.18.camel@localhost.localdomain>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

While adding USB support to an MV64360 based board this week, I
discovered that all MV64x60 boards in the kernel have platform_notify
functions marked with __init. This causes an oops if a device is added
after boot.

The patch below removes the __init markers. I do not have all these
boards to test on, but the change seems very unlikely to break anything
else.

Signed-off-by: Adrian Cox <adrian@humboldt.co.uk>

diff --git a/arch/ppc/platforms/cpci690.c b/arch/ppc/platforms/cpci690.c
index 6ca7bca..ad1a21e 100644
--- a/arch/ppc/platforms/cpci690.c
+++ b/arch/ppc/platforms/cpci690.c
@@ -290,7 +290,7 @@ cpci690_fixup_mpsc_pdata(struct platform
 	pdata->brg_clk_freq = cpci690_get_bus_freq();
 }
 
-static int __init
+static int
 cpci690_platform_notify(struct device *dev)
 {
 	static struct {
diff --git a/arch/ppc/platforms/ev64260.c b/arch/ppc/platforms/ev64260.c
index ffde8f6..fea4cf8 100644
--- a/arch/ppc/platforms/ev64260.c
+++ b/arch/ppc/platforms/ev64260.c
@@ -416,7 +416,7 @@ ev64260_fixup_mpsc_pdata(struct platform
 	return;
 }
 
-static int __init
+static int
 ev64260_platform_notify(struct device *dev)
 {
 	static struct {
diff --git a/arch/ppc/platforms/ev64360.c b/arch/ppc/platforms/ev64360.c
index b9d844f..e8cc999 100644
--- a/arch/ppc/platforms/ev64360.c
+++ b/arch/ppc/platforms/ev64360.c
@@ -300,7 +300,7 @@ ev64360_fixup_eth_pdata(struct platform_
 }
 #endif
 
-static int __init
+static int
 ev64360_platform_notify(struct device *dev)
 {
 	static struct {
diff --git a/arch/ppc/platforms/hdpu.c b/arch/ppc/platforms/hdpu.c
index 50039a2..c79e589 100644
--- a/arch/ppc/platforms/hdpu.c
+++ b/arch/ppc/platforms/hdpu.c
@@ -354,7 +354,7 @@ static void __init hdpu_fixup_cpustate_p
 }
 #endif
 
-static int __init hdpu_platform_notify(struct device *dev)
+static int hdpu_platform_notify(struct device *dev)
 {
 	static struct {
 		char *bus_id;
diff --git a/arch/ppc/platforms/katana.c b/arch/ppc/platforms/katana.c
index 6e58e30..b655e53 100644
--- a/arch/ppc/platforms/katana.c
+++ b/arch/ppc/platforms/katana.c
@@ -598,7 +598,7 @@ katana_fixup_mv64xxx_pdata(struct platfo
 }
 #endif
 
-static int __init
+static int
 katana_platform_notify(struct device *dev)
 {
 	static struct {
diff --git a/arch/ppc/platforms/radstone_ppc7d.c b/arch/ppc/platforms/radstone_ppc7d.c
index 872c0a3..d5c3e92 100644
--- a/arch/ppc/platforms/radstone_ppc7d.c
+++ b/arch/ppc/platforms/radstone_ppc7d.c
@@ -712,7 +712,7 @@ ppc7d_fixup_i2c_pdata(struct platform_de
 }
 #endif
 
-static int __init ppc7d_platform_notify(struct device *dev)
+static int ppc7d_platform_notify(struct device *dev)
 {
 	static struct {
 		char *bus_id;


-- 
Adrian Cox <adrian@humboldt.co.uk>
