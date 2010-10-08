Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7FAD8B70D1
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Oct 2010 06:06:58 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id o98J6rv1005758
	for <linuxppc-dev@ozlabs.org>; Fri, 8 Oct 2010 14:06:54 -0500
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 01/11] powerpc/mpc8xxx_gpio: Add support for 'qoriq-gpio'
	controllers
Date: Fri,  8 Oct 2010 14:06:43 -0500
Message-Id: <1286564813-21209-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add 'fsl,qoriq-gpio' compatiable to the list we search for to bind
against for mpc8xxx_gpio.  This compatiable will be used on P1-P5xxx
QorIQ devices like P4080.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/sysdev/mpc8xxx_gpio.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/sysdev/mpc8xxx_gpio.c b/arch/powerpc/sysdev/mpc8xxx_gpio.c
index 2b69084..c0ea05e 100644
--- a/arch/powerpc/sysdev/mpc8xxx_gpio.c
+++ b/arch/powerpc/sysdev/mpc8xxx_gpio.c
@@ -330,6 +330,9 @@ static int __init mpc8xxx_add_gpiochips(void)
 	for_each_compatible_node(np, NULL, "fsl,mpc8610-gpio")
 		mpc8xxx_add_controller(np);
 
+	for_each_compatible_node(np, NULL, "fsl,qoriq-gpio")
+		mpc8xxx_add_controller(np);
+
 	return 0;
 }
 arch_initcall(mpc8xxx_add_gpiochips);
-- 
1.7.2.3
