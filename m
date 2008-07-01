Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 967DBDE252
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Jul 2008 23:04:41 +1000 (EST)
Date: Tue, 1 Jul 2008 17:04:38 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH] powerpc/86xx: mpc8610_hpcd: fix interrupt trigger type for
	ULi IDE
Message-ID: <20080701130438.GA25531@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

i8259 PIC is disabled on MPC8610HPCD, and ULi IDE is configured to use
PCI sideband interrupt that is specified in the device tree.

Current HPCD's device tree specify that IDE interrupt is low to high
sensitive, but in practice ULi IDE throws active-high interrupts (not
active-low as all normal PCI devices).

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---

This is for -next, since the bug could be triggered only on RT kernels
with hardirq preemption.

 arch/powerpc/boot/dts/mpc8610_hpcd.dts |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8610_hpcd.dts b/arch/powerpc/boot/dts/mpc8610_hpcd.dts
index 65a5f64..981941e 100644
--- a/arch/powerpc/boot/dts/mpc8610_hpcd.dts
+++ b/arch/powerpc/boot/dts/mpc8610_hpcd.dts
@@ -363,7 +363,7 @@
 			0xe000 0 0 4 &mpic 1 1
 
 			/* IDSEL 0x1f */
-			0xf800 0 0 1 &mpic 3 0
+			0xf800 0 0 1 &mpic 3 2
 			0xf800 0 0 2 &mpic 0 1
 		>;
 
-- 
1.5.5.4
