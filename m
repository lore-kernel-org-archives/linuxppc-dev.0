Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound5-wa4-R.bigfish.com (outbound-wa4.frontbridge.com
	[216.32.181.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 57242DDECC
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Feb 2008 09:54:23 +1100 (EST)
Message-ID: <47ACDD40.3050908@am.sony.com>
Date: Fri, 08 Feb 2008 14:52:48 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [patch 3/6] PS3: Fix bootwrapper hang bug
References: <20080208224723.029462363@am.sony.com>
In-Reply-To: <20080208224723.029462363@am.sony.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Fix a bug in the lv1_get_repository_node_value() routine of the PS3
bootwrapper.  Changes in the PS3 system firmware 2.20 cause this bug
to hang the system when branching from the bootwrapper to the kernel
_start.

Since the video system has not yet been enabled at the time
the bug is hit, the system hangs with a blank screen.  Earlier
firmwares don't cause such a catastrophic failure, and so this
bug went undetected.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
 arch/powerpc/boot/ps3-hvcall.S |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/powerpc/boot/ps3-hvcall.S
+++ b/arch/powerpc/boot/ps3-hvcall.S
@@ -145,7 +145,7 @@
 .macro STORE_REGS_5_2
 	lwz r11, 16(r1)
 	std r4, 0(r11)
-	lwz r11, 24(r1)
+	lwz r11, 20(r1)
 	std r5, 0(r11)
 .endm
 

-- 
