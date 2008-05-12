Return-Path: <avorontsov@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 6E54FDDE07
	for <linuxppc-dev@ozlabs.org>; Mon, 12 May 2008 22:35:37 +1000 (EST)
Date: Mon, 12 May 2008 16:35:33 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH] [POWERPC] 86xx: mpc8610_hpcd: fix second serial port
Message-ID: <20080512123533.GA29838@polina.dev.rtsoft.ru>
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

DIU platform code should not just write to the PIXIS' BRDCFG0 register,
it should set and clear its own bits only, otherwise it will break
firmware setup (in fact it breaks second uart).

Also get rid of magic numbers in the related code.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/platforms/86xx/mpc8610_hpcd.c |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
index 71dbd9d..4c61a10 100644
--- a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
+++ b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
@@ -285,11 +285,21 @@ void mpc8610hpcd_set_gamma_table(int monitor_port, char *gamma_table_base)
 	}
 }
 
+#define PX_BRDCFG0_DVISEL	(1 << 3)
+#define PX_BRDCFG0_DLINK	(1 << 4)
+#define PX_BRDCFG0_DIU_MASK	(PX_BRDCFG0_DVISEL | PX_BRDCFG0_DLINK)
+
 void mpc8610hpcd_set_monitor_port(int monitor_port)
 {
-	static const u8 bdcfg[] = {0xBD, 0xB5, 0xA5};
+	static const u8 bdcfg[] = {
+		PX_BRDCFG0_DVISEL | PX_BRDCFG0_DLINK,
+		PX_BRDCFG0_DLINK,
+		0,
+	};
+
 	if (monitor_port < 3)
-		*pixis_bdcfg0 = bdcfg[monitor_port];
+		clrsetbits_8(pixis_bdcfg0, PX_BRDCFG0_DIU_MASK,
+			     bdcfg[monitor_port]);
 }
 
 void mpc8610hpcd_set_pixel_clock(unsigned int pixclock)
-- 
1.5.5.1
