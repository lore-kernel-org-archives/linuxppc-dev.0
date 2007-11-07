Return-Path: <olaf@aepfle.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 6AAF5DDDFD
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Nov 2007 01:42:33 +1100 (EST)
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id 9400B2232C8
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Nov 2007 15:42:31 +0100 (CET)
Received: from localhost (unknown [192.168.1.157])
	by mail.m-online.net (Postfix) with ESMTP id 8736D9009A
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Nov 2007 15:42:31 +0100 (CET)
Received: from localhost ([192.168.3.149])
	by localhost (scanner1.m-online.net [192.168.1.157]) (amavisd-new,
	port 10024) with ESMTP id mYhaGKs4TDZp for <linuxppc-dev@ozlabs.org>;
	Wed,  7 Nov 2007 15:42:25 +0100 (CET)
Received: from ibook.aepfle.de (DSL01.83.171.165.156.ip-pool.NEFkom.net
	[83.171.165.156]) by mail.mnet-online.de (Postfix) with ESMTP
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Nov 2007 15:42:25 +0100 (CET)
Date: Wed, 7 Nov 2007 15:43:54 +0100
From: Olaf Hering <olaf@aepfle.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] autoload snd-powermac via modalias
Message-ID: <20071107144354.GA4961@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Autoload snd-powermac on systems without i2s bus by creating a fake
modalias entry. udev/modprobe will use the 'modalias' file from
/sys/devices/pci*/*/*/*:mac-io/*:davbus/ to find a matching module.
Newer systems use snd-aoa, which provides the required modalias already.

Some systems with i2s bus, but without a 'layout-id' property, will not work
with this patch because an fake i2s alias will conflict with snd-aoa.


Signed-off-by: Olaf Hering <olaf@aepfle.de>

---
 sound/ppc/powermac.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/sound/ppc/powermac.c
+++ b/sound/ppc/powermac.c
@@ -174,6 +174,16 @@ static struct platform_driver snd_pmac_d
 	},
 };
 
+/* for NewWorld AGP (Pismo, CRT iMac) */
+MODULE_ALIAS("of:NdavbusTsoundbusCdavbus");
+/* for OldWorld beige G3 */
+/* for NewWorld PCI (G3 and early G4) */
+MODULE_ALIAS("of:NdavbusTdavbus");
+/* for OldWorld ohare based */
+MODULE_ALIAS("of:NdavbusTsoundbus");
+/* for OldWorld bandit based */
+MODULE_ALIAS("of:NawacsTsound");
+
 static int __init alsa_card_pmac_init(void)
 {
 	int err;
