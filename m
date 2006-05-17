Return-Path: <tie-fei.zang@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 9D15667E10
	for <linuxppc-dev@ozlabs.org>; Wed, 17 May 2006 20:14:44 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	k4HAUid4023957
	for <linuxppc-dev@ozlabs.org>; Wed, 17 May 2006 03:30:44 -0700 (MST)
Received: from zch01exm40.ap.freescale.net (zch01exm40.ap.freescale.net
	[10.192.130.11])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k4HAQNpQ020065
	for <linuxppc-dev@ozlabs.org>; Wed, 17 May 2006 05:26:24 -0500 (CDT)
Message-ID: <9FCDBA58F226D911B202000BDBAD46730626D628@zch01exm40.ap.freescale.net>
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH/2.6.17-rc4 10/10]  bugs fix for marvell SATA on powerpc pl
	atform
Date: Wed, 17 May 2006 18:14:35 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, Alexandre.Bounine@tundra.com,
	Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Fix Marvell SATA driver bugs on PowerPC platform: 
SATA device can't work for the problem on little-endian mode.
U-Boot can't find SATA device after kernel reboots.

Signed-off-by: Hongjun cheng	<hong-jun.chen@reescale.com>
Signed-off-by: Roy Zang		<tie-fei.zang@freescale.com>

>From nobody Mon Sep 17 00:00:00 2001
From: roy zang <tie-fei.zang@freescale.com>
Date: Tue May 16 15:25:23 2006 +0800
Subject: [PATCH] Fix bugs on powerpc platform for mv sata driver

---

 drivers/scsi/sata_mv.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

d82ac19d259f8487a31105eaf844a93cbd9008e8
diff --git a/drivers/scsi/sata_mv.c b/drivers/scsi/sata_mv.c
index d5fdcb9..4166422 100644
--- a/drivers/scsi/sata_mv.c
+++ b/drivers/scsi/sata_mv.c
@@ -1032,6 +1032,9 @@ static inline void mv_crqb_pack_cmd(u16 
 {
 	*cmdw = data | (addr << CRQB_CMD_ADDR_SHIFT) | CRQB_CMD_CS |
 		(last ? CRQB_CMD_LAST : 0);
+#ifdef CONFIG_PPC
+	*cmdw = cpu_to_le16(*cmdw);
+#endif
 }
 
 /**
@@ -1567,13 +1570,18 @@ static void mv5_read_preamp(struct mv_ho
 static void mv5_enable_leds(struct mv_host_priv *hpriv, void __iomem *mmio)
 {
 	u32 tmp;
-
+#ifndef CONFIG_PPC
 	writel(0, mmio + MV_GPIO_PORT_CTL);
+#endif
 
 	/* FIXME: handle MV_HP_ERRATA_50XXB2 errata */
 
 	tmp = readl(mmio + MV_PCI_EXP_ROM_BAR_CTL);
+#ifdef CONFIG_PPC
+	tmp &= ~(1 << 0);
+#else	
 	tmp |= ~(1 << 0);
+#endif
 	writel(tmp, mmio + MV_PCI_EXP_ROM_BAR_CTL);
 }
 
-- 
1.3.0
