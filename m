Return-Path: <martyn.welch@gefanuc.com>
Received: from ext-cn0ut-4.online-age.net (ext-cn0ut-4.online-age.net
	[63.210.253.233])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ext-cn0ut.online-age.net",
	Issuer "Savvis Communications Root CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 3D782DDDCA
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Nov 2008 21:18:56 +1100 (EST)
Received: from int-cn0ut-4.online-age.net (int-cn0ut-4.online-age.net
	[3.159.252.73])
	by ext-cn0ut-4.online-age.net (8.13.6/8.13.6/20051114-SVVS-TLS-DNSBL)
	with ESMTP id mAIAIqTj024879
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Nov 2008 05:18:53 -0500
Received: from cinmlip01.e2k.ad.ge.com (int-cn0ut-4.online-age.net
	[3.159.252.73])
	by int-cn0ut-4.online-age.net (8.13.6/8.13.6/20050510-SVVS) with ESMTP
	id mAIAIqmK020516
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Nov 2008 05:18:52 -0500
From: Martyn Welch <martyn.welch@gefanuc.com>
Subject: [PATCH] powerpc: Use generic PHY driver for Marvell 88E1111 PHY on GE
	Fanuc SBC610
To: linuxppc-dev@ozlabs.org
Date: Tue, 18 Nov 2008 10:20:24 +0000
Message-ID: <20081118102023.7047.94495.stgit@ubuntu8041.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The Marvell PHY driver is currently being used for the 88E1111 on the
SBC610. This driver is causing the link to run in 10/Half mode, the generic
PHY driver is correctly configuring the PHY as 1000/Full.

Edit default config to use generic PHY driver.
---

 arch/powerpc/configs/86xx/gef_sbc610_defconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/configs/86xx/gef_sbc610_defconfig b/arch/powerpc/configs/86xx/gef_sbc610_defconfig
index 2da13e0..07ccaf8 100644
--- a/arch/powerpc/configs/86xx/gef_sbc610_defconfig
+++ b/arch/powerpc/configs/86xx/gef_sbc610_defconfig
@@ -838,7 +838,7 @@ CONFIG_PHYLIB=y
 #
 # MII PHY device drivers
 #
-CONFIG_MARVELL_PHY=y
+# CONFIG_MARVELL_PHY is not set
 # CONFIG_DAVICOM_PHY is not set
 # CONFIG_QSEMI_PHY is not set
 # CONFIG_LXT_PHY is not set
