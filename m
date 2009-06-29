Return-Path: <ashish.kalra@freescale.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 722DCB708D
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 30 Jun 2009 01:11:54 +1000 (EST)
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 00CF1DDD1B
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jun 2009 01:11:53 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n5TFBXar010976
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jun 2009 08:11:43 -0700 (MST)
Received: from zin33exm20.fsl.freescale.net (zin33exm20.ap.freescale.net
	[10.232.192.5])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id n5TFBVgl003011
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jun 2009 10:11:32 -0500 (CDT)
Date: Mon, 29 Jun 2009 20:41:22 +0530 (India Standard Time)
From: ashish kalra <ashish.kalra@freescale.com>
To: linux-ide@vger.kernel.org
Message-ID: <Pine.WNT.4.64.0906292038560.4924@B00888-02.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ashish Kalra <Ashish.Kalra@freescale.com>
Date: Fri, 26 Jun 2009 15:46:02 +0530
Subject: [PATCH][v2] sata_fsl: Add asynchronous notification support

Enable device hot-plug support on Port multiplier fan-out ports

Signed-off-by: Ashish Kalra <Ashish.Kalra@freescale.com>
---
  drivers/ata/sata_fsl.c |   10 ++++++++--
  1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index 94eaa43..5751145 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -34,7 +34,7 @@ enum {

  	SATA_FSL_HOST_FLAGS	= (ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
  				ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA |
-				ATA_FLAG_PMP | ATA_FLAG_NCQ),
+ 				ATA_FLAG_PMP | ATA_FLAG_NCQ | ATA_FLAG_AN),

  	SATA_FSL_MAX_CMDS	= SATA_FSL_QUEUE_DEPTH,
  	SATA_FSL_CMD_HDR_SIZE	= 16,	/* 4 DWORDS */
@@ -132,7 +132,7 @@ enum {
  	INT_ON_SINGL_DEVICE_ERR = (1 << 1),
  	INT_ON_CMD_COMPLETE = 1,

-	INT_ON_ERROR = INT_ON_FATAL_ERR |
+	INT_ON_ERROR = INT_ON_FATAL_ERR | INT_ON_SNOTIFY_UPDATE |
  	    INT_ON_PHYRDY_CHG | INT_ON_SINGL_DEVICE_ERR,

  	/*
@@ -154,6 +154,7 @@ enum {

  	DEFAULT_PORT_IRQ_ENABLE_MASK = IE_ON_FATAL_ERR | IE_ON_PHYRDY_CHG |
  	    IE_ON_SIGNATURE_UPDATE |
+	    IE_ON_SNOTIFY_UPDATE |
  	    IE_ON_SINGL_DEVICE_ERR | IE_ON_CMD_COMPLETE,

  	EXT_INDIRECT_SEG_PRD_FLAG = (1 << 31),
@@ -1003,6 +1004,11 @@ static void sata_fsl_error_intr(struct ata_port *ap)
  		freeze = 1;
  	}

+	/* Handle SDB FIS receive & notify update */
+	if (hstatus & INT_ON_SNOTIFY_UPDATE) {
+		sata_async_notification(ap);
+	}
+
  	/* Handle PHYRDY change notification */
  	if (hstatus & INT_ON_PHYRDY_CHG) {
  		DPRINTK("SATA FSL: PHYRDY change indication\n");
-- 
1.6.0
