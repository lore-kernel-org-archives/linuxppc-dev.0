Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 15088DDEC5
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Aug 2007 06:14:52 +1000 (EST)
Date: Tue, 28 Aug 2007 15:14:44 -0500
From: Scott Wood <scottwood@freescale.com>
To: jgarzik@pobox.com
Subject: [PATCH v3 5/8] fs_enet: mac-fcc: Eliminate __fcc-* macros.
Message-ID: <20070828201444.GD24145@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070828201127.GA24068@ld0162-tx32.am.freescale.net>
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

These macros accomplish nothing other than defeating type checking.

This patch also fixes one instance of the wrong register size being
used that was revealed by enabling type checking.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 drivers/net/fs_enet/mac-fcc.c |   25 ++++++++-----------------
 1 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/net/fs_enet/mac-fcc.c b/drivers/net/fs_enet/mac-fcc.c
index ad3c5fa..8b30361 100644
--- a/drivers/net/fs_enet/mac-fcc.c
+++ b/drivers/net/fs_enet/mac-fcc.c
@@ -48,28 +48,19 @@
 
 /* FCC access macros */
 
-#define __fcc_out32(addr, x)	out_be32((unsigned *)addr, x)
-#define __fcc_out16(addr, x)	out_be16((unsigned short *)addr, x)
-#define __fcc_out8(addr, x)	out_8((unsigned char *)addr, x)
-#define __fcc_in32(addr)	in_be32((unsigned *)addr)
-#define __fcc_in16(addr)	in_be16((unsigned short *)addr)
-#define __fcc_in8(addr)		in_8((unsigned char *)addr)
-
-/* parameter space */
-
 /* write, read, set bits, clear bits */
-#define W32(_p, _m, _v)	__fcc_out32(&(_p)->_m, (_v))
-#define R32(_p, _m)	__fcc_in32(&(_p)->_m)
+#define W32(_p, _m, _v)	out_be32(&(_p)->_m, (_v))
+#define R32(_p, _m)	in_be32(&(_p)->_m)
 #define S32(_p, _m, _v)	W32(_p, _m, R32(_p, _m) | (_v))
 #define C32(_p, _m, _v)	W32(_p, _m, R32(_p, _m) & ~(_v))
 
-#define W16(_p, _m, _v)	__fcc_out16(&(_p)->_m, (_v))
-#define R16(_p, _m)	__fcc_in16(&(_p)->_m)
+#define W16(_p, _m, _v)	out_be16(&(_p)->_m, (_v))
+#define R16(_p, _m)	in_be16(&(_p)->_m)
 #define S16(_p, _m, _v)	W16(_p, _m, R16(_p, _m) | (_v))
 #define C16(_p, _m, _v)	W16(_p, _m, R16(_p, _m) & ~(_v))
 
-#define W8(_p, _m, _v)	__fcc_out8(&(_p)->_m, (_v))
-#define R8(_p, _m)	__fcc_in8(&(_p)->_m)
+#define W8(_p, _m, _v)	out_8(&(_p)->_m, (_v))
+#define R8(_p, _m)	in_8(&(_p)->_m)
 #define S8(_p, _m, _v)	W8(_p, _m, R8(_p, _m) | (_v))
 #define C8(_p, _m, _v)	W8(_p, _m, R8(_p, _m) & ~(_v))
 
@@ -290,7 +281,7 @@ static void restart(struct net_device *dev)
 
 	/* clear everything (slow & steady does it) */
 	for (i = 0; i < sizeof(*ep); i++)
-		__fcc_out8((char *)ep + i, 0);
+		out_8((char *)ep + i, 0);
 
 	/* get physical address */
 	rx_bd_base_phys = fep->ring_mem_addr;
@@ -495,7 +486,7 @@ static void tx_kickstart(struct net_device *dev)
 	struct fs_enet_private *fep = netdev_priv(dev);
 	fcc_t *fccp = fep->fcc.fccp;
 
-	S32(fccp, fcc_ftodr, 0x80);
+	S16(fccp, fcc_ftodr, 0x8000);
 }
 
 static u32 get_int_events(struct net_device *dev)
-- 
1.5.0.3
