Return-Path: <ken@bitsko.slc.ut.us>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id DCF24B71C3
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 13 Jun 2009 07:34:28 +1000 (EST)
Received: from sccmmhc91.asp.att.net (sccmmhc91.asp.att.net [204.127.203.211])
	by ozlabs.org (Postfix) with ESMTP id 547E0DDD04
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Jun 2009 07:34:27 +1000 (EST)
Received: from localhost.localdomain (tara [127.0.0.1])
	by localhost.localdomain (8.14.2/8.14.2) with ESMTP id n5CLYdtb021831
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jun 2009 16:34:39 -0500
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] net/fs_enet: Allow use_rmii to be set in OF
From: Ken MacLeod <ken@bitsko.slc.ut.us>
Date: Fri, 12 Jun 2009 16:34:37 -0500
Message-ID: <m3fxe516he.fsf@bitsko.slc.ut.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Allow use_rmii in fs_platform_info to be set in the OF device tree
using phy-mode="rmii".

Signed-off-by: Ken MacLeod <ken@bitsko.slc.ut.us>
---
 drivers/net/fs_enet/fs_enet-main.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/net/fs_enet/fs_enet-main.c b/drivers/net/fs_enet/fs_enet-main.c
index a9cbc31..57879be 100644
--- a/drivers/net/fs_enet/fs_enet-main.c
+++ b/drivers/net/fs_enet/fs_enet-main.c
@@ -1043,6 +1043,7 @@ static int __devinit fs_enet_probe(struct of_device *ofdev,
 	struct fs_platform_info *fpi;
 	const u32 *data;
 	const u8 *mac_addr;
+	const char *str;
 	int privsize, len, ret = -ENODEV;
 
 	fpi = kzalloc(sizeof(*fpi), GFP_KERNEL);
@@ -1057,6 +1058,10 @@ static int __devinit fs_enet_probe(struct of_device *ofdev,
 		fpi->cp_command = *data;
 	}
 
+	str = of_get_property(ofdev->node, "phy-mode", &len);
+	if (str != NULL && !strcasecmp(str, "rmii"))
+		fpi->use_rmii = 1;
+
 	fpi->rx_ring = 32;
 	fpi->tx_ring = 32;
 	fpi->rx_copybreak = 240;
-- 
1.5.4.3
