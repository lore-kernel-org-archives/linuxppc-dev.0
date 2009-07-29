Return-Path: <ashish.kalra@freescale.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 03917B70AD
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 30 Jul 2009 02:05:55 +1000 (EST)
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 94061DDD0C
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Jul 2009 02:05:53 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n6TG5VeF018053
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Jul 2009 09:05:43 -0700 (MST)
Received: from zin33exm20.fsl.freescale.net (zin33exm20.ap.freescale.net
	[10.232.192.5])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id n6TG5Tm3021468
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Jul 2009 11:05:30 -0500 (CDT)
Date: Wed, 29 Jul 2009 21:33:27 +0530 (India Standard Time)
From: ashish kalra <ashish.kalra@freescale.com>
To: linux-ide@vger.kernel.org
Subject: [PATCH][sata_fsl] Defer non-ncq commands when ncq commands active
Message-ID: <Pine.WNT.4.64.0907292129310.4440@B00888-02.fsl.freescale.net>
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
Date: Wed, 29 Jul 2009 21:15:49 +0530

Fix for non-ncq & ncq commands causing timeouts when both are issued 
simultaneously to the same device.

Signed-off-by: Ashish Kalra <Ashish.Kalra@freescale.com>
---
  drivers/ata/sata_fsl.c |    1 +
  1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index 5a88b44..a33f130 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -1262,6 +1262,7 @@ static struct scsi_host_template sata_fsl_sht = {
  static struct ata_port_operations sata_fsl_ops = {
  	.inherits		= &sata_pmp_port_ops,

+	.qc_defer = ata_std_qc_defer;
  	.qc_prep = sata_fsl_qc_prep,
  	.qc_issue = sata_fsl_qc_issue,
  	.qc_fill_rtf = sata_fsl_qc_fill_rtf,
-- 
1.6.0
