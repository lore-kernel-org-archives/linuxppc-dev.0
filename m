Return-Path: <LeoLi@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id F0297DDFCC
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Feb 2007 22:30:54 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l16BUrYW005236
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Feb 2007 04:30:53 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l16BUIxv014599
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Feb 2007 05:30:50 -0600 (CST)
Message-ID: <45C8672B.1050302@freescale.com>
Date: Tue, 06 Feb 2007 19:31:55 +0800
From: Li Yang <leoli@freescale.com>
MIME-Version: 1.0
To: jeff@garzik.org
Subject: [PATCH 4/4] ucc_geth: Add support to local-mac-address property
Content-Type: text/plain; charset=windows-1252; format=flowed
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

IEEE-1275 defines “local-mac-address” to be a standard
property name to specify preassigned network address.
This patch adds support for it.

Signed-off-by: Li Yang <leoli@freescale.com>
---
 drivers/net/ucc_geth.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/drivers/net/ucc_geth.c b/drivers/net/ucc_geth.c
index dcec66d..62512fc 100644
--- a/drivers/net/ucc_geth.c
+++ b/drivers/net/ucc_geth.c
@@ -4053,6 +4053,7 @@ static int ucc_geth_probe(struct of_device* ofdev, const struct of_device_id *ma
 	static int mii_mng_configured = 0;
 	const phandle *ph;
 	const unsigned int *prop;
+	const void *mac_addr;
 
 	ugeth_vdbg("%s: IN", __FUNCTION__);
 
@@ -4178,7 +4179,12 @@ static int ucc_geth_probe(struct of_device* ofdev, const struct of_device_id *ma
 
 	ugeth->ug_info = ug_info;
 	ugeth->dev = dev;
-	memcpy(dev->dev_addr, get_property(np, "mac-address", NULL), 6);
+
+	mac_addr = get_property(np, "mac-address", NULL);
+	if (mac_addr == NULL)
+		mac_addr = get_property(np, "local-mac-address", NULL);
+	if (mac_addr)
+		memcpy(dev->dev_addr, mac_addr, 6);
 
 	return 0;
 }
