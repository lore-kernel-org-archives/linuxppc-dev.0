Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id E9E6BB7C09
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Oct 2009 03:50:14 +1100 (EST)
Date: Fri, 16 Oct 2009 20:50:13 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH] powerpc/85xx: Fix USB GPIOs for MPC8569E-MDS boards
Message-ID: <20091016165013.GA13836@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@ozlabs.org, Liu Yu <Yu.Liu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch fixes USB GPIOs numbers for MPC8569E-MDS boards, plus
according to the latest HW Getting Started Guide (rev 3.3, pilot
boards), USB "POWER" GPIO polarity has changed, it is no longer
inverted.

This patch makes USB Host somewhat work on pilot boards, though
there are still some problems with determining devices speed and
long bulk transfers.

Reported-by: Liu Yu <Yu.Liu@freescale.com>
Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/boot/dts/mpc8569mds.dts |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8569mds.dts b/arch/powerpc/boot/dts/mpc8569mds.dts
index 06332d6..1e3ec8f 100644
--- a/arch/powerpc/boot/dts/mpc8569mds.dts
+++ b/arch/powerpc/boot/dts/mpc8569mds.dts
@@ -487,8 +487,8 @@
 				 &qe_pio_f 5 0   /* USBTN */
 				 &qe_pio_f 6 0   /* USBRP */
 				 &qe_pio_f 8 0   /* USBRN */
-				 &bcsr17   6 0   /* SPEED */
-				 &bcsr17   5 1>; /* POWER */
+				 &bcsr17   1 0   /* SPEED */
+				 &bcsr17   2 0>; /* POWER */
 		};
 
 		enet0: ucc@2000 {
-- 
1.6.3.3
