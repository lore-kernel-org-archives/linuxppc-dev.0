Return-Path: <abounine@tundra.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 68BE2B710E
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 19 Oct 2010 01:09:40 +1100 (EST)
From: Alexandre Bounine <alexandre.bounine@idt.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH -mm 1/2] RapidIO: Fix maximum port number in tsi57x EM
	initialization
Date: Mon, 18 Oct 2010 10:03:19 -0400
Message-Id: <1287410600-24783-1-git-send-email-alexandre.bounine@idt.com>
Cc: Alexandre Bounine <alexandre.bounine@idt.com>,
	Thomas Moll <thomas.moll@sysgo.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Replace hardcoded maximum port number with actual reported number of
switch ports.

Signed-off-by: Alexandre Bounine <alexandre.bounine@idt.com>
Cc: Kumar Gala <galak@kernel.crashing.org>
Cc: Matt Porter <mporter@kernel.crashing.org>
Cc: Li Yang <leoli@freescale.com>
Cc: Thomas Moll <thomas.moll@sysgo.com>
Cc: Micha Nelissen <micha@neli.hopto.org>
---
 drivers/rapidio/switches/tsi57x.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/rapidio/switches/tsi57x.c b/drivers/rapidio/switches/tsi57x.c
index d9e9492..2003fb6 100644
--- a/drivers/rapidio/switches/tsi57x.c
+++ b/drivers/rapidio/switches/tsi57x.c
@@ -166,7 +166,8 @@ tsi57x_em_init(struct rio_dev *rdev)
 
 	pr_debug("TSI578 %s [%d:%d]\n", __func__, destid, hopcount);
 
-	for (portnum = 0; portnum < 16; portnum++) {
+	for (portnum = 0;
+	     portnum < RIO_GET_TOTAL_PORTS(rdev->swpinfo); portnum++) {
 		/* Make sure that Port-Writes are enabled (for all ports) */
 		rio_mport_read_config_32(mport, destid, hopcount,
 				TSI578_SP_MODE(portnum), &regval);
-- 
1.7.3.1
