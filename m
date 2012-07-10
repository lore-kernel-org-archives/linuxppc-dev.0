Return-Path: <B38951@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe001.messaging.microsoft.com [216.32.180.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 94FCE2C0493
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jul 2012 16:29:40 +1000 (EST)
From: Jia Hongtao <B38951@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <galak@kernel.crashing.org>
Subject: [PATCH 1/2] powerpc/mpc8572ds: Fix eTSEC is not available on core1 of
 AMP boot issue
Date: Tue, 10 Jul 2012 14:08:25 +0800
Message-ID: <1341900506-23401-1-git-send-email-B38951@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: b38951@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The issue log on core1 is:
root@mpc8572ds:~# ifconfig eth0 10.192.208.244
net eth0: could not attach to PHY
SIOCSIFFLAGS: No such device

To attach PHY node mdio@24520 should not be disabled in dts of core1.
Because all PHYs are controlled through this node as follows:

mdio@24520 {
	phy0: ethernet-phy@0 {
		interrupts = <10 1 0 0>;
		reg = <0x0>;
	};
	phy1: ethernet-phy@1 {
		interrupts = <10 1 0 0>;
		reg = <0x1>;
	};
	phy2: ethernet-phy@2 {
		interrupts = <10 1 0 0>;
		reg = <0x2>;
	};
	phy3: ethernet-phy@3 {
		interrupts = <10 1 0 0>;
		reg = <0x3>;
	};

	tbi0: tbi-phy@11 {
		reg = <0x11>;
		device_type = "tbi-phy";
	};
};

Signed-off-by: Li Yang <leoli@freescale.com>
Signed-off-by: Jia Hongtao <B38951@freescale.com>
---
 arch/powerpc/boot/dts/mpc8572ds_camp_core1.dts |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8572ds_camp_core1.dts b/arch/powerpc/boot/dts/mpc8572ds_camp_core1.dts
index d6a8faf..1932396 100644
--- a/arch/powerpc/boot/dts/mpc8572ds_camp_core1.dts
+++ b/arch/powerpc/boot/dts/mpc8572ds_camp_core1.dts
@@ -67,9 +67,6 @@
 		ethernet@24000 {
 			status = "disabled";
 		};
-		mdio@24520 {
-			status = "disabled";
-		};
 		ptp_clock@24e00 {
 			status = "disabled";
 		};
-- 
1.7.5.1
