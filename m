Return-Path: <ncase@xes-inc.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 5A920B70C8
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  9 Jun 2009 09:06:14 +1000 (EST)
Received: from xes-mad.com (xes-mad.com [216.165.139.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9EFE2DDD04
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Jun 2009 09:06:13 +1000 (EST)
From: Nate Case <ncase@xes-inc.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH] powerpc/boot: cuboot: Fix up ethernet3 MAC address on MPC85xx
Date: Mon,  8 Jun 2009 17:17:42 -0500
Message-Id: <1244499462-18719-1-git-send-email-ncase@xes-inc.com>
Cc: linuxppc-dev@ozlabs.org, Nate Case <ncase@xes-inc.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

MPC85xx platforms do support 4 ethernet ports, so make sure the boot
wrapper fixes up all of them in the fdt.

Signed-off-by: Nate Case <ncase@xes-inc.com>
---
 arch/powerpc/boot/cuboot-85xx.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/cuboot-85xx.c b/arch/powerpc/boot/cuboot-85xx.c
index 6776a1a..277ba4a 100644
--- a/arch/powerpc/boot/cuboot-85xx.c
+++ b/arch/powerpc/boot/cuboot-85xx.c
@@ -15,6 +15,7 @@
 #include "cuboot.h"
 
 #define TARGET_85xx
+#define TARGET_HAS_ETH3
 #include "ppcboot.h"
 
 static bd_t bd;
@@ -27,6 +28,7 @@ static void platform_fixups(void)
 	dt_fixup_mac_address_by_alias("ethernet0", bd.bi_enetaddr);
 	dt_fixup_mac_address_by_alias("ethernet1", bd.bi_enet1addr);
 	dt_fixup_mac_address_by_alias("ethernet2", bd.bi_enet2addr);
+	dt_fixup_mac_address_by_alias("ethernet3", bd.bi_enet3addr);
 	dt_fixup_cpu_clocks(bd.bi_intfreq, bd.bi_busfreq / 8, bd.bi_busfreq);
 
 	/* Unfortunately, the specific model number is encoded in the
-- 
1.6.0.2
